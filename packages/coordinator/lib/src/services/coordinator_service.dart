import 'dart:async'; // For StreamSubscription, Timer
import 'dart:convert'; // For jsonDecode
import 'dart:io'; // For File operations
import 'dart:math'; // For random preimage
import 'dart:typed_data'; // For Uint8List

import 'package:yaml/yaml.dart';
import 'package:clock/clock.dart'; // Added for Clock
import 'package:crypto/crypto.dart'; // For SHA256
import 'package:dotenv/dotenv.dart';
import 'package:http/http.dart' as http; // For exchange-rate HTTP requests
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

// The YAML-driven offer flow shares this library's privates so it can reach the
// coordinator's common services without widening its public API.
part 'coordinator_flow_generic.dart';
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
part 'actions/common/update_taker_invoice.dart';
part 'actions/common/validate_code.dart';
part 'actions/twint/notify_maker_of_charge.dart';
part 'actions/twint/send_twint_code_to_taker.dart';
part 'actions/twint/set_new_code.dart';

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

class _PendingOfferRecord {
  final Map<String, dynamic> data;

  const _PendingOfferRecord({
    required this.data,
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

  /// Bank-scoped channel links advertised in get_info, `bankId → (messenger →
  /// url)`. Set from `<MESSENGER>_CHANNEL_LINK_<BANKID>` env vars (e.g.
  /// `TELEGRAM_CHANNEL_LINK_TATRABANKA`). Lets takers subscribe only to the
  /// banks they hold; falls back to [_channelLinks] client-side.
  late final Map<String, Map<String, String>> _bankChannelLinks;

  /// Per-bank notification targets, `bankId → [targets]`, set from
  /// `<CHANNEL>_<BANKID>` env vars (e.g. `TELEGRAM_CHAT_ID_TATRABANKA`,
  /// `MATRIX_ROOM_SLSP`, `SIMPLEX_GROUP_VUB`, `SIGNAL_GROUP_ID_VUB`). A new-offer
  /// notification for a bank-scoped offer is sent to the general channel AND the
  /// offer bank's channel (both only if configured).
  late final Map<String, List<String>> _telegramChatIdsByBank;
  late final Map<String, List<String>> _matrixRoomsByBank;
  late final Map<String, List<String>> _simplexGroupsByBank;
  late final Map<String, List<String>> _signalGroupsByBank;

  /// The general (non-bank) Telegram chat ids, so per-offer sends can union them
  /// with the offer bank's chat ids.
  late final List<String> _telegramGeneralChatIds;

  /// Read `<baseKey>_<BANKID>` env for each served bank into `bankId →
  /// [comma-split values]`, dropping banks with no configured value.
  Map<String, List<String>> _perBankEnvTargets(String baseKey) {
    final out = <String, List<String>>{};
    for (final bankId in servedBanks) {
      final raw = _env['${baseKey}_${bankId.toUpperCase()}'];
      final vals = (raw?.split(',') ?? const <String>[])
          .map((s) => s.trim())
          .where((s) => s.isNotEmpty)
          .toList();
      if (vals.isNotEmpty) out[bankId] = vals;
    }
    return out;
  }

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

  /// The bank ids this coordinator serves within a bank-scoped market. Empty
  /// means it serves every bank the market's instrument defines. Set from the
  /// `BANKS` env (comma list), validated against the instrument's bank list.
  late final List<String> _servedBanks;

  /// The instrument driving offers of [category], falling back to the market's
  /// primary (first) instrument when the category is null or unmapped. The
  /// fallback preserves pre-split behavior for legacy/older clients that omit a
  /// category on markets with a single effective instrument (BLIK, MB WAY) or
  /// several identical ones (TWINT shop/online) — the old market-level scalars
  /// always resolved to that instrument regardless of category.
  InstrumentSpec _instrumentForCategory(OfferCategory? category) =>
      _paymentSystem.instrumentFor(category) ??
      _paymentSystem.instruments.values.first;

  /// The market's primary instrument — drives deployment-level flow config
  /// (engine mode, flowId). Current markets have one flow across their
  /// categories; a market with per-category flows would need the FlowRegistry
  /// (deferred to the QR phase).
  InstrumentSpec get _primaryInstrument =>
      _paymentSystem.instruments.values.first;

  /// Whether [offer]'s instrument has the maker supply the payment code upfront
  /// (TWINT). Public so the RPC layer can gate code reveal without reaching for
  /// deprecated market-level scalars.
  bool offerUsesMakerProvidedCode(Offer offer) =>
      _instrumentForCategory(offer.category).makerProvidesCode;

  /// Bank ids this coordinator will accept on new offers: the configured
  /// [_servedBanks] subset, or all of the market ATM instrument's banks when
  /// unset. Empty for bank-agnostic markets.
  List<String> get servedBanks {
    if (_servedBanks.isNotEmpty) return _servedBanks;
    return [
      for (final b in _instrumentForCategory(OfferCategory.atm).banks) b.id
    ];
  }

  /// Flow timeout parameters this coordinator can resolve (yaml `after: $name`).
  static const Set<String> _knownFlowDurationParams = {'code_validity'};

  /// Resolve a timeout edge's duration for [offer]: a fixed `after:` int, or a
  /// `$param` resolved per offer (today only `$code_validity`, from the offer's
  /// bank). Null when the edge has neither (no timer) or an unknown param.
  int? _resolveTimeoutSeconds(Offer offer, FlowTransition t) {
    if (t.durationSeconds != null) return t.durationSeconds;
    final param = t.durationParam;
    if (param == null) return null;
    switch (param) {
      case 'code_validity':
        return _codeValidityForOffer(offer).inSeconds;
      default:
        AppLogger.warning(
            'FLOW ENGINE: unknown timeout param "\$$param" for offer '
            '${offer.id}; no timer armed.');
        return null;
    }
  }

  /// The code-validity window for [offer] — its bank's override, else the
  /// instrument default. Drives the `$code_validity` flow timeouts so Tatra /
  /// SLSP / VÚB get 20 / 15 / 3 minutes from one flow.
  Duration _codeValidityForOffer(Offer offer) {
    final instrument = _instrumentForCategory(offer.category);
    return instrument.validityFor(instrument.bankById(offer.bankId));
  }

  /// Validate the maker-chosen [bank] for a new offer in [category]. Returns the
  /// bank id to store (null for bank-agnostic instruments). Throws when a
  /// bank-scoped instrument is missing a valid, served bank.
  String? _resolveOfferBank(String? bank, OfferCategory? category) {
    final instrument = _instrumentForCategory(category);
    if (!instrument.hasBanks) return null;
    final normalized = bank?.trim();
    if (normalized == null || normalized.isEmpty) {
      throw Exception(
          'A bank is required for ${_paymentSystem.id} offers (one of: '
          '${servedBanks.join(', ')}).');
    }
    if (instrument.bankById(normalized) == null) {
      throw Exception('Unknown bank "$normalized" for ${_paymentSystem.id}.');
    }
    if (!servedBanks.contains(normalized)) {
      throw Exception('This coordinator does not serve bank "$normalized" '
          '(served: ${servedBanks.join(', ')}).');
    }
    return normalized;
  }

  /// State-machine engine loaded from the active method's bundled flow
  /// definition. It is required: every coordinator operates through the
  /// generic YAML flow executor.
  late final FlowEngine _flowEngine;

  // Test-only engine override for exercising deep startup validation against
  // deliberately malformed definitions.
  final FlowEngine? _flowEngineOverride;

  // Test-only override for the payment method id, bypassing `.env`.
  final String? _paymentSystemIdOverride;

  // Supported currencies
  late final List<String> _supportedCurrencies;

  // Reservation timeout configuration
  late final int _reservationTimeoutSeconds;

  /// Reservation window in seconds, read from the `reserved` state in the YAML
  /// definition (with the configured value as a defensive fallback).
  int get _reservationSeconds {
    return _flowEngine.timeoutFor('reserved')?.durationSeconds ??
        _reservationTimeoutSeconds;
  }

  // Funded expire timeout configuration
  late final int _fundedExpireTimeoutSeconds;

  /// Funded-state expiry window in seconds, read from the YAML definition.
  int get fundedExpirySeconds => _fundedExpirySeconds;

  int get _fundedExpirySeconds {
    return _flowEngine.timeoutFor(_flowEngine.initialState)?.durationSeconds ??
        _fundedExpireTimeoutSeconds;
  }

  // taker charged timeout configuration
  late final int _takerChargedAutoConfirmTimeoutSeconds;

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

  final Map<String, _PendingOfferRecord> _pendingOffers = {};
  final Map<String, StreamSubscription> _invoiceSubscriptions = {};
  final Map<String, Timer> _pendingOfferTimeouts = {};
  // Per-stage offer timers live in the generic flow. The coordinator keeps
  // only the shared republish timer.
  final Map<String, Timer> _statusRepublishTimers = {};

  // Fee percentages, configurable via environment variables
  late final double _makerFeePercentage;
  late final double _takerFeePercentage;
  late final int _pendingOfferTimeoutSeconds;

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
      TelegramService? telegramServiceForTest,
      String? paymentSystemIdForTest,
      FlowEngine? flowEngineForTest})
      : _clock = clock ?? const Clock(),
        _httpClient = httpClient ?? http.Client(),
        _nostrService = nostrService,
        _paymentSystemIdOverride = paymentSystemIdForTest,
        _flowEngineOverride = flowEngineForTest {
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

    // Bank subset served by this deployment (bank-scoped markets only, e.g. SK).
    // `BANKS=tatrabanka,slsp` serves those; unset serves every bank the market's
    // ATM instrument defines. Unknown ids are rejected at startup.
    final atmInstrument = _paymentSystem.instrumentFor(OfferCategory.atm) ??
        _paymentSystem.instrumentFor(null);
    final knownBankIds = {
      for (final b in atmInstrument?.banks ?? const []) b.id,
    };
    _servedBanks = (_env['BANKS']?.split(',') ?? const <String>[])
        .map((b) => b.trim())
        .where((b) => b.isNotEmpty)
        .toList();
    final unknownBanks =
        _servedBanks.where((b) => !knownBankIds.contains(b)).toList();
    if (unknownBanks.isNotEmpty) {
      throw StateError(
          'BANKS lists unknown bank(s) ${unknownBanks.join(', ')} for market '
          '"${_paymentSystem.id}" (known: ${knownBankIds.join(', ')}).');
    }

    // Per-bank channel links from `<MESSENGER>_CHANNEL_LINK_<BANKID>` envs, only
    // for the banks this deployment serves.
    final servedBankIds =
        _servedBanks.isNotEmpty ? _servedBanks : knownBankIds.toList();
    _bankChannelLinks = {};
    for (final bankId in servedBankIds) {
      final links = <String, String>{};
      for (final id in CoordinatorInfo.messengerIds) {
        final envKey =
            '${id.toUpperCase()}_CHANNEL_LINK_${bankId.toUpperCase()}';
        final url = (_env[envKey] ?? '').trim();
        if (url.isNotEmpty) links[id] = url;
      }
      if (links.isNotEmpty) _bankChannelLinks[bankId] = links;
    }

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
    _makerFeePercentage =
        double.tryParse(_env['MAKER_FEE'] ?? '') ?? 0.5; // Default to 0.5%
    _takerFeePercentage =
        double.tryParse(_env['TAKER_FEE'] ?? '') ?? 0.5; // Default to 0.5%
    _pendingOfferTimeoutSeconds =
        int.tryParse(_env['PENDING_OFFER_TIMEOUT_SECONDS'] ?? '') ??
            26 * 60 * 60;

    // Per-bank notification targets (bank-scoped markets, e.g. SK). A bank-scoped
    // offer notifies the general channel AND the offer bank's channel.
    _telegramChatIdsByBank = _perBankEnvTargets('TELEGRAM_CHAT_ID');
    _matrixRoomsByBank = _perBankEnvTargets('MATRIX_ROOM');
    _simplexGroupsByBank = _perBankEnvTargets('SIMPLEX_GROUP');
    _signalGroupsByBank = _perBankEnvTargets('SIGNAL_GROUP_ID');

    // Initialize Telegram service
    final telegramBotToken = _env['TELEGRAM_BOT_TOKEN'];
    final telegramChatIds =
        (_env['TELEGRAM_CHAT_ID']?.split(',') ?? const <String>[])
            .map((chatId) => chatId.trim())
            .where((chatId) => chatId.isNotEmpty)
            .toSet()
            .toList();
    _telegramGeneralChatIds = telegramChatIds;
    _telegramService = telegramServiceForTest;
    if (_telegramService != null) {
      AppLogger.info('Telegram service initialized from test override.');
    } else if (telegramBotToken != null &&
        telegramBotToken.isNotEmpty &&
        (telegramChatIds.isNotEmpty || _telegramChatIdsByBank.isNotEmpty)) {
      _telegramService = TelegramService(
        botToken: telegramBotToken,
        chatIds: telegramChatIds,
        httpClient: _httpClient,
      );
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
        '(generic YAML flow).');
  }

