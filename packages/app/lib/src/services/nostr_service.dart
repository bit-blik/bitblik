import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/isolates/isolate_manager.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'package:ndk_rust_verifier/ndk_rust_verifier.dart' as web_rust_verifier;

import 'package:bitblik_core/core.dart';
import 'key_service.dart';
import 'nostr_cache_factory.dart';

/// Discovered coordinator information
class DiscoveredCoordinator {
  final String pubkey;
  final String name;
  final String? icon;
  final int minAmountSats;
  final int maxAmountSats;
  final double makerFee;
  final double takerFee;
  final int reservationSeconds;
  final List<String> currencies;
  final String version;
  final DateTime lastSeen;
  bool? responsive;
  final String? termsOfUsageNaddr;

  DiscoveredCoordinator({
    required this.pubkey,
    required this.name,
    this.icon,
    required this.minAmountSats,
    required this.maxAmountSats,
    required this.makerFee,
    required this.takerFee,
    required this.reservationSeconds,
    required this.currencies,
    required this.version,
    required this.lastSeen,
    this.responsive,
    this.termsOfUsageNaddr,
  });

  factory DiscoveredCoordinator.fromNostrEvent(Nip01Event event) {
    final info = CoordinatorInfo.fromNostrEvent(event);
    return DiscoveredCoordinator(
      pubkey: event.pubKey,
      name: info.name,
      icon: info.icon,
      minAmountSats: info.minAmountSats,
      maxAmountSats: info.maxAmountSats,
      makerFee: info.makerFee,
      takerFee: info.takerFee,
      reservationSeconds: info.reservationSeconds,
      currencies: info.currencies,
      version: info.version ?? '',
      lastSeen: DateTime.fromMillisecondsSinceEpoch(event.createdAt * 1000),
      responsive: null,
      termsOfUsageNaddr: info.termsOfUsageNaddr,
    );
  }

  CoordinatorInfo toCoordinatorInfo() {
    return CoordinatorInfo(
      name: name,
      icon: icon,
      minAmountSats: minAmountSats,
      maxAmountSats: maxAmountSats,
      makerFee: makerFee,
      takerFee: takerFee,
      reservationSeconds: reservationSeconds,
      currencies: currencies,
      nostrNpub: Nip19.encodePubKey(pubkey),
      version: version,
      termsOfUsageNaddr: termsOfUsageNaddr,
    );
  }
}

/// Service for Nostr-based communication with coordinators
class NostrService {
  static const String _selectedCoordinatorKey = 'selected_coordinator_pubkey';
  static const String _relayUrlsKey = 'relay_urls';
  static const String _blacklistKey = 'coordinators.blacklist';
  static const String _customWhitelistKey = 'coordinators.customWhitelist';

  static const List<String> _defaultRelayUrls = [
    'wss://relay.mostro.network',
    'wss://relay.primal.net',
    // 'wss://relay.damus.io',
    // 'wss://nos.lol',
  ];

  final KeyService _keyService;
  Ndk? _ndk;
  Bip340EventSigner? _clientSigner;
  BitblikRpcClient? _rpcClient;

  List<String> _relayUrls = [];

  NdkResponse? _offerStatusSubscription;
  NdkResponse? _offerSubscription;

  bool _isInitialized = false;

  // Discovered coordinators
  final Map<String, DiscoveredCoordinator> _discoveredCoordinators = {};
  final StreamController<OfferStatusUpdate> _offerStatusController =
      StreamController<OfferStatusUpdate>.broadcast();
  late StreamController<Offer> _offerStreamController;

  // Coordinator info cache by pubkey
  final Map<String, CoordinatorInfo> _coordinatorInfoCache = {};

  // Blacklist and custom whitelist (loaded from preferences)
  List<String> _disabledCoordinators = [];
  List<String> _customCoordinators = [];

  NostrService(this._keyService) {
    _offerStreamController = StreamController<Offer>.broadcast();
  }

  /// Initialize the Nostr service
  Future<void> init() async {
    if (_isInitialized) return;

    await _loadConfiguration();
    await _initializeNdk();
    await _subscribeToResponses();

    _isInitialized = true;
    Logger.log.i(() => '✅ NostrService initialized');
  }

  /// Load configuration from SharedPreferences
  Future<void> _loadConfiguration() async {
    final prefs = await SharedPreferences.getInstance();

    _relayUrls =
    // prefs.getStringList(_relayUrlsKey) ??
    List.from(_defaultRelayUrls);
    _disabledCoordinators = prefs.getStringList(_blacklistKey) ?? [];
    _customCoordinators =
        prefs.getStringList(_customWhitelistKey) ?? [];

    Logger.log.i(() => '📡 Using relays: $_relayUrls');
    Logger.log.i(
      () => '🚫 Disabled coordinators: ${_disabledCoordinators.length}',
    );
    Logger.log.i(
      () =>
          '✅ Custom whitelisted coordinators: ${_customCoordinators.length}',
    );
  }

