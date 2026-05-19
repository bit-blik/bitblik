import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:memory_cache/memory_cache.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/logger/logger.dart';

import '../models/coordinator_info.dart';
import '../models/offer.dart';
import 'key_service.dart';
import 'nostr_service.dart';

class ApiServiceNostr {
  static const _btcPlnCacheKey = 'btcPlnRate';

  final NostrService _nostrService;
  final KeyService _keyService;

  ApiServiceNostr(this._keyService) : _nostrService = NostrService(_keyService);

  Future<void> init() async {
    await _keyService.init();
    await _nostrService.init();
    final ndkInstance = _nostrService.ndk;
    if (ndkInstance != null) {
      _keyService.attachNdk(ndkInstance);
      await _keyService.migrateLegacyWalletStorage();
    }
  }

  Future<void> dispose() async {
    await _nostrService.dispose();
  }

  Future<Map<String, dynamic>> initiateOfferFiat({
    required double fiatAmount,
    required String makerId,
    String? coordinatorPubkey,
  }) async {
    try {
      if (coordinatorPubkey == null) {
        throw Exception('Coordinator pubkey is required for offer creation');
      }
      return await _nostrService.initiateOfferFiat(
        fiatAmount: fiatAmount,
        makerId: makerId,
        coordinatorPubkey: coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling initiateOfferFiat: $e');
      rethrow;
    }
  }

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
    },
  ];

  static List<String> get exchangeRateSourceNames =>
      _exchangeRateSources.map((s) => s['name']!).toList();

  // Parser for CoinGecko response
  double? _parseCoinGeckoResponse(String responseBody) {
    try {
      final data = jsonDecode(responseBody);
      final rate = data['bitcoin']['pln'];
      if (rate is num) {
        return rate.toDouble();
      }
    } catch (e) {
      Logger.log.e(() => 'Error parsing CoinGecko response: $e');
    }
    return null;
  }

  double? _parseYadioResponse(String responseBody) {
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

  double? _parseBlockchainInfoResponse(String responseBody) {
    try {
      final data = jsonDecode(responseBody);
      final plnData = data['PLN'];
      if (plnData != null && plnData['last'] is num) {
        return (plnData['last'] as num).toDouble();
      }
    } catch (e) {
      Logger.log.e(() => 'Error parsing Blockchain.info response: $e');
    }
    return null;
  }

  Future<double> getBtcPlnRate() async {
    // Check cache first
    final cachedRate = MemoryCache.instance.read<double>(_btcPlnCacheKey);
    if (cachedRate != null) {
      return cachedRate;
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
      MemoryCache.instance.create(
        _btcPlnCacheKey,
        averageRate,
        expiry: const Duration(minutes: 5),
      );
      return averageRate;
    } else {
      final lastKnown = MemoryCache.instance.read<double>(_btcPlnCacheKey);
      if (lastKnown != null) {
        Logger.log.w(
          () =>
              'Returning stale BTC/PLN rate due to all sources failing to fetch.',
        );
        return lastKnown;
      }
      throw Exception('Failed to fetch BTC/PLN rate from all sources.');
    }
  }

  Future<double?> _fetchRateFromSource(Map<String, String> source) async {
    final url = Uri.parse(source['url']!);
    final parserName = source['parser']!;
    final sourceName = source['name']!;

    try {
      final response = await http.get(url);
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
              'Failed to fetch BTC/PLN rate from $sourceName: ${response.statusCode} ${response.body}',
        );
        return null;
      }
    } catch (e) {
      Logger.log.e(() => 'Error fetching BTC/PLN rate from $sourceName: $e');
      return null;
    }
  }

  Future<DateTime?> reserveOffer(
    String offerId,
    String takerId,
    String coordinatorPubkey,
  ) async {
    try {
      return await _nostrService.reserveOffer(
        offerId,
        takerId,
        coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling reserveOffer: $e');
      rethrow;
    }
  }

  Future<void> submitBlikCode({
    required String offerId,
    required String takerId,
    required String blikCode,
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

  Future<Map<String, dynamic>?> getMyActiveOffer(
    String userPubkey,
    String coordinatorPubkey,
  ) async {
    try {
      return await _nostrService.getMyActiveOffer(
        userPubkey,
        coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.e(() => 'Error calling getMyActiveOffer: $e');
      return null;
    }
  }

  Future<List<Offer>> getMyFinishedOffers(String userPubkey) async {
    try {
      return await _nostrService.getMyFinishedOffers(userPubkey);
    } catch (e) {
      Logger.log.e(() => 'Error calling getMyFinishedOffers: $e');
      return [];
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
  Future<Map<String, dynamic>> getSuccessfulOffersStats() async {
    try {
      return await _nostrService.getSuccessfulOffersStats();
    } catch (e) {
      Logger.log.e(() => 'Error calling getSuccessfulOffersStats: $e');
      rethrow;
    }
  }

  /// Update Nostr relay configuration
  Future<void> updateRelayConfig(List<String> relayUrls) async {
    await _nostrService.updateRelayConfig(relayUrls);
  }

  /// Start coordinator discovery
  Future<List<DiscoveredCoordinator>> startCoordinatorDiscovery() async {
    return await _nostrService.startCoordinatorDiscovery();
  }

  /// Start coordinator discovery
  Future<void> checkCoordinatorHealth(String pubKey) async {
    await _nostrService.checkCoordinatorHealth(pubKey);
  }

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

  /// Get discovered coordinators list
  List<DiscoveredCoordinator> get discoveredCoordinators =>
      _nostrService.discoveredCoordinators;

  /// Get current relay URLs
  List<String> get relayUrls => _nostrService.relayUrls;

  /// Get NDK instance (for connectivity management)
  Ndk? get ndk => _nostrService.ndk;

  Stream<Offer> get offersStream => _nostrService.offersStream;

  Future<void> startOfferSubscription() async {
    // Ensure KeyService/NDK are initialized before starting subscriptions.
    await init();
    await _nostrService.startOfferSubscription();
  }

  Future<Offer?> getOffer(String offerId) async {
    try {
      return await _nostrService.getOffer(offerId);
    } catch (e) {
      Logger.log.e(() => 'Error calling getOffer: $e');
      rethrow;
    }
  }

  // --- Coordinator Management Methods ---

  /// Check if a coordinator is in the default whitelist
  bool isDefaultWhitelisted(String pubkey) =>
      _nostrService.isDefaultWhitelisted(pubkey);

  /// Check if a coordinator is blacklisted
  bool isBlacklisted(String pubkey) => _nostrService.isBlacklisted(pubkey);

  /// Get the list of blacklisted coordinators
  List<String> get blacklistedCoordinators =>
      _nostrService.blacklistedCoordinators;

  /// Get the list of custom whitelisted coordinators
  List<String> get customWhitelistedCoordinators =>
      _nostrService.customWhitelistedCoordinators;

  /// Get the list of default whitelisted coordinators
  List<String> get defaultWhitelistedCoordinators =>
      _nostrService.defaultWhitelistedCoordinators;

  /// Toggle blacklist status for a coordinator
  Future<void> toggleBlacklist(String pubkey, bool blacklist) async =>
      await _nostrService.toggleBlacklist(pubkey, blacklist);

  /// Add a coordinator to custom whitelist
  Future<void> addCustomWhitelist(String npub) async =>
      await _nostrService.addCustomWhitelist(npub);

  /// Remove a coordinator from custom whitelist
  Future<void> removeCustomWhitelist(String pubkey) async =>
      await _nostrService.removeCustomWhitelist(pubkey);
}