  Future<void> _loadFlowEngine() async {
    final method = _paymentSystem.id;
    final flowId = _primaryInstrument.flowId;

    if (_flowEngineOverride != null) {
      _flowEngine = _flowEngineOverride;
    } else {
      try {
        final engine = await FlowLoader.load(flowId);
        if (engine == null) {
          throw StateError(
              'FLOW ENGINE: flow "$flowId" could not be located for method '
              '"$method". Refusing to start.');
        }
        _flowEngine = engine;
      } catch (e) {
        throw StateError(
            'FLOW ENGINE: "$flowId.yml" failed to load or validate for method '
            '"$method": $e');
      }
    }

    // Deep self-check beyond structural parse: effects, timer durations,
    // payout wiring and nip69. Any inconsistency prevents startup.
    flow.validateDefinition();
    AppLogger.info(
        'FLOW ENGINE: generic enforcement active for method "$method" '
        '(flow=$flowId).');
  }

  // ════════════════════════════════════════════════════════════════════
  // The flow logic lives in coordinator_flow_generic.dart; this class owns the
  // shared services it calls.
  // ════════════════════════════════════════════════════════════════════

  bool isTerminalOffer(Offer offer) {
    return _flowEngine.definition.state(offer.statusRaw)?.terminal ?? false;
  }

