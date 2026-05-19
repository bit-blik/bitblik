import 'dart:async'; // For StreamSubscription, Timer
import 'dart:convert'; // For jsonDecode
import 'dart:io'; // For File operations
import 'dart:math'; // For random preimage
import 'dart:typed_data'; // For Uint8List

import 'package:yaml/yaml.dart';
import 'package:clock/clock.dart'; // Added for Clock
import 'package:crypto/crypto.dart'; // For SHA256
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http; // For LNURL HTTP requests
import 'package:matrix/matrix.dart' as matrix; // Import Matrix SDK
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart' as path;
import 'package:process_run/process_run.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:decimal/decimal.dart';

import '../models/offer.dart';
import 'database_service.dart';
import 'lnd_service.dart';
import 'nwc_service.dart';
import 'payment_service.dart';
import '../models/invoice_status.dart';
import '../models/invoice_update.dart';
import 'nostr_service.dart';
import 'telegram_service.dart';
import '../logging/app_logger.dart';

// Set to Duration.zero for production
const Duration _kDebugDelayDuration = Duration(seconds: 0);

// Taker payment fee limit as a fraction of taker fees (0.2 = 20%)
const double kTakerFeeLimitFactor = 0.2;

class CoordinatorService {
  final DatabaseService _dbService;
  PaymentService? _paymentBackend; // Unified payment backend
  String _paymentBackendType =
      "none"; // To track active backend: "lnd", "nwc", or "none"
  final Clock _clock; // Added for testable time
  final http.Client _httpClient; // Added for testable HTTP calls
  late DotEnv _env;
  NostrService? _nostrService; // Nostr service for publishing events

  matrix.Client? _matrixClient; // Matrix client instance
  TelegramService? _telegramService; // Telegram service for notifications

  late final String _matrixHomeserver;
  late final String _matrixUser;
  late final String _matrixClientName;
  late final String _matrixPassword;
  late final String _matrixRoomId;

  // Coordinator Info
  late final String _coordinatorName;
  late final String _coordinatorIconUrl;
  late final String _termsOfUsageNaddr;

  // Offer amount limits
  late final int _minAmountSats;
  late final int _maxAmountSats;

  // Supported currencies
  late final List<String> _supportedCurrencies;

  // Reservation timeout configuration
  late final int _reservationTimeoutSeconds;

  // Funded expire timeout configuration
  late final int _fundedExpireTimeoutSeconds;

  // taker charged timeout configuration
  late final int _takerChargedAutoConfirmTimeoutSeconds;

  // conflict -> dispute auto-transition timeout configuration
  late final int _conflictAutoDisputeTimeoutSeconds;

  // Exchange rate cache
  double? _cachedPlnRate;
  DateTime? _cachedPlnRateTime;

  // Define a structure for exchange rate sources
  static final List<Map<String, String>> _exchangeRateSources = [
    {
      'name': 'CoinGecko',
      'url':
          'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=pln',
      'parser': '_parseCoinGeckoResponse',
    },
    {
      'name': 'Yadio',
      'url': 'https://api.yadio.io/exrates/pln',
      'parser': '_parseYadioResponse',
    },
    {
      'name': 'Blockchain.info',
      'url': 'https://blockchain.info/ticker',
      'parser': '_parseBlockchainInfoResponse',
    }
  ];

  // Parser for CoinGecko response
  double? _parseCoinGeckoResponse(String responseBody) {
    try {
      final data = jsonDecode(responseBody);
      final rate = data['bitcoin']['pln'];
      if (rate is num) {
        return rate.toDouble();
      }
    } catch (e) {
      AppLogger.info('Error parsing CoinGecko response: $e');
    }
    return null;
  }

  // Parser for Yadio.io response
  double? _parseYadioResponse(String responseBody) {
    try {
      final data = jsonDecode(responseBody);
      final rate =
          data['BTC']; // Yadio returns BTC in PLN directly with this key
      if (rate is num) {
        return rate.toDouble();
      }
    } catch (e) {
      AppLogger.info('Error parsing Yadio response: $e');
    }
    return null;
  }

  // Parser for Blockchain.info response
  double? _parseBlockchainInfoResponse(String responseBody) {
    try {
      final data = jsonDecode(responseBody);
      final rate = data['PLN']?['last'];
      if (rate is num) {
        return rate.toDouble();
      }
    } catch (e) {
      AppLogger.info('Error parsing Blockchain.info response: $e');
    }
    return null;
  }

  Future<double> _getPlnRate() async {
    final now = DateTime.now();
    if (_cachedPlnRate != null &&
        _cachedPlnRateTime != null &&
        now.difference(_cachedPlnRateTime!).inMinutes < 5) {
      return _cachedPlnRate!;
    }

    List<Future<double?>> fetchFutures = [];
    for (var source in _exchangeRateSources) {
      fetchFutures.add(_fetchRateFromSource(source));
    }

    final List<double?> results = await Future.wait(fetchFutures);
    final List<double> validRates =
        results.where((rate) => rate != null).cast<double>().toList();

    if (validRates.isNotEmpty) {
      final averageRate =
          validRates.reduce((a, b) => a + b) / validRates.length;
      _cachedPlnRate = averageRate;
      _cachedPlnRateTime = now;
      AppLogger.info(
          'Successfully fetched and averaged BTC/PLN rate: $averageRate from ${validRates.length} sources.');
      return averageRate;
    } else {
      if (_cachedPlnRate != null) {
        AppLogger.info(
            'Returning stale BTC/PLN rate due to all sources failing to fetch.');
        return _cachedPlnRate!;
      }
      throw Exception('Failed to fetch BTC/PLN rate from all sources.');
    }
  }

