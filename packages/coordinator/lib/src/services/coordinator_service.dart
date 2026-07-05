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
import 'package:uuid/uuid.dart';

import 'package:bitblik_core/core.dart';
import 'database_service.dart';
import 'lnd_service.dart';
import 'nwc_service.dart';
import 'payment_service.dart';
import '../models/invoice_status.dart';
import '../models/invoice_update.dart';
import '../models/pay_invoice_result.dart';
import 'nostr_service.dart';
import 'telegram_service.dart';
import '../flow/flow_loader.dart';
import '../logging/app_logger.dart';

// Offer-flow strategy: generic (yaml-driven) vs legacy enum. Parts share this
// library's privates so each flow can reach the shared services on
// CoordinatorService without widening its public API.
part 'coordinator_flow.dart';
part 'coordinator_flow_generic.dart';
part 'coordinator_flow_legacy.dart';
// Flow action implementations (one file per yml action keyword).
part 'actions/all_actions.dart';
part 'actions/common/accept_taker_invoice.dart';
part 'actions/common/assert_assigned_taker.dart';
part 'actions/common/cancel_hold_invoice.dart';
part 'actions/common/cancel_reservation.dart';
part 'actions/common/clear_taker_fields.dart';
part 'actions/common/refund_maker.dart';
part 'actions/common/require_maker_refund_invoice.dart';
part 'actions/common/resolve_taker_invoice.dart';
part 'actions/common/reserve_taker.dart';
part 'actions/common/send_offer_notifications.dart';
part 'actions/common/send_payment.dart';
part 'actions/common/settle_offer_funds.dart';
part 'actions/common/stamp_code_received_at.dart';
part 'actions/common/stamp_maker_confirmed_at.dart';
part 'actions/common/stamp_reserved_at.dart';
part 'actions/common/stamp_taker_charged_at.dart';
part 'actions/common/validate_code.dart';
part 'actions/twint/notify_maker_of_charge.dart';
part 'actions/twint/send_twint_code_to_taker.dart';
part 'actions/twint/set_new_code.dart';

// Set to Duration.zero for production
const Duration _kDebugDelayDuration = Duration(seconds: 0);

// Taker payment fee limit as a fraction of taker fees (0.2 = 20%)
const double kTakerFeeLimitFactor = 0.2;

/// Bilingual (English/local language) wording used in chat notifications
/// (Telegram/Matrix/SimpleX/Signal) for new-offer announcements.
class OfferNotificationStrings {
  final String newOffer;
  final String premium;
  final String shop;
  final String atm;
  final String online;

