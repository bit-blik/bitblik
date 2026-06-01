import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/isolates/isolate_manager.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

// import 'package:ndk_rust_verifier/ndk_rust_verifier.dart' as web_rust_verifier;

import 'package:bitblik_core/core.dart';
import 'coordinator_prefs_store.dart';
import 'key_service.dart';
import 'nostr_cache_factory.dart';

/// Service for Nostr-based communication with coordinators
class NostrService {
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
  CoordinatorRegistry? _coordinatorRegistry;

  List<String> _relayUrls = [];

  NdkResponse? _offerStatusSubscription;
  NdkResponse? _offerSubscription;
  final Map<String, Offer> _knownOffers = {};
  StreamSubscription<List<CoordinatorRecord>>? _coordinatorRegistryChangesSub;
  Set<String> _offerSubscriptionAuthors = const {};
  bool _offerSubscriptionRequested = false;

  bool _isInitialized = false;
  Future<void>? _initInFlight;

  late StreamController<OfferStatusUpdate> _offerStatusController;
  late StreamController<Offer> _offerStreamController;

  NostrService(this._keyService) {
    _createStreamControllers();
  }

  void _createStreamControllers() {
    _offerStatusController = StreamController<OfferStatusUpdate>.broadcast();
    _offerStreamController = StreamController<Offer>.broadcast();
  }

  /// Initialize the Nostr service
  Future<void> init() async {
    if (_isInitialized) return;
    if (_offerStatusController.isClosed || _offerStreamController.isClosed) {
      _createStreamControllers();
    }

    final inFlight = _initInFlight;
    if (inFlight != null) {
      await inFlight;
      return;
    }

    final completer = Completer<void>();
    _initInFlight = completer.future;

    try {
      _relayUrls = List.from(_defaultRelayUrls);
      Logger.log.i(() => '📡 Using relays: $_relayUrls');

      await _initializeNdk();
      await _subscribeToResponses();
      await _initCoordinatorRegistry();

      _isInitialized = true;
      Logger.log.i(() => '✅ NostrService initialized');
      completer.complete();
    } catch (e, st) {
      completer.completeError(e, st);
      rethrow;
    } finally {
      _initInFlight = null;
    }
  }

  Future<void> _initCoordinatorRegistry() async {
    _coordinatorRegistry = CoordinatorRegistry(
      ndk: _ndk!,
      rpcClient: _rpcClient!,
      store: CoordinatorPrefsStore(),
      relays: _relayUrls,
    );
    await _coordinatorRegistry!.init();
    await _coordinatorRegistryChangesSub?.cancel();
    _coordinatorRegistryChangesSub = _coordinatorRegistry!.changes.listen((
      records,
    ) {
      final enabledPubkeys =
          records
              .where((record) => record.enabled)
              .map((record) => record.pubkeyHex)
              .toSet();
      _pruneKnownOffers(enabledPubkeys);
      if (!_offerSubscriptionRequested ||
          setEquals(enabledPubkeys, _offerSubscriptionAuthors)) {
        return;
      }
      unawaited(_syncOfferSubscription(enabledPubkeys));
    });
  }