  /// Initialize NDK and connect to relays
  Future<void> _initializeNdk() async {
    // Destroy existing NDK instance if it exists
    if (_ndk != null) {
      try {
        await _ndk!.destroy();
        Logger.log.d(() => '🔄 Destroyed previous NDK instance');
      } catch (e) {
        Logger.log.w(() => '⚠️ Error destroying previous NDK instance: $e');
      }
    }
    final cacheManager = await createNostrCacheManager();
    // await SembastCacheManager.create(
    //           databasePath: (await getApplicationDocumentsDirectory()).path,
    //         )
    ;

    late final EventVerifier eventVerifier;
    if (kIsWeb) {
      try {
        eventVerifier = WebEventVerifier();
      } on UnsupportedError {
        eventVerifier = Bip340EventVerifier();
      }
    } else {
      eventVerifier = RustEventVerifier();
    }

    // Initialize NDK with bootstrap relays config
    _ndk = Ndk(
      NdkConfig(
        cache: cacheManager,
        walletsRepo: FlutterSecureStorageWalletsRepo(),
        eventVerifier: eventVerifier,
        bootstrapRelays: _relayUrls,
        logLevel: kDebugMode ? LogLevel.debug : LogLevel.warning,
      ),
    );

    await IsolateManager.instance.ready;

    ndk!.connectivity.relayConnectivityChanges.listen((data) {
      print("🔗 Relay connectivity change: ${data}");
    });

    // _ndk!.connectivity.relayConnectivityChanges.listen((data) {
    //   print('🔗 Relay connectivity change: $data');
    //   print('🔗 Connectivity data type: ${data.runtimeType}');
    //
    //   // Print detailed information if data has specific properties
    //   try {
    //     if (data is Map) {
    //       final map = data as Map;
    //       print('🔗 Connectivity map keys: ${map.keys}');
    //       map.forEach((key, value) {
    //         print('🔗   $key: $value');
    //       });
    //     } else {
    //       print('🔗 Connectivity data toString: ${data.toString()}');
    //     }
    //   } catch (e) {
    //     print('🔗 Error parsing connectivity data: $e');
    //   }
    // });
    Logger.log.i(
      () =>
          '🔑 Client signer initialized with pubkey: ${_keyService.publicKeyHex}',
    );

    // Do not block initialization on relay connectivity.
    // Wallet permissions (including cached NWC permissions) can be available
    // before relays are connected, and startup should stay responsive.
    Logger.log.t(() => '⏳ Skipping blocking relay wait during initialization.');

    // Best-effort connectivity probe for diagnostics only.
    try {
      await ndk!.connectivity.relayConnectivityChanges.first.timeout(
        const Duration(milliseconds: 250),
      );
      Logger.log.t(() => '✅ Relay connectivity event received during startup');
    } on TimeoutException {
      Logger.log.t(() => 'ℹ️ No relay connectivity event yet (continuing)');
    } catch (e) {
      Logger.log.t(() => 'ℹ️ Relay connectivity probe failed (continuing): $e');
    }
  }

  /// Subscribe to response events from coordinator (via [BitblikRpcClient]).
  Future<void> _subscribeToResponses() async {
    if (_keyService.publicKeyHex == null ||
        _keyService.privateKeyHex == null) {
      throw Exception('KeyService not initialized');
    }

    _clientSigner = Bip340EventSigner(
      privateKey: _keyService.privateKeyHex!,
      publicKey: _keyService.publicKeyHex!,
    );

    _rpcClient = BitblikRpcClient(
      ndk: _ndk!,
      signer: _clientSigner!,
      relays: _relayUrls,
      subscriptionName: 'client-responses',
    );
    await _rpcClient!.start();
    Logger.log.i(() => '👂 Subscribed to coordinator responses');
  }

  /// Send a request to the coordinator and wait for response
  Future<NostrResponse> sendRequest(
    NostrRequest request,
    String coordinatorPubkey,
  ) async {
    if (!_isInitialized) {
      await init();
    }
    if (_rpcClient == null) {
      throw Exception('RPC client not initialized');
    }

    try {
      return await _rpcClient!.send(request, coordinatorPubkey);
    } on TimeoutException {
      // Trigger a health check for this coordinator, unless this WAS the
      // health check (avoid infinite recursion).
      if (request.method != kRpcGetInfo) {
        checkCoordinatorHealth(coordinatorPubkey).catchError((error) {
          Logger.log.w(
            () => '⚠️ Error during health check after timeout: $error',
          );
        });
      }
      rethrow;
    }
  }

  /// Helper method to handle response and throw exceptions on error
  T _handleResponse<T>(
    NostrResponse response,
    T Function(Map<String, dynamic>) parser,
  ) {
    if (!response.isSuccess) {
      final error = response.error;
      final errorMessage = error?['message'] ?? 'Unknown error';
      final errorCode = error?['code'] ?? 'UNKNOWN';
      throw NostrException(errorMessage, code: errorCode);
    }

    if (response.result == null) {
      throw NostrException('No result in response');
    }

    return parser(response.result!);
  }

