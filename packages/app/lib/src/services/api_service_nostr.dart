import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:memory_cache/memory_cache.dart';
import 'package:ndk/ndk.dart';

import 'package:bitblik_core/core.dart';
import 'key_service.dart';
import 'nostr_service.dart';
import 'offer_db_service.dart';

class ApiServiceNostr {
  static String _btcRateCacheKey(String currency) =>
      'btcRate_${currency.toUpperCase()}';
  static String _btcRateFetchedAtCacheKey(String currency) =>
      'btcRateFetchedAt_${currency.toUpperCase()}';
  static String _sourceRateCacheKey(String name, String currency) =>
      'btcRateSource_${currency.toUpperCase()}_$name';

  final NostrService _nostrService;
  final KeyService _keyService;

  ApiServiceNostr(this._keyService) : _nostrService = NostrService(_keyService);

  Future<void> init() async {
    await _keyService.init();
    if (_keyService.publicKeyHex == null || _keyService.privateKeyHex == null) {
      throw const KeyServiceInitializationException(
        'Secure identity storage did not provide a usable keypair.',
      );
    }
    await _nostrService.init();
    final ndkInstance = _nostrService.ndk;
    if (ndkInstance != null) {
      _keyService.attachNdk(ndkInstance);
      unawaited(
        _keyService.migrateLegacyWalletStorage().catchError((e) {
          Logger.log.w(() => '⚠️ Failed migrating legacy wallet storage: $e');
        }),
      );
    }
  }

  Future<void> dispose() async {
    await _nostrService.dispose();
  }

  /// Emits `true` when at least one relay is connected, `false` when none are.
  /// Fires on every connect/reconnect (boot, network restore, app resume).
  Stream<bool> get relayConnectionState => _nostrService.relayConnectionState;