  const OfferNotificationStrings({
    required this.newOffer,
    required this.premium,
    required this.shop,
    required this.atm,
    required this.online,
  });
}

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

  /// Community/notification channel links advertised in get_info, keyed by
  /// messenger id. Set from `<MESSENGER>_CHANNEL_LINK` env vars.
  late final Map<String, String> _channelLinks;

  // Offer amount limits
  late final int _minAmountSats;
  late final int _maxAmountSats;

  // Maximum maker premium (%) above market price. 0 = feature disabled.
  late final double _maxPremiumPercent;

  // The single payment method this coordinator serves (BLIK, MB WAY, ...).
  // Drives the code-confirmation window and the default currency.
  late final PaymentSystem _paymentSystem;

  /// The payment system this coordinator serves. Used by [NostrService] to tag
  /// published offers with the matching `y` (platform) and `pm` values so each
  /// market's clients filter to their own offers.
  PaymentSystem get paymentSystem => _paymentSystem;

  /// Effective engine mode for this deployment: the method's
  /// [PaymentSystem.flowEngineMode], optionally overridden by the FLOW_MODE env.
  late final FlowEngineMode _flowEngineMode;

  static FlowEngineMode? _parseFlowMode(String? raw) {
    switch (raw?.toLowerCase()) {
      case null:
      case '':
        return null;
      case 'generic':
        return FlowEngineMode.generic;
      case 'legacy':
      case 'legacyenum':
      case 'enum':
        return FlowEngineMode.legacyEnum;
      default:
        AppLogger.warning(
            'Unrecognized FLOW_MODE "$raw"; using the method default.');
        return null;
    }
  }

  /// State-machine engine loaded from the active method's bundled flow
  /// definition. Null when no faithful flow exists yet for this method.
  ///
  /// PHASE 1 (shadow mode): used only by [_shadowCheckTransition] to verify the
  /// hardcoded transitions against the declarative flow; the hardcoded logic
  /// remains authoritative. Phase 2 will make this the enforcement source.
  FlowEngine? _flowEngine;

  // Test-only override for the payment method id, bypassing `.env`.
  final String? _paymentSystemIdOverride;

  // Test-only override for the engine mode, bypassing the FLOW_MODE env.
  final FlowEngineMode? _flowModeOverrideForTest;

  // Supported currencies
  late final List<String> _supportedCurrencies;

  // Reservation timeout configuration
  late final int _reservationTimeoutSeconds;

  /// Effective reservation timeout (env-configurable), exposed for tests.
  int get reservationTimeoutSeconds => _reservationTimeoutSeconds;

  /// Reservation window in seconds. Generic (yaml-driven) flows read it strictly
  /// from the `reserved` state in the `.yml` and ignore the env override; enum
  /// flows use the env-configurable [_reservationTimeoutSeconds].
  int get _reservationSeconds {
    if (isGenericFlow) {
      return _flowEngine!.timeoutFor('reserved')?.durationSeconds ??
          _reservationTimeoutSeconds;
    }
    return _reservationTimeoutSeconds;
  }

  // Funded expire timeout configuration
  late final int _fundedExpireTimeoutSeconds;

  /// Funded-state expiry window in seconds. Generic (yaml-driven) flows read it
  /// strictly from the `.yml` state definition and ignore the env override;
  /// enum flows use the env-configurable [_fundedExpireTimeoutSeconds].
  int get fundedExpirySeconds => _fundedExpirySeconds;

  int get _fundedExpirySeconds {
    if (isGenericFlow) {
      // Generic: the funded window is the timeout of the flow's initial state.
      return _flowEngine!
              .timeoutFor(_flowEngine!.initialState)
              ?.durationSeconds ??
          _fundedExpireTimeoutSeconds;
    }
    return _fundedExpireTimeoutSeconds;
  }

  // taker charged timeout configuration
  late final int _takerChargedAutoConfirmTimeoutSeconds;

  // conflict -> dispute auto-transition timeout configuration
  late final int _conflictAutoDisputeTimeoutSeconds;

  // Exchange rate cache, keyed by uppercase currency code (e.g. PLN, EUR).
  final Map<String, double> _cachedRates = {};
  final Map<String, DateTime> _cachedRateTimes = {};

  // Build the exchange-rate sources for [currency] (case-insensitive).
  static List<Map<String, String>> _exchangeRateSourcesFor(String currency) {
    final lower = currency.toLowerCase();
    return [
      {
        'name': 'CoinGecko',
        'url':
            'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=$lower',
        'parser': 'coingecko',
      },
      {
        'name': 'Yadio',
        'url': 'https://api.yadio.io/exrates/$lower',
        'parser': 'yadio',
      },
      {
        'name': 'Blockchain.info',
        'url': 'https://blockchain.info/ticker',
        'parser': 'blockchain',
      },
    ];
  }

  // Parser for CoinGecko response
  double? _parseCoinGeckoResponse(String responseBody, String currency) {
    try {
      final data = jsonDecode(responseBody);
      final rate = data['bitcoin']?[currency.toLowerCase()];
      if (rate is num) {
        return rate.toDouble();
      }
    } catch (e) {
      AppLogger.info('Error parsing CoinGecko response: $e');
    }
    return null;
  }

  // Parser for Yadio.io response (BTC price in the requested base currency)
  double? _parseYadioResponse(String responseBody, String currency) {
    try {
      final data = jsonDecode(responseBody);
      final rate = data['BTC'];
      if (rate is num) {
        return rate.toDouble();
      }
    } catch (e) {
      AppLogger.info('Error parsing Yadio response: $e');
    }
    return null;
  }

  // Parser for Blockchain.info response
  double? _parseBlockchainInfoResponse(String responseBody, String currency) {
    try {
      final data = jsonDecode(responseBody);
      final rate = data[currency.toUpperCase()]?['last'];
      if (rate is num) {
        return rate.toDouble();
      }
    } catch (e) {
      AppLogger.info('Error parsing Blockchain.info response: $e');
    }
    return null;
  }

  Future<double> _getRate(String currency) async {
    final cur = currency.toUpperCase();
    final now = DateTime.now();
    final cached = _cachedRates[cur];
    final cachedTime = _cachedRateTimes[cur];
    if (cached != null &&
        cachedTime != null &&
        now.difference(cachedTime).inMinutes < 5) {
      return cached;
    }

    final fetchFutures = <Future<double?>>[];
    for (var source in _exchangeRateSourcesFor(cur)) {
      fetchFutures.add(_fetchRateFromSource(source, cur));
    }

    final List<double?> results = await Future.wait(fetchFutures);
    final List<double> validRates =
        results.where((rate) => rate != null).cast<double>().toList();

    if (validRates.isNotEmpty) {
      final averageRate =
          validRates.reduce((a, b) => a + b) / validRates.length;
      _cachedRates[cur] = averageRate;
      _cachedRateTimes[cur] = now;
      AppLogger.info(
          'Successfully fetched and averaged BTC/$cur rate: $averageRate from ${validRates.length} sources.');
      return averageRate;
    } else {
      if (cached != null) {
        AppLogger.info(
            'Returning stale BTC/$cur rate due to all sources failing to fetch.');
        return cached;
      }
      throw Exception('Failed to fetch BTC/$cur rate from all sources.');
    }
  }

  Future<double?> _fetchRateFromSource(
      Map<String, String> source, String currency) async {
    final url = Uri.parse(source['url']!);
    final parserName = source['parser']!;
    final sourceName = source['name']!;

    try {
      final response = await _httpClient.get(url); // Use _httpClient
      if (response.statusCode == 200) {
        double? rate;
        if (parserName == 'coingecko') {
          rate = _parseCoinGeckoResponse(response.body, currency);
        } else if (parserName == 'yadio') {
          rate = _parseYadioResponse(response.body, currency);
        } else if (parserName == 'blockchain') {
          rate = _parseBlockchainInfoResponse(response.body, currency);
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
            'Failed to fetch BTC/$currency rate from $sourceName: ${response.statusCode} ${response.body}');
        return null;
      }
    } catch (e) {
      AppLogger.info('Error fetching BTC/$currency rate from $sourceName: $e');
      return null;
    }
  }

  final Map<String, Map<String, dynamic>> _pendingOffers = {};
  final Map<String, StreamSubscription> _invoiceSubscriptions = {};
  // Per-stage offer timers live in the flow strategies (LegacyEnumOfferFlow /
  // GenericOfferFlow). The coordinator keeps only the shared republish timer.
  final Map<String, Timer> _statusRepublishTimers = {};

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
      NostrService? nostrService,
      String? paymentSystemIdForTest,
      FlowEngineMode? flowModeForTest})
      : _clock = clock ?? const Clock(),
        _httpClient = httpClient ?? http.Client(),
        _nostrService = nostrService,
        _paymentSystemIdOverride = paymentSystemIdForTest,
        _flowModeOverrideForTest = flowModeForTest {
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

    // Community group/notification links, advertised in get_info. Operators set
    // TELEGRAM_CHANNEL_LINK, MATRIX_CHANNEL_LINK, SIMPLEX_CHANNEL_LINK,
    // SIGNAL_CHANNEL_LINK. Unset = app falls back to its bundled defaults for
    // the payment system.
    _channelLinks = {
      for (final id in CoordinatorInfo.messengerIds)
        if ((_env['${id.toUpperCase()}_CHANNEL_LINK'] ?? '').trim().isNotEmpty)
          id: _env['${id.toUpperCase()}_CHANNEL_LINK']!.trim(),
    };

    _minAmountSats = int.tryParse(_env['MIN_AMOUNT_SATS'] ?? '') ?? 1000;
    _maxAmountSats = int.tryParse(_env['MAX_AMOUNT_SATS'] ?? '') ?? 250000;

    // Maker premium cap (%). Default 0 = feature off; operator opts in.
    _maxPremiumPercent = double.tryParse(_env['MAX_PREMIUM'] ?? '') ?? 0;

    // One method per deployment. Default 'blik' keeps existing PL coordinators
    // unchanged. The method's currency is the default when CURRENCIES is unset.
    // Tests pin the method via [_paymentSystemIdOverride] so they don't depend
    // on a local `.env`.
    _paymentSystem = paymentSystemById(
        _paymentSystemIdOverride ?? _env['PAYMENT_SYSTEM']?.trim());

    // Engine mode defaults to the method's own [PaymentSystem.flowEngineMode],
    // but FLOW_MODE (`legacy`/`legacyEnum` | `generic`) overrides it per
    // deployment — e.g. to dry-run a method on the generic executor. The
    // generic mode still requires a loadable flow definition (flowId); if none
    // loads, [isGenericFlow] stays false regardless of this setting.
    _flowEngineMode = _flowModeOverrideForTest ??
        _parseFlowMode(_env['FLOW_MODE']?.trim()) ??
        _paymentSystem.flowEngineMode;

    _supportedCurrencies =
        (_env['CURRENCIES']?.split(',') ?? [_paymentSystem.currency])
            .map((c) => c.trim().toUpperCase())
            .toList();

    _reservationTimeoutSeconds =
        int.tryParse(_env['RESERVATION_SECONDS'] ?? '') ?? 33;
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
    final telegramChatIds =
        (_env['TELEGRAM_CHAT_ID']?.split(',') ?? const <String>[])
            .map((chatId) => chatId.trim())
            .where((chatId) => chatId.isNotEmpty)
            .toSet()
            .toList();
    if (telegramBotToken != null &&
        telegramBotToken.isNotEmpty &&
        telegramChatIds.isNotEmpty) {
      _telegramService = TelegramService(
          botToken: telegramBotToken,
          chatIds: telegramChatIds,
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
    await _loadFlowEngine();
    AppLogger.info(
        'CoordinatorService initialized with $_paymentBackendType backend '
        '(${isGenericFlow ? 'generic' : 'legacy-enum'} flow).');
  }

  Future<void> _loadFlowEngine() async {
    final method = _paymentSystem.id;
    final flowId = _paymentSystem.flowId;
    // Was the mode set by FLOW_MODE, or by the method's own default?
    final overridden = _flowEngineMode != _paymentSystem.flowEngineMode;
    final source = overridden ? 'FLOW_MODE env override' : 'method default';

    // When generic mode is explicitly intended, any failure to obtain a valid
    // engine is fatal: we must NOT silently downgrade to legacy enforcement.
    final wantGeneric = _flowEngineMode == FlowEngineMode.generic;

    if (flowId == null) {
      if (wantGeneric) {
        throw StateError(
            'FLOW ENGINE: GENERIC mode requested ($source) for method "$method" '
            'but it declares no flowId. Refusing to start; fix the config or '
            'unset FLOW_MODE=generic.');
      }
      AppLogger.info(
          'FLOW ENGINE: method "$method" has no flow definition; legacy enum '
          'enforcement only.');
      return;
    }

    try {
      _flowEngine = await FlowLoader.load(flowId);
    } catch (e) {
      // Parse/validation error in the yml.
      if (wantGeneric) {
        throw StateError(
            'FLOW ENGINE: GENERIC mode but "$flowId.yml" failed to parse/'
            'validate: $e. Refusing to start.');
      }
      AppLogger.warning(
          'FLOW ENGINE: "$flowId.yml" failed to parse ($e); shadow disabled, '
          'legacy enum enforcement only.');
      return;
    }
    if (_flowEngine == null) {
      if (wantGeneric) {
        throw StateError(
            'FLOW ENGINE: GENERIC mode but flow "$flowId" could not be located. '
            'Refusing to start.');
      }
      AppLogger.warning(
          'FLOW ENGINE: flow "$flowId" not found for method "$method"; '
          'legacy enum enforcement only.');
      return;
    }

    // isGenericFlow is now meaningful (engine != null).
    if (isGenericFlow) {
      // Deep self-check beyond structural parse: effects, timer durations,
      // payout wiring, nip69. Throws (fatal) on any inconsistency.
      flow.validateDefinition();
      AppLogger.warning(
          'FLOW ENGINE: GENERIC ENFORCING mode ACTIVE for method "$method" '
          '(flow=$flowId, $source). State transitions AND timers are enforced '
          'from $flowId.yml; legacy enum handlers are bypassed.');
    } else {
      AppLogger.info(
          'FLOW ENGINE: SHADOW mode for method "$method" (flow=$flowId, $source). '
          'Legacy enum logic enforces; the engine only logs FLOW-SHADOW MISMATCH '
          'divergences.');
    }
  }

  /// PHASE 1 shadow check: compare an about-to-be-applied transition against the
  /// loaded [FlowEngine]. Logs loudly on divergence but never blocks — hardcoded
  /// logic stays authoritative until Phase 2. No-op when no engine is loaded.
  void _shadowCheckTransition({
    required OfferStatus from,
    required String event,
    required FlowActor actor,
    required OfferStatus to,
  }) {
    final engine = _flowEngine;
    if (engine == null) return;
    final fromState = flowStateForOfferStatus(from);
    final res = engine.resolveUserAction(
        fromState: fromState, event: event, actor: actor);
    if (!res.allowed) {
      AppLogger.warning(
          'FLOW-SHADOW MISMATCH: legacy allows $from --$event/${actor.name}--> $to '
          'but engine rejects (${res.rejectReason}).');
      return;
    }
    final expected = offerStatusFromFlowState(res.target ?? '');
    if (expected != to) {
      AppLogger.warning(
          'FLOW-SHADOW MISMATCH: $from --$event/${actor.name}--> legacy=$to engine=$expected.');
    }
  }

  // ════════════════════════════════════════════════════════════════════
  // Offer-flow strategy selection. The flow logic lives in the part files
  // coordinator_flow_generic.dart (yaml-driven) and coordinator_flow_legacy.dart
  // (hardcoded enum); this class owns only the shared services they call.
  // ════════════════════════════════════════════════════════════════════

  bool get isGenericFlow =>
      _flowEngineMode == FlowEngineMode.generic && _flowEngine != null;

  OfferFlow? _flow;

  /// Active offer-flow strategy, derived from [isGenericFlow] (meaningful once
  /// the flow engine has loaded in [init]). nostr_service routes offer-action
  /// RPCs through it; the coordinator delegates funded-timer arming and startup
  /// recovery to it.
  OfferFlow get flow => _flow ??=
      isGenericFlow ? GenericOfferFlow(this) : LegacyEnumOfferFlow(this);

  /// NIP-69 status category declared by the flow state [raw], for the broadcast
  /// layer. Generic flows read it from the yaml `nip69:` attribute; legacy flows
  /// return null (the broadcaster falls back to its OfferStatus mapping).
  String? nip69CategoryForRaw(String raw) =>
      isGenericFlow ? _flowEngine!.definition.state(raw)?.nip69 : null;

  Future<void> doInitialCheckStatuses() async {
    await _initializeMatrixClient();
    // Each flow recovers its own timers: the generic flow re-arms yaml-driven
    // timers; the legacy flow runs its per-stage expiry sweeps.
    await flow.recoverTimers();
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
        id: const Uuid().v4(),
        createdAt: DateTime.now().toUtc(),
        coordinatorPubkey: _nostrService?.coordinatorPubkey ?? '',
        amountSats: pendingData['amountSats'],
        makerFees: pendingData['makerFees'],
        takerFees: pendingData['takerFees'],
        makerPubkey: pendingData['makerId'],
        holdInvoicePaymentHash: paymentHashHex,
        holdInvoicePreimage: pendingData['preimageHex'],
        // Enum view stays funded; generic flows persist the raw initial-state
        // name from the flow definition (== funded for current flows).
        status: OfferStatus.funded,
        statusRaw: isGenericFlow ? _flowEngine!.initialState : null,
        blikCode: pendingData['blikCode'] as String?,
        // Maker-provides-code flows (TWINT): the code is issued now — this
        // stamp is the base for its yaml lifespan timeout (code_received_at),
        // reset only when a fresh code is entered, not by reserve/revert.
        blikReceivedAt: pendingData['blikCode'] != null &&
                _paymentSystem.makerProvidesCodeAtOfferCreation
            ? DateTime.now().toUtc()
            : null,
        fiatAmount: pendingData['fiatAmount'],
        fiatCurrency: pendingData['fiatCurrency'],
        category: () {
          final raw = pendingData['category'];
          if (raw is! String || raw.trim().isEmpty) return null;
          try {
            return OfferCategory.values.byName(raw);
          } catch (_) {
            return null;
          }
        }(),
        premiumPercent:
            (pendingData['premiumPercent'] as num?)?.toDouble() ?? 0,
        clientVersion: pendingData['clientVersion'] as String?,
      );
      await _dbService.createOffer(offer);
      // --- Begin: broadcast NIP-69 order event ---
      final expirationUnix = offer.createdAt
              .add(Duration(seconds: _fundedExpirySeconds))
              .millisecondsSinceEpoch ~/
          1000;
      await _nostrService?.broadcastNip69OrderFromOffer(offer,
          expiration: expirationUnix, premium: offer.premiumPercent);
      // --- End: broadcast NIP-69 order event ---
      flow.onOfferFunded(offer);

      // Publish status update
      await _publishStatusUpdate(offer);

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

  /// Send Telegram notification (returns Future for parallel execution).
  /// Persists the sent message ids so the message can be edited later
  /// (struck out) if the offer is cancelled or expires.
  Future<void> _sendTelegramNotification(
      String notificationText, String offerId) async {
    try {
      final result =
          await _telegramService!.sendMessageDetailed(notificationText);
      for (final sent in result.sentMessages) {
        try {
          await _dbService.saveTelegramOfferMessage(
            offerId: offerId,
            chatId: sent.chatId,
            messageId: sent.messageId,
            messageText: notificationText,
          );
        } catch (e) {
          AppLogger.info(
              'Error persisting Telegram message id for offer $offerId: $e',
              offerId: offerId);
        }
      }
    } catch (e) {
      AppLogger.info('Error sending Telegram notification: $e');
    }
  }

  /// Edit the Telegram notification(s) for an offer to strikethrough,
  /// signalling the offer is no longer available (cancelled/expired).
  Future<void> _strikeTelegramOfferMessages(String offerId) async {
    if (_telegramService == null || !_telegramService!.isConfigured) {
      return;
    }
    try {
      final messages = await _dbService.getTelegramOfferMessages(offerId);
      if (messages.isEmpty) return;

      for (final message in messages) {
        await _telegramService!.editMessage(
          chatId: message.chatId,
          messageId: message.messageId,
          text: '<s>${message.messageText}</s>',
        );
      }
      await _dbService.deleteTelegramOfferMessages(offerId);
    } catch (e) {
      AppLogger.info(
          'Error striking out Telegram message(s) for offer $offerId: $e',
          offerId: offerId);
    }
  }

  /// Delete the Telegram notification(s) for an offer (e.g. once it has
  /// been successfully paid and is no longer relevant to the channel).
  Future<void> _deleteTelegramOfferMessages(String offerId) async {
    if (_telegramService == null || !_telegramService!.isConfigured) {
      return;
    }
    try {
      final messages = await _dbService.getTelegramOfferMessages(offerId);
      if (messages.isEmpty) return;

      for (final message in messages) {
        await _telegramService!.deleteMessage(
          chatId: message.chatId,
          messageId: message.messageId,
        );
      }
      await _dbService.deleteTelegramOfferMessages(offerId);
    } catch (e) {
      AppLogger.info(
          'Error deleting Telegram message(s) for offer $offerId: $e',
          offerId: offerId);
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

  String _buildFundedOfferNotification(Offer offer) {
    final strings = _notificationStrings;
    final fiatText =
        '${offer.fiatAmount.toStringAsFixed(2)} ${offer.fiatCurrency}';
    final categoryText = _formatCategoryForNotification(offer.category);
    final categorySuffix = categoryText == null ? '' : ', $categoryText';
    final premiumSuffix = offer.premiumPercent > 0
        ? ', +${_formatPremium(offer.premiumPercent)}% ${strings.premium}'
        : '';
    return '${strings.newOffer}: ${offer.amountSats} sats ($fiatText)$categorySuffix$premiumSuffix -> https://${frontendDomain}/offers/${offer.id}';
  }

  Future<void> _sendOfferNotifications(Offer offer) async {
    final notificationText = _buildFundedOfferNotification(offer);
    final notificationFutures = <Future<void>>[];

    if (_simplexChatExec != '') {
      notificationFutures.add(_sendSimpleXNotification(notificationText));
    }

    if (_matrixClient != null && _matrixClient!.isLogged()) {
      notificationFutures.add(_sendMatrixNotification(notificationText));
    }

    if (_telegramService != null && _telegramService!.isConfigured) {
      notificationFutures
          .add(_sendTelegramNotification(notificationText, offer.id));
    }

    if (_signalCliExec != '' && _signalGroupId.isNotEmpty) {
      notificationFutures.add(_sendSignalNotification(notificationText));
    }

    if (notificationFutures.isNotEmpty) {
      await Future.wait(notificationFutures, eagerError: false);
    }
  }

  /// Notification wording for the market served by the configured payment
  /// system (English/local language), keyed by the system's country code.
  /// Falls back to Poland's wording for unknown markets.
  static const Map<String, OfferNotificationStrings>
      _notificationStringsByCountry = {
    'PL': OfferNotificationStrings(
      newOffer: 'New offer/Nowa oferta',
      premium: 'premium/premia',
      shop: 'Shop/Sklep',
      atm: 'ATM/Bankomat',
      online: 'Online',
    ),
    'PT': OfferNotificationStrings(
      newOffer: 'New offer/Nova oferta',
      premium: 'premium',
      shop: 'Shop/Loja',
      atm: 'ATM/Multibanco',
      online: 'Online',
    ),
    'CH': OfferNotificationStrings(
      newOffer: 'New offer/Neues Angebot',
      premium: 'premium/Premium',
      shop: 'Shop/Geschäft',
      atm: 'ATM/Bancomat',
      online: 'Online',
    ),
  };

  OfferNotificationStrings get _notificationStrings =>
      _notificationStringsByCountry[_paymentSystem.country] ??
      _notificationStringsByCountry['PL']!;

  /// Trim trailing ".0" so 5.0 -> "5" but 2.5 stays "2.5".
  String _formatPremium(double premium) {
    final s = premium.toStringAsFixed(1);
    return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
  }

  String? _formatCategoryForNotification(OfferCategory? category) {
    final strings = _notificationStrings;
    switch (category) {
      case OfferCategory.shop:
        return strings.shop;
      case OfferCategory.atm:
        return strings.atm;
      case OfferCategory.online:
        return strings.online;
      case null:
        return null;
    }
  }

  int _expectedTakerNetAmountSats(Offer offer) {
    return offer.amountSats -
        (offer.takerFees ??
            OfferQuote.takerFeeSats(offer.amountSats, _takerFeePercentage));
  }

  int _effectiveTakerFeeSats(Offer offer) {
    return offer.takerFees ??
        OfferQuote.takerFeeSats(offer.amountSats, _takerFeePercentage);
  }

  void _validateTakerInvoiceAmount(
    Offer offer,
    String takerInvoice, {
    required String action,
  }) {
    final trimmed = takerInvoice.trim();
    if (trimmed.isEmpty) {
      throw Exception('Missing taker invoice for $action.');
    }

    final req = Bolt11PaymentRequest(trimmed);
    final invoiceAmountSats =
        (req.amount * Decimal.fromInt(100000000)).toBigInt().toInt();
    final netAmountSats = _expectedTakerNetAmountSats(offer);

    // Zero-amount invoices cannot be locally verified and are unsafe here,
    // especially for NWC where the wallet pays the invoice's encoded amount.
    if (invoiceAmountSats <= 0) {
      throw Exception(
          'Provided taker invoice for $action must encode an amount close to the expected net amount $netAmountSats sats.');
    }
    if (invoiceAmountSats > netAmountSats + 10) {
      throw Exception(
          'Provided taker invoice amount $invoiceAmountSats sats is greater than expected net amount $netAmountSats sats for $action.');
    }
    if (invoiceAmountSats < netAmountSats - 100) {
      throw Exception(
          'Provided taker invoice amount $invoiceAmountSats sats is much smaller than expected net amount $netAmountSats sats for $action.');
    }
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
    if (offer.status != OfferStatus.takerPaymentFailed) {
      AppLogger.info(
          'Offer $offerId is in status ${offer.status}. Taker invoice updates are only allowed in takerPaymentFailed.',
          offerId: offerId);
      return false;
    }
    _validateTakerInvoiceAmount(
      offer,
      takerInvoice,
      action: 'update_taker_invoice',
    );
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
    final takerFees = _effectiveTakerFeeSats(offer);
    final netAmountSats = offer.amountSats - takerFees;
    String? takerInvoice = offer.takerInvoice;

    if (takerInvoice == null || takerInvoice.isEmpty) {
      if (offer.takerLightningAddress == null ||
          offer.takerLightningAddress!.isEmpty) {
        AppLogger.info(
            'Async Error: Missing both taker invoice and Lightning Address for offer $offerId.',
            offerId: offerId);
        await _dbService.updateOfferStatus(
            offerId, OfferStatus.takerPaymentFailed,
            failureReason: 'Missing both taker invoice and Lightning Address');
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
              offerId, OfferStatus.takerPaymentFailed,
              failureReason:
                  'Failed to get invoice from lightning address (LNURL resolution failed)');
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
      _validateTakerInvoiceAmount(
        offer,
        takerInvoice,
        action: 'pay_taker',
      );
      await _sendTakerPayment(offerId, takerInvoice);
    } catch (e) {
      AppLogger.info(
          'Async Exception during taker payment for offer $offerId: $e',
          offerId: offerId);
      await _dbService.updateOfferStatus(
          offerId, OfferStatus.takerPaymentFailed,
          failureReason: e.toString());
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
            offerId, OfferStatus.takerPaymentFailed,
            failureReason: 'Offer not found');
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
      final takerFees = _effectiveTakerFeeSats(offer);
      final netAmountSats = offer.amountSats - takerFees;
      AppLogger.info(
          'Calculated taker fees for offer $offerId: $takerFees sats. Paying net amount: $netAmountSats sats.',
          offerId: offerId);

      if (_paymentBackend == null) {
        AppLogger.info(
            'CRITICAL: No payment backend configured for _sendTakerPayment.');
        await _dbService.updateOfferStatus(
            offerId, OfferStatus.takerPaymentFailed,
            failureReason: 'No payment backend configured');
        return 'No payment backend configured.';
      }

      _validateTakerInvoiceAmount(
        offer,
        takerInvoice,
        action: 'pay_taker',
      );

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
        await _markTakerPaid(offerId, paymentResult, takerFees);
        return null; // Success
      }

      // payInvoice reported failure/timeout. The NWC pay_invoice request is not
      // idempotent: a timeout or transport error does NOT prove the payment
      // failed — the wallet may have settled it anyway. Reconcile before
      // declaring failure, so we don't mark a paid offer as failed (which would
      // also let a later retry double-pay the taker).
      final reconciled = await _paymentBackend!
          .reconcileOutgoingPayment(invoice: takerInvoice);
      if (reconciled != null && reconciled.isSuccess) {
        AppLogger.info(
            ' Taker payment for offer $offerId reconciled as SETTLED despite error "${paymentResult.paymentError}". Marking paid.',
            offerId: offerId);
        await _markTakerPaid(offerId, reconciled, takerFees);
        return null;
      }

      AppLogger.info(
          ' Failed to pay taker for offer $offerId. Reason: ${paymentResult.paymentError}',
          offerId: offerId);
      await _dbService.updateOfferStatus(
          offerId, OfferStatus.takerPaymentFailed,
          failureReason: paymentResult.paymentError ??
              'Payment failed (no route or unknown error)');

      // Publish status update
      final failedOffer = await _dbService.getOfferById(offerId);
      if (failedOffer != null) {
        await _publishStatusUpdate(failedOffer);
      }

      return ' Failed to pay taker for offer $offerId. Reason: ${paymentResult.paymentError}';
    } catch (e) {
      AppLogger.info(
          'Exception during taker payment for offer $offerId (using $_paymentBackendType): $e',
          offerId: offerId);
      // Same idempotency caveat as the failure branch: an exception doesn't
      // prove the payment didn't settle. Reconcile before marking failed.
      try {
        final reconciled = await _paymentBackend?.reconcileOutgoingPayment(
            invoice: takerInvoice);
        final offerForFees = await _dbService.getOfferById(offerId);
        if (reconciled != null &&
            reconciled.isSuccess &&
            offerForFees != null) {
          final takerFees = _effectiveTakerFeeSats(offerForFees);
          AppLogger.info(
              ' Taker payment for offer $offerId reconciled as SETTLED despite exception. Marking paid.',
              offerId: offerId);
          await _markTakerPaid(offerId, reconciled, takerFees);
          return null;
        }
      } catch (reconcileError) {
        AppLogger.info(
            'Reconciliation after exception failed for offer $offerId: $reconcileError',
            offerId: offerId);
      }
      await _dbService.updateOfferStatus(
          offerId, OfferStatus.takerPaymentFailed,
          failureReason: e.toString());
      // Publish status update
      final failedOffer = await _dbService.getOfferById(offerId);
      if (failedOffer != null) {
        await _publishStatusUpdate(failedOffer);
      }
      return 'Exception during taker payment for offer $offerId: $e';
    }
  }

  /// Status-write-free taker payment primitive: attempts the Lightning payment
  /// and, on a reported failure/exception, reconciles (NWC pay_invoice is not
  /// idempotent) before declaring failure. Performs NO DB writes/publishes so it
  /// can back both the legacy enum payout and the generic (raw) payout.
  ///
  /// Returns the settled [PayInvoiceResult] on success, or an error string.
  Future<({bool ok, PayInvoiceResult? result, String? error})>
      _attemptTakerPayment(
          String invoice, int netAmountSats, int feeLimitSat) async {
    if (_paymentBackend == null) {
      return (ok: false, result: null, error: 'No payment backend configured');
    }
    try {
      final r = await _paymentBackend!.payInvoice(
        invoice: invoice,
        amountSat: netAmountSats,
        feeLimitSat: feeLimitSat,
      );
      if (r.isSuccess) return (ok: true, result: r, error: null);
      final rec =
          await _paymentBackend!.reconcileOutgoingPayment(invoice: invoice);
      if (rec != null && rec.isSuccess) {
        return (ok: true, result: rec, error: null);
      }
      return (
        ok: false,
        result: null,
        error: r.paymentError ?? 'Payment failed (no route or unknown error)'
      );
    } catch (e) {
      try {
        final rec =
            await _paymentBackend?.reconcileOutgoingPayment(invoice: invoice);
        if (rec != null && rec.isSuccess) {
          return (ok: true, result: rec, error: null);
        }
      } catch (_) {/* reconcile failed; fall through to error */}
      return (ok: false, result: null, error: e.toString());
    }
  }

  /// Mark an offer as successfully paid to the taker and broadcast the update.
  /// Shared by the direct success path and the reconciliation paths.
  Future<void> _markTakerPaid(
      String offerId, PayInvoiceResult result, int takerFees) async {
    await Future.delayed(_kDebugDelayDuration);
    await _dbService.updateOfferStatus(offerId, OfferStatus.takerPaid,
        takerFees: takerFees);
    await _dbService.updateTakerInvoiceFees(offerId, result.feeSat ?? 0);
    AppLogger.info(
        ' Updated taker invoice fees to ${result.feeSat ?? 0} sats for offer $offerId.',
        offerId: offerId);

    final paidOffer = await _dbService.getOfferById(offerId);
    if (paidOffer != null) {
      await _publishStatusUpdate(paidOffer);
      await _nostrService?.broadcastNip69OrderFromOffer(paidOffer);
    }

    await _deleteTelegramOfferMessages(offerId);
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
    if (offer.status != OfferStatus.takerPaymentFailed) {
      AppLogger.info(
          'Offer $offerId is in status ${offer.status}. Retry is only allowed in takerPaymentFailed.',
          offerId: offerId);
      return "offer is not in takerPaymentFailed";
    }
    _validateTakerInvoiceAmount(
      offer,
      offer.takerInvoice!,
      action: 'retry_taker_payment',
    );

    // Guard against double-paying: a prior attempt may have actually settled
    // even though it was recorded as failed (NWC pay_invoice timeouts are not
    // idempotent). Reconcile before sending a fresh payment.
    final reconciled = await _paymentBackend?.reconcileOutgoingPayment(
        invoice: offer.takerInvoice!);
    if (reconciled != null && reconciled.isSuccess) {
      AppLogger.info(
          'Retry: offer $offerId already SETTLED on wallet. Finalizing instead of paying again.',
          offerId: offerId);
      final takerFees = _effectiveTakerFeeSats(offer);
      await _markTakerPaid(offerId, reconciled, takerFees);
      return null;
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
  Future<void> _publishStatusUpdate(
    Offer offer, {
    bool allowCompatibilityRetry = true,
  }) async {
    if (_nostrService == null) {
      AppLogger.info(
          'Nostr service not available, skipping status update publication');
      return;
    }

    try {
      AppLogger.info(
        'Queueing status update offer=${offer.id} status=${offer.status.name} paymentHash=${offer.holdInvoicePaymentHash ?? ''} maker=${offer.makerPubkey} taker=${offer.takerPubkey ?? '-'} retry=${allowCompatibilityRetry ? 'primary' : 'compat'}',
        offerId: offer.id,
      );
      await _nostrService!.publishOfferStatusUpdate(
        offerId: offer.id,
        paymentHash: offer.holdInvoicePaymentHash ?? '',
        // Use the raw status string so generic (yaml-driven) flows broadcast
        // their real state (e.g. `twint_charged`) instead of the enum's
        // `unknown` fallback. For legacy flows statusRaw == status.name.
        status: offer.statusRaw,
        timestamp: DateTime.now().toUtc(),
        createdAt: offer.createdAt,
        reservedAt: offer.reservedAt,
        blikReceivedAt: offer.blikReceivedAt,
        makerPubkey: offer.makerPubkey,
        takerPubkey: offer.takerPubkey,
      );
      if (allowCompatibilityRetry) {
        _scheduleCompatibilityStatusRepublish(offer);
      }
    } catch (e) {
      AppLogger.info('Error publishing status update for offer ${offer.id}: $e',
          offerId: offer.id);
    }
  }

  void _scheduleCompatibilityStatusRepublish(Offer offer) {
    _statusRepublishTimers[offer.id]?.cancel();

    // Legacy clients subscribe to offer status updates from "now", and may
    // briefly restart the subscription as local offer ids are reconciled.
    // A one-shot re-publication of `blikReceived` gives them a second chance
    // to observe the transition and trigger `get_blik`.
    if (offer.status != OfferStatus.blikReceived) {
      _statusRepublishTimers.remove(offer.id);
      return;
    }

    _statusRepublishTimers[offer.id] =
        Timer(const Duration(seconds: 4), () async {
      _statusRepublishTimers.remove(offer.id);
      try {
        AppLogger.info(
          'Compatibility re-publish timer fired for offer ${offer.id}',
          offerId: offer.id,
        );
        final current = await _dbService.getOfferById(offer.id);
        if (current == null || current.status != OfferStatus.blikReceived) {
          AppLogger.info(
            'Skipping compatibility re-publish for offer ${offer.id}; current status=${current?.status.name ?? 'missing'}',
            offerId: offer.id,
          );
          return;
        }
        await _publishStatusUpdate(
          current,
          allowCompatibilityRetry: false,
        );
      } catch (e) {
        AppLogger.info(
          'Error re-publishing blikReceived compatibility update for offer ${offer.id}: $e',
          offerId: offer.id,
        );
      }
    });
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
        offersJsonLast7Days.add(offer.toStatsJson());
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

  Future<Map<String, dynamic>> initiateOfferFiat({
    required double fiatAmount,
    required String makerId,
    String? fiatCurrency,
    OfferCategory? category,
    double premiumPercent = 0,
    String? blikCode,
    String? clientVersion,
  }) async {
    // Resolve the currency: client-supplied, else this coordinator's method
    // currency. Reject currencies this coordinator does not serve.
    final currency = (fiatCurrency ?? _paymentSystem.currency).toUpperCase();
    if (!_supportedCurrencies.contains(currency)) {
      throw Exception(
          'Unsupported currency: $currency (supported: ${_supportedCurrencies.join(',')})');
    }
    fiatCurrency = currency;
    // Reject categories this coordinator's payment method does not serve
    // (e.g. MB WAY only supports ATM cash-out).
    if (category != null &&
        !_paymentSystem.supportedCategories.contains(category)) {
      throw Exception(
          'Unsupported category ${category.name} for ${_paymentSystem.id}');
    }
    if (_paymentSystem.makerProvidesCodeAtOfferCreation) {
      final normalizedCode = blikCode?.trim() ?? '';
      if (!_paymentSystem.isValidCode(normalizedCode)) {
        throw Exception(
            'Invalid ${_paymentSystem.codeLabel} code. Expected exactly ${_paymentSystem.codeLength} digits.');
      }
      blikCode = normalizedCode;
    }
    // Clamp premium to what this coordinator allows.
    final premium = premiumPercent.clamp(0, _maxPremiumPercent).toDouble();
    AppLogger.info(
        'Initiating offer: fiatAmount=$fiatAmount $fiatCurrency, maker=$makerId, category=${category?.name}, premium=$premium%');
    final rate = await _getRate(fiatCurrency);
    final btcPerFiat = 1 / rate;
    final btcAmount = fiatAmount * btcPerFiat;
    // Market-value sats; range validation runs on this base amount.
    final baseSats = (btcAmount * 100000000).round();

    if (baseSats < _minAmountSats) {
      throw Exception(
          'Amount $baseSats sats is below minimum $_minAmountSats sats');
    }
    if (baseSats > _maxAmountSats) {
      throw Exception(
          'Amount $baseSats sats exceeds maximum $_maxAmountSats sats');
    }

    // Premium reduces the sats the maker locks for the same fiat amount.
    final satsAmount = (baseSats * (1 - premium / 100)).round();

    // Maker fee is charged on the original market value, unaffected by premium.
    final makerFees = OfferQuote.makerFeeSats(baseSats, _makerFeePercentage);
    final takerFees = OfferQuote.takerFeeSats(satsAmount, _takerFeePercentage);
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
      if (_paymentBackendType == 'nwc' &&
          backendResponse.paymentHash != paymentHashHex) {
        AppLogger.info(
            'NWC returned payment hash ${backendResponse.paymentHash} different from requested $paymentHashHex. Keeping the requested hash for offer lifecycle operations.');
      } else {
        returnedPaymentHashHex = backendResponse.paymentHash;
      }
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
      'blikCode': blikCode,
      'category': category?.name,
      'premiumPercent': premium,
      'clientVersion': clientVersion,
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
      'premiumPercent': premium,
      'rate': rate,
    };
  }

  Future<CoordinatorInfo> getCoordinatorInfo() async {
    String? version = Platform.environment['APP_VERSION'];
    if (version == null || version.isEmpty) {
      try {
        final pubspecFile = File('pubspec.yaml');
        if (await pubspecFile.exists()) {
          final yamlContent = await pubspecFile.readAsString();
          final yamlMap = loadYaml(yamlContent);
          final v = yamlMap['version'];
          if (v != null) version = v.toString();
        }
      } catch (_) {}
    }

    return CoordinatorInfo(
      name: _coordinatorName,
      reservationSeconds: _reservationSeconds,
      makerFee: _makerFeePercentage,
      takerFee: _takerFeePercentage,
      minAmountSats: _minAmountSats,
      maxAmountSats: _maxAmountSats,
      takerChargedAutoConfirmSeconds: _takerChargedAutoConfirmTimeoutSeconds,
      maxPremiumPercent: _maxPremiumPercent,
      currencies: List<String>.from(_supportedCurrencies),
      paymentSystem: _paymentSystem.id,
      nostrNpub: null,
      icon: _coordinatorIconUrl.isNotEmpty ? _coordinatorIconUrl : null,
      version: (version != null && version.isNotEmpty) ? version : null,
      termsOfUsageNaddr:
          _termsOfUsageNaddr.isNotEmpty ? _termsOfUsageNaddr : null,
      channelLinks: _channelLinks,
    );
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

  Future<Offer?> getOfferDetailsForParticipant(
    String userPubkey, {
    String? offerId,
    String? paymentHash,
  }) async {
    Offer? offer;
    if (offerId != null && offerId.isNotEmpty) {
      offer = await _dbService.getOfferById(offerId);
    } else if (paymentHash != null && paymentHash.isNotEmpty) {
      offer = await _dbService.getOfferByPaymentHash(paymentHash);
    } else {
      throw ArgumentError('offerId or paymentHash is required');
    }

    if (offer == null) return null;
    if (offer.makerPubkey != userPubkey && offer.takerPubkey != userPubkey) {
      return null;
    }
    return offer;
  }
}