  Future<double?> _fetchRateFromSource(Map<String, String> source) async {
    final url = Uri.parse(source['url']!);
    final parserName = source['parser']!;
    final sourceName = source['name']!;

    try {
      final response = await _httpClient.get(url); // Use _httpClient
      if (response.statusCode == 200) {
        double? rate;
        if (parserName == '_parseCoinGeckoResponse') {
          rate = _parseCoinGeckoResponse(response.body);
        } else if (parserName == '_parseYadioResponse') {
          rate = _parseYadioResponse(response.body);
        } else if (parserName == '_parseBlockchainInfoResponse') {
          rate = _parseBlockchainInfoResponse(response.body);
        }
        if (rate != null) {
          AppLogger.info('Successfully fetched rate from $sourceName: $rate');
          return rate;
        } else {
          AppLogger.info('Failed to parse response from $sourceName');
          return null;
        }
      } else {
        AppLogger.info(
            'Failed to fetch BTC/PLN rate from $sourceName: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      AppLogger.info('Error fetching BTC/PLN rate from $sourceName: $e');
      return null;
    }
  }

  final Map<String, Map<String, dynamic>> _pendingOffers = {};
  final Map<String, StreamSubscription> _invoiceSubscriptions = {};
  final Map<String, Timer> _reservationTimers = {};
  final Map<String, Timer> _blikConfirmationTimers = {};
  final Map<String, Timer> _fundedOfferTimers = {};
  final Map<String, Timer> _takerChargedTimers = {};
  final Map<String, Timer> _conflictTimers = {};

  // Fee percentages, configurable via environment variables
  late final double _makerFeePercentage;
  late final double _takerFeePercentage;

  late final _simplexGroup;
  late final _simplexChatExec;
  late final _signalCliExec;
  late final _signalGroupId;
  late final frontendDomain;

  CoordinatorService(this._dbService,
      {PaymentService? paymentServiceForTest,
      Clock? clock,
      http.Client? httpClient,
      NostrService? nostrService})
      : _clock = clock ?? const Clock(),
        _httpClient = httpClient ?? http.Client(),
        _nostrService = nostrService {
    // Initialize dotenv
    _env = DotEnv(includePlatformEnvironment: true)..load();

    // Initialize all configuration values
    _matrixHomeserver = _env['MATRIX_HOMESERVER'] ?? 'https://matrix.org';
    _matrixClientName = _env['MATRIX_CLIENT_NAME'] ?? 'BitBlik';
    _matrixUser = _env['MATRIX_USER'] ?? '';
    _matrixPassword = _env['MATRIX_PASSWORD'] ?? '';
    _matrixRoomId = _env['MATRIX_ROOM'] ?? '';

    frontendDomain = _env['FRONTEND_DOMAIN'] ?? 'bitblik.app';

    _simplexGroup = _env['SIMPLEX_GROUP'] ?? 'Bitblik new offers';
    _simplexChatExec = _env['SIMPLEX_CHAT_EXEC'] ?? './simplex-chat';

    _signalCliExec = _env['SIGNAL_CLI_EXEC'] ?? 'signal-cli';
    _signalGroupId = _env['SIGNAL_GROUP_ID'] ?? '';

    _coordinatorName = _env['NAME'] ?? 'BitBlik Coordinator';
    _coordinatorIconUrl =
        _env['ICON_URL'] ?? 'https://bitblik.app/splash/img/dark-2x.png';

    final termsOfUsageEnv = _env['TERMS_OF_USAGE_NADDR'] ?? '';
    _termsOfUsageNaddr = termsOfUsageEnv;

    _minAmountSats = int.tryParse(_env['MIN_AMOUNT_SATS'] ?? '') ?? 1000;
    _maxAmountSats = int.tryParse(_env['MAX_AMOUNT_SATS'] ?? '') ?? 250000;

    _supportedCurrencies = (_env['CURRENCIES']?.split(',') ?? ['PLN'])
        .map((c) => c.trim().toUpperCase())
        .toList();

    _reservationTimeoutSeconds =
        int.tryParse(_env['RESERVATION_SECONDS'] ?? '') ?? 30;
    _fundedExpireTimeoutSeconds =
        int.tryParse(_env['FUNDED_EXPIRY_SECONDS'] ?? '') ?? 600;
    _takerChargedAutoConfirmTimeoutSeconds =
        int.tryParse(_env['TAKER_CHARGED_AUTO_CONFIRM_SECONDS'] ?? '') ??
            3600; // 1h
    _conflictAutoDisputeTimeoutSeconds = 3600; // 60m

    _makerFeePercentage =
        double.tryParse(_env['MAKER_FEE'] ?? '') ?? 0.5; // Default to 0.5%
    _takerFeePercentage =
        double.tryParse(_env['TAKER_FEE'] ?? '') ?? 0.5; // Default to 0.5%

    // Initialize Telegram service
    final telegramBotToken = _env['TELEGRAM_BOT_TOKEN'];
    final telegramChatId = _env['TELEGRAM_CHAT_ID'];
    if (telegramBotToken != null &&
        telegramBotToken.isNotEmpty &&
        telegramChatId != null &&
        telegramChatId.isNotEmpty) {
      _telegramService = TelegramService(
          botToken: telegramBotToken,
          chatId: telegramChatId,
          httpClient: _httpClient);
      AppLogger.info('Telegram service initialized.');
      // } else {
      //   AppLogger.info(
      //       'Telegram not configured: TELEGRAM_BOT_TOKEN or TELEGRAM_CHAT_ID not set. Skipping Telegram initialization.');
    }

    if (paymentServiceForTest != null) {
      _paymentBackend = paymentServiceForTest;
      AppLogger.info(
          'CoordinatorService initialized with injected payment backend for testing.');
      _paymentBackendType = "injected_test_backend";
    }
  }

  Future<void> init() async {
    if (_paymentBackend == null) {
      await _initializePaymentBackend();
    }
    AppLogger.info(
        'CoordinatorService initialized with $_paymentBackendType backend.');
  }

  Future<void> doInitialCheckStatuses() async {
    await _initializeMatrixClient();
    await _checkExpiredFundedOffers();
    await _checkExpiredReservations();
    await _checkExpiredBlikConfirmations();
    await _checkTakerChargedAutoConfirm();
    await _checkConflictAutoDispute();
  }

  Future<void> _initializeMatrixClient() async {
    if (_matrixUser.isEmpty ||
        _matrixPassword.isEmpty ||
        _matrixRoomId.isEmpty) {
      AppLogger.info(
          'Matrix credentials or Room ID not configured. Skipping Matrix initialization.');
      return;
    }
    try {
      AppLogger.info(
          'Initializing Matrix client for $_matrixUser on $_matrixHomeserver... client name: $_matrixClientName');

      // Initialize sqflite_common_ffi for server-side usage
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;

      // Create data directory for matrix database
      final dataDir = Directory('data/matrix');
      if (!await dataDir.exists()) {
        await dataDir.create(recursive: true);
      }

      final dbPath = path.join(dataDir.path, 'matrix_database.sqlite');

      // Create the database using sqflite_common_ffi
      final database = await openDatabase(
        dbPath,
        version: 1,
        onCreate: (db, version) async {
          // Let the matrix SDK handle database creation
          AppLogger.info('Matrix database created at $dbPath');
        },
      );

      // Initialize the matrix client with the new database approach
      _matrixClient = matrix.Client(
        _matrixClientName,
        database: await matrix.MatrixSdkDatabase.init(
          _matrixClientName,
          database: database,
        ),
      );

      // await _matrixClient!.init();

      // Check homeserver
      await _matrixClient!.checkHomeserver(Uri.parse(_matrixHomeserver));

      // Login
      final loginResponse = await _matrixClient!.login(
        matrix.LoginType.mLoginPassword,
        identifier: matrix.AuthenticationUserIdentifier(user: _matrixUser),
        password: _matrixPassword,
      );

      AppLogger.info(
          'Matrix client logged in successfully as ${loginResponse.userId.localpart}');
    } catch (e) {
      AppLogger.info('Error initializing or logging in Matrix client: $e');
      _matrixClient = null;
    }
  }

  Future<void> _initializePaymentBackend() async {
    final nwcUri = _env['NWC_URI'];
    final lndHost = _env['LND_HOST'];

    if (nwcUri != null && nwcUri.isNotEmpty) {
      AppLogger.info('NWC_URI found. Initializing NwcService...');
      try {
        final nwcService = NwcService(nwcUri: nwcUri);
        await nwcService.connect();
        _paymentBackend = nwcService;
        _paymentBackendType = "nwc";
        AppLogger.info('NwcService initialized and connected successfully.');
      } catch (e) {
        AppLogger.info('Error initializing NwcService: $e');
        _paymentBackend = null; // Ensure backend is null on error
        _paymentBackendType = "none";
        AppLogger.info(
            'Falling back to LND check due to NWC initialization error.');
        if (lndHost != null && lndHost.isNotEmpty) {
          await _initializeLndService(lndHost);
        } else {
          throw Exception("CRITICAL: NWC failed and LND_HOST not configured");
        }
      }
    } else if (lndHost != null && lndHost.isNotEmpty) {
      await _initializeLndService(lndHost);
    } else {
      throw Exception(
          "CRITICAL: No payment backend configured (NWC_URI or LND_HOST not set). Hold invoice functionality will be disabled.");
    }
  }

  Future<void> _initializeLndService(String lndHost) async {
    AppLogger.info(
        'LND_HOST found ($lndHost). Initializing LndService (uses internal env vars for details)...');
    try {
      final lndService = LndService();
      await lndService.connect();
      _paymentBackend = lndService;
      _paymentBackendType = "lnd";
      AppLogger.info('LndService initialized and connected successfully.');
    } catch (e) {
      AppLogger.info('Error initializing LndService: $e');
      _paymentBackend = null; // Ensure backend is null on error
      _paymentBackendType = "none";
    }
  }

  Future<void> _checkExpiredFundedOffers() async {
    AppLogger.info('Checking for expired funded offers on startup...');
    if (_paymentBackend == null) {
      AppLogger.info(
          "Skipping expired funded offers check: No payment backend configured.");
      return;
    }
    try {
      final fundedOffers =
          await _dbService.getOffersByStatus(OfferStatus.funded, limit: 1000);
      final now = DateTime.now().toUtc();
      final expirationDuration = Duration(seconds: _fundedExpireTimeoutSeconds);

      int cancelledCount = 0;
      for (final offer in fundedOffers) {
        final createdAt = offer.createdAt;
        final expiryTime = createdAt.add(expirationDuration);
        if (now.isAfter(expiryTime)) {
          AppLogger.info(
              'Offer ${offer.id} funded expired (created at $createdAt, expired at $expiryTime). Cancelling.',
              offerId: offer.id);
          try {
            await _paymentBackend!
                .cancelInvoice(paymentHashHex: offer.holdInvoicePaymentHash);
            AppLogger.info(
                'Hold invoice for offer ${offer.id} cancelled via $_paymentBackendType due to startup expiration check.',
                offerId: offer.id);
          } catch (e) {
            AppLogger.info(
                'Error cancelling hold invoice for expired offer ${offer.id} using  $e',
                offerId: offer.id);
          }
          final dbSuccess =
              await _dbService.updateOfferStatus(offer.id, OfferStatus.expired);
          if (dbSuccess) {
            cancelledCount++;
            AppLogger.info(
                'Offer ${offer.id} status updated to expired in DB due to startup expiration check.',
                offerId: offer.id);

            // Publish status update
            final expiredOffer = await _dbService.getOfferById(offer.id);
            if (expiredOffer != null) {
              await _publishStatusUpdate(expiredOffer);
              await _nostrService?.broadcastNip69OrderFromOffer(expiredOffer);
            }
          } else {
            AppLogger.info(
                'Failed to update offer ${offer.id} status to expired in DB after startup expiration check.',
                offerId: offer.id);
          }
        }
      }
      AppLogger.info(
          'Expired funded offer check complete. Marked $cancelledCount offers as expired.');
    } catch (e) {
      AppLogger.info('Error during expired funded offer check: $e');
    }
  }

  Future<void> _checkTakerChargedAutoConfirm() async {
    AppLogger.info('Checking for takerCharged auto confirm on startup...');
    if (_paymentBackend == null) {
      AppLogger.info("Skipping, no payment backend configured.");
      return;
    }
    try {
      final offers = await _dbService
          .getOffersByStatus(OfferStatus.takerCharged, limit: 1000);
      final now = DateTime.now().toUtc();
      final expirationDuration =
          Duration(seconds: _takerChargedAutoConfirmTimeoutSeconds);

      int cancelledCount = 0;
      int timerRestartedCount = 0;
      for (final offer in offers) {
        // Use createdAt as the base for expiration since that's when the hold invoice was created
        final expiryTime = offer.createdAt.add(expirationDuration);
        if (now.isAfter(expiryTime)) {
          AppLogger.info(
              'Offer ${offer.id} takerCharged auto confirm (created at ${offer.createdAt}, expired at $expiryTime). Auto confirming.',
              offerId: offer.id);
          try {
            await confirmMakerPayment(offer.id, offer.makerPubkey);
            cancelledCount++;
          } catch (e) {
            AppLogger.info(
                'Error takerCharged auto confirming for offer ${offer.id} using  $e',
                offerId: offer.id);
          }
        } else {
          // Restart timer for offers that haven't expired yet
          AppLogger.info(
              'Offer ${offer.id} still within takerCharged window (expires at $expiryTime). Restarting timer.',
              offerId: offer.id);
          _startTakerChargedTimer(offer);
          timerRestartedCount++;
        }
      }
      AppLogger.info(
          'takerCharged auto confirm offer check complete. Auto confirmed $cancelledCount offers, restarted timers for $timerRestartedCount offers.');
    } catch (e) {
      AppLogger.info('Error during takerCharged auto confirm check: $e');
    }
  }

  Future<void> _checkConflictAutoDispute() async {
    AppLogger.info('Checking for conflict auto dispute on startup...');
    if (_paymentBackend == null) {
      AppLogger.info('Skipping, no payment backend configured.');
      return;
    }

    try {
      final offers =
          await _dbService.getOffersByStatus(OfferStatus.conflict, limit: 1000);
      final now = _clock.now().toUtc();
      final timeoutDuration =
          Duration(seconds: _conflictAutoDisputeTimeoutSeconds);

      int autoDisputedCount = 0;
      int timerRestartedCount = 0;
      for (final offer in offers) {
        final conflictStartAt = (offer.updatedAt ?? offer.createdAt).toUtc();
        final expiryTime = conflictStartAt.add(timeoutDuration);
        if (now.isAfter(expiryTime)) {
          AppLogger.info(
              'Offer ${offer.id} conflict timeout reached (entered conflict at $conflictStartAt, expired at $expiryTime). Opening dispute.',
              offerId: offer.id);
          final success = await openDispute(offer.id, offer.makerPubkey);
          if (success) {
            autoDisputedCount++;
          }
        } else {
          AppLogger.info(
              'Offer ${offer.id} still within conflict window (expires at $expiryTime). Restarting timer.',
              offerId: offer.id);
          _startConflictTimer(offer);
          timerRestartedCount++;
        }
      }

      AppLogger.info(
          'Conflict auto dispute check complete. Auto disputed $autoDisputedCount offers, restarted timers for $timerRestartedCount offers.');
    } catch (e) {
      AppLogger.info('Error during conflict auto dispute check: $e');
    }
  }

  Future<void> _checkExpiredReservations() async {
    AppLogger.info('Checking for expired reserved offers on startup...');
    try {
      final reservedOffers =
          await _dbService.getOffersByStatus(OfferStatus.reserved, limit: 1000);
      final now = DateTime.now().toUtc();
      final timeoutDuration =
          Duration(seconds: _reservationTimeoutSeconds); // Reservation timeout

      int revertedCount = 0;
      for (final offer in reservedOffers) {
        if (offer.reservedAt != null) {
          final expiryTime = offer.reservedAt!.add(timeoutDuration);
          if (now.isAfter(expiryTime)) {
            AppLogger.info(
                'Offer ${offer.id} reservation expired (reserved at ${offer.reservedAt}, expired at $expiryTime). Reverting status.',
                offerId: offer.id);
            final success = await _dbService.updateOfferStatus(
              offer.id,
              OfferStatus.funded,
              // Clear reservation related fields
              takerPubkey: null,
              reservedAt: null,
            );
            if (success) {
              revertedCount++;

              // Publish status update
              final revertedOffer = await _dbService.getOfferById(offer.id);
              if (revertedOffer != null) {
                await _publishStatusUpdate(revertedOffer);
              }

              // Restart the funded offer timer
              _startFundedOfferTimer(
                  offer); // offer object is available from the loop
            } else {
              AppLogger.info(
                  'Error reverting expired offer ${offer.id} on startup.',
                  offerId: offer.id);
            }
          }
        } else {
          AppLogger.info(
              'Warning: Offer ${offer.id} is reserved but has no reserved_at timestamp. Reverting.',
              offerId: offer.id);
          final success = await _dbService.updateOfferStatus(
            offer.id,
            OfferStatus.funded,
            // Clear reservation related fields
            takerPubkey: null,
            reservedAt: null,
          );
          if (success) {
            revertedCount++;
            // Restart the funded offer timer
            _startFundedOfferTimer(
                offer); // offer object is available from the loop
          } else {
            AppLogger.info(
                'Error reverting reserved offer ${offer.id} with missing timestamp on startup.',
                offerId: offer.id);
          }
        }
      }
      AppLogger.info(
          'Expired reservation check complete. Reverted $revertedCount offers.');
    } catch (e) {
      AppLogger.info('Error during expired reservation check: $e');
    }
  }

  Future<void> _checkExpiredBlikConfirmations() async {
    AppLogger.info(
        '### COORDINATOR: Running _checkExpiredBlikConfirmations on startup...');
    try {
      final offersToCheck = [
        ...await _dbService.getOffersByStatus(OfferStatus.blikReceived,
            limit: 1000),
        ...await _dbService.getOffersByStatus(OfferStatus.blikSentToMaker,
            limit: 1000),
      ];

      final now = _clock.now().toUtc();
      const timeoutDuration = Duration(seconds: 120);

      int expiredCount = 0;
      for (final offer in offersToCheck) {
        if (offer.blikReceivedAt != null) {
          final expiryTime = offer.blikReceivedAt!.add(timeoutDuration);
          if (now.isAfter(expiryTime)) {
            // Determine the appropriate expired status based on current status
            final newStatus = offer.status == OfferStatus.blikReceived
                ? OfferStatus.expiredBlik
                : OfferStatus.expiredSentBlik;
            AppLogger.info(
                'Offer ${offer.id} BLIK confirmation expired (BLIK received at ${offer.blikReceivedAt}, expired at $expiryTime). Transitioning to $newStatus.',
                offerId: offer.id);
            final success = await _dbService.updateOfferStatus(
              offer.id,
              newStatus,
              // Clear BLIK related fields as well
              blikCode: null,
              takerLightningAddress: null,
              blikReceivedAt: null,
            );
            if (success) {
              expiredCount++;

              // Publish status update
              final expiredOffer = await _dbService.getOfferById(offer.id);
              if (expiredOffer != null) {
                await _publishStatusUpdate(expiredOffer);
              }
            } else {
              AppLogger.info(
                  'Error updating expired BLIK confirmation for offer ${offer.id} on startup.',
                  offerId: offer.id);
            }
          }
        } else {
          AppLogger.info(
              'Warning: Offer ${offer.id} is in state ${offer.status} but has no blik_received_at timestamp. Transitioning to expired status.',
              offerId: offer.id);
          // Determine the appropriate expired status based on current status
          final newStatus = offer.status == OfferStatus.blikReceived
              ? OfferStatus.expiredBlik
              : OfferStatus.expiredSentBlik;
          final success = await _dbService.updateOfferStatus(
            offer.id,
            newStatus,
            // Clear BLIK related fields as well
            blikCode: null,
            takerLightningAddress: null,
            blikReceivedAt: null, // Though it's missing, good to be explicit
          );
          if (success) {
            expiredCount++;
            // Publish status update
            final expiredOffer = await _dbService.getOfferById(offer.id);
            if (expiredOffer != null) {
              await _publishStatusUpdate(expiredOffer);
            }
          } else {
            AppLogger.info(
                'Error updating offer ${offer.id} with missing BLIK timestamp on startup.',
                offerId: offer.id);
          }
        }
      }
      AppLogger.info(
          'Expired BLIK confirmation check complete. Expired $expiredCount offers.');
    } catch (e) {
      AppLogger.info('Error during expired BLIK confirmation check: $e');
    }
  }

  Future<Map<String, dynamic>> initiateOfferFiat({
    required double fiatAmount,
    required String makerId,
    String fiatCurrency = 'PLN',
  }) async {
    AppLogger.info(
        'Initiating offer: fiatAmount=$fiatAmount $fiatCurrency, maker=$makerId');
    final rate = await _getPlnRate();
    final btcPerPln = 1 / rate;
    final btcAmount = fiatAmount * btcPerPln;
    final satsAmount = (btcAmount * 100000000).round();
    final makerFees =
        (satsAmount * _makerFeePercentage / 100).ceil(); // Use static field
    final takerFees =
        (satsAmount * _takerFeePercentage / 100).ceil(); // Use static field
    final totalAmountSats = satsAmount + makerFees;
    final preimage = _generatePreimage();
    final paymentHash = sha256.convert(preimage).bytes;
    final paymentHashHex = paymentHash
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join('');
    final memo =
        '${_coordinatorName} - Payment $fiatAmount $fiatCurrency reference: $paymentHashHex. This payment WILL FREEZE IN YOUR WALLET, check on BitBlik if the lock was successful. It will be unlocked (fail) unless you cheat or cancel unilaterally.';

    String holdInvoice;
    String returnedPaymentHashHex = paymentHashHex;

    if (_paymentBackend == null) {
      AppLogger.info(
          'CRITICAL: No payment backend configured for initiateOfferFiat.');
      throw Exception("No payment backend configured to create hold invoice.");
    }

    final backendResponse = await _paymentBackend!.createHoldInvoice(
        amountSats: totalAmountSats,
        memo: memo,
        paymentHashHex: paymentHashHex);
    holdInvoice = backendResponse.invoice;
    if (backendResponse.paymentHash.isNotEmpty) {
      returnedPaymentHashHex = backendResponse.paymentHash;
    }

    final preimageHex =
        preimage.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join('');
    _pendingOffers[returnedPaymentHashHex] = {
      'amountSats': satsAmount,
      'makerFees': makerFees,
      'takerFees': takerFees,
      'makerId': makerId,
      'preimageHex': preimageHex,
      'fiatAmount': fiatAmount,
      'fiatCurrency': fiatCurrency,
      'actualPaymentHashForSubscription': returnedPaymentHashHex,
    };
    AppLogger.info(
        'Pending offer stored for payment hash $returnedPaymentHashHex');
    _startInvoiceSubscription(returnedPaymentHashHex);
    return {
      'holdInvoice': holdInvoice,
      'paymentHash': returnedPaymentHashHex,
      'fiatAmount': fiatAmount,
      'fiatCurrency': fiatCurrency,
      'amountSats': satsAmount,
      'makerFees': makerFees,
      'totalAmountSats': totalAmountSats,
      'rate': rate,
    };
  }

  void _startInvoiceSubscription(String paymentHashHex) {
    _invoiceSubscriptions[paymentHashHex]?.cancel();
    AppLogger.info('Starting subscription for invoice: $paymentHashHex');

    if (_paymentBackend == null) {
      AppLogger.info(
          'CRITICAL: No payment backend configured for _startInvoiceSubscription.');
      _pendingOffers.remove(paymentHashHex);
      return;
    }

    try {
      final subscription = _paymentBackend!
          .subscribeToInvoiceUpdates(paymentHashHex: paymentHashHex)
          .listen(
        (InvoiceUpdate update) async {
          AppLogger.info(
              '$_paymentBackendType Invoice Update for $paymentHashHex: Status=${update.status}');
          if (update.status == InvoiceStatus.ACCEPTED) {
            AppLogger.info(
                '$_paymentBackendType Invoice ACCEPTED (funded): $paymentHashHex');
            await _createOfferFromFundedInvoice(paymentHashHex);
            _invoiceSubscriptions[paymentHashHex]?.cancel();
            _invoiceSubscriptions.remove(paymentHashHex);
          } else if (update.status == InvoiceStatus.CANCELED) {
            AppLogger.info(
                '$_paymentBackendType Invoice CANCELED: $paymentHashHex');
            _pendingOffers.remove(paymentHashHex);
            _invoiceSubscriptions[paymentHashHex]?.cancel();
            _invoiceSubscriptions.remove(paymentHashHex);
          } else if (update.status == InvoiceStatus.SETTLED) {
            // This case might be less common for hold invoices before BLIK,
            // but good to handle if the backend sends it.
            AppLogger.info(
                '$_paymentBackendType Invoice SETTLED: $paymentHashHex');
            _invoiceSubscriptions[paymentHashHex]?.cancel();
            _invoiceSubscriptions.remove(paymentHashHex);
          }
        },
        onError: (error) {
          AppLogger.info(
              'Error in $_paymentBackendType subscription stream for $paymentHashHex: $error');
          _pendingOffers.remove(paymentHashHex);
          _invoiceSubscriptions.remove(paymentHashHex);
        },
        onDone: () {
          AppLogger.info(
              '$_paymentBackendType Subscription stream closed for $paymentHashHex');
          // For NWC, onDone might not mean the end of the world if it's a shared stream.
          // However, for a specific invoice subscription, it usually means it's over.
          // LND typically closes after final state.
          // To be safe, if it's not already removed by ACCEPTED/CANCELED/ERROR, remove it.
          if (_invoiceSubscriptions.containsKey(paymentHashHex)) {
            _pendingOffers.remove(
                paymentHashHex); // Clean up pending offer if stream closes unexpectedly
            _invoiceSubscriptions.remove(paymentHashHex);
          }
        },
        cancelOnError: true,
      );
      _invoiceSubscriptions[paymentHashHex] = subscription;
    } catch (e) {
      AppLogger.info(
          'Failed to initiate $_paymentBackendType subscription for $paymentHashHex: $e');
      _pendingOffers.remove(paymentHashHex);
    }
  }

  Future<void> _createOfferFromFundedInvoice(String paymentHashHex) async {
    final pendingData = _pendingOffers.remove(paymentHashHex);
    if (pendingData == null) {
      AppLogger.info(
          'Warning: _createOfferFromFundedInvoice called for unknown or already processed payment hash: $paymentHashHex');
      final existingOffer =
          await _dbService.getOfferByPaymentHash(paymentHashHex);
      if (existingOffer == null) {
        AppLogger.info(
            'Error: No pending data and no existing offer found for funded hash: $paymentHashHex');
      } else {
        AppLogger.info('Offer already exists for funded hash: $paymentHashHex');
      }
      return;
    }

    AppLogger.info(
        'Creating offer in DB for funded payment hash: $paymentHashHex');
    try {
      final offer = Offer(
        amountSats: pendingData['amountSats'],
        makerFees: pendingData['makerFees'],
        takerFees: pendingData['takerFees'],
        makerPubkey: pendingData['makerId'],
        holdInvoicePaymentHash: paymentHashHex,
        holdInvoicePreimage: pendingData['preimageHex'],
        status: OfferStatus.funded,
        fiatAmount: pendingData['fiatAmount'],
        fiatCurrency: pendingData['fiatCurrency'],
      );
      await _dbService.createOffer(offer);
      // --- Begin: broadcast NIP-69 order event ---
      final expirationUnix = offer.createdAt
              .add(Duration(seconds: _fundedExpireTimeoutSeconds))
              .millisecondsSinceEpoch ~/
          1000;
      await _nostrService?.broadcastNip69OrderFromOffer(offer,
          expiration: expirationUnix);
      // --- End: broadcast NIP-69 order event ---
      _startFundedOfferTimer(offer);

      // Publish status update
      await _publishStatusUpdate(offer);

      final fiatText =
          '${offer.fiatAmount.toStringAsFixed(2)} ${offer.fiatCurrency}';
      final notificationText =
          // TODO test.bitblik.app for test version
          // TODO link for full offer id -> opens screen with offer details and possibility of TAKE
          "New offer/Nowa oferta: ${offer.amountSats} sats (${fiatText}) -> https://${frontendDomain}/offers/${offer.id}";

      // Send all notifications in parallel
      final List<Future<void>> notificationFutures = [];

      // SimpleX notification
      if (_simplexChatExec != '') {
        notificationFutures.add(_sendSimpleXNotification(notificationText));
      }

      // Matrix notification
      if (_matrixClient != null && _matrixClient!.isLogged()) {
        notificationFutures.add(_sendMatrixNotification(notificationText));
      }

      // Telegram notification
      if (_telegramService != null && _telegramService!.isConfigured) {
        notificationFutures.add(_sendTelegramNotification(notificationText));
      }

      // Signal notification
      if (_signalCliExec != '' && _signalGroupId.isNotEmpty) {
        notificationFutures.add(_sendSignalNotification(notificationText));
      }

      // Execute all notifications in parallel
      if (notificationFutures.isNotEmpty) {
        await Future.wait(notificationFutures, eagerError: false);
      }

      AppLogger.info('Offer ${offer.id} created successfully in DB.',
          offerId: offer.id);
    } catch (e) {
      AppLogger.info('Error creating offer in DB for $paymentHashHex: $e');
    }
  }

  /// Send SimpleX notification (returns Future for parallel execution)
  Future<void> _sendSimpleXNotification(String notificationText) async {
    try {
      final simplexMsg = "#'$_simplexGroup' $notificationText";
      final result = await run('$_simplexChatExec -e "$simplexMsg" --ha');
      if (result.first.stderr.isNotEmpty) {
        AppLogger.info('simplex command error: ${result.first.stderr}');
      }
    } catch (e) {
      AppLogger.info('Error sending SimpleX notification: $e');
    }
  }

  /// Send Matrix notification (returns Future for parallel execution)
  Future<void> _sendMatrixNotification(String notificationText) async {
    try {
      AppLogger.info('Sending Matrix notification to room $_matrixRoomId');
      final room = _matrixClient!.getRoomById(_matrixRoomId);
      if (room == null) {
        AppLogger.info('Error: Could not find Matrix room $_matrixRoomId');
      } else {
        await room.sendTextEvent(notificationText);
        AppLogger.info('Matrix notification sent successfully.');
      }
    } catch (e) {
      AppLogger.info('Error sending Matrix notification: $e');
    }
  }

  /// Send Telegram notification (returns Future for parallel execution)
  Future<void> _sendTelegramNotification(String notificationText) async {
    try {
      await _telegramService!.sendMessage(notificationText);
    } catch (e) {
      AppLogger.info('Error sending Telegram notification: $e');
    }
  }

  /// Send Signal notification (returns Future for parallel execution)
  Future<void> _sendSignalNotification(String notificationText) async {
    try {
      final signalCmd =
          '$_signalCliExec send -g $_signalGroupId -m "$notificationText"';
      final result = await run(signalCmd);
      if (result.first.stderr.isNotEmpty) {
        AppLogger.info('signal-cli command error: ${result.first.stderr}');
      } else {
        AppLogger.info('Signal notification sent successfully.');
      }
    } catch (e) {
      AppLogger.info('Error sending Signal notification: $e');
    }
  }

  void _startFundedOfferTimer(Offer offer) {
    _fundedOfferTimers[offer.id]?.cancel();

    final now = _clock.now().toUtc();
    final expirationTime =
        offer.createdAt.add(Duration(seconds: _fundedExpireTimeoutSeconds));
    final remainingDuration = expirationTime.difference(now);

    if (remainingDuration.isNegative || remainingDuration.inSeconds == 0) {
      AppLogger.info(
          'Offer ${offer.id} has already passed its expiration time. Handling expiration immediately.',
          offerId: offer.id);
      // Ensure it's not processed in a tight loop if already handled
      _fundedOfferTimers.remove(offer.id);
      _handleFundedOfferExpiration(offer);
    } else {
      AppLogger.info(
          'Starting funded offer expiration timer for offer ${offer.id} with remaining duration: ${remainingDuration.inSeconds}s',
          offerId: offer.id);
      _fundedOfferTimers[offer.id] = Timer(remainingDuration, () {
        AppLogger.info('Funded offer timer expired for offer ${offer.id}',
            offerId: offer.id);
        _handleFundedOfferExpiration(offer);
        _fundedOfferTimers.remove(offer.id);
      });
    }
  }

  Future<void> _handleFundedOfferExpiration(Offer offer) async {
    AppLogger.info('Handling funded offer expiration for offer ${offer.id}',
        offerId: offer.id);
    if (offer.status == OfferStatus.funded) {
      if (_paymentBackend != null) {
        try {
          await _paymentBackend!
              .cancelInvoice(paymentHashHex: offer.holdInvoicePaymentHash);
          AppLogger.info(
              'Hold invoice for offer ${offer.id} cancelled via $_paymentBackendType due to expiration.',
              offerId: offer.id);
          sleep(Duration(seconds: 1));
          final invoiceDetails = await _paymentBackend!
              .lookupInvoice(paymentHashHex: offer.holdInvoicePaymentHash);
          // TODO this will not work for NWC, we need to handle it
          if (invoiceDetails.status == InvoiceStatus.CANCELED) {
            AppLogger.info(
                'Verified invoice ${offer.holdInvoicePaymentHash} is cancelled via $_paymentBackendType.');
          } else {
            AppLogger.info(
                'Warning: Invoice ${offer.holdInvoicePaymentHash} status is ${invoiceDetails.status}, expected CANCELED.');
            return; // Exit if cancellation fails
          }
        } catch (e) {
          AppLogger.info(
              'Error cancelling hold invoice for expired offer ${offer.id} using  $e',
              offerId: offer.id);
          return; // Exit if cancellation fails
        }
      } else {
        AppLogger.info(
            'CRITICAL: No payment backend to cancel invoice for expired offer ${offer.id}.',
            offerId: offer.id);
      }
      final dbSuccess =
          await _dbService.updateOfferStatus(offer.id, OfferStatus.expired);
      if (dbSuccess) {
        AppLogger.info(
            'Offer ${offer.id} status updated to expired in DB due to expiration.',
            offerId: offer.id);

        // Publish status update
        final expiredOffer = await _dbService.getOfferById(offer.id);
        if (expiredOffer != null) {
          await _publishStatusUpdate(expiredOffer);
          await _nostrService?.broadcastNip69OrderFromOffer(expiredOffer);
        }
      } else {
        AppLogger.info(
            'Failed to update offer ${offer.id} status to expired in DB after expiration.',
            offerId: offer.id);
      }
    } else {
      AppLogger.info(
          'Offer ${offer.id} is no longer funded (current status: ${offer.status}). No action needed for funded expiration.',
          offerId: offer.id);
    }
  }

  void _startTakerChargedTimer(Offer offer) {
    if (offer.status != OfferStatus.takerCharged) {
      AppLogger.info(
          'Error: Cannot start taker charged timer for offer ${offer.id} - not in state takerCharged, status is ${offer.status}',
          offerId: offer.id);
      return;
    }
    _takerChargedTimers[offer.id]?.cancel();

    final now = _clock.now().toUtc();
    // Use createdAt as the base for timer calculation since that's when the hold invoice was created
    final expirationTime = offer.createdAt
        .add(Duration(seconds: _takerChargedAutoConfirmTimeoutSeconds));
    final remainingDuration = expirationTime.difference(now);

    if (remainingDuration.isNegative || remainingDuration.inSeconds == 0) {
      AppLogger.info(
          'Offer ${offer.id} has already passed its expiration time. Handling expiration immediately.',
          offerId: offer.id);
      // Ensure it's not processed in a tight loop if already handled
      _takerChargedTimers.remove(offer.id);
      _handleTakerChargedAutoConfirmation(offer);
    } else {
      AppLogger.info(
          'Starting taker charged auto confirmationtimer for offer ${offer.id} with remaining duration: ${remainingDuration.inSeconds}s',
          offerId: offer.id);
      _takerChargedTimers[offer.id] = Timer(remainingDuration, () {
        AppLogger.info(
            'taker charged auto confirmation timer expired for offer ${offer.id}',
            offerId: offer.id);
        _handleTakerChargedAutoConfirmation(offer);
        _takerChargedTimers.remove(offer.id);
      });
    }
  }

  void _startConflictTimer(Offer offer) {
    if (offer.status != OfferStatus.conflict) {
      AppLogger.info(
          'Error: Cannot start conflict timer for offer ${offer.id} - not in state conflict, status is ${offer.status}',
          offerId: offer.id);
      return;
    }

    _conflictTimers[offer.id]?.cancel();

    final now = _clock.now().toUtc();
    final conflictStartAt = (offer.updatedAt ?? now).toUtc();
    final expirationTime = conflictStartAt
        .add(Duration(seconds: _conflictAutoDisputeTimeoutSeconds));
    final remainingDuration = expirationTime.difference(now);

    if (remainingDuration.isNegative || remainingDuration.inSeconds == 0) {
      AppLogger.info(
          'Offer ${offer.id} has already passed conflict timeout. Handling auto dispute immediately.',
          offerId: offer.id);
      _conflictTimers.remove(offer.id);
      _handleConflictTimeout(offer.id);
      return;
    }

    AppLogger.info(
        'Starting conflict auto dispute timer for offer ${offer.id} with remaining duration: ${remainingDuration.inSeconds}s',
        offerId: offer.id);
    _conflictTimers[offer.id] = Timer(remainingDuration, () {
      AppLogger.info('Conflict timer expired for offer ${offer.id}',
          offerId: offer.id);
      _conflictTimers.remove(offer.id);
      _handleConflictTimeout(offer.id);
    });
  }

  Future<void> _handleConflictTimeout(String offerId) async {
    AppLogger.info('Handling conflict timeout for offer $offerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null) {
      AppLogger.info(
          'Offer $offerId not found while handling conflict timeout.',
          offerId: offerId);
      return;
    }
    if (offer.status != OfferStatus.conflict) {
      AppLogger.info(
          'Offer $offerId is no longer in conflict (current status: ${offer.status}). No action needed for conflict timeout.',
          offerId: offerId);
      return;
    }

    final success = await openDispute(offerId, offer.makerPubkey);
    if (!success) {
      AppLogger.info(
          'Failed to auto-open dispute for offer $offerId after conflict timeout.',
          offerId: offerId);
    }
  }

  Future<void> _handleTakerChargedAutoConfirmation(Offer offer) async {
    AppLogger.info(
        'Handling taker charged auto confirmation expiration for offer ${offer.id}',
        offerId: offer.id);
    if (offer.status == OfferStatus.takerCharged) {
      if (_paymentBackend != null) {
        try {
          final success =
              await confirmMakerPayment(offer.id, offer.makerPubkey);
          if (!success) {
            throw Exception(
                'Failed to confirm payment. Check offer state, LND connection, or logs.');
          }
        } catch (e) {
          AppLogger.info(
              'Error auto confirming offer after $_takerChargedAutoConfirmTimeoutSeconds seconds in status taker charged $e');
          return; // Exit if cancellation fails
        }
      } else {
        AppLogger.info(
            'CRITICAL: No payment backend auto confirm offer in status takerCharged.');
      }
    } else {
      AppLogger.info(
          'Offer ${offer.id} is no longer in takerCharged status (current status: ${offer.status}). No action needed for takerCharged auto confirmation expiration',
          offerId: offer.id);
    }
  }

  // --- Coordinator Info Endpoint ---
  Future<Map<String, dynamic>> getCoordinatorInfo() async {
    final Map<String, dynamic> info = {
      'name': _coordinatorName,
      'reservation_seconds': _reservationTimeoutSeconds,
      'maker_fee': _makerFeePercentage,
      'taker_fee': _takerFeePercentage,
      'min_amount_sats': _minAmountSats,
      'max_amount_sats': _maxAmountSats,
      'currencies': _supportedCurrencies,
      'terms_of_usage_naddr': _termsOfUsageNaddr,
    };

    if (_coordinatorIconUrl.isNotEmpty) {
      info['icon'] = _coordinatorIconUrl;
    }

    // Read version from environment variable, with fallback to pubspec.yaml
    final versionFromEnv = Platform.environment['APP_VERSION'];
    if (versionFromEnv != null && versionFromEnv.isNotEmpty) {
      info['version'] = versionFromEnv;
    } else {
      try {
        final pubspecFile = File('pubspec.yaml');
        if (await pubspecFile.exists()) {
          final yamlContent = await pubspecFile.readAsString();
          final yamlMap = loadYaml(yamlContent);
          final version = yamlMap['version'];
          if (version != null) {
            info['version'] = version.toString();
          }
        }
      } catch (_) {}
    }
    return info;
  }

  // --- Other API Endpoint Logic ---

  Future<List<Offer>> getMyActiveOffers(String userPubkey) async {
    // AppLogger.info('Fetching active offers for user: $userPubkey');
    return await _dbService.getMyActiveOffers(userPubkey);
  }

  Future<Offer?> getOfferByPaymentHash(String paymentHash) async {
    // AppLogger.info('Fetching offer by payment hash: $paymentHash');
    return await _dbService.getOfferByPaymentHash(paymentHash);
  }

  Future<Offer?> getOfferById(String offerId) async {
    // AppLogger.info('Fetching offer by ID: $offerId', offerId: offerId);
    return await _dbService.getOfferById(offerId);
  }

  Future<DateTime?> reserveOffer(String offerId, String takerId) async {
    AppLogger.info('Reserving offer $offerId for taker $takerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null ||
        (offer.status != OfferStatus.funded &&
            offer.status != OfferStatus.invalidBlik &&
            offer.status != OfferStatus.expiredSentBlik &&
            offer.status != OfferStatus.expiredBlik) ||
        ((offer.status == OfferStatus.invalidBlik ||
                offer.status == OfferStatus.expiredBlik) &&
            offer.takerPubkey != takerId)) {
      AppLogger.info(
          'Offer $offerId not found or not available for reservation status:${offer?.status}.',
          offerId: offerId);
      _fundedOfferTimers[offerId]?.cancel();
      _fundedOfferTimers.remove(offerId);
      return null;
    }

    final now = DateTime.now().toUtc();
    final timestampToStore = now.add(const Duration(seconds: 1));

    final success = await _dbService.updateOfferStatus(
      offerId,
      OfferStatus.reserved,
      takerPubkey: takerId,
      reservedAt: timestampToStore,
    );

    if (success) {
      AppLogger.info(
          'Offer $offerId reserved successfully, DB timestamp set to $timestampToStore.',
          offerId: offerId);
      _fundedOfferTimers[offerId]?.cancel();
      _fundedOfferTimers.remove(offerId);
      _startReservationTimer(offerId);

      // Publish status update
      final updatedOffer = await _dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _publishStatusUpdate(updatedOffer);
        await _nostrService?.broadcastNip69OrderFromOffer(updatedOffer);
      }

      return timestampToStore;
    } else {
      AppLogger.info('Failed to reserve offer $offerId in DB.',
          offerId: offerId);
      return null;
    }
  }

  void _startReservationTimer(String offerId) {
    _reservationTimers[offerId]?.cancel();
    AppLogger.info(
        'Starting $_reservationTimeoutSeconds\s reservation timer for offer $offerId',
        offerId: offerId);
    _reservationTimers[offerId] =
        Timer(Duration(seconds: _reservationTimeoutSeconds), () {
      AppLogger.info('Reservation timer expired for offer $offerId',
          offerId: offerId);
      _handleReservationTimeout(offerId);
      _reservationTimers.remove(offerId);
    });
  }

  // New private method to handle reverting an offer to funded state
  Future<bool> _revertOfferToFunded(String offerId) async {
    AppLogger.info('Reverting offer $offerId to funded state.',
        offerId: offerId);
    final success = await _dbService.updateOfferStatus(
      offerId,
      OfferStatus.funded,
      takerPubkey: null,
      blikCode: null,
      takerLightningAddress: null,
      reservedAt: null, // Ensure reservedAt is cleared
    );
    if (success) {
      // AppLogger.info('Offer $offerId successfully reverted to funded.',
      //     offerId: offerId);
      // Restart the funded offer timer
      final offer = await _dbService.getOfferById(offerId);
      if (offer != null) {
        _startFundedOfferTimer(offer);
      } else {
        AppLogger.info(
            'Error: Could not find offer $offerId after reverting to funded to restart timer.',
            offerId: offerId);
      }
    } else {
      AppLogger.info('Error reverting offer $offerId to funded in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<void> _handleReservationTimeout(String offerId) async {
    AppLogger.info('Handling reservation timeout for offer $offerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer != null && offer.status == OfferStatus.reserved) {
      AppLogger.info(
          'Offer $offerId is still reserved. Reverting status to funded due to timeout.',
          offerId: offerId);
      final reverted = await _revertOfferToFunded(offerId);
      if (reverted) {
        // Publish status update
        final revertedOffer = await _dbService.getOfferById(offerId);
        if (revertedOffer != null) {
          await _publishStatusUpdate(revertedOffer);
          await _nostrService?.broadcastNip69OrderFromOffer(revertedOffer);
        }
      }
    } else {
      AppLogger.info(
          'Offer $offerId no longer reserved (current status: ${offer?.status}). No action needed for reservation timeout.',
          offerId: offerId);
    }
  }

  void _startBlikConfirmationTimer(String offerId) {
    _blikConfirmationTimers[offerId]?.cancel();
    AppLogger.info(
        '### COORDINATOR: Starting 120s BLIK confirmation timer for offer $offerId',
        offerId: offerId);
    _blikConfirmationTimers[offerId] = Timer(const Duration(seconds: 120), () {
      AppLogger.info(
          '### COORDINATOR: Raw timer expired for offer $offerId. Calling handler...',
          offerId: offerId);
      _handleBlikConfirmationTimeout(offerId);
      _blikConfirmationTimers.remove(offerId);
    });
  }

  Future<void> _handleBlikConfirmationTimeout(String offerId) async {
    AppLogger.info(
        '### COORDINATOR: Handling BLIK confirmation timeout for offer $offerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer != null &&
        (offer.status == OfferStatus.blikReceived ||
            offer.status == OfferStatus.blikSentToMaker)) {
      final newStatus = offer.status == OfferStatus.blikReceived
          ? OfferStatus.expiredBlik
          : OfferStatus.expiredSentBlik;
      AppLogger.info(
          'Offer ${offer.id} BLIK confirmation timed out (status: ${offer.status}). Transitioning to $newStatus',
          offerId: offer.id);
      final success = await _dbService.updateOfferStatus(
        offerId,
        newStatus,
        // Clear BLIK related fields as well
        blikCode: null,
        takerLightningAddress: null,
        blikReceivedAt: null,
      );
      if (success) {
        AppLogger.info(
            'Offer $offerId status reverted to $newStatus to BLIK confirmation timeout.',
            offerId: offerId);

        // Publish status update
        final revertedOffer = await _dbService.getOfferById(offerId);
        if (revertedOffer != null) {
          await _publishStatusUpdate(revertedOffer);
        }

        // TODO start 60min timer to settle the invoice
        //_startFundedOfferTimer(offer);
      } else {
        AppLogger.info(
            'Error reverting offer $offerId status after BLIK confirmation timeout.',
            offerId: offerId);
      }
    } else {
      AppLogger.info(
          'Offer $offerId no longer awaiting BLIK confirmation (current status: ${offer?.status}). No action needed for BLIK timeout.',
          offerId: offerId);
    }
  }

  Future<bool> submitBlikCode(String offerId, String takerId, String blikCode,
      String? takerLightningAddress, String? takerInvoice) async {
    AppLogger.info(
        'Submitting BLIK $blikCode for offer $offerId by taker $takerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null ||
        offer.status != OfferStatus.reserved ||
        offer.takerPubkey != takerId) {
      AppLogger.info(
          'Offer $offerId not found, not reserved, or taker mismatch.',
          offerId: offerId);
      return false;
    }

    final netAmountSats = offer.amountSats -
        (offer.takerFees ??
            (offer.amountSats * _takerFeePercentage / 100).ceil());
    AppLogger.info(
        'Calculated net amount for taker invoice: $netAmountSats sats (Original: ${offer.amountSats}, Fee: ${offer.takerFees})');

    if (takerInvoice == null) {
      if (takerLightningAddress == null || takerLightningAddress.isEmpty) {
        AppLogger.info(
            'Cannot resolve LNURL invoice for offer $offerId: missing takerLightningAddress and takerInvoice.',
            offerId: offerId);
        return false;
      }
      takerInvoice =
          await _resolveLnurlPay(takerLightningAddress, netAmountSats);
    } else {
      final req = Bolt11PaymentRequest(takerInvoice);
      final invoiceAmountSats =
          (req.amount * Decimal.fromInt(100000000)).toBigInt().toInt();
      if (invoiceAmountSats > netAmountSats + 10) {
        // Allow small rounding difference because of slight rate different between client/server
        throw Exception(
            'Provided taker invoice amount ${invoiceAmountSats} sats is greater than expected net amount $netAmountSats sats.');
      }
      if (invoiceAmountSats < netAmountSats - 100) {
        // Allow small rounding difference because of slight rate different between client/server
        throw Exception(
            'Provided taker invoice amount ${invoiceAmountSats} sats is much smaller than expected net amount $netAmountSats sats.');
      }
    }
    if (takerInvoice == null || takerInvoice.isEmpty) {
      AppLogger.info(
          'Could not get an invoice for net amount $netAmountSats sats for LN address $takerLightningAddress');
      return false;
    }
    // The following line seems to be a copy-paste error, the condition is already checked above.
    // AppLogger.info('Offer $offerId not found, not reserved, or taker mismatch.', offerId: offerId);

    _reservationTimers[offerId]?.cancel();
    _reservationTimers.remove(offerId);
    AppLogger.info(
        'Cancelled reservation timer for offer $offerId due to BLIK submission.',
        offerId: offerId);

    final blikReceivedTime = DateTime.now().toUtc();

    final invoiceStored =
        await _dbService.updateTakerInvoice(offerId, takerInvoice);
    if (!invoiceStored) {
      AppLogger.info(
          'Failed to persist taker invoice for offer $offerId. Rejecting BLIK submission.',
          offerId: offerId);
      return false;
    }

    final success = await _dbService.updateOfferStatus(
        offerId, OfferStatus.blikReceived,
        blikCode: blikCode,
        takerLightningAddress: takerLightningAddress,
        blikReceivedAt: blikReceivedTime);

    if (success) {
      AppLogger.info('BLIK code for offer $offerId stored.', offerId: offerId);
      _startBlikConfirmationTimer(offerId);

      // Publish status update
      final updatedOffer = await _dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _publishStatusUpdate(updatedOffer);
      }
    } else {
      AppLogger.info('Failed to store BLIK code for offer $offerId in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<String?> getBlikCodeForMaker(String offerId, String makerId) async {
    AppLogger.info('Maker $makerId requesting BLIK for offer $offerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null ||
        offer.makerPubkey != makerId ||
        offer.blikCode == null) {
      AppLogger.info(
          'Offer $offerId not found, maker mismatch, status not blikReceived/blikSentToMaker, or no BLIK code available.',
          offerId: offerId);
      return null;
    }
    // Allow fetching if status is blikReceived OR blikSentToMaker
    if (offer.status != OfferStatus.blikReceived &&
        offer.status != OfferStatus.blikSentToMaker) {
      AppLogger.info(
          'Offer $offerId not in correct state (${offer.status}) to provide BLIK code to maker.',
          offerId: offerId);
      return null;
    }

    try {
      // Only update to blikSentToMaker if it's currently blikReceived
      if (offer.status == OfferStatus.blikReceived) {
        final statusUpdated = await _dbService.updateOfferStatus(
            offerId, OfferStatus.blikSentToMaker);
        if (!statusUpdated) {
          AppLogger.info(
              'Warning: Failed to update offer $offerId status to blikSentToMaker, but returning code anyway.',
              offerId: offerId);
        } else {
          AppLogger.info('Offer $offerId status updated to blikSentToMaker.',
              offerId: offerId);

          // Publish status update
          final updatedOffer = await _dbService.getOfferById(offerId);
          if (updatedOffer != null) {
            await _publishStatusUpdate(updatedOffer);
          }
        }
      }
      // Restart timer to continue monitoring for expiration even after maker gets the code
      // The timer should still fire after 2 minutes from blikReceivedAt to check if maker confirmed
      _blikConfirmationTimers[offerId]?.cancel();
      _blikConfirmationTimers.remove(offerId);
      // Restart the timer, but calculate remaining time from blikReceivedAt
      if (offer.blikReceivedAt != null) {
        final now = _clock.now().toUtc();
        final elapsed = now.difference(offer.blikReceivedAt!);
        const timeoutDuration = Duration(seconds: 120);
        final remaining = timeoutDuration - elapsed;
        if (remaining > Duration.zero) {
          _blikConfirmationTimers[offerId] = Timer(remaining, () {
            AppLogger.info(
                '### COORDINATOR: Raw timer expired for offer $offerId. Calling handler...',
                offerId: offerId);
            _handleBlikConfirmationTimeout(offerId);
            _blikConfirmationTimers.remove(offerId);
          });
        } else {
          // Already expired, handle immediately
          _handleBlikConfirmationTimeout(offerId);
        }
      } else {
        // Fallback: restart with full duration if blikReceivedAt is missing
        _startBlikConfirmationTimer(offerId);
      }
    } catch (e) {
      AppLogger.info('Error during getBlikCodeForMaker for offer $offerId: $e',
          offerId: offerId);
    }

    AppLogger.info('Returning BLIK code for offer $offerId to maker.',
        offerId: offerId);
    return offer.blikCode;
  }

  Future<bool> markBlikInvalid(String offerId, String makerId) async {
    AppLogger.warning('Maker $makerId marking BLIK as invalid for offer $offerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);

    if (offer == null || offer.makerPubkey != makerId) {
      AppLogger.warning(
          'Offer $offerId not found or maker ID mismatch for marking BLIK invalid.',
          offerId: offerId);
      return false;
    }

    if (offer.status != OfferStatus.takerCharged &&
        offer.status != OfferStatus.blikSentToMaker &&
        offer.status != OfferStatus.expiredSentBlik) {
      AppLogger.warning(
          'Offer $offerId is not in a state where BLIK can be marked invalid (current state: ${offer.status}).',
          offerId: offerId);
      return false;
    }

    _blikConfirmationTimers[offerId]?.cancel();
    _blikConfirmationTimers.remove(offerId);
    // AppLogger.info(
    //     'Cancelled BLIK confirmation timer for offer $offerId (if active).',
    //     offerId: offerId);

    final newStatus = offer.status != OfferStatus.takerCharged
        ? OfferStatus.invalidBlik
        : OfferStatus.conflict;

    final success = await _dbService.updateOfferStatus(offerId, newStatus);

    if (success) {
      AppLogger.info('Offer $offerId status updated to $newStatus.',
          offerId: offerId);

      // Publish status update
      final updatedOffer = await _dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _publishStatusUpdate(updatedOffer);
        if (newStatus == OfferStatus.conflict) {
          _startConflictTimer(updatedOffer);
        } else {
          _conflictTimers[offerId]?.cancel();
          _conflictTimers.remove(offerId);
        }
      }
    } else {
      AppLogger.warning(
          'Failed to update offer $offerId status to $newStatus in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<bool> markBlikCharged(String offerId, String takerId) async {
    AppLogger.info('Taker $takerId marking offer $offerId as charged.',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);

    if (offer == null || offer.takerPubkey != takerId) {
      AppLogger.info(
          'Offer $offerId not found or taker ID mismatch for marking conflict.',
          offerId: offerId);
      return false;
    }

    if (offer.status != OfferStatus.invalidBlik &&
        offer.status != OfferStatus.expiredSentBlik) {
      AppLogger.info(
          'Offer $offerId is in wrong state (current state: ${offer.status}). Cannot mark as charged.',
          offerId: offerId);
      return false;
    }

    final newStatus = offer.status == OfferStatus.invalidBlik
        ? OfferStatus.conflict
        : OfferStatus.takerCharged;
    final success = await _dbService.updateOfferStatus(offerId, newStatus);

    if (success) {
      AppLogger.info('Offer $offerId status updated to $newStatus.',
          offerId: offerId);

      // Publish status update
      final updatedOffer = await _dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _publishStatusUpdate(updatedOffer);
        await _nostrService?.broadcastNip69OrderFromOffer(updatedOffer);
        if (newStatus == OfferStatus.conflict) {
          _startConflictTimer(updatedOffer);
        } else {
          _conflictTimers[offerId]?.cancel();
          _conflictTimers.remove(offerId);
        }
      }
      if (newStatus == OfferStatus.takerCharged && updatedOffer != null) {
        _startTakerChargedTimer(updatedOffer);
      }
    } else {
      AppLogger.info(
          'Failed to update offer $offerId status to $newStatus in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<bool> openDispute(String offerId, String makerId) async {
    AppLogger.info('Maker $makerId marking offer $offerId as dispute.',
        offerId: offerId);
    _conflictTimers[offerId]?.cancel();
    _conflictTimers.remove(offerId);
    final offer = await _dbService.getOfferById(offerId);

    if (offer == null || offer.makerPubkey != makerId) {
      AppLogger.info(
          'Offer $offerId not found or maker ID mismatch for opening dispute.',
          offerId: offerId);
      return false;
    }

    if (offer.status != OfferStatus.conflict) {
      AppLogger.info(
          'Offer $offerId is not in the conflict state (current state: ${offer.status}). Cannot mark as open dispute.',
          offerId: offerId);
      return false;
    }
    try {
      if (_paymentBackend != null) {
        await _paymentBackend!
            .settleInvoice(preimageHex: offer.holdInvoicePreimage);
        AppLogger.info(
            'Hold invoice for offer $offerId settled successfully via $_paymentBackendType.',
            offerId: offerId);
      } else {
        AppLogger.info(
            'CRITICAL: No payment backend to settle invoice for offer $offerId.',
            offerId: offerId);
        throw Exception("No payment backend to settle invoice.");
      }
    } catch (e) {
      AppLogger.info('Error settling hold invoice for offer $offerId: $e',
          offerId: offerId);
      // ....
      return false;
    }

    final success =
        await _dbService.updateOfferStatus(offerId, OfferStatus.dispute);

    if (success) {
      AppLogger.info('Offer $offerId status updated to dispute.',
          offerId: offerId);

      // Publish status update
      final updatedOffer = await _dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _publishStatusUpdate(updatedOffer);
        await _nostrService?.broadcastNip69OrderFromOffer(updatedOffer);
      }
    } else {
      AppLogger.info('Failed to update offer $offerId status to dispute in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<bool> confirmMakerPayment(String offerId, String makerId) async {
    AppLogger.info('Maker $makerId confirming payment for offer $offerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null ||
        offer.makerPubkey != makerId ||
        (offer.status !=
                OfferStatus
                    .conflict && // Allow confirmation from conflict state
            offer.status !=
                OfferStatus
                    .takerCharged && // Allow confirmation from takerCharged state
            offer.status !=
                OfferStatus
                    .blikSentToMaker && // Allow confirmation from blikSentToMaker state
            offer.status !=
                OfferStatus
                    .expiredSentBlik // Allow confirmation from expiredSentBlik state
        )) {
      AppLogger.info(
          'Offer $offerId not found, maker mismatch, or not in correct state for confirmation (current: ${offer?.status}).',
          offerId: offerId);
      return false;
    }

    _reservationTimers[offerId]?.cancel();
    _reservationTimers.remove(offerId);
    _blikConfirmationTimers[offerId]?.cancel();
    _blikConfirmationTimers.remove(offerId);
    _conflictTimers[offerId]?.cancel();
    _conflictTimers.remove(offerId);
    AppLogger.info(
        'Cancelled timers for offer $offerId during maker confirmation.',
        offerId: offerId);

    bool success =
        await _dbService.updateOfferStatus(offerId, OfferStatus.makerConfirmed);
    if (!success) {
      AppLogger.info(
          'Failed to update offer $offerId status to makerConfirmed in DB.',
          offerId: offerId);
      return false;
    }
    AppLogger.info('Offer $offerId status updated to makerConfirmed.',
        offerId: offerId);

    final updatedOffer = await _dbService.getOfferById(offerId);
    if (updatedOffer != null) {
      await _publishStatusUpdate(updatedOffer);
    }

    try {
      if (_paymentBackend != null) {
        await _paymentBackend!
            .settleInvoice(preimageHex: offer.holdInvoicePreimage);
        AppLogger.info(
            'Hold invoice for offer $offerId settled successfully via $_paymentBackendType.',
            offerId: offerId);
      } else {
        AppLogger.info(
            'CRITICAL: No payment backend to settle invoice for offer $offerId.',
            offerId: offerId);
        throw Exception("No payment backend to settle invoice.");
      }
      await Future.delayed(_kDebugDelayDuration);
      success =
          await _dbService.updateOfferStatus(offerId, OfferStatus.settled);
      if (!success) {
        AppLogger.info(
            'Failed to update offer $offerId status to settled in DB.',
            offerId: offerId);
      } else {
        // Publish status update
        final settledOffer = await _dbService.getOfferById(offerId);
        if (settledOffer != null) {
          await _publishStatusUpdate(settledOffer);
        }
      }
    } catch (e) {
      AppLogger.info('Error settling hold invoice for offer $offerId: $e',
          offerId: offerId);
      // Potentially revert makerConfirmed status or set to a failed state
      return false;
    }

    Future.microtask(() => _payTakerAsync(offerId));
    return true;
  }

  Future<bool> updateTakerInvoice(
      String offerId, String takerInvoice, String userPubkey) async {
    AppLogger.info(
        'Updating taker invoice for offer $offerId by user $userPubkey',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null) {
      AppLogger.info('Offer $offerId not found.', offerId: offerId);
      return false;
    }
    if (offer.takerPubkey != userPubkey) {
      AppLogger.info('User pubkey mismatch for updating taker invoice.');
      return false;
    }
    final success = await _dbService.updateTakerInvoice(offerId, takerInvoice);
    if (success) {
      AppLogger.info('Taker invoice updated for offer $offerId.',
          offerId: offerId);
    } else {
      AppLogger.info('Failed to update taker invoice for offer $offerId.',
          offerId: offerId);
    }
    return success;
  }

  Future<bool> cancelReservation(String offerId, String takerId) async {
    AppLogger.info(
        'Taker $takerId attempting to cancel reservation for offer $offerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null) {
      AppLogger.info('Offer $offerId not found.', offerId: offerId);
      return false;
    }
    if (offer.takerPubkey != takerId) {
      AppLogger.info(
          'Taker mismatch for cancelling reservation on offer $offerId.',
          offerId: offerId);
      return false;
    }
    if (offer.status != OfferStatus.reserved &&
        offer.status != OfferStatus.expiredBlik &&
        offer.status != OfferStatus.invalidBlik) {
      AppLogger.info(
          'Offer $offerId cannot be cancelled in status ${offer.status}.',
          offerId: offerId);
      _reservationTimers[offerId]?.cancel();
      _reservationTimers.remove(offerId);
      return false;
    }

    _reservationTimers[offerId]?.cancel();
    _reservationTimers.remove(offerId);

    // Revert offer to funded using the new method
    final reverted = await _revertOfferToFunded(offerId);

    if (reverted) {
      AppLogger.info('Reservation for offer $offerId cancelled by taker.',
          offerId: offerId);

      // Publish status update
      final revertedOffer = await _dbService.getOfferById(offerId);
      if (revertedOffer != null) {
        await _publishStatusUpdate(revertedOffer);
        await _nostrService?.broadcastNip69OrderFromOffer(revertedOffer);
      }

      return true;
    } else {
      AppLogger.info(
          'Failed to cancel reservation for offer $offerId (DB update failed).',
          offerId: offerId);
      return false;
    }
  }

  Future<bool> cancelOffer(String offerId, String makerId) async {
    AppLogger.info('Maker $makerId attempting to cancel offer $offerId',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null) {
      AppLogger.info('Offer $offerId not found.', offerId: offerId);
      return false;
    }
    if (offer.makerPubkey != makerId) {
      AppLogger.info('Maker mismatch for cancelling offer $offerId.',
          offerId: offerId);
      return false;
    }
    if (offer.status != OfferStatus.funded) {
      AppLogger.info(
          'Offer $offerId cannot be cancelled in status ${offer.status}.',
          offerId: offerId);
      _fundedOfferTimers[offerId]?.cancel();
      _fundedOfferTimers.remove(offerId);
      return false;
    }

    _fundedOfferTimers[offerId]?.cancel();
    _fundedOfferTimers.remove(offerId);

    if (_paymentBackend != null) {
      try {
        await _paymentBackend!
            .cancelInvoice(paymentHashHex: offer.holdInvoicePaymentHash);
        AppLogger.info(
            'Hold invoice for offer $offerId cancelled successfully via $_paymentBackendType.',
            offerId: offerId);
      } catch (e) {
        AppLogger.info(
            'Error cancelling hold invoice for offer $offerId using  $e',
            offerId: offerId);
      }
    } else {
      AppLogger.info(
          'CRITICAL: No payment backend to cancel invoice for offer $offerId.',
          offerId: offerId);
    }

    final dbSuccess = await _dbService.cancelOffer(offerId, makerId);
    if (dbSuccess) {
      AppLogger.info('Offer $offerId status updated to cancelled in DB.',
          offerId: offerId);

      // Publish status update
      final cancelledOffer = await _dbService.getOfferById(offerId);
      if (cancelledOffer != null) {
        await _publishStatusUpdate(cancelledOffer);
        await _nostrService?.broadcastNip69OrderFromOffer(cancelledOffer);
      }

      _invoiceSubscriptions[offer.holdInvoicePaymentHash]?.cancel();
      _invoiceSubscriptions.remove(offer.holdInvoicePaymentHash);
      _pendingOffers.remove(offer.holdInvoicePaymentHash);
      return true;
    } else {
      AppLogger.info(
          'Failed to update offer $offerId status to cancelled in DB.',
          offerId: offerId);
      return false;
    }
  }

  Future<void> _payTakerAsync(String offerId) async {
    AppLogger.info('Starting async taker payment process for offer $offerId...',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null) {
      AppLogger.info('Async Error: Offer $offerId not found for taker payment.',
          offerId: offerId);
      return;
    }
    if (offer.status != OfferStatus.settled) {
      AppLogger.info(
          'Async Error: Offer $offerId not in settled state (state is ${offer.status}). Cannot pay taker.',
          offerId: offerId);
      return;
    }

    // Calculate net amount after taker fees
    final takerFees = (offer.amountSats * _takerFeePercentage / 100)
        .ceil(); // Use static field
    final netAmountSats = offer.amountSats - takerFees;
    String? takerInvoice = offer.takerInvoice;

    if (takerInvoice == null || takerInvoice.isEmpty) {
      if (offer.takerLightningAddress == null ||
          offer.takerLightningAddress!.isEmpty) {
        AppLogger.info(
            'Async Error: Missing both taker invoice and Lightning Address for offer $offerId.',
            offerId: offerId);
        await _dbService.updateOfferStatus(
            offerId, OfferStatus.takerPaymentFailed);
        final failedOffer = await _dbService.getOfferById(offerId);
        if (failedOffer != null) {
          await _publishStatusUpdate(failedOffer);
        }
        return;
      }

      AppLogger.info(
          'Async: No stored taker invoice. Attempting LNURL resolution for ${offer.takerLightningAddress} and net amount $netAmountSats sats (Original: ${offer.amountSats}, Fee: $takerFees)');
    } else {
      AppLogger.info(
          'Async: Using stored taker invoice for offer $offerId and net amount $netAmountSats sats (Original: ${offer.amountSats}, Fee: $takerFees)',
          offerId: offerId);
    }

    try {
      if (takerInvoice == null || takerInvoice.isEmpty) {
        takerInvoice =
            await _resolveLnurlPay(offer.takerLightningAddress!, netAmountSats);
        if (takerInvoice == null || takerInvoice.isEmpty) {
          AppLogger.info(
              'Async Error: Failed to resolve LNURL for net amount $netAmountSats for offer $offerId.',
              offerId: offerId);
          await _dbService.updateOfferStatus(
              offerId, OfferStatus.takerPaymentFailed);
          final failedOffer = await _dbService.getOfferById(offerId);
          if (failedOffer != null) {
            await _publishStatusUpdate(failedOffer);
          }
          return;
        }

        bool invoiceStored =
            await _dbService.updateTakerInvoice(offerId, takerInvoice);
        if (!invoiceStored) {
          AppLogger.info(
              'Async Warning: Failed to store resolved taker invoice for offer $offerId. Proceeding with payment attempt.',
              offerId: offerId);
        }
      }
      await _sendTakerPayment(offerId, takerInvoice);
    } catch (e) {
      AppLogger.info(
          'Async Exception during taker payment for offer $offerId: $e',
          offerId: offerId);
      await _dbService.updateOfferStatus(
          offerId, OfferStatus.takerPaymentFailed);
      final failedOffer = await _dbService.getOfferById(offerId);
      if (failedOffer != null) {
        await _publishStatusUpdate(failedOffer);
      }
    }
  }

  Future<String?> _sendTakerPayment(String offerId, String takerInvoice) async {
    AppLogger.info('Attempting to send taker payment for offer $offerId...',
        offerId: offerId);
    try {
      final offer = await _dbService.getOfferById(offerId);
      if (offer == null) {
        AppLogger.info('Offer $offerId not found for taker payment.',
            offerId: offerId);
        await _dbService.updateOfferStatus(
            offerId, OfferStatus.takerPaymentFailed);
        return "invalid offer";
      }
      await Future.delayed(_kDebugDelayDuration);
      await _dbService.updateOfferStatus(offerId, OfferStatus.payingTaker);

      // Publish status update
      final payingOffer = await _dbService.getOfferById(offerId);
      if (payingOffer != null) {
        await _publishStatusUpdate(payingOffer);
      }

      // Calculate taker fees (configurable % of the original offer amount)
      final takerFees = (offer.amountSats * _takerFeePercentage / 100).ceil();
      final netAmountSats = offer.amountSats - takerFees;
      AppLogger.info(
          'Calculated taker fees for offer $offerId: $takerFees sats. Paying net amount: $netAmountSats sats.',
          offerId: offerId);

      if (_paymentBackend == null) {
        AppLogger.info(
            'CRITICAL: No payment backend configured for _sendTakerPayment.');
        await _dbService.updateOfferStatus(
            offerId, OfferStatus.takerPaymentFailed);
        return 'No payment backend configured.';
      }

      final feeLimitSat = (offer.takerFees! * kTakerFeeLimitFactor).ceil();
      AppLogger.info(
          ' Attempting to pay invoice for offer $offerId. Amount: $netAmountSats sats, Fee limit: $feeLimitSat sats.',
          offerId: offerId);

      final paymentResult = await _paymentBackend!.payInvoice(
        invoice: takerInvoice,
        amountSat: netAmountSats,
        feeLimitSat: feeLimitSat,
      );

      if (paymentResult.isSuccess) {
        AppLogger.info(
            ' Successfully paid taker for offer $offerId. Preimage: ${paymentResult.paymentPreimage}',
            offerId: offerId);
        await Future.delayed(_kDebugDelayDuration);
        await _dbService.updateOfferStatus(offerId, OfferStatus.takerPaid,
            takerFees: takerFees);
        await _dbService.updateTakerInvoiceFees(
            offerId, paymentResult.feeSat ?? 0);
        AppLogger.info(
            ' Updated taker invoice fees to ${paymentResult.feeSat ?? 0} sats for offer $offerId.',
            offerId: offerId);

        // Publish status update
        final paidOffer = await _dbService.getOfferById(offerId);
        if (paidOffer != null) {
          await _publishStatusUpdate(paidOffer);
          await _nostrService?.broadcastNip69OrderFromOffer(paidOffer);
        }

        return null; // Success
      } else {
        AppLogger.info(
            ' Failed to pay taker for offer $offerId. Reason: ${paymentResult.paymentError}',
            offerId: offerId);
        await _dbService.updateOfferStatus(
            offerId, OfferStatus.takerPaymentFailed);

        // Publish status update
        final failedOffer = await _dbService.getOfferById(offerId);
        if (failedOffer != null) {
          await _publishStatusUpdate(failedOffer);
        }

        return ' Failed to pay taker for offer $offerId. Reason: ${paymentResult.paymentError}';
      }
    } catch (e) {
      AppLogger.info(
          'Exception during taker payment for offer $offerId (using $_paymentBackendType): $e',
          offerId: offerId);
      await _dbService.updateOfferStatus(
          offerId, OfferStatus.takerPaymentFailed);
      // Publish status update
      final failedOffer = await _dbService.getOfferById(offerId);
      if (failedOffer != null) {
        await _publishStatusUpdate(failedOffer);
      }
      return 'Exception during taker payment for offer $offerId: $e';
    }
  }

  Future<String?> retryTakerPayment(String offerId, String userPubkey) async {
    AppLogger.info(
        'Retrying taker payment for offer $offerId by user $userPubkey',
        offerId: offerId);
    final offer = await _dbService.getOfferById(offerId);
    if (offer == null) {
      AppLogger.info('Offer $offerId not found.', offerId: offerId);
      return "invalid offer";
    }
    if (offer.takerPubkey != userPubkey) {
      AppLogger.info('User pubkey mismatch for retrying taker payment.');
      return "not your offer";
    }
    if (offer.takerInvoice == null || offer.takerInvoice!.isEmpty) {
      AppLogger.info('No taker invoice available for offer $offerId.',
          offerId: offerId);
      return "No taker invoice in offer";
    }
    return await _sendTakerPayment(offerId, offer.takerInvoice!);
  }

  Uint8List _generatePreimage() {
    final random = Random.secure();
    return Uint8List.fromList(
        List<int>.generate(32, (_) => random.nextInt(256)));
  }

  Uint8List hexToBytes(String hex) {
    hex = hex.replaceAll(RegExp(r'\s+'), '');
    if (hex.length % 2 != 0) {
      throw ArgumentError("Hex string must have an even number of characters");
    }
    final bytes = <int>[];
    for (int i = 0; i < hex.length; i += 2) {
      final hexPair = hex.substring(i, i + 2);
      bytes.add(int.parse(hexPair, radix: 16));
    }
    return Uint8List.fromList(bytes);
  }

  Future<String?> _resolveLnurlPay(
      String lightningAddress, int netAmountSats) async {
    try {
      if (!lightningAddress.contains('@')) {
        AppLogger.info('Invalid Lightning Address format: $lightningAddress');
        return null;
      }
      final parts = lightningAddress.split('@');
      final username = parts[0];
      final domain = parts[1];
      final lnurlpUrl = Uri.https(domain, '/.well-known/lnurlp/$username');
      AppLogger.info('LNURL: Requesting step 1 from $lnurlpUrl');
      final response1 = await _httpClient.get(lnurlpUrl); // Use _httpClient
      if (response1.statusCode != 200) {
        AppLogger.info(
            'LNURL Error: Step 1 request failed (${response1.statusCode}) for $lightningAddress: ${response1.body}');
        return null;
      }
      final data1 = jsonDecode(response1.body) as Map<String, dynamic>;
      if (data1['status'] == 'ERROR') {
        AppLogger.info(
            'LNURL Error: Service returned error in step 1 for $lightningAddress: ${data1['reason']}');
        return null;
      }
      if (data1['tag'] != 'payRequest') {
        AppLogger.info(
            'LNURL Error: Invalid tag in step 1 response for $lightningAddress: ${data1['tag']}');
        return null;
      }
      final callbackUrl = data1['callback'] as String?;
      final minSendable = data1['minSendable'] as int?;
      final maxSendable = data1['maxSendable'] as int?;
      if (callbackUrl == null || minSendable == null || maxSendable == null) {
        AppLogger.info(
            'LNURL Error: Missing required fields (callback, min/maxSendable) in step 1 for $lightningAddress');
        return null;
      }
      final amountMsats = netAmountSats * 1000;
      if (amountMsats < minSendable || amountMsats > maxSendable) {
        AppLogger.info(
            'LNURL Error: Net amount $netAmountSats sats ($amountMsats msats) is outside acceptable range ($minSendable - $maxSendable msats) for $lightningAddress');
        return null;
      }
      final callbackUri = Uri.parse(callbackUrl);
      final queryParams = Map<String, String>.from(callbackUri.queryParameters);
      queryParams['amount'] = amountMsats.toString();
      final finalUrl = callbackUri.replace(queryParameters: queryParams);
      AppLogger.info('LNURL: Requesting step 2 from $finalUrl');
      final response2 = await _httpClient.get(finalUrl); // Use _httpClient
      if (response2.statusCode != 200) {
        AppLogger.info(
            'LNURL Error: Step 2 request failed (${response2.statusCode}) for $lightningAddress: ${response2.body}');
        return null;
      }
      final data2 = jsonDecode(response2.body) as Map<String, dynamic>;
      if (data2['status'] == 'ERROR') {
        AppLogger.info(
            'LNURL Error: Service returned error in step 2 for $lightningAddress: ${data2['reason']}');
        return null;
      }
      final invoice = data2['pr'] as String?;
      if (invoice == null) {
        AppLogger.info(
            'LNURL Error: Missing invoice ("pr" field) in step 2 response for $lightningAddress');
        return null;
      }
      AppLogger.info('LNURL Success: Resolved invoice for $lightningAddress');
      return invoice;
    } catch (e) {
      AppLogger.info(
          'Exception during LNURL resolution for $lightningAddress: $e');
      return null;
    }
  }

  /// Set the Nostr service for publishing status updates
  void setNostrService(NostrService nostrService) {
    _nostrService = nostrService;

    AppLogger.info('Nostr service set for status update publishing');
  }

  /// Publish offer status update via Nostr
  Future<void> _publishStatusUpdate(Offer offer) async {
    if (_nostrService == null) {
      AppLogger.info(
          'Nostr service not available, skipping status update publication');
      return;
    }

    try {
      await _nostrService!.publishOfferStatusUpdate(
        offerId: offer.id,
        paymentHash: offer.holdInvoicePaymentHash,
        status: offer.status.name,
        timestamp: DateTime.now().toUtc(),
        createdAt: offer.createdAt,
        reservedAt: offer.reservedAt,
        makerPubkey: offer.makerPubkey,
        takerPubkey: offer.takerPubkey,
      );
    } catch (e) {
      AppLogger.info('Error publishing status update for offer ${offer.id}: $e',
          offerId: offer.id);
    }
  }

  Future<Map<String, dynamic>> getSuccessfulOffersWithStats() async {
    AppLogger.info('Fetching successful offers with stats...');
    final allSuccessfulOffers = await _dbService.getOffersByStatus(
        OfferStatus.takerPaid,
        limit: 10000); // Fetch a large number for stats for calculations

    final List<Map<String, dynamic>> offersJsonLast7Days =
        []; // For the response's "offers" field
    Duration totalBlikReceivedToCreatedDuration =
        Duration.zero; // For stats calculation
    int countBlikReceivedToCreated = 0; // For stats calculation
    Duration totalTakerPaidToCreatedDuration = Duration.zero;
    int countTakerPaidToCreated = 0;

    Duration last7DaysBlikReceivedToCreatedDuration = Duration.zero;
    int last7DaysCountBlikReceivedToCreated = 0;
    Duration last7DaysTakerPaidToCreatedDuration = Duration.zero;
    int last7DaysCountTakerPaidToCreated = 0;

    final sevenDaysAgo =
        DateTime.now().toUtc().subtract(const Duration(days: 7));

    // Iterate over all successful offers for stats calculation
    for (final offer in allSuccessfulOffers) {
      offer.holdInvoicePaymentHash = "";
      // Add to offersJsonLast7Days only if created in the last 7 days
      if (offer.createdAt.isAfter(sevenDaysAgo)) {
        offersJsonLast7Days.add(offer.toJson());
      }

      // Calculate stats based on allSuccessfulOffers
      if (offer.blikReceivedAt != null) {
        final duration = offer.blikReceivedAt!.difference(offer.createdAt);
        totalBlikReceivedToCreatedDuration += duration;
        countBlikReceivedToCreated++;
        if (offer.createdAt.isAfter(sevenDaysAgo)) {
          last7DaysBlikReceivedToCreatedDuration += duration;
          last7DaysCountBlikReceivedToCreated++;
        }
      }

      if (offer.takerPaidAt != null) {
        final duration = offer.takerPaidAt!.difference(offer.createdAt);
        totalTakerPaidToCreatedDuration += duration;
        countTakerPaidToCreated++;
        if (offer.createdAt.isAfter(sevenDaysAgo)) {
          last7DaysTakerPaidToCreatedDuration += duration;
          last7DaysCountTakerPaidToCreated++;
        }
      }
    }

    final avgBlikReceivedToCreatedLifetime = countBlikReceivedToCreated > 0
        ? (totalBlikReceivedToCreatedDuration.inSeconds /
                countBlikReceivedToCreated)
            .round()
        : 0;
    final avgTakerPaidToCreatedLifetime = countTakerPaidToCreated > 0
        ? (totalTakerPaidToCreatedDuration.inSeconds / countTakerPaidToCreated)
            .round()
        : 0;

    final avgBlikReceivedToCreatedLast7Days =
        last7DaysCountBlikReceivedToCreated > 0
            ? (last7DaysBlikReceivedToCreatedDuration.inSeconds /
                    last7DaysCountBlikReceivedToCreated)
                .round()
            : 0;
    final avgTakerPaidToCreatedLast7Days = last7DaysCountTakerPaidToCreated > 0
        ? (last7DaysTakerPaidToCreatedDuration.inSeconds /
                last7DaysCountTakerPaidToCreated)
            .round()
        : 0;

    return {
      'offers': offersJsonLast7Days, // Return only offers from the last 7 days
      'stats': {
        'lifetime': {
          'avg_time_blik_received_to_created_seconds':
              avgBlikReceivedToCreatedLifetime,
          'avg_time_taker_paid_to_created_seconds':
              avgTakerPaidToCreatedLifetime,
          'count': allSuccessfulOffers.length, // Count based on all offers
        },
        'last_7_days': {
          'avg_time_blik_received_to_created_seconds':
              avgBlikReceivedToCreatedLast7Days,
          'avg_time_taker_paid_to_created_seconds':
              avgTakerPaidToCreatedLast7Days,
          'count':
              allSuccessfulOffers // Count for last_7_days stats based on filtering all offers
                  .where((o) => o.createdAt.isAfter(sevenDaysAgo))
                  .length,
        }
      }
    };
  }
}