  GenericOfferFlow? _flow;

  /// The coordinator's sole offer-flow strategy. Nostr routes offer-action RPCs
  /// through it; it also owns funded-timer arming and startup recovery.
  GenericOfferFlow get flow => _flow ??= GenericOfferFlow(this);

  /// NIP-69 status category declared by the flow state [raw], for the broadcast
  /// layer, read from the YAML state's `nip69:` attribute.
  String? nip69CategoryForRaw(String raw) =>
      _flowEngine.definition.state(raw)?.nip69;

  Future<void> doInitialCheckStatuses() async {
    await _initializeMatrixClient();
    // The generic flow re-arms YAML-driven timers for live offers.
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

  Future<void> _removeInvoiceSubscription(String paymentHashHex) async {
    final subscription = _invoiceSubscriptions.remove(paymentHashHex);
    await subscription?.cancel();
  }

  void _armPendingOfferTimeout(String paymentHashHex) {
    _pendingOfferTimeouts[paymentHashHex]?.cancel();
    _pendingOfferTimeouts[paymentHashHex] = Timer(
      Duration(seconds: _pendingOfferTimeoutSeconds),
      () {
        _pendingOfferTimeouts.remove(paymentHashHex);
        unawaited(_expirePendingOffer(paymentHashHex));
      },
    );
  }

  Future<void> _expirePendingOffer(String paymentHashHex) async {
    final pending = _pendingOffers[paymentHashHex];
    if (pending == null) return;

    AppLogger.info(
      'Pending offer for $paymentHashHex exceeded the pre-funding retention '
      'window (${_pendingOfferTimeoutSeconds}s). Cleaning up.',
    );

    try {
      await _paymentBackend?.cancelInvoice(paymentHashHex: paymentHashHex);
    } catch (e) {
      AppLogger.info(
        'Failed to cancel timed-out pending hold invoice $paymentHashHex: $e',
      );
    }

    await _clearPendingOffer(paymentHashHex, reason: 'pending offer timeout');
  }

  Future<void> _clearPendingOffer(
    String paymentHashHex, {
    String? reason,
  }) async {
    _pendingOfferTimeouts.remove(paymentHashHex)?.cancel();
    _pendingOffers.remove(paymentHashHex);
    await _removeInvoiceSubscription(paymentHashHex);
    if (reason != null && reason.isNotEmpty) {
      AppLogger.info(
        'Cleared pending offer resources for $paymentHashHex ($reason).',
      );
    }
  }

  void _startInvoiceSubscription(String paymentHashHex) {
    unawaited(_removeInvoiceSubscription(paymentHashHex));
    AppLogger.info('Starting subscription for invoice: $paymentHashHex');

    if (_paymentBackend == null) {
      AppLogger.info(
          'CRITICAL: No payment backend configured for _startInvoiceSubscription.');
      unawaited(_clearPendingOffer(
        paymentHashHex,
        reason: 'no payment backend available',
      ));
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
            await _clearPendingOffer(
              paymentHashHex,
              reason: 'invoice accepted',
            );
          } else if (update.status == InvoiceStatus.CANCELED) {
            AppLogger.info(
                '$_paymentBackendType Invoice CANCELED: $paymentHashHex');
            await _clearPendingOffer(
              paymentHashHex,
              reason: 'invoice canceled',
            );
          } else if (update.status == InvoiceStatus.SETTLED) {
            // This case might be less common for hold invoices before BLIK,
            // but good to handle if the backend sends it.
            AppLogger.info(
                '$_paymentBackendType Invoice SETTLED: $paymentHashHex');
            await _clearPendingOffer(
              paymentHashHex,
              reason: 'invoice settled before offer creation',
            );
          }
        },
        onError: (error) {
          AppLogger.info(
              'Error in $_paymentBackendType subscription stream for $paymentHashHex: $error');
          unawaited(_clearPendingOffer(
            paymentHashHex,
            reason: 'invoice subscription error',
          ));
        },
        onDone: () {
          AppLogger.info(
              '$_paymentBackendType Subscription stream closed for $paymentHashHex');
          // For NWC, onDone might not mean the end of the world if it's a shared stream.
          // However, for a specific invoice subscription, it usually means it's over.
          // LND typically closes after final state.
          // To be safe, if it's not already removed by ACCEPTED/CANCELED/ERROR, remove it.
          if (_invoiceSubscriptions.containsKey(paymentHashHex)) {
            unawaited(_clearPendingOffer(
              paymentHashHex,
              reason: 'invoice subscription completed',
            ));
          }
        },
        cancelOnError: true,
      );
      _invoiceSubscriptions[paymentHashHex] = subscription;
    } catch (e) {
      AppLogger.info(
          'Failed to initiate $_paymentBackendType subscription for $paymentHashHex: $e');
      unawaited(_clearPendingOffer(
        paymentHashHex,
        reason: 'failed to start invoice subscription',
      ));
    }
  }

  Future<void> _createOfferFromFundedInvoice(String paymentHashHex) async {
    final pending = _pendingOffers.remove(paymentHashHex);
    _pendingOfferTimeouts.remove(paymentHashHex)?.cancel();
    final pendingData = pending?.data;
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
        statusRaw: _flowEngine.initialState,
        blikCode: pendingData['blikCode'] as String?,
        // Maker-provides-code flows (TWINT): the code is issued now — this
        // stamp is the base for its yaml lifespan timeout (code_received_at),
        // reset only when a fresh code is entered, not by reserve/revert.
        blikReceivedAt: pendingData['blikCode'] != null &&
                _primaryInstrument.makerProvidesCode
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
        // Market id + maker-chosen bank, so per-offer instrument/bank
        // resolution (validity windows, labels) works everywhere downstream.
        paymentSystemId: _paymentSystem.id,
        bankId: pendingData['bank'] as String?,
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
  Future<void> _sendSimpleXNotification(String notificationText,
      {String? group}) async {
    try {
      final simplexMsg = "#'${group ?? _simplexGroup}' $notificationText";
      final result = await run('$_simplexChatExec -e "$simplexMsg" --ha');
      if (result.first.stderr.isNotEmpty) {
        AppLogger.info('simplex command error: ${result.first.stderr}');
      }
    } catch (e) {
      AppLogger.info('Error sending SimpleX notification: $e');
    }
  }

  /// Send Matrix notification (returns Future for parallel execution)
  Future<void> _sendMatrixNotification(String notificationText,
      {String? roomId}) async {
    try {
      final targetRoom = roomId ?? _matrixRoomId;
      AppLogger.info('Sending Matrix notification to room $targetRoom');
      final room = _matrixClient!.getRoomById(targetRoom);
      if (room == null) {
        AppLogger.info('Error: Could not find Matrix room $targetRoom');
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
      String notificationText, String offerId,
      {List<String>? chatIds}) async {
    try {
      final result = await _telegramService!
          .sendMessageDetailed(notificationText, chatIds: chatIds);
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

  Future<void> _syncTelegramOfferMessagesForState(Offer offer) async {
    switch (offer.statusRaw) {
      case 'cancelled':
      case 'expired':
        await _strikeTelegramOfferMessages(offer.id);
        return;
      case 'takerPaid':
        await _deleteTelegramOfferMessages(offer.id);
        return;
      default:
        return;
    }
  }

  /// Send Signal notification (returns Future for parallel execution)
  Future<void> _sendSignalNotification(String notificationText,
      {String? groupId}) async {
    try {
      final group = groupId ?? _signalGroupId;
      final signalCmd = '$_signalCliExec send -g $group -m "$notificationText"';
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

  /// General target [general] (dropped if empty) unioned with the offer bank's
  /// targets from [byBank], deduped. Both only when configured.
  List<String> _notifyTargets(
    String general,
    Map<String, List<String>> byBank,
    String? bankId,
  ) {
    final s = <String>{if (general.isNotEmpty) general};
    if (bankId != null) s.addAll(byBank[bankId] ?? const []);
    return s.toList();
  }

  Future<void> _sendOfferNotifications(Offer offer) async {
    final notificationText = _buildFundedOfferNotification(offer);
    final bankId = offer.bankId;
    final notificationFutures = <Future<void>>[];

    // Each messenger: send to the general channel AND the offer bank's channel
    // (both only if configured). For bank-agnostic offers, just the general one.
    if (_simplexChatExec != '') {
      for (final group in _notifyTargets(
          _simplexGroup as String? ?? '', _simplexGroupsByBank, bankId)) {
        notificationFutures
            .add(_sendSimpleXNotification(notificationText, group: group));
      }
    }

    if (_matrixClient != null && _matrixClient!.isLogged()) {
      for (final room
          in _notifyTargets(_matrixRoomId, _matrixRoomsByBank, bankId)) {
        notificationFutures
            .add(_sendMatrixNotification(notificationText, roomId: room));
      }
    }

    if (_telegramService != null && _telegramService!.isConfigured) {
      // Default (null) → the service's own general chats. When the offer's bank
      // has its own chats, override with general ∪ bank so both are notified.
      final bankChats = bankId != null
          ? (_telegramChatIdsByBank[bankId] ?? const [])
          : const [];
      final chatIds = bankChats.isEmpty
          ? null
          : <String>{..._telegramGeneralChatIds, ...bankChats}.toList();
      notificationFutures.add(_sendTelegramNotification(
          notificationText, offer.id,
          chatIds: chatIds));
    }

    if (_signalCliExec != '') {
      for (final group
          in _notifyTargets(_signalGroupId, _signalGroupsByBank, bankId)) {
        notificationFutures
            .add(_sendSignalNotification(notificationText, groupId: group));
      }
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
    'SK': OfferNotificationStrings(
      newOffer: 'New offer/Nová ponuka',
      premium: 'premium/prémia',
      shop: 'Shop/Obchod',
      atm: 'ATM/Bankomat',
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

  /// Status-write-free taker payment primitive: attempts the Lightning payment
  /// and, on a reported failure/exception, reconciles (NWC pay_invoice is not
  /// idempotent) before declaring failure. Performs NO DB writes/publishes so it
  /// backs the generic raw-state payout flow.
  ///
  /// Returns the settled [PayInvoiceResult] on success, or an error string.
  Future<({bool ok, PayInvoiceResult? result, String? error})>
      _attemptTakerPayment(
          String invoice, int netAmountSats, int feeLimitSat) async {
    if (_paymentBackend == null) {
      return (ok: false, result: null, error: 'No payment backend configured');
    }
    try {
      // A committed payout/refund state may be resumed after a coordinator
      // crash. Reconcile before every attempt because NWC pay_invoice is not
      // idempotent and the previous call may have settled before the crash.
      final existing =
          await _paymentBackend!.reconcileOutgoingPayment(invoice: invoice);
      if (existing != null && existing.isSuccess) {
        return (ok: true, result: existing, error: null);
      }
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

  Future<void> shutdown() async {
    for (final timer in _pendingOfferTimeouts.values) {
      timer.cancel();
    }
    _pendingOfferTimeouts.clear();

    for (final timer in _statusRepublishTimers.values) {
      timer.cancel();
    }
    _statusRepublishTimers.clear();

    for (final subscription in _invoiceSubscriptions.values) {
      await subscription.cancel();
    }
    _invoiceSubscriptions.clear();
    _pendingOffers.clear();

    await _paymentBackend?.disconnect();
    _httpClient.close();
  }

  Map<String, dynamic> debugSnapshot() {
    final flowCounters = flow.debugCounters();
    return {
      'payment_backend_type': _paymentBackendType,
      'payment_system': _paymentSystem.id,
      'supported_currencies': _supportedCurrencies,
      'pending_offers': _pendingOffers.length,
      'invoice_subscriptions': _invoiceSubscriptions.length,
      'pending_offer_timeouts': _pendingOfferTimeouts.length,
      'status_republish_timers': _statusRepublishTimers.length,
      'cached_rates': _cachedRates.length,
      'cached_rate_timestamps': _cachedRateTimes.length,
      'matrix_initialized': _matrixClient != null,
      'telegram_configured': _telegramService?.isConfigured ?? false,
      'flow_counters': flowCounters,
    };
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
    String? bank,
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
    // Resolve the payment instrument for this offer's category. Bank-scoped
    // markets (SK ATM) require the maker to pick a served bank up front — they
    // withdraw at that bank's ATM, so the bank is fixed for the offer.
    final instrument = _instrumentForCategory(category);
    final resolvedBank = _resolveOfferBank(bank, category);
    if (instrument.makerProvidesCode) {
      final normalizedCode = blikCode?.trim() ?? '';
      final bankSpec = instrument.bankById(resolvedBank);
      if (!instrument.validate(normalizedCode, bank: bankSpec)) {
        throw Exception(
            'Invalid ${instrument.codeLabel} code. Expected exactly '
            '${instrument.codeLengthFor(bankSpec)} digits.');
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
    _pendingOfferTimeouts.remove(returnedPaymentHashHex)?.cancel();
    _pendingOffers[returnedPaymentHashHex] = _PendingOfferRecord(
      data: {
        'amountSats': satsAmount,
        'makerFees': makerFees,
        'takerFees': takerFees,
        'makerId': makerId,
        'preimageHex': preimageHex,
        'fiatAmount': fiatAmount,
        'fiatCurrency': fiatCurrency,
        'blikCode': blikCode,
        'category': category?.name,
        'bank': resolvedBank,
        'premiumPercent': premium,
        'clientVersion': clientVersion,
        'actualPaymentHashForSubscription': returnedPaymentHashHex,
      },
    );
    AppLogger.info(
        'Pending offer stored for payment hash $returnedPaymentHashHex');
    _armPendingOfferTimeout(returnedPaymentHashHex);
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
      banks: List<String>.from(_servedBanks),
      nostrNpub: null,
      icon: _coordinatorIconUrl.isNotEmpty ? _coordinatorIconUrl : null,
      version: (version != null && version.isNotEmpty) ? version : null,
      termsOfUsageNaddr:
          _termsOfUsageNaddr.isNotEmpty ? _termsOfUsageNaddr : null,
      channelLinks: _channelLinks,
      bankChannelLinks: _bankChannelLinks,
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
