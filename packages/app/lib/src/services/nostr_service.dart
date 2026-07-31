import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:ndk/domain_layer/entities/cashu/cashu_user_seedphrase.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/isolates/isolate_manager.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

// import 'package:ndk_rust_verifier/ndk_rust_verifier.dart' as web_rust_verifier;

import 'package:bitblik_core/core.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:ndk_flutter/repositories/cashu_seed_store.dart';
import '../config/build_flavor.dart';
import '../utils/platform_detection.dart';
import 'coordinator_prefs_store.dart';
import 'key_service.dart';
import 'nostr_cache_factory.dart';
import 'relay_reconnect_gate.dart';

/// Result of a reserve_offer RPC. Generic (yaml-driven) coordinators return
/// the full offer json ([offer] non-null); legacy enum coordinators return
/// only the reservation timestamp.
typedef ReserveOfferResult = ({DateTime? reservedAt, Offer? offer});

/// The taker's local reserved offer after a successful reserve: prefer the
/// coordinator's full offer json when present (server truth: raw flow state,
/// blik_received_at as the code-lifespan countdown base, updated_at), falling
/// back to patching the listed offer for legacy enum coordinators.
Offer reservedOfferFromResult(
  Offer listed,
  String takerId,
  ReserveOfferResult result,
) {
  final remote = result.offer;
  if (remote != null) {
    var merged = remote;
    if (merged.takerPubkey == null) {
      merged = merged.copyWith(takerPubkey: takerId);
    }
    // Never lose the coordinator routing: the response json may omit or blank
    // it, and follow-up RPCs (e.g. the TWINT code fetch) route by it.
    if (merged.coordinatorPubkey.isEmpty ||
        merged.coordinatorPubkey == 'unknown_coordinator') {
      merged = merged.copyWith(coordinatorPubkey: listed.coordinatorPubkey);
    }
    // The coordinator doesn't persist the market id / bank in a column, so its
    // RPC response can come back with them null. Keep the values resolved from
    // the listed offer's wire tags (`y` → market, `bank`), otherwise
    // paymentSystemForOffer falls back to currency and an SK (EUR) offer
    // wrongly resolves to MB WAY (10-digit codes).
    if ((merged.paymentSystemId == null || merged.paymentSystemId!.isEmpty) &&
        listed.paymentSystemId != null) {
      merged = merged.copyWith(paymentSystemId: listed.paymentSystemId);
    }
    if ((merged.bankId == null || merged.bankId!.isEmpty) &&
        listed.bankId != null) {
      merged = merged.copyWith(bankId: listed.bankId);
    }
    return merged;
  }
  return listed.copyWith(
    status: OfferStatus.reserved,
    takerPubkey: takerId,
    reservedAt: result.reservedAt,
  );
}

/// Service for Nostr-based communication with coordinators
class NostrService {
  /// Discovery relays — used ONLY to find coordinators (their info + NIP-65
  /// events) and to bootstrap NDK. All per-coordinator communication is routed
  /// to each coordinator's own relays (see [CoordinatorRegistry.relaysFor]).
  static const List<String> _defaultRelayUrls = kDiscoveryRelays;


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

  /// `#y` platform tag the offers subscription filters on. Follows the active
  /// payment system so each market only receives its own offers (and the
  /// new-offer notifications derived from them). Defaults to the historical
  /// `Bitblik` value until [startOfferSubscription] sets it.
  String _offerPlatformTag = 'Bitblik';