  Future<Map<String, dynamic>> initiateOfferFiat({
    required double fiatAmount,
    required String fiatCurrency,
    OfferCategory? category,
    String? coordinatorPubkey,
    double premiumPercent = 0,
    String? blikCode,
    String? bank,
  }) async {
    try {
      if (coordinatorPubkey == null) {
        throw Exception('Coordinator pubkey is required for offer creation');
      }
      return await _nostrService.initiateOfferFiat(
        fiatAmount: fiatAmount,
        fiatCurrency: fiatCurrency,
        category: category,
        coordinatorPubkey: coordinatorPubkey,
        premiumPercent: premiumPercent,
        blikCode: blikCode,
        bank: bank,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling initiateOfferFiat: $e');
      rethrow;
    }
  }

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

  // Source names are currency-independent.
  static List<String> get exchangeRateSourceNames =>
      _exchangeRateSourcesFor('PLN').map((s) => s['name']!).toList();

  // Parser for CoinGecko response
  double? _parseCoinGeckoResponse(String responseBody, String currency) {
    try {
      final data = jsonDecode(responseBody);
      final rate = data['bitcoin']?[currency.toLowerCase()];
      if (rate is num) {
        return rate.toDouble();
      }
    } catch (e) {
      Logger.log.e(() => 'Error parsing CoinGecko response: $e');
    }
    return null;
  }

  double? _parseYadioResponse(String responseBody, String currency) {
    try {
      final data = jsonDecode(responseBody);
      final rate = data['BTC'];
      if (rate is num) {
        return rate.toDouble();
      }
    } catch (e) {
      Logger.log.e(() => 'Error parsing Yadio response: $e');
    }
    return null;
  }

  double? _parseBlockchainInfoResponse(String responseBody, String currency) {
    try {
      final data = jsonDecode(responseBody);
      final curData = data[currency.toUpperCase()];
      if (curData != null && curData['last'] is num) {
        return (curData['last'] as num).toDouble();
      }
    } catch (e) {
      Logger.log.e(() => 'Error parsing Blockchain.info response: $e');
    }
    return null;
  }

  Future<double> getBtcRate(String currency) async {
    final cachedRate = MemoryCache.instance.read<double>(
      _btcRateCacheKey(currency),
    );
    if (cachedRate != null) {
      return cachedRate;
    }

    await _fetchAndCacheAllSources(currency);

    final fresh = MemoryCache.instance.read<double>(_btcRateCacheKey(currency));
    if (fresh != null) return fresh;

    throw Exception('Failed to fetch BTC/$currency rate from all sources.');
  }

  Future<void> _fetchAndCacheAllSources(String currency) async {
    final fetchedAt = DateTime.now();
    final sources = _exchangeRateSourcesFor(currency);
    final results = await Future.wait(
      sources.map((s) => _fetchRateFromSource(s, currency)),
    );

    for (var i = 0; i < sources.length; i++) {
      final name = sources[i]['name']!;
      final rate = results[i];
      if (rate != null) {
        MemoryCache.instance.create(
          _sourceRateCacheKey(name, currency),
          rate,
          expiry: const Duration(minutes: 5),
        );
      }
    }

    final validRates = results.whereType<double>().toList();
    if (validRates.isNotEmpty) {
      final averageRate =
          validRates.reduce((a, b) => a + b) / validRates.length;
      MemoryCache.instance.create(
        _btcRateCacheKey(currency),
        averageRate,
        expiry: const Duration(minutes: 5),
      );
      MemoryCache.instance.create(
        _btcRateFetchedAtCacheKey(currency),
        fetchedAt,
        expiry: const Duration(minutes: 5),
      );
    } else {
      Logger.log.w(
        () =>
            'Returning stale BTC/$currency rate due to all sources failing to fetch.',
      );
    }
  }

  Future<double?> _fetchRateFromSource(
    Map<String, String> source,
    String currency,
  ) async {
    final url = Uri.parse(source['url']!);
    final parserName = source['parser']!;
    final sourceName = source['name']!;

    try {
      final response = await http.get(url);
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
          Logger.log.d(
            () => 'Successfully fetched rate from $sourceName: $rate',
          );
          return rate;
        } else {
          Logger.log.w(() => 'Failed to parse response from $sourceName');
          return null;
        }
      } else {
        Logger.log.w(
          () =>
              'Failed to fetch BTC/$currency rate from $sourceName: ${response.statusCode} ${response.body}',
        );
        return null;
      }
    } catch (e) {
      Logger.log.e(
        () => 'Error fetching BTC/$currency rate from $sourceName: $e',
      );
      return null;
    }
  }

  Future<({Map<String, double?> rates, DateTime fetchedAt})> getSourceRates(
    String currency,
  ) async {
    if (MemoryCache.instance.read<double>(_btcRateCacheKey(currency)) == null) {
      await _fetchAndCacheAllSources(currency);
    }
    final fetchedAt =
        MemoryCache.instance.read<DateTime>(
          _btcRateFetchedAtCacheKey(currency),
        ) ??
        DateTime.now();
    final rates = Map.fromEntries(
      _exchangeRateSourcesFor(currency).map(
        (s) => MapEntry(
          s['name']!,
          MemoryCache.instance.read<double>(
            _sourceRateCacheKey(s['name']!, currency),
          ),
        ),
      ),
    );
    return (rates: rates, fetchedAt: fetchedAt);
  }

  Future<ReserveOfferResult> reserveOffer(
    String offerId,
    String takerId,
    String coordinatorPubkey, {
    String? takerLightningAddress,
    String? takerInvoice,
  }) async {
    // Client-side guard: a maker cannot take their own offer. The public
    // NIP-69 offer event carries no maker pubkey (it falls back to the
    // coordinator's), so the only reliable source for the real maker is our
    // own local record of offers we created. If a local record exists for this
    // offer with our pubkey as maker, block before any coordinator request.
    final localOffer = await OfferDbService().getOfferById(offerId);
    if (localOffer != null && localOffer.makerPubkey == takerId) {
      Logger.log.w(() => 'Blocked attempt to take own offer $offerId');
      throw const CannotTakeOwnOfferException();
    }

    try {
      return await _nostrService.reserveOffer(
        offerId,
        takerId,
        coordinatorPubkey,
        takerLightningAddress: takerLightningAddress,
        takerInvoice: takerInvoice,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling reserveOffer: $e');
      rethrow;
    }
  }

  Future<void> submitBlikCode({
    required String offerId,
    required String takerId,
    String? blikCode,
    required String takerInvoice,
    required String coordinatorPubkey,
  }) async {
    try {
      await _nostrService.submitBlikCode(
        offerId: offerId,
        takerId: takerId,
        blikCode: blikCode,
        takerInvoice: takerInvoice,
        coordinatorPubkey: coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling submitBlikCode: $e');
      rethrow;
    }
  }

  Future<String?> getBlikCodeForMaker(
    String offerId,
    String makerId,
    String coordinatorPubkey,
  ) async {
    try {
      return await _nostrService.getBlikCodeForMaker(
        offerId,
        makerId,
        coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling getBlikCodeForMaker: $e');
      if (e.toString().contains('not found')) {
        return null;
      }
      rethrow;
    }
  }

  Future<void> confirmMakerPayment(
    String offerId,
    String makerId,
    String coordinatorPubkey,
  ) async {
    try {
      await _nostrService.confirmMakerPayment(
        offerId,
        makerId,
        coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling confirmMakerPayment: $e');
      rethrow;
    }
  }

  Future<Map<String, dynamic>?> getOfferDetails(
    Offer offer,
    String coordinatorPubkey, {
    bool strict = false,
  }) async {
    try {
      return await _nostrService.getOfferDetails(
        offer,
        coordinatorPubkey,
        strict: strict,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling getOfferDetails: $e');
      if (strict) rethrow;
      return null;
    }
  }

  Future<void> cancelOffer(String offerId, String coordinatorPubkey) async {
    try {
      await _nostrService.cancelOffer(offerId, coordinatorPubkey);
    } catch (e) {
      Logger.log.e(() => 'Error calling cancelOffer: $e');
      rethrow;
    }
  }

  /// Generic flow-action dispatcher for yaml-driven flows (see
  /// [NostrService.sendFlowAction]). The [event] is the transition name, which
  /// equals the coordinator RPC method.
  Future<Map<String, dynamic>> sendFlowAction({
    required String event,
    required String offerId,
    required String coordinatorPubkey,
    Map<String, dynamic> extraParams = const {},
  }) async {
    try {
      return await _nostrService.sendFlowAction(
        event: event,
        offerId: offerId,
        coordinatorPubkey: coordinatorPubkey,
        extraParams: extraParams,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling flow action "$event": $e');
      rethrow;
    }
  }

  Future<void> cancelReservation(
    String offerId,
    String takerPubkey,
    String coordinatorPubKey,
  ) async {
    try {
      await _nostrService.cancelReservation(
        offerId,
        takerPubkey,
        coordinatorPubKey,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling cancelReservation: $e');
      rethrow;
    }
  }

  Future<void> updateTakerInvoice({
    required String offerId,
    required String newBolt11,
    required String userPubkey,
    required String coordinatorPubkey,
  }) async {
    try {
      await _nostrService.updateTakerInvoice(
        offerId: offerId,
        newBolt11: newBolt11,
        userPubkey: userPubkey,
        coordinatorPubkey: coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling updateTakerInvoice: $e');
      rethrow;
    }
  }

  // POST /offers/{offerId}/retry-taker-payment - via Nostr
  Future<Map<String, dynamic>> retryTakerPayment({
    required String offerId,
    required String userPubkey,
    required String coordinatorPubkey,
  }) async {
    try {
      return await _nostrService.retryTakerPayment(
        offerId: offerId,
        userPubkey: userPubkey,
        coordinatorPubkey: coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling retryTakerPayment: $e');
      rethrow;
    }
  }

  // POST /offers/{offerId}/blik-invalid - via Nostr
  Future<void> markBlikInvalid(
    String offerId,
    String makerId,
    String coordinatorPubKey,
  ) async {
    try {
      await _nostrService.markBlikInvalid(offerId, makerId, coordinatorPubKey);
    } catch (e) {
      Logger.log.e(() => 'Error calling markBlikInvalid: $e');
      rethrow;
    }
  }

  Future<void> markBlikCharged(String offerId, String coordinatorPubKey) async {
    try {
      await _nostrService.markBlikCharged(offerId, coordinatorPubKey);
    } catch (e) {
      Logger.log.e(() => 'Error calling markOfferConflict: $e');
      rethrow;
    }
  }

  Future<void> openDispute(String offerId, String coordinatorPubKey) async {
    try {
      await _nostrService.openDispute(offerId, coordinatorPubKey);
    } catch (e) {
      Logger.log.e(() => 'Error calling markOfferConflict: $e');
      rethrow;
    }
  }

  /// Get coordinator info by pubkey
  CoordinatorInfo? getCoordinatorInfoByPubkey(String coordinatorPubkey) {
    return _nostrService.getCoordinatorInfoByPubkey(coordinatorPubkey);
  }

  // GET /stats/successful-offers - via Nostr
  Future<Map<String, dynamic>> getSuccessfulOffersStats({
    String? paymentSystemId,
  }) async {
    try {
      return await _nostrService.getSuccessfulOffersStats(
        paymentSystemId: paymentSystemId,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling getSuccessfulOffersStats: $e');
      rethrow;
    }
  }

  /// Coordinator registry exposed for screens that need streamed updates.
  CoordinatorRegistry get coordinatorRegistry =>
      _nostrService.coordinatorRegistry;

  /// One-shot discovery sweep. Updates registry in place.
  Future<void> startCoordinatorDiscovery() =>
      _nostrService.coordinatorRegistry.discover();

  /// Probe a single coordinator's responsiveness.
  Future<void> checkCoordinatorHealth(String pubKey) =>
      _nostrService.coordinatorRegistry.probeHealth(pubKey);

  /// Start listening for offer status updates
  Future<void> startOfferStatusSubscription(
    String coordinatorPubKey,
    String userPubkey,
  ) async {
    await _nostrService.startOfferStatusSubscription(
      coordinatorPubKey,
      userPubkey,
    );
  }

  /// Stop offer status subscription
  Future<void> stopOfferStatusSubscription() async {
    await _nostrService.stopOfferStatusSubscription();
  }

  /// Get stream of offer status updates
  Stream<OfferStatusUpdate> get offerStatusStream =>
      _nostrService.offerStatusStream;

  /// Snapshot of all known coordinators (enabled + disabled). UI should
  /// prefer the registry's `changes` stream to react to updates.
  List<CoordinatorRecord> get discoveredCoordinators =>
      _nostrService.coordinatorRegistry.all;

  /// Get current relay URLs
  List<String> get relayUrls => _nostrService.relayUrls;

  /// Get NDK instance (for connectivity management)
  Ndk? get ndk => _nostrService.ndk;

  Stream<Offer> get offersStream => _nostrService.offersStream;
  List<Offer> get knownOffers => _nostrService.knownOffers;

  Future<void> startOfferSubscription({String platformTag = 'Bitblik'}) async {
    // Ensure KeyService/NDK are initialized before starting subscriptions.
    await init();
    await _nostrService.startOfferSubscription(platformTag: platformTag);
  }

  Future<Offer?> getOffer(String offerId) async {
    try {
      return await _nostrService.getOffer(offerId);
    } catch (e) {
      Logger.log.e(() => 'Error calling getOffer: $e');
      rethrow;
    }
  }

  // --- Coordinator Management ---

  /// Thin wrappers over [CoordinatorRegistry]. Screens that need richer
  /// behaviour should call into [coordinatorRegistry] directly.
  bool isEnabled(String pubkey) =>
      _nostrService.coordinatorRegistry.recordFor(pubkey)?.enabled ?? false;

  Future<void> setCoordinatorEnabled(String pubkey, bool enabled) =>
      _nostrService.coordinatorRegistry.setEnabled(pubkey, enabled);

  Future<CoordinatorRecord> addManualCoordinator(String npubOrHex) =>
      _nostrService.coordinatorRegistry.addManual(npubOrHex);

  Future<void> removeCoordinator(String pubkey) =>
      _nostrService.coordinatorRegistry.remove(pubkey);
}