  // --- API Methods (matching original ApiService) ---

  /// POST /initiate-offer (fiat version)
  Future<Map<String, dynamic>> initiateOfferFiat({
    required double fiatAmount,
    required String makerId,
    required String coordinatorPubkey,
  }) async {
    final request = NostrRequest(
      method: kRpcInitiateOffer,
      params: {'fiat_amount': fiatAmount, 'maker_id': makerId},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    return _handleResponse(response, (result) => result);
  }

  /// GET BTC/PLN rate from external sources (unchanged - not using coordinator)
  Future<double> getBtcPlnRate() async {
    // This method should remain using HTTP requests to external APIs
    // as it doesn't need to go through the coordinator
    throw UnimplementedError(
      'This method should use the original HTTP implementation for external APIs',
    );
  }

  /// Get a stream of all live offers published (subscribe before listening!)
  Stream<Offer> get offersStream => _offerStreamController.stream;

  /// Start listening for offers (subscribe to event kind 38383 from all coordinators)
  Future<void> startOfferSubscription() async {
    if (!_isInitialized) {
      await init();
    }

    // Unsubscribe previous subscription, if any
    if (_offerSubscription != null) {
      await _ndk!.requests.closeSubscription(_offerSubscription!.requestId);
    }
    final filter = Filter(
      kinds: [kKindOffer],
      tags: {
        "#f": ["PLN"],
        "#y": ["Bitblik"],
        // "#pm": ["BLIK"],
      },
      since:
          DateTime.now()
              .subtract(const Duration(hours: 2))
              .millisecondsSinceEpoch ~/
          1000,
    );
    _offerSubscription = _ndk!.requests.subscription(
      name: "offers-stream",
      filters: [filter],
      explicitRelays: _relayUrls,
    );
    _offerSubscription!.stream.listen(_handleOfferEvent);
    Logger.log.i(() => '🔎 Started offers subscription');
  }

  void _handleOfferEvent(Nip01Event event) {
    try {
      _offerStreamController.add(Offer.fromNostrEvent(event));
    } catch (e) {
      Logger.log.e(() => '❌ Error parsing offer event: $e');
    }
  }

  /// Stop the live offer subscription
  Future<void> stopOfferSubscription() async {
    if (_offerSubscription != null) {
      await _ndk!.requests.closeSubscription(_offerSubscription!.requestId);
      _offerSubscription = null;
    }
    await _offerStreamController.close();
    _offerStreamController =
        StreamController<Offer>.broadcast(); // so can restart
  }

  /// GET /offers/{offerId}
  Future<Offer?> getOffer(String offerId) async {
    if (!_isInitialized) {
      await init();
    }

    final filter = Filter(kinds: [kKindOffer], dTags: [offerId], limit: 1);

    // Use query for a one-time fetch.
    final response = _ndk!.requests.query(
      filters: [filter],
      cacheRead: false,
      explicitRelays: _relayUrls,
    );
    final events = await response.stream.toList();

    if (events.isEmpty) {
      return null;
    }

    return Offer.fromNostrEvent(events.first);
  }

  /// POST /offers/{offerId}/reserve
  Future<DateTime?> reserveOffer(
    String offerId,
    String takerId,
    String coordinatorPubkey,
  ) async {
    final request = NostrRequest(
      method: kRpcReserveOffer,
      params: {'offer_id': offerId},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    return _handleResponse(response, (result) {
      final timestamp = result['reserved_at'] as int?;
      if (timestamp != null) {
        return DateTime.fromMillisecondsSinceEpoch(timestamp);
      }
      return null;
    });
  }

  /// POST /offers/{offerId}/blik
  Future<void> submitBlikCode({
    required String offerId,
    required String takerId,
    required String blikCode,
    required String takerInvoice,
    required String coordinatorPubkey,
  }) async {
    final request = NostrRequest(
      method: kRpcSubmitBlik,
      params: {
        'offer_id': offerId,
        'blik_code': blikCode,
        'taker_invoice': takerInvoice,
      },
    );

    final response = await sendRequest(request, coordinatorPubkey);
    _handleResponse(response, (result) => null);
  }

  /// GET /offers/{offerId}/blik
  Future<String?> getBlikCodeForMaker(
    String offerId,
    String makerId,
    String coordinatorPubkey,
  ) async {
    final request = NostrRequest(
      method: kRpcGetBlik,
      params: {'offer_id': offerId},
    );

    try {
      final response = await sendRequest(request, coordinatorPubkey);
      return _handleResponse(
        response,
        (result) => result['blik_code'] as String?,
      );
    } catch (e) {
      if (e is NostrException && e.message.contains('not found')) {
        return null;
      }
      rethrow;
    }
  }

  /// POST /offers/{offerId}/confirm
  Future<void> confirmMakerPayment(
    String offerId,
    String makerId,
    String coordinatorPubkey,
  ) async {
    final request = NostrRequest(
      method: kRpcConfirmPayment,
      params: {'offer_id': offerId},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    _handleResponse(response, (result) => null);
  }

  /// GET /my-active-offer
  Future<Map<String, dynamic>?> getMyActiveOffer(
    String userPubkey,
    String coordinatorPubkey,
  ) async {
    if (!_isInitialized) {
      await init();
    }

    try {
      final request = NostrRequest(method: kRpcGetMyActiveOffer, params: {});
      final response = await sendRequest(request, coordinatorPubkey);
      final result = _handleResponse(response, (result) {
        if (result.isEmpty) return null;
        // Add coordinator pubkey to the result
        result['coordinator_pubkey'] = coordinatorPubkey;
        return result;
      });
      if (result != null) {
        return result; // Return the first active offer found
      }
    } catch (e) {
      // Continue to the next coordinator if one fails
      Logger.log.e(
        () =>
            "Error getting active offer from coordinator ${coordinatorPubkey}: $e",
      );
    }
    return null; // No active offer found on any coordinator
  }

  /// GET /my-finished-offers - This will now query all coordinators
  Future<List<Offer>> getMyFinishedOffers(String userPubkey) async {
    if (!_isInitialized) {
      await init();
    }

    final allOffers = <Offer>[];
    final coordinators = _discoveredCoordinators.values.toList();
    if (coordinators.isEmpty) {
      Logger.log.w(
        () => "No coordinators discovered, cannot get finished offers.",
      );
      return [];
    }

    final List<Future<List<Offer>>> offerFutures = [];

    for (final coordinator in coordinators) {
      offerFutures.add(
        _getMyFinishedOffersFromCoordinator(userPubkey, coordinator.pubkey),
      );
    }

    final List<List<Offer>> results = await Future.wait(offerFutures);
    for (final offerList in results) {
      allOffers.addAll(offerList);
    }

    allOffers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return allOffers;
  }

  Future<List<Offer>> _getMyFinishedOffersFromCoordinator(
    String userPubkey,
    String coordinatorPubkey,
  ) async {
    try {
      final request = NostrRequest(
        method: kRpcGetMyFinishedOffers,
        params: {},
      );
      final response = await sendRequest(request, coordinatorPubkey);
      return _handleResponse(response, (result) {
        final List<dynamic> jsonList = result['offers'] ?? [];
        return jsonList.map((json) {
          final offer = Offer.fromJson(json);
          return offer.copyWith(coordinatorPubkey: coordinatorPubkey);
        }).toList();
      });
    } catch (e) {
      Logger.log.e(
        () =>
            "Error getting finished offers from coordinator $coordinatorPubkey: $e",
      );
      return [];
    }
  }

  /// DELETE /offers/{offerId}/cancel
  Future<void> cancelOffer(String offerId, String coordinatorPubkey) async {
    final request = NostrRequest(
      method: kRpcCancelOffer,
      params: {'offer_id': offerId},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    _handleResponse(response, (result) => null);
  }

  /// DELETE /offers/{offerId}/reservation (taker cancels reservation)
  Future<void> cancelReservation(
    String offerId,
    String takerPubkey,
    String coordinatorPubkey,
  ) async {
    final request = NostrRequest(
      method: kRpcCancelReservation,
      params: {'offer_id': offerId},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    _handleResponse(response, (result) => null);
  }

  /// POST /offers/{offerId}/update-invoice
  Future<void> updateTakerInvoice({
    required String offerId,
    required String newBolt11,
    required String userPubkey,
    required String coordinatorPubkey,
  }) async {
    final request = NostrRequest(
      method: kRpcUpdateTakerInvoice,
      params: {'offer_id': offerId, 'bolt11': newBolt11},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    _handleResponse(response, (result) => null);
  }

  /// POST /offers/{offerId}/retry-taker-payment
  Future<Map<String, dynamic>> retryTakerPayment({
    required String offerId,
    required String userPubkey,
    required String coordinatorPubkey,
  }) async {
    final request = NostrRequest(
      method: kRpcRetryTakerPayment,
      params: {'offer_id': offerId},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    return _handleResponse(response, (result) => result);
  }

  /// POST /offers/{offerId}/blik-invalid
  Future<void> markBlikInvalid(
    String offerId,
    String makerId,
    String coordinatorPubkey,
  ) async {
    final request = NostrRequest(
      method: kRpcMarkBlikInvalid,
      params: {'offer_id': offerId},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    _handleResponse(response, (result) => null);
  }

  Future<void> markBlikCharged(String offerId, String coordinatorPubkey) async {
    final request = NostrRequest(
      method: kRpcMarkBlikCharged,
      params: {'offer_id': offerId},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    _handleResponse(response, (result) => null);
  }

  Future<void> openDispute(String offerId, String coordinatorPubkey) async {
    final request = NostrRequest(
      method: kRpcOpenDispute,
      params: {'offer_id': offerId},
    );

    final response = await sendRequest(request, coordinatorPubkey);
    _handleResponse(response, (result) => null);
  }

  /// Get coordinator info by pubkey (from cache or discovery)
  CoordinatorInfo? getCoordinatorInfoByPubkey(String coordinatorPubkey) {
    // Check cache first
    if (_coordinatorInfoCache.containsKey(coordinatorPubkey)) {
      return _coordinatorInfoCache[coordinatorPubkey];
    }

    // Check discovered coordinators
    final discoveredCoordinator = _discoveredCoordinators[coordinatorPubkey];
    if (discoveredCoordinator != null) {
      final coordinatorInfo = discoveredCoordinator.toCoordinatorInfo();
      // Cache for future use
      _coordinatorInfoCache[coordinatorPubkey] = coordinatorInfo;
      return coordinatorInfo;
    }

    return null;
  }

  /// GET /stats/successful-offers - This will now query all coordinators
  Future<Map<String, dynamic>> getSuccessfulOffersStats() async {
    if (!_isInitialized) {
      await init();
    }

    final coordinators = _discoveredCoordinators.values.toList();
    if (coordinators.isEmpty) {
      Logger.log.w(() => "No coordinators discovered, cannot get stats.");
      return {
        'total_sats': 0,
        'total_offers': 0,
        'offers': <Offer>[],
        'stats': {
          'lifetime': {
            'avg_time_blik_received_to_created_seconds': null,
            'avg_time_taker_paid_to_created_seconds': null,
            'count': 0,
          },
          'last_7_days': {
            'avg_time_blik_received_to_created_seconds': null,
            'avg_time_taker_paid_to_created_seconds': null,
            'count': 0,
          },
        },
      };
    }

    int totalSats = 0;
    int totalOffers = 0;
    final allOffers = <Offer>[];

    // For aggregating stats
    int lifetimeCount = 0;
    int last7DaysCount = 0;
    double lifetimeBlikTimeSum = 0;
    double lifetimePaidTimeSum = 0;
    double last7DaysBlikTimeSum = 0;
    double last7DaysPaidTimeSum = 0;
    int lifetimeBlikTimeValidEntries = 0;
    int lifetimePaidTimeValidEntries = 0;
    int last7DaysBlikTimeValidEntries = 0;
    int last7DaysPaidTimeValidEntries = 0;

    for (final coordinator in coordinators) {
      try {
        final request = NostrRequest(
          method: kRpcGetSuccessfulOffersStats,
          params: {},
        );
        final response = await sendRequest(request, coordinator.pubkey);
        final stats = _handleResponse(response, (result) {
          if (result.containsKey('offers') && result['offers'] is List) {
            final List<dynamic> offersJson = result['offers'];
            result['offers'] =
                offersJson.map((json) => Offer.fromJson(json)).toList();
          }
          return result;
        });

        // Aggregate basic totals
        totalSats += (stats['total_sats'] as num?)?.toInt() ?? 0;
        totalOffers += (stats['total_offers'] as num?)?.toInt() ?? 0;
        if (stats['offers'] is List<Offer>) {
          allOffers.addAll(stats['offers']);
        }

        // Aggregate nested stats if present
        if (stats.containsKey('stats') &&
            stats['stats'] is Map<String, dynamic>) {
          final nestedStats = stats['stats'] as Map<String, dynamic>;

          // Process lifetime stats
          if (nestedStats.containsKey('lifetime') &&
              nestedStats['lifetime'] is Map<String, dynamic>) {
            final lifetimeStats =
                nestedStats['lifetime'] as Map<String, dynamic>;
            final count = (lifetimeStats['count'] as num?)?.toInt() ?? 0;
            lifetimeCount += count;

            final blikTime =
                lifetimeStats['avg_time_blik_received_to_created_seconds']
                    as num?;
            if (blikTime != null && count > 0) {
              lifetimeBlikTimeSum += blikTime.toDouble() * count;
              lifetimeBlikTimeValidEntries += count;
            }

            final paidTime =
                lifetimeStats['avg_time_taker_paid_to_created_seconds'] as num?;
            if (paidTime != null && count > 0) {
              lifetimePaidTimeSum += paidTime.toDouble() * count;
              lifetimePaidTimeValidEntries += count;
            }
          }

          // Process last_7_days stats
          if (nestedStats.containsKey('last_7_days') &&
              nestedStats['last_7_days'] is Map<String, dynamic>) {
            final last7DaysStats =
                nestedStats['last_7_days'] as Map<String, dynamic>;
            final count = (last7DaysStats['count'] as num?)?.toInt() ?? 0;
            last7DaysCount += count;

            final blikTime =
                last7DaysStats['avg_time_blik_received_to_created_seconds']
                    as num?;
            if (blikTime != null && count > 0) {
              last7DaysBlikTimeSum += blikTime.toDouble() * count;
              last7DaysBlikTimeValidEntries += count;
            }

            final paidTime =
                last7DaysStats['avg_time_taker_paid_to_created_seconds']
                    as num?;
            if (paidTime != null && count > 0) {
              last7DaysPaidTimeSum += paidTime.toDouble() * count;
              last7DaysPaidTimeValidEntries += count;
            }
          }
        }
      } catch (e) {
        Logger.log.e(
          () =>
              "Error getting stats from coordinator ${coordinator.pubkey}: $e",
        );
      }
    }

    // Sort offers by creation date (most recent first)
    allOffers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return {
      'total_sats': totalSats,
      'total_offers': totalOffers,
      'offers': allOffers,
      'stats': {
        'lifetime': {
          'avg_time_blik_received_to_created_seconds':
              lifetimeBlikTimeValidEntries > 0
                  ? (lifetimeBlikTimeSum / lifetimeBlikTimeValidEntries).round()
                  : null,
          'avg_time_taker_paid_to_created_seconds':
              lifetimePaidTimeValidEntries > 0
                  ? (lifetimePaidTimeSum / lifetimePaidTimeValidEntries).round()
                  : null,
          'count': lifetimeCount,
        },
        'last_7_days': {
          'avg_time_blik_received_to_created_seconds':
              last7DaysBlikTimeValidEntries > 0
                  ? (last7DaysBlikTimeSum / last7DaysBlikTimeValidEntries)
                      .round()
                  : null,
          'avg_time_taker_paid_to_created_seconds':
              last7DaysPaidTimeValidEntries > 0
                  ? (last7DaysPaidTimeSum / last7DaysPaidTimeValidEntries)
                      .round()
                  : null,
          'count': last7DaysCount,
        },
      },
    };
  }

  // --- Coordinator Discovery Methods ---

  /// Start discovering coordinators on the network
  Future<List<DiscoveredCoordinator>> startCoordinatorDiscovery() async {
    if (!_isInitialized) {
      await init();
    }

    final filter = Filter(
      kinds: [kKindCoordinatorInfo],
      // since:
      //     DateTime.now()
      //         .subtract(const Duration(hours: 24))
      //         .millisecondsSinceEpoch ~/
      //     1000,
    );

    final response = _ndk!.requests.query(
      name: "coordinator-discovery",
      filters: [filter],
      explicitRelays: _relayUrls,
    );
    await for (final event in response.stream) {
      _handleCoordinatorInfoEvent(event);
    }
    return discoveredCoordinators;
  }

  /// Start listening for offer status updates
  Future<void> startOfferStatusSubscription(
    String coordinatorPubKey,
    String userPubkey,
  ) async {
    if (!_isInitialized) {
      await init();
    }

    // Close existing subscription if any
    if (_offerStatusSubscription != null) {
      await stopOfferStatusSubscription();
    }

    final filter = Filter(
      kinds: [kKindOfferStatusUpdate],
      authors: [coordinatorPubKey],
      pTags: [userPubkey], // Events tagged to the user's pubkey
      since: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );

    _offerStatusSubscription = _ndk!.requests.subscription(
      name: "offer-status-updates",
      filters: [filter],
      explicitRelays: _relayUrls,
    );

    _offerStatusSubscription!.stream.listen(_handleOfferStatusEvent);
    Logger.log.i(() => '📊 Started offer status subscription for $userPubkey');
  }

  Future<void> stopOfferStatusSubscription() async {
    if (_offerStatusSubscription != null) {
      await _ndk!.requests.closeSubscription(
        _offerStatusSubscription!.requestId,
      );
      _offerStatusSubscription = null;
      Logger.log.i(() => '📊 Stopped offer status subscription');
    }
  }

  /// Handle incoming offer status update events
  void _handleOfferStatusEvent(Nip01Event event) async {
    try {
      Logger.log.d(
        () =>
            '📊 Received offer status update: ${event.id} from ${event.pubKey}',
      );

      final content = await ProtocolCodec.decryptStatusUpdate(
        event,
        _keyService.privateKeyHex!,
      );
      final statusUpdate = OfferStatusUpdate.fromJson(content, event.pubKey);

      // Emit the status update to listeners
      _offerStatusController.add(statusUpdate);

      Logger.log.d(
        () =>
            '📊 Processed status update: ${statusUpdate.offerId} -> ${statusUpdate.status}',
      );
    } catch (e) {
      Logger.log.e(() => '❌ Error handling offer status event: $e');
    }
  }

  /// Get stream of offer status updates
  Stream<OfferStatusUpdate> get offerStatusStream =>
      _offerStatusController.stream;

  /// Check if a coordinator should be included (not blacklisted, and in default or custom whitelist)
  bool _shouldIncludeCoordinator(String pubkey) {
    // Normalize pubkey to hex format for comparison
    String pubkeyHex = _normalizePubkey(pubkey);

    // Check if blacklisted
    if (_disabledCoordinators.any((b) => _normalizePubkey(b) == pubkeyHex)) {
      return false;
    }

    // // Check if in custom whitelist
    // if (_customWhitelistedCoordinators.any(
    //   (w) => _normalizePubkey(w) == pubkeyHex,
    // )) {
    //   return true;
    // }

    return true;
  }

  /// Normalize pubkey to hex format
  String _normalizePubkey(String pubkey) {
    try {
      if (pubkey.startsWith('npub')) {
        return Nip19.decode(pubkey);
      }
    } catch (_) {
      // If decoding fails, use as-is
    }
    return pubkey;
  }

  /// Handle incoming coordinator info events
  void _handleCoordinatorInfoEvent(Nip01Event event) {
    try {
      final coordinator = DiscoveredCoordinator.fromNostrEvent(event);
      final pubkey = coordinator.pubkey;

      if (_shouldIncludeCoordinator(pubkey)) {
        _discoveredCoordinators[pubkey] = coordinator;
        _discoveredCoordinators[pubkey]!.responsive = true;
        // Cache coordinator info immediately when discovered
        final coordinatorInfo = coordinator.toCoordinatorInfo();
        _coordinatorInfoCache[pubkey] = coordinatorInfo;
        Logger.log.i(
          () => '🎯 Discovered coordinator: ${coordinator.name} ($pubkey)',
        );
        // Only check health if not blacklisted
        if (_shouldIncludeCoordinator(pubkey)) {
          // Check health via get_info after discovery (don't await)
          // checkCoordinatorHealth(pubkey);
        }
      }
    } catch (e) {
      Logger.log.e(() => '❌ Error parsing coordinator info event: $e');
    }
  }

  // Add health check
  Future<void> checkCoordinatorHealth(String coordinatorPubkey) async {
    // Only check health for coordinators that should be included
    if (!_shouldIncludeCoordinator(coordinatorPubkey)) {
      return;
    }

    try {
      final request = NostrRequest(method: kRpcGetInfo, params: {});
      // Use a shorter timeout for health checks
      await sendRequest(request, coordinatorPubkey);
      // If no exception, coordinator is responsive
      _markCoordinatorResponsive(coordinatorPubkey, true);
    } catch (e) {
      Logger.log.w(
        () =>
            '🚨 Coordinator $coordinatorPubkey did not respond to get_info: $e',
      );
      _markCoordinatorResponsive(coordinatorPubkey, false);
    }
  }

  void _markCoordinatorResponsive(String pubkey, bool responsive) {
    if (_discoveredCoordinators.containsKey(pubkey)) {
      _discoveredCoordinators[pubkey]!.responsive = responsive;
      // final c = _discoveredCoordinators[pubkey]!;
      // _discoveredCoordinators[pubkey] = DiscoveredCoordinator(
      //   pubkey: c.pubkey,
      //   name: c.name,
      //   icon: c.icon,
      //   minAmountSats: c.minAmountSats,
      //   maxAmountSats: c.maxAmountSats,
      //   makerFee: c.makerFee,
      //   takerFee: c.takerFee,
      //   reservationSeconds: c.reservationSeconds,
      //   currencies: c.currencies,
      //   version: c.version,
      //   lastSeen: c.lastSeen,
      //   responsive: responsive,
      // );
      // Update listeners
      // _coordinatorsController.add(_discoveredCoordinators.values.toList());
    }
  }

  /// Get current list of discovered coordinators
  /// Includes both discovered coordinators and custom whitelisted ones
  List<DiscoveredCoordinator> get discoveredCoordinators {
    final coordinators = <DiscoveredCoordinator>[];

    // Add discovered coordinators (already filtered by _shouldIncludeCoordinator)
    coordinators.addAll(_discoveredCoordinators.values);

    // Add custom whitelisted coordinators that haven't been discovered yet
    for (final pubkey in _customCoordinators) {
      final normalized = _normalizePubkey(pubkey);
      if (!_discoveredCoordinators.containsKey(normalized)) {
        // Create a placeholder coordinator for custom whitelisted ones
        coordinators.add(
          DiscoveredCoordinator(
            pubkey: normalized,
            name: pubkey, // Use pubkey as name if not discovered
            icon: null,
            minAmountSats: 0,
            maxAmountSats: 0,
            makerFee: 0.0,
            takerFee: 0.0,
            reservationSeconds: 0,
            currencies: [],
            version: '',
            lastSeen: DateTime.now(),
            responsive: null,
            termsOfUsageNaddr: null,
          ),
        );
      }
    }

    // Sort: default whitelisted first (by responsive status, then name), then custom whitelisted at the end
    coordinators.sort((a, b) {
      final aNormalized = _normalizePubkey(a.pubkey);
      final bNormalized = _normalizePubkey(b.pubkey);

      final aIsCustomOnly =
          _customCoordinators.any(
            (w) => _normalizePubkey(w) == aNormalized,
          );
      final bIsCustomOnly =
          _customCoordinators.any(
            (w) => _normalizePubkey(w) == bNormalized,
          );

      // Custom-only coordinators come last (after default whitelisted)
      if (aIsCustomOnly != bIsCustomOnly) {
        return aIsCustomOnly
            ? 1
            : -1; // custom-only goes to the end (positive value)
      }

      // Within each group (default or custom), sort by responsive status (true first)
      final aResponsive = a.responsive ?? false;
      final bResponsive = b.responsive ?? false;

      if (aResponsive != bResponsive) {
        return aResponsive ? -1 : 1; // responsive coordinators come first
      }

      // If responsive status is the same, sort by name alphabetically
      return a.name.compareTo(b.name);
    });

    return coordinators;
  }

  /// Update relay configuration
  Future<void> updateRelayConfig(List<String> relayUrls) async {
    final prefs = await SharedPreferences.getInstance();
    _relayUrls = relayUrls;
    await prefs.setStringList(_relayUrlsKey, relayUrls);

    // Reinitialize NDK with new relays if already initialized
    if (_isInitialized) {
      await dispose();
      await init();
      await startCoordinatorDiscovery();
    }
  }

  // --- Coordinator Management Methods ---

  /// Check if a coordinator is blacklisted
  bool isBlacklisted(String pubkey) {
    final normalized = _normalizePubkey(pubkey);
    return _disabledCoordinators.any(
      (b) => _normalizePubkey(b) == normalized,
    );
  }

  /// Get the list of blacklisted coordinators
  List<String> get blacklistedCoordinators =>
      List.from(_disabledCoordinators);

  /// Get the list of custom whitelisted coordinators
  List<String> get customWhitelistedCoordinators =>
      List.from(_customCoordinators);

  /// Toggle blacklist status for a coordinator
  Future<void> toggleBlacklist(String pubkey, bool blacklist) async {
    final normalized = _normalizePubkey(pubkey);

    if (blacklist) {
      // Remove any existing entry (in case of format mismatch) and add normalized
      _disabledCoordinators.removeWhere(
        (b) => _normalizePubkey(b) == normalized,
      );
      _disabledCoordinators.add(normalized);
    } else {
      _disabledCoordinators.removeWhere(
        (b) => _normalizePubkey(b) == normalized,
      );
    }

    // Save to preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_blacklistKey, _disabledCoordinators);

    // Don't remove from discovered coordinators - keep them visible so users can unblacklist
    // The _shouldIncludeCoordinator check will prevent them from being used in operations

    Logger.log.i(
      () =>
          '${blacklist ? "🚫" : "✅"} Coordinator $normalized ${blacklist ? "blacklisted" : "unblacklisted"}',
    );
  }

  /// Add a coordinator to custom whitelist
  Future<void> addCustomWhitelist(String npub) async {
    final trimmed = npub.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Npub cannot be empty');
    }

    // Validate npub format
    String normalized;
    try {
      if (trimmed.startsWith('npub')) {
        normalized = Nip19.decode(trimmed);
      } else {
        // Assume it's already hex
        normalized = trimmed;
      }
    } catch (e) {
      throw ArgumentError('Invalid npub format: $e');
    }

    // Check if already in custom whitelist
    if (_customCoordinators.any(
      (w) => _normalizePubkey(w) == normalized,
    )) {
      throw ArgumentError('Coordinator already in custom whitelist');
    }

    _customCoordinators.add(normalized);

    // Save to preferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _customWhitelistKey,
      _customCoordinators,
    );

    Logger.log.i(() => '✅ Added coordinator $normalized to custom whitelist');

    // Try to discover this coordinator
    // Note: This won't immediately discover it, but it will be included if discovered later
  }

  /// Remove a coordinator from custom whitelist
  Future<void> removeCustomWhitelist(String pubkey) async {
    final normalized = _normalizePubkey(pubkey);

    final beforeLength = _customCoordinators.length;
    _customCoordinators.removeWhere(
      (w) => _normalizePubkey(w) == normalized,
    );
    final afterLength = _customCoordinators.length;

    if (beforeLength > afterLength) {
      // Save to preferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setStringList(
        _customWhitelistKey,
        _customCoordinators,
      );

      _discoveredCoordinators.remove(normalized);
      _coordinatorInfoCache.remove(normalized);

      Logger.log.i(
        () => '🗑️ Removed coordinator $normalized from custom whitelist',
      );
    }
  }

  /// Dispose resources
  Future<void> dispose() async {
    if (_rpcClient != null) {
      await _rpcClient!.stop();
      _rpcClient = null;
    }
    if (_offerStatusSubscription != null) {
      await _ndk!.requests.closeSubscription(
        _offerStatusSubscription!.requestId,
      );
    }
    if (_offerSubscription != null) {
      await _ndk!.requests.closeSubscription(_offerSubscription!.requestId);
    }
    await _offerStatusController.close();
    await _offerStreamController.close();
    if (_ndk != null) {
      await _ndk!.destroy();
      _ndk = null;
    }
    _isInitialized = false;
  }

  /// Get current relay URLs
  List<String> get relayUrls => List.from(_relayUrls);

  /// Get NDK instance (for connectivity management)
  Ndk? get ndk => _ndk;
}

/// Exception for Nostr-related errors
class NostrException implements Exception {
  final String message;
  final String? code;

  NostrException(this.message, {this.code});

  @override
  String toString() =>
      'NostrException: $message${code != null ? ' ($code)' : ''}';
}