  /// The platform tag the currently-live subscription was built with, so a tag
  /// change (payment-system switch) re-fires the REQ even if authors are equal.
  String? _liveOfferSubscriptionPlatformTag;

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
      // Keep the RPC response subscription pointed at the relays of all
      // enabled coordinators so we receive replies regardless of where each
      // coordinator publishes.
      unawaited(
        _rpcClient?.updateResponseRelays(
              _coordinatorRegistry!.relaysForEnabled(),
            ) ??
            Future.value(),
      );
      if (!_offerSubscriptionRequested ||
          (setEquals(enabledPubkeys, _offerSubscriptionAuthors) &&
              _liveOfferSubscriptionPlatformTag == _offerPlatformTag)) {
        return;
      }
      unawaited(_syncOfferSubscription(enabledPubkeys));
    });
  }

  /// Union of relays in active use to reach enabled coordinators. Drives the
  /// top-bar connectivity dots (excludes discovery-only and NWC relays).
  Set<String> get coordinatorRelaysInUse =>
      _coordinatorRegistry?.relaysForEnabled() ?? <String>{};

  /// Relays to subscribe/query across all enabled coordinators, falling back to
  /// discovery relays when none are known yet.
  List<String> _enabledCoordinatorRelays() {
    final relays =
        _coordinatorRegistry?.relaysForEnabled().toList() ?? const [];
    return relays.isEmpty ? _relayUrls : relays;
  }

  /// Relays for a single coordinator, falling back to discovery relays.
  List<String> _relaysForCoordinator(String pubkey) {
    final relays = _coordinatorRegistry?.relaysFor(pubkey) ?? const [];
    return relays.isEmpty ? _relayUrls : relays;
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

    final cashuSeedPhrase = await CashuSeedStore().loadOrCreate();

    // Initialize NDK with bootstrap relays config
    _ndk = Ndk(
      NdkConfig(
        cache: cacheManager,
        walletsRepo: FlutterSecureStorageWalletsRepo(),
        eventVerifier: eventVerifier,
        bootstrapRelays: _relayUrls,
        logLevel: false && kDebugMode ? LogLevel.debug : LogLevel.warning,
        cashuUserSeedphrase: CashuUserSeedphrase(seedPhrase: cashuSeedPhrase),
      ),
    );

    await IsolateManager.instance.ready;

    // ndk!.connectivity.relayConnectivityChanges.listen((data) {
    //   print("🔗 Relay connectivity change: ${data}");
    // });

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
    if (_keyService.publicKeyHex == null || _keyService.privateKeyHex == null) {
      throw Exception('KeyService not initialized');
    }

    _clientSigner = Bip340EventSigner(
      privateKey: _keyService.privateKeyHex!,
      publicKey: _keyService.publicKeyHex!,
    );

    // Brand is the BUILT flavor (buildAppName, set before runApp from the
    // flavor entrypoint / appFlavor / appId), not the user's runtime
    // payment-system preference. e.g.
    // 'app-bitblik-android/0.8.0', 'app-bitway-web-ios/0.8.0'.
    final brand = buildAppName.toLowerCase();
    final platform = PlatformDetection.platformSlug;
    String version;
    try {
      version = (await PackageInfo.fromPlatform()).version;
    } catch (e) {
      Logger.log.w(() => '⚠️ Could not resolve app version for clientId: $e');
      version = 'unknown';
    }
    final clientId = 'app-$brand-$platform/$version';

    _rpcClient = BitblikRpcClient(
      ndk: _ndk!,
      signer: _clientSigner!,
      relays: _relayUrls,
      subscriptionName: 'client-responses',
      clientId: clientId,
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

    // iOS PWA: if the app just came back to foreground, a relay reconnect may be
    // in flight (see RelayReconnectGate / AppLifecycleNotifier). Wait for fresh
    // sockets before writing so we never publish onto a zombie connection.
    if (kIsWeb) {
      await RelayReconnectGate.instance.ensureReady();
    }

    try {
      return await _rpcClient!.send(
        request,
        coordinatorPubkey,
        timeoutOverride: timeoutOverride,
        relays: _coordinatorRegistry?.relaysFor(coordinatorPubkey),
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
    required String fiatCurrency,
    OfferCategory? category,
    required String coordinatorPubkey,
    double premiumPercent = 0,
    String? blikCode,
    String? bank,
  }) async {
    final request = NostrRequest(
      method: kRpcInitiateOffer,
      params: {
        'fiat_amount': fiatAmount,
        'fiat_currency': fiatCurrency,
        if (category != null) 'category': category.name,
        if (premiumPercent > 0) 'premium_percent': premiumPercent,
        if (blikCode != null && blikCode.isNotEmpty) 'blik_code': blikCode,
        if (bank != null && bank.isNotEmpty) 'bank': bank,
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
  Future<void> startOfferSubscription({String platformTag = 'Bitblik'}) async {
    if (!_isInitialized) {
      await init();
    }
    _offerSubscriptionRequested = true;
    _offerPlatformTag = platformTag;
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
    _liveOfferSubscriptionPlatformTag = null;
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
      _liveOfferSubscriptionPlatformTag = null;
      Logger.log.i(
        () => '🔎 Stopped offers subscription: no enabled coordinators',
      );
      return;
    }
    if (_offerSubscription != null &&
        setEquals(enabledPubkeys, _offerSubscriptionAuthors) &&
        _liveOfferSubscriptionPlatformTag == _offerPlatformTag) {
      return;
    }

    if (_offerSubscription != null) {
      await _ndk!.requests.closeSubscription(_offerSubscription!.requestId);
    }

    final filter = Filter(
      kinds: [kKindOffer],
      authors: enabledPubkeys.toList(growable: false),
      // No `#f` (fiat) filter: offers of all currencies are received and then
      // filtered by the user's selected payment method client-side
      // (availableOffersProvider). Keeps one subscription valid across markets.
      tags: {
        "#y": [_offerPlatformTag],
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
      explicitRelays: _enabledCoordinatorRelays(),
    );
    _offerSubscriptionAuthors = enabledPubkeys;
    _liveOfferSubscriptionPlatformTag = _offerPlatformTag;
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
      explicitRelays: _enabledCoordinatorRelays(),
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
  Future<ReserveOfferResult> reserveOffer(
    String offerId,
    String takerId,
    String coordinatorPubkey, {
    String? takerLightningAddress,
    String? takerInvoice,
  }) async {
    final request = NostrRequest(
      method: kRpcReserveOffer,
      params: {
        'offer_id': offerId,
        // D1: generic flows (TWINT) capture the taker's payout details at
        // reserve via the `accept_taker_invoice` effect. Legacy enum flows
        // (BLIK) ignore these extra params.
        if (takerLightningAddress != null && takerLightningAddress.isNotEmpty)
          'taker_lightning_address': takerLightningAddress,
        if (takerInvoice != null && takerInvoice.isNotEmpty)
          'taker_invoice': takerInvoice,
      },
    );

    final response = await sendRequest(request, coordinatorPubkey);
    return _handleResponse(response, (result) {
      // Generic (yaml-driven) coordinators answer with the full offer json —
      // keep it: it carries server truth the flow UI needs (raw state,
      // blik_received_at as the code-lifespan countdown base, updated_at).
      // Enum coordinators return only {reserved_at: epoch-ms}.
      Offer? offer;
      if (result['id'] is String && result['status'] is String) {
        try {
          offer = Offer.fromJson(result);
        } catch (_) {
          offer = null;
        }
      }
      final raw = result['reserved_at'];
      DateTime? reservedAt;
      if (raw is int) {
        reservedAt = DateTime.fromMillisecondsSinceEpoch(raw, isUtc: true);
      } else if (raw is String) {
        reservedAt = DateTime.tryParse(raw)?.toUtc();
      }
      return (reservedAt: reservedAt, offer: offer);
    });
  }

  /// Generic dispatcher for yaml-driven (generic) flows. The transition [event]
  /// IS the RPC method name, so this sends it verbatim with `offer_id` plus any
  /// [extraParams] a screen collected (e.g. `taker_invoice`, `blik_code`).
  /// Returns the coordinator result map; throws [NostrException] on error.
  Future<Map<String, dynamic>> sendFlowAction({
    required String event,
    required String offerId,
    required String coordinatorPubkey,
    Map<String, dynamic> extraParams = const {},
  }) async {
    final request = NostrRequest(
      method: event,
      params: {'offer_id': offerId, ...extraParams},
    );
    final response = await sendRequest(request, coordinatorPubkey);
    return _handleResponse(response, (result) => result);
  }

  /// POST /offers/{offerId}/blik
  Future<void> submitBlikCode({
    required String offerId,
    required String takerId,
    String? blikCode,
    required String takerInvoice,
    required String coordinatorPubkey,
  }) async {
    final request = NostrRequest(
      method: kRpcSubmitBlik,
      params: {
        'offer_id': offerId,
        if (blikCode != null && blikCode.isNotEmpty) 'blik_code': blikCode,
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
        () =>
            "Error getting offer details from coordinator ${coordinatorPubkey}: $e",
      );
      if (strict) rethrow;
      return null;
    }
  }

  bool _looksLikeUuid(String s) => RegExp(
    r'^[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}$',
    caseSensitive: false,
  ).hasMatch(s);

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

  /// GET /stats/successful-offers — computed entirely client-side from the
  /// coordinators' public `s=success` offer events (kind [kKindOffer]), which
  /// already carry `created_at`, `reserved_at`, `blik_received_at` and
  /// `paid_at`. No per-coordinator RPC fan-out: a single paginated query over
  /// the union of the relevant coordinators' relays.
  ///
  /// Window is 30 days (the `lifetime` block is best-effort over that window —
  /// relays prune old events, so true all-time totals live only in each
  /// coordinator's DB). `last_7_days` is the recent subset shown in the UI.
  Future<Map<String, dynamic>> getSuccessfulOffersStats({
    String? paymentSystemId,
  }) async {
    if (!_isInitialized) {
      await init();
    }

    // Only aggregate coordinators serving the selected payment system.
    final coordinators =
        paymentSystemId == null
            ? coordinatorRegistry.enabled
            : coordinatorRegistry.enabled
                .where((c) => c.paymentSystem == paymentSystemId)
                .toList();
    if (coordinators.isEmpty) {
      Logger.log.w(() => "No coordinators enabled, cannot get stats.");
      return _emptyStats();
    }

    // Offer events live on each coordinator's own relays — query their union
    // with an `authors` filter, paginated, instead of N point-to-point RPCs.
    final relays = <String>{};
    for (final c in coordinators) {
      relays.addAll(_relaysForCoordinator(c.pubkeyHex));
    }
    final authors = coordinators.map((c) => c.pubkeyHex).toList();

    final now = DateTime.now().toUtc();
    final windowStart = now.subtract(const Duration(days: 30));
    final sevenDaysAgo = now.subtract(const Duration(days: 7));

    final offers = await _fetchSuccessOffers(
      authors: authors,
      relays: relays.toList(),
      since: windowStart.millisecondsSinceEpoch ~/ 1000,
    );

    int totalSats = 0;
    final recentOffers = <Offer>[];

    // Per-window timing accumulators. `blik_received_at` is not present in the
    // public offer event, so we use `reserved_at` (created→reserved) as the
    // headline "reserve" timing alongside the created→paid finishing time.
    var lifetimeReserved = _Avg();
    var lifetimePaid = _Avg();
    var last7Reserved = _Avg();
    var last7Paid = _Avg();
    int lifetimeCount = 0;
    int last7DaysCount = 0;

    for (final offer in offers) {
      lifetimeCount++;
      final recent = offer.createdAt.toUtc().isAfter(sevenDaysAgo);
      if (recent) {
        last7DaysCount++;
        totalSats += offer.amountSats;
        recentOffers.add(offer);
      }

      void add(DateTime? end, _Avg lifetime, _Avg last7) {
        if (end == null) return;
        final secs = end.difference(offer.createdAt).inSeconds.toDouble();
        lifetime.add(secs);
        if (recent) last7.add(secs);
      }

      add(offer.reservedAt, lifetimeReserved, last7Reserved);
      add(offer.takerPaidAt, lifetimePaid, last7Paid);
    }

    // Most recent first.
    recentOffers.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return {
      'total_sats': totalSats,
      'total_offers': recentOffers.length,
      'offers': recentOffers,
      'stats': {
        'lifetime': {
          'avg_time_reserved_to_created_seconds': lifetimeReserved.avg,
          'avg_time_taker_paid_to_created_seconds': lifetimePaid.avg,
          'count': lifetimeCount,
        },
        'last_7_days': {
          'avg_time_reserved_to_created_seconds': last7Reserved.avg,
          'avg_time_taker_paid_to_created_seconds': last7Paid.avg,
          'count': last7DaysCount,
        },
      },
    };
  }

  Map<String, dynamic> _emptyStats() => {
    'total_sats': 0,
    'total_offers': 0,
    'offers': <Offer>[],
    'stats': {
      for (final window in ['lifetime', 'last_7_days'])
        window: {
          'avg_time_reserved_to_created_seconds': null,
          'avg_time_taker_paid_to_created_seconds': null,
          'count': 0,
        },
    },
  };

  /// Paginated fetch of `s=success` [kKindOffer] events for [authors] from
  /// [relays], newer than [since]. Dedupes by addressable coordinate
  /// (author + `d` offer id) across pages. Relays cap how many events a single
  /// REQ returns, so we page backwards with an `until` cursor.
  Future<List<Offer>> _fetchSuccessOffers({
    required List<String> authors,
    required List<String> relays,
    required int since,
  }) async {
    if (authors.isEmpty || relays.isEmpty) return const [];
    const pageSize = 500;
    final seen = <String>{};
    final offers = <Offer>[];

    var until = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    while (true) {
      final response = _ndk!.requests.query(
        name: 'successful-offers-stats',
        filter: Filter(
          kinds: [kKindOffer],
          authors: authors,
          tags: {
            '#s': ['success'],
          },
          since: since,
          until: until,
          limit: pageSize,
        ),
        explicitRelays: relays,
      );

      var pageCount = 0;
      var oldest = until;
      await for (final event in response.stream) {
        pageCount++;
        if (event.createdAt < oldest) oldest = event.createdAt;
        final dTag = event.getDtag() ?? event.id;
        if (!seen.add('${event.pubKey}:$dTag')) continue;
        offers.add(Offer.fromNostrEvent(event));
      }

      if (pageCount < pageSize) break;
      final nextUntil = oldest - 1;
      if (nextUntil >= until || nextUntil < since) break;
      until = nextUntil;
    }
    return offers;
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
      explicitRelays: _relaysForCoordinator(coordinatorPubKey),
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

/// Running average accumulator: sum of seconds over a count of valid entries.
class _Avg {
  double _sum = 0;
  int _n = 0;
  void add(double seconds) {
    _sum += seconds;
    _n++;
  }

  /// Rounded average in seconds, or null when there are no entries.
  int? get avg => _n > 0 ? (_sum / _n).round() : null;
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