  CoordinatorRegistry get coordinatorRegistry {
    final registry = _coordinatorRegistry;
    if (registry == null) {
      throw StateError(
        'CoordinatorRegistry accessed before NostrService.init()',
      );
    }
    return registry;
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
    String coordinatorPubkey, {
    Duration? timeoutOverride,
  }) async {
    if (!_isInitialized) {
      await init();
    }
    if (_rpcClient == null) {
      throw Exception('RPC client not initialized');
    }

    try {
      return await _rpcClient!.send(
        request,
        coordinatorPubkey,
        timeoutOverride: timeoutOverride,
      );
    } on TimeoutException {
      // Trigger a health check for this coordinator, unless this WAS the
      // health check (avoid infinite recursion).
      if (request.method != kRpcGetInfo) {
        _coordinatorRegistry?.probeHealth(coordinatorPubkey).catchError((
          error,
        ) {
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
    OfferCategory? category,
    required String coordinatorPubkey,
  }) async {
    final request = NostrRequest(
      method: kRpcInitiateOffer,
      params: {
        'fiat_amount': fiatAmount,
        'maker_id': makerId,
        if (category != null) 'category': category.name,
      },
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
  List<Offer> get knownOffers =>
      _knownOffers.values.toList(growable: false)
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  /// Start listening for offers (subscribe to event kind 38383 from all coordinators)
  Future<void> startOfferSubscription() async {
    if (!_isInitialized) {
      await init();
    }
    _offerSubscriptionRequested = true;
    final enabledPubkeys =
        coordinatorRegistry.enabled.map((record) => record.pubkeyHex).toSet();
    await _syncOfferSubscription(enabledPubkeys);
  }

  void _handleOfferEvent(Nip01Event event) {
    try {
      final offer = Offer.fromNostrEvent(event);
      _knownOffers[offer.id] = offer;
      _offerStreamController.add(offer);
    } catch (e) {
      Logger.log.e(() => '❌ Error parsing offer event: $e');
    }
  }

  /// Stop the live offer subscription
  Future<void> stopOfferSubscription() async {
    _offerSubscriptionRequested = false;
    if (_offerSubscription != null) {
      await _ndk!.requests.closeSubscription(_offerSubscription!.requestId);
      _offerSubscription = null;
    }
    _offerSubscriptionAuthors = const {};
    await _offerStreamController.close();
    _offerStreamController =
        StreamController<Offer>.broadcast(); // so can restart
  }

  Future<void> _syncOfferSubscription(Set<String> enabledPubkeys) async {
    _pruneKnownOffers(enabledPubkeys);
    if (enabledPubkeys.isEmpty) {
      if (_offerSubscription != null) {
        await _ndk!.requests.closeSubscription(_offerSubscription!.requestId);
        _offerSubscription = null;
      }
      _offerSubscriptionAuthors = const {};
      Logger.log.i(
        () => '🔎 Stopped offers subscription: no enabled coordinators',
      );
      return;
    }
    if (_offerSubscription != null &&
        setEquals(enabledPubkeys, _offerSubscriptionAuthors)) {
      return;
    }

    if (_offerSubscription != null) {
      await _ndk!.requests.closeSubscription(_offerSubscription!.requestId);
    }

    final filter = Filter(
      kinds: [kKindOffer],
      authors: enabledPubkeys.toList(growable: false),
      tags: {
        "#f": ["PLN"],
        "#y": ["Bitblik"],
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
    _offerSubscriptionAuthors = enabledPubkeys;
    _offerSubscription!.stream.listen(_handleOfferEvent);
    Logger.log.i(
      () =>
          '🔎 Started offers subscription for ${enabledPubkeys.length} enabled coordinators',
    );
  }

  void _pruneKnownOffers(Set<String> enabledPubkeys) {
    if (enabledPubkeys.isEmpty) {
      _knownOffers.clear();
      return;
    }
    _knownOffers.removeWhere(
      (_, offer) => !enabledPubkeys.contains(offer.coordinatorPubkey),
    );
  }

  /// GET /offers/{offerId}
  Future<Offer?> getOffer(String offerId) async {
    if (!_isInitialized) {
      await init();
    }

    final filter = Filter(kinds: [kKindOffer], dTags: [offerId], limit: 1);

    // One-time fetch. Return as soon as ANY relay answers instead of draining
    // the stream until EOSE-from-all-relays / the 10s default timeout: limit:1
    // on an addressable kind (38383) means the first event IS the offer, and
    // the details screen live-merges later status updates from the
    // subscription. cacheRead:false keeps it authoritative from the relay.
    final response = _ndk!.requests.query(
      filters: [filter],
      cacheRead: false,
      explicitRelays: _relayUrls,
    );

    Nip01Event? event;
    await for (final e in response.stream.timeout(
      const Duration(seconds: 6),
      onTimeout: (sink) => sink.close(),
    )) {
      event = e;
      break;
    }

    if (event == null) {
      return null;
    }

    final offer = Offer.fromNostrEvent(event);
    _knownOffers[offer.id] = offer;
    return offer;
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
        return DateTime.fromMillisecondsSinceEpoch(timestamp, isUtc: true);
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

  /// GET /offer-details
  /// Fetch offer details from the coordinator.
  ///
  /// Returns `null` ONLY when the coordinator genuinely reports no such offer
  /// (it answers with an empty result). When [strict] is true, transient
  /// failures (timeout, RPC error, relays not yet connected) are rethrown
  /// instead of being swallowed to `null`, so callers can tell "coordinator
  /// said no" apart from "I never got an answer". Non-strict callers keep the
  /// best-effort behaviour of returning `null` on any failure.
  Future<Map<String, dynamic>?> getOfferDetails(
    Offer offer,
    String coordinatorPubkey, {
    bool strict = false,
  }) async {
    if (!_isInitialized) {
      await init();
    }

    try {
      final params = <String, dynamic>{};
      if (_looksLikeUuid(offer.id)) {
        params['offer_id'] = offer.id;
      } else if (offer.holdInvoicePaymentHash != null &&
          offer.holdInvoicePaymentHash!.isNotEmpty) {
        params['payment_hash'] = offer.holdInvoicePaymentHash!;
      } else {
        return null;
      }

      final request = NostrRequest(method: kRpcGetOfferDetails, params: params);
      final response = await sendRequest(request, coordinatorPubkey);
      // Genuine "offer not found" → coordinator returns {} → null here.
      // Transient failures throw before reaching this point.
      return _handleResponse(response, (result) {
        if (result.isEmpty) return null;
        result['coordinator_pubkey'] = coordinatorPubkey;
        return result;
      });
    } catch (e) {
      Logger.log.e(
        () => "Error getting offer details from coordinator ${coordinatorPubkey}: $e",
      );
      if (strict) rethrow;
      return null;
    }
  }

  bool _looksLikeUuid(String s) => RegExp(
        r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
        caseSensitive: false,
      ).hasMatch(s);

  /// GET /my-finished-offers - This will now query all coordinators
  Future<List<Offer>> getMyFinishedOffers(String userPubkey) async {
    if (!_isInitialized) {
      await init();
    }

    final allOffers = <Offer>[];
    final coordinators = coordinatorRegistry.enabled;
    if (coordinators.isEmpty) {
      Logger.log.w(
        () => "No coordinators enabled, cannot get finished offers.",
      );
      return [];
    }

    final List<Future<List<Offer>>> offerFutures = [];

    for (final coordinator in coordinators) {
      offerFutures.add(
        _getMyFinishedOffersFromCoordinator(userPubkey, coordinator.pubkeyHex),
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

    final response = await sendRequest(
      request,
      coordinatorPubkey,
      timeoutOverride: const Duration(seconds: 120),
    );
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

    final response = await sendRequest(
      request,
      coordinatorPubkey,
      timeoutOverride: const Duration(seconds: 120),
    );
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

  /// Get coordinator info by pubkey (from registry).
  CoordinatorInfo? getCoordinatorInfoByPubkey(String coordinatorPubkey) =>
      _coordinatorRegistry?.infoFor(coordinatorPubkey);

  /// GET /stats/successful-offers - This will now query all coordinators
  Future<Map<String, dynamic>> getSuccessfulOffersStats() async {
    if (!_isInitialized) {
      await init();
    }

    final coordinators = coordinatorRegistry.enabled;
    if (coordinators.isEmpty) {
      Logger.log.w(() => "No coordinators enabled, cannot get stats.");
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
        final response = await sendRequest(request, coordinator.pubkeyHex);
        final stats = _handleResponse(response, (result) {
          if (result.containsKey('offers') && result['offers'] is List) {
            final List<dynamic> offersJson = result['offers'];
            result['offers'] = offersJson
                .map((json) => Offer.fromJson(json)
                    .copyWith(coordinatorPubkey: coordinator.pubkeyHex))
                .toList();
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
              "Error getting stats from coordinator ${coordinator.pubkeyHex}: $e",
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

  /// Dispose resources
  Future<void> dispose() async {
    _initInFlight = null;
    await _coordinatorRegistryChangesSub?.cancel();
    _coordinatorRegistryChangesSub = null;
    await _coordinatorRegistry?.dispose();
    _coordinatorRegistry = null;
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
    _knownOffers.clear();
    _offerSubscriptionRequested = false;
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

  /// Emits `true` whenever at least one relay is connected and `false` when
  /// none are. Backed by a BehaviorSubject, so a new listener immediately
  /// receives the current state; deduplicated so it only fires on actual
  /// connect/disconnect transitions (including reconnects after the app
  /// returns from background). Empty until [ndk] is initialized.
  Stream<bool> get relayConnectionState {
    final ndk = _ndk;
    if (ndk == null) return const Stream<bool>.empty();
    return ndk.connectivity.relayConnectivityChanges
        .map((relays) => relays.values.any((r) => r.isConnected))
        .distinct();
  }
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
