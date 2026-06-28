import 'dart:async';
import 'dart:math';

import 'package:bip340/bip340.dart' as bip340;
import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/nip_65.dart';
import 'package:ndk/domain_layer/entities/read_write_marker.dart';

import 'coordinator_service.dart';
import 'package:bitblik_core/core.dart';
import '../logging/app_logger.dart';

/// Service to handle Nostr communication for the coordinator
/// Implements info replaceable events and NIP-44 encrypted request/response
class NostrService {
  final CoordinatorService _coordinatorService;
  late final Ndk _ndk;
  late Bip340EventSigner _signer;
  final RustEventVerifier rustEventVerifier = RustEventVerifier();
  static const Duration _relayRefreshInterval = Duration(seconds: 60);
  static const Duration _relayChangeGracePeriod = Duration(minutes: 5);
  static const Duration _relayQueryTimeout = Duration(seconds: 6);

  // Relay configuration.
  //
  // [_envRelays] is the seed set from config (NOSTR_RELAYS). [_relays] is the
  // working set actually used for info/offers/responses/status — resolved at
  // [init] from the coordinator's own NIP-65 event when one already exists,
  // otherwise published fresh from [_envRelays].
  final List<String> _envRelays;
  List<String> _relays;

  /// Discovery relays — resolved from Bitblik's profile NIP-65 at [init]
  /// (fallback: hardcoded bootstrap). The coordinator publishes its info +
  /// NIP-65 here so clients find it on the same relays they discover from.
  List<String> _discoveryRelays = List.from(kDiscoveryRelays);
  List<String> _graceRelays = const [];

  /// The relays currently used to communicate (resolved after [init]).
  List<String> get workingRelays => List.unmodifiable(_relays);
  List<String> get _broadcastRelays =>
      {..._graceRelays, ..._relays}.toList(growable: false);

  // Subscription for incoming requests
  NdkResponse? _requestSubscription;
  Timer? _relayRefreshTimer;
  Timer? _relayGraceTimer;

  // NIP-69 offer events are parameterized replaceable. If two state changes for
  // the same offer are published within the same second, some relays may keep
  // the older one and reject the newer with "have newer event". Keep a
  // monotonic created_at per offer id so every replacement wins deterministically.
  final Map<String, int> _lastOfferEventCreatedAtById = {};

  NostrService(
    this._coordinatorService, {
    List<String> relays = const [
      'wss://relay.damus.io',
      'wss://relay.primal.net',
    ],
  })  : _envRelays = relays,
        _relays = List.from(relays);

  /// Relays the coordinator publishes its discovery events (info + NIP-65) to,
  /// so clients can find it on the discovery set as well as its own.
  List<String> get _discoveryTargets =>
      {..._discoveryRelays, ..._broadcastRelays}.toList();

  String _shortKey(String value) {
    if (value.length <= 12) return value;
    return '${value.substring(0, 8)}...${value.substring(value.length - 4)}';
  }

  String _describeResponse(NostrResponse response) {
    final result = response.result;
    final error = response.error;
    if (result != null) {
      final keys = result.keys.toList()..sort();
      return 'resultKeys=$keys containsBlik=${result.containsKey('blik_code')}';
    }
    if (error != null) {
      return 'errorCode=${error['code']}';
    }
    return 'empty';
  }

  /// Initialize the Nostr service
  Future<void> init({required String privateKey}) async {
    // Bootstrap NDK on discovery + env relays so the self NIP-65 lookup can
    // succeed regardless of where a prior list was published.
    final bootstrap = {...kDiscoveryRelays, ..._envRelays}.toList();
    _ndk = Ndk(
      NdkConfig(
          cache: MemCacheManager(),
          eventVerifier: rustEventVerifier,
          bootstrapRelays: bootstrap,
          logLevel: LogLevel.info),
    );

    // Generate or load coordinator keys
    if (privateKey.isNotEmpty) {
      final decodedKey = _decodeNsecKey(privateKey);
      if (decodedKey == null) {
        throw Exception(
            'Invalid private key format. Use hex or nsec1... format.');
      }

      _signer = Bip340EventSigner(
        privateKey: decodedKey,
        publicKey: bip340.getPublicKey(decodedKey),
      );
    } else {
      // Generate new keys
      final random = Random.secure();
      final privateKeyBytes =
          List<int>.generate(32, (_) => random.nextInt(256));
      final privateKeyHex = privateKeyBytes
          .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
          .join('');

      _signer = Bip340EventSigner(
        privateKey: privateKeyHex,
        publicKey: bip340.getPublicKey(privateKeyHex),
      );

      AppLogger.info(
          'Generated new coordinator keys. Private key: $privateKeyHex');
      AppLogger.info(
          'Store this private key in your .env file as NOSTR_PRIVATE_KEY');
    }

    // Log the coordinator key into NDK accounts so the userRelayLists usecase
    // (NIP-65 publish) can sign with it.
    _ndk.accounts.loginPrivateKey(
      pubkey: _signer.getPublicKey(),
      privkey: _signer.privateKey!,
    );

    // Resolve discovery relays from Bitblik's profile NIP-65 (fallback:
    // hardcoded bootstrap). These are where we publish our info + NIP-65.
    await _resolveDiscoveryRelays();

    // Resolve the working relay set from our own NIP-65 (or publish a new one).
    await _resolveWorkingRelays();

    // Ensure a kind-0 profile (name/logo) exists on the discovery relays.
    await _ensureMetadata();

    // Publish coordinator info
    await _publishCoordinatorInfo();

    // Start listening for requests
    await _startRequestListener();

    // Follow external NIP-65 updates without restart.
    _startRelayRefreshLoop();
  }

  /// Determine the relays this coordinator uses. If a NIP-65 (kind
  /// [kKindRelayList]) event already exists for our pubkey, adopt the relays it
  /// advertises (env relays were only a bootstrap seed). Otherwise publish a
  /// fresh NIP-65 advertising the env relays.
  /// Resolve discovery relays from Bitblik's profile NIP-65. Falls back to the
  /// hardcoded bootstrap relays when unavailable.
  Future<void> _resolveDiscoveryRelays() async {
    // Union of hardcoded bootstrap relays and Bitblik's advertised relays, so
    // we publish where clients always look (bootstrap) plus any relays Bitblik
    // adds. Mirrors the client-side resolution.
    final resolved = <String>{...kDiscoveryRelays};
    final list = await _fetchRelayListFor(
      kBitblikPubkeyHex,
      queryRelays: kDiscoveryRelays,
    );
    if (list != null) resolved.addAll(list);
    _discoveryRelays = resolved.toList();
    AppLogger.info('Resolved discovery relays: $_discoveryRelays');
  }

  /// Ensure a kind-0 profile metadata event (name + logo) exists for this
  /// coordinator. If none is published yet, broadcast a fresh one built from
  /// the env-configured name/icon to the discovery relays. Sticky: never
  /// overwrites an existing profile.
  Future<void> _ensureMetadata() async {
    final hex = _signer.getPublicKey();
    try {
      final existing =
          await _ndk.metadata.loadMetadata(hex, forceRefresh: true);
      if (existing != null) {
        AppLogger.info(
            'Existing kind 0 metadata found (name=${existing.name})');
        return;
      }
      final info = await _coordinatorService.getCoordinatorInfo();
      final metadata = Metadata()
        ..pubKey = hex
        ..name = info.name
        ..displayName = info.name
        ..picture = info.icon;
      await _ndk.metadata.broadcastMetadata(
        metadata,
        specificRelays: _discoveryTargets,
      );
      AppLogger.info(
          'Published fresh kind 0 metadata: name=${info.name} picture=${info.icon}');
    } catch (e) {
      AppLogger.info('Error ensuring kind 0 metadata: $e');
    }
  }

  Future<void> _resolveWorkingRelays() async {
    final hex = _signer.getPublicKey();
    final existing = await _fetchRelayListFor(
      hex,
      queryRelays: {..._discoveryRelays, ..._relays},
    );
    if (existing != null && existing.isNotEmpty) {
      _relays = existing;
      final configured = _envRelays.map(normalizeRelayUrl).toSet();
      final published = _relays.map(normalizeRelayUrl).toSet();
      if (configured.isNotEmpty &&
          (configured.length != published.length ||
              !configured.containsAll(published))) {
        AppLogger.info(
          'Configured relays $_envRelays differ from published NIP-65 $_relays; runtime will use the published list until it is updated.',
        );
      }
      AppLogger.info('Adopted existing NIP-65 relays: $_relays');
    } else {
      _relays = List.from(_envRelays);
      AppLogger.info(
        'No existing NIP-65 relay list found; using configured relays: $_relays',
      );
      await _publishRelayList();
    }
  }

  /// Fetch the newest NIP-65 relay list authored by [hex] directly from the
  /// provided [queryRelays], bypassing cache. Discovery relays are the source
  /// of truth for coordinator relay lists.
  Future<List<String>?> _fetchRelayListFor(
    String hex, {
    required Iterable<String> queryRelays,
  }) async {
    final explicitRelays = queryRelays
        .map(normalizeRelayUrl)
        .where((u) => u.isNotEmpty)
        .toSet()
        .toList(growable: false);
    if (explicitRelays.isEmpty) return null;

    Nip01Event? newest;
    try {
      final response = _ndk.requests.query(
        name: 'coordinator-self-nip65',
        filter: Filter(
          kinds: [kKindRelayList],
          authors: [hex],
        ),
        explicitRelays: explicitRelays,
        cacheRead: false,
      );
      await for (final event in response.stream.timeout(
        _relayQueryTimeout,
        onTimeout: (sink) => sink.close(),
      )) {
        if (event.pubKey != hex) continue;
        if (newest == null || event.createdAt > newest.createdAt) {
          newest = event;
        }
      }
    } catch (_) {
      return null;
    }

    if (newest == null) return null;

    final urls = <String>{};
    for (final tag in newest.tags) {
      if (tag.length >= 2 && tag[0] == 'r') {
        final url = normalizeRelayUrl(tag[1]);
        if (url.isNotEmpty) urls.add(url);
      }
    }
    return urls.isEmpty ? null : urls.toList(growable: false);
  }

  /// Publish the coordinator's CURRENT working relay list to both its working
  /// relays and the discovery relays.
  ///
  /// This mirrors the authoritative runtime set onto the discovery relays on
  /// every startup, so clients that discover the coordinator there can also
  /// resolve its NIP-65 without needing to guess or rely on stale fallback
  /// sources.
  Future<void> _publishRelayList() async {
    if (_relays.isEmpty) return;
    try {
      final relayMap = <String, ReadWriteMarker>{
        for (final relay in _relays.map(normalizeRelayUrl))
          if (relay.isNotEmpty) relay: ReadWriteMarker.readWrite,
      };
      final event = Nip65(
        pubKey: _signer.getPublicKey(),
        relays: relayMap,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      ).toEvent();
      await _signer.sign(event);
      await _ndk.broadcast
          .broadcast(
            nostrEvent: event,
            customSigner: _signer,
            specificRelays: _discoveryTargets,
          )
          .broadcastDoneFuture;
      AppLogger.info(
        'Published NIP-65 relay list (${relayMap.keys.toList()}) to relays: $_discoveryTargets',
      );
    } catch (e) {
      AppLogger.info('Error publishing NIP-65 relay list: $e');
    }
  }

  void _startRelayRefreshLoop() {
    _relayRefreshTimer?.cancel();
    _relayRefreshTimer = Timer.periodic(_relayRefreshInterval, (_) {
      _refreshWorkingRelays().catchError((e) {
        AppLogger.info('Error refreshing working NIP-65 relays: $e');
      });
    });
  }

  Future<void> _refreshWorkingRelays() async {
    final latest = await _fetchRelayListFor(
      _signer.getPublicKey(),
      queryRelays: {..._discoveryRelays, ..._relays},
    );
    if (latest == null || latest.isEmpty) return;
    final next = latest
        .map(normalizeRelayUrl)
        .where((u) => u.isNotEmpty)
        .toSet()
        .toList(growable: false);
    final current = _relays.map(normalizeRelayUrl).toSet();
    if (current.length == next.length && current.containsAll(next)) return;
    await _applyWorkingRelayChange(next);
  }

  Future<void> _applyWorkingRelayChange(List<String> nextRelays) async {
    final previousTargets = _broadcastRelays;
    _relays = nextRelays;
    _graceRelays = previousTargets;
    AppLogger.info(
      'Detected updated NIP-65 relays; switching runtime relays to $_relays and keeping previous relays active during grace period: $_graceRelays',
    );
    await _restartRequestListener(_broadcastRelays);

    _relayGraceTimer?.cancel();
    _relayGraceTimer = Timer(_relayChangeGracePeriod, () {
      _finishRelayGracePeriod().catchError((e) {
        AppLogger.info('Error ending relay grace period: $e');
      });
    });
  }

  Future<void> _finishRelayGracePeriod() async {
    if (_graceRelays.isEmpty) return;
    final expired = _graceRelays;
    _graceRelays = const [];
    AppLogger.info(
      'Relay grace period ended; dropping previous relays: $expired',
    );
    await _restartRequestListener(_relays);
  }

  /// Decode nsec bech32 private key to hex format
  String? _decodeNsecKey(String nsecKey) {
    try {
      if (!nsecKey.startsWith('nsec1')) {
        // If it doesn't start with nsec1, assume it's already hex
        return nsecKey;
      }

      // Simple bech32 decoding for nsec keys
      // This is a basic implementation - in production you'd use a proper bech32 library
      // final data = nsecKey.substring(5); // Remove 'nsec1' prefix

      // For now, return the input as-is since NDK should handle nsec decoding
      // In a full implementation, you'd decode the bech32 format properly
      return Nip19.decode(nsecKey); // Let NDK handle the decoding
    } catch (e) {
      AppLogger.info('Error decoding nsec key: $e');
      return null;
    }
  }

  /// Publish coordinator info as a replaceable event
  Future<void> _publishCoordinatorInfo() async {
    try {
      final info = await _coordinatorService.getCoordinatorInfo();

      final event = Nip01Event(
        kind: kKindCoordinatorInfo,
        pubKey: _signer.getPublicKey(),
        content: '',
        tags: info.toNostrTags(),
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      await _signer.sign(event);
      await _ndk.broadcast.broadcast(
        nostrEvent: event,
        customSigner: _signer,
        specificRelays: _discoveryTargets,
      );

      AppLogger.info(
          'Published coordinator info event for pub key: ${event.pubKey} to relays: $_discoveryTargets');
    } catch (e) {
      AppLogger.info('Error publishing coordinator info: $e');
    }
  }

  /// Send encrypted offer status update to relevant users
  Future<void> publishOfferStatusUpdate({
    required String offerId,
    required String paymentHash,
    required String status,
    required DateTime timestamp,
    required String makerPubkey,
    String? takerPubkey,
    DateTime? reservedAt,
    DateTime? createdAt,
    DateTime? blikReceivedAt,
  }) async {
    try {
      final payload = <String, dynamic>{
        'offer_id': offerId,
        'payment_hash': paymentHash,
        'status': status,
        'created_at':
            createdAt != null ? createdAt.millisecondsSinceEpoch ~/ 1000 : null,
        'reserved_at': reservedAt != null
            ? reservedAt.millisecondsSinceEpoch ~/ 1000
            : null,
        // Carry blik_received_at so the taker/maker confirmation countdown
        // reflects the real 2-min BLIK lifetime (anchored to this timestamp)
        // and does not restart on the blikReceived -> blikSentToMaker transition.
        'blik_received_at': blikReceivedAt != null
            ? blikReceivedAt.millisecondsSinceEpoch ~/ 1000
            : null,
        'timestamp': timestamp.millisecondsSinceEpoch ~/ 1000,
      };

      AppLogger.info(
        'Publishing status update offer=$offerId status=$status paymentHash=${_shortKey(paymentHash)} maker=${_shortKey(makerPubkey)} taker=${takerPubkey == null || takerPubkey.isEmpty ? '-' : _shortKey(takerPubkey)}',
        offerId: offerId,
      );

      await _sendEncryptedStatusUpdate(makerPubkey, payload, offerId);
      if (takerPubkey != null && takerPubkey.isNotEmpty) {
        await _sendEncryptedStatusUpdate(takerPubkey, payload, offerId);
      }
    } catch (e) {
      AppLogger.info('Error sending encrypted offer status updates: $e',
          offerId: offerId);
    }
  }

  /// Send encrypted status update to a specific user
  Future<void> _sendEncryptedStatusUpdate(
    String recipientPubkey,
    Map<String, dynamic> payload,
    String offerId,
  ) async {
    try {
      final privateKey = _signer.privateKey;
      if (privateKey == null) {
        throw Exception('No private key available for encryption');
      }

      AppLogger.info(
        'Sending status update offer=$offerId status=${payload['status']} to=${_shortKey(recipientPubkey)} paymentHash=${_shortKey((payload['payment_hash'] ?? '').toString())}',
        offerId: offerId,
      );

      final event = await ProtocolCodec.encryptStatusUpdate(
        payload: payload,
        offerId: offerId,
        senderPrivateKeyHex: privateKey,
        senderPubkeyHex: _signer.getPublicKey(),
        recipientPubkey: recipientPubkey,
      );

      await _signer.sign(event);
      await _ndk.broadcast.broadcast(
        nostrEvent: event,
        customSigner: _signer,
        specificRelays: _broadcastRelays,
      );
      AppLogger.info(
        'Sent status update offer=$offerId status=${payload['status']} to=${_shortKey(recipientPubkey)} event=${event.id}',
        offerId: offerId,
      );
    } catch (e) {
      AppLogger.info(
          'Error sending encrypted status update to $recipientPubkey: $e');
    }
  }

  /// Start listening for encrypted requests
  Future<void> _startRequestListener() async {
    await _restartRequestListener(_broadcastRelays);
  }

  Future<void> _restartRequestListener(List<String> relays) async {
    try {
      if (_requestSubscription != null) {
        await _ndk.requests.closeSubscription(_requestSubscription!.requestId);
        _requestSubscription = null;
      }
      final filter = Filter(
        kinds: [kKindCoordinatorRequest],
        pTags: [_signer.getPublicKey()], // Events tagged with our pubkey
        since: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      final response = _ndk.requests.subscription(
        name: "coordinator-requests",
        filter: filter,
        // Listen on our working relays (NIP-65 set), which may differ from the
        // bootstrap/discovery relays.
        explicitRelays: relays,
      );
      _requestSubscription = response;

      response.stream.listen(_handleRequest).onError((e) {
        AppLogger.info('!!!!!!!!!!!!!! Error in request listener: $e');
        AppLogger.info('!!!!!!!!!!!!!! SHOULD RETRY subscription');
      });

      AppLogger.info(
          'Started listening for coordinator requests on kind ${kKindCoordinatorRequest} via relays: $relays');
    } catch (e) {
      AppLogger.info('Error starting request listener: $e');
    }
  }

  /// Handle incoming encrypted requests
  Future<void> _handleRequest(Nip01Event event) async {
    final privateKey = _signer.privateKey;
    if (privateKey == null) {
      throw Exception('No private key available for decryption');
    }

    final request = await ProtocolCodec.decryptRequest(event, privateKey);
    final id = request.id;
    AppLogger.info(
      '${request.client} - ${request.method} from=${_shortKey(event.pubKey)} params=${request.params.values.map((v) => v.toString()).toList()..sort()}',
    );
    if (id == null) {
      await _sendErrorResponse(
          event.pubKey, null, 'INVALID_REQUEST', 'Missing id');
      return;
    }
    try {
      final response = await _processRequest(
          request.method, request.params, event.pubKey,
          clientVersion: request.client);
      await _sendResponse(event.pubKey, id, response);
    } catch (e) {
      AppLogger.info('Error handling request: $e');
      await _sendErrorResponse(
          event.pubKey, id, 'INTERNAL_ERROR', e.toString());
    }
  }

  /// Process a coordinator request
  Future<Map<String, dynamic>> _processRequest(
      String method, Map<String, dynamic> params, String userPubkey,
      {String? clientVersion}) async {
    try {
      switch (method) {
        case kRpcGetInfo:
          final info = await _coordinatorService.getCoordinatorInfo();
          return info.toJson();

        // case 'list_offers':
        //   final offers = await _coordinatorService.listAvailableOffers();
        //   return {'offers': offers};

        case kRpcInitiateOffer:
          final fiatAmount = (params['fiat_amount'] as num?)?.toDouble();
          final categoryRaw = params['category'] as String?;
          OfferCategory? category;
          if (categoryRaw != null && categoryRaw.trim().isNotEmpty) {
            try {
              category = OfferCategory.values.byName(categoryRaw);
            } catch (_) {
              throw Exception('Invalid category: $categoryRaw');
            }
          }

          if (fiatAmount == null) {
            throw Exception('Missing required parameter: fiat_amount');
          }

          final premiumPercent =
              (params['premium_percent'] as num?)?.toDouble() ?? 0;
          final fiatCurrency = params['fiat_currency'] as String?;
          final blikCode = params['blik_code'] as String?;

          return await _coordinatorService.initiateOfferFiat(
            fiatAmount: fiatAmount,
            makerId: userPubkey,
            fiatCurrency: fiatCurrency,
            category: category,
            premiumPercent: premiumPercent,
            blikCode: blikCode,
            clientVersion: clientVersion,
          );

        case kRpcReserveOffer:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final reservationTimestamp =
              await _coordinatorService.reserveOffer(offerId, userPubkey);
          if (reservationTimestamp != null) {
            return {
              'message': 'Offer reserved successfully',
              'reserved_at': reservationTimestamp.millisecondsSinceEpoch,
            };
          } else {
            throw Exception(
                'Failed to reserve offer. It might be unavailable or already reserved.');
          }

        case kRpcSubmitBlik:
          final offerId = params['offer_id'] as String?;
          final blikCode = params['blik_code'] as String?;
          final takerLightningAddress =
              params['taker_lightning_address'] as String?;
          final taker_invoice = params['taker_invoice'] as String?;

          if (offerId == null ||
              (takerLightningAddress == null && taker_invoice == null)) {
            throw Exception(
                'Missing required parameters: offer_id and taker invoice/lightning address');
          }

          final success = await _coordinatorService.submitBlikCode(offerId,
              userPubkey, blikCode, takerLightningAddress, taker_invoice);

          if (success) {
            return {'message': 'BLIK code submitted successfully'};
          } else {
            throw Exception(
                'Failed to submit BLIK code. Offer state might be invalid or taker mismatch.');
          }

        case kRpcGetBlik:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final blikCode = await _coordinatorService.getBlikCodeForMaker(
              offerId, userPubkey);
          if (blikCode != null) {
            return {'blik_code': blikCode};
          } else {
            throw Exception(
                'BLIK code not found or not available for this offer/maker.');
          }

        case kRpcConfirmPayment:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success = await _coordinatorService.confirmMakerPayment(
              offerId, userPubkey);
          if (success) {
            return {
              'message': 'Payment confirmed, invoice settled, taker paid.'
            };
          } else {
            throw Exception(
                'Failed to confirm payment. Check offer state, LND connection, or logs.');
          }

        // DEPRECATED: clients now resolve a local-only offer (id == payment
        // hash, no UUID yet) via `get_offer_details` with a `payment_hash`
        // param instead of this dedicated lookup. Kept for old clients.
        case kRpcGetMyActiveOffer:
          final activeOffers =
              await _coordinatorService.getMyActiveOffers(userPubkey);
          if (activeOffers.isNotEmpty) {
            final offer = activeOffers.first;
            return offer.toRpcJson();
          } else {
            return {};
          }

        case kRpcGetOfferDetails:
          final offerId = params['offer_id'] as String?;
          final paymentHash = params['payment_hash'] as String?;
          final offer = await _coordinatorService.getOfferDetailsForParticipant(
            userPubkey,
            offerId: offerId,
            paymentHash: paymentHash,
          );
          if (offer == null) {
            return {};
          }
          final includeBlikCode = _coordinatorService
                  .paymentSystem.makerProvidesCodeAtOfferCreation &&
              offer.takerPubkey == userPubkey;
          return offer.toRpcJson(includeBlikCode: includeBlikCode);

        // DEPRECATED: clients (>= local-db-counts change) no longer call this.
        // The per-coordinator "your offers" count is now derived from the
        // client's own local offer DB, so finished-offer history lives on the
        // client and is not re-fetched from the coordinator. Kept for backward
        // compatibility with older clients; safe to remove once those are gone.
        case kRpcGetMyFinishedOffers:
          final activeOffers =
              await _coordinatorService.getMyActiveOffers(userPubkey);
          final now = DateTime.now().toUtc();
          final finished = activeOffers
              .where((offer) =>
                  offer.status.name != 'expired' &&
                      offer.status.name != 'cancelled' ||
                  offer.takerPaidAt != null &&
                      now.difference(offer.takerPaidAt!.toUtc()).inHours < 24)
              .toList();

          final finishedList =
              finished.map((offer) => offer.toRpcJson()).toList();
          return {'offers': finishedList};

        case kRpcCancelOffer:
          //PILA Error handling request: Exception: Error processing request: PostgreSQLSeverity.error 22P02: invalid input syntax for type uuid: "unknown_id"
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.cancelOffer(offerId, userPubkey);
          if (success) {
            return {'message': 'Offer cancelled successfully'};
          } else {
            throw Exception(
                'Failed to cancel offer. It might be in the wrong state or you are not the maker.');
          }

        case kRpcCancelReservation:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.cancelReservation(offerId, userPubkey);
          if (success) {
            return {'message': 'Reservation cancelled successfully'};
          } else {
            throw Exception(
                'Failed to cancel reservation. It might be in the wrong state or you are not the taker.');
          }

        case kRpcMarkBlikInvalid:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.markBlikInvalid(offerId, userPubkey);
          if (success) {
            return {'message': 'BLIK code marked as invalid successfully'};
          } else {
            throw Exception(
                'Failed to mark BLIK as invalid. Offer might be in the wrong state, not found, or maker ID mismatch.');
          }

        case kRpcMarkBlikCharged:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.markBlikCharged(offerId, userPubkey);
          if (success) {
            return {'message': 'Offer marked as conflict successfully'};
          } else {
            throw Exception(
                'Failed to mark offer as conflict. Offer might be in the wrong state, not found, or taker ID mismatch.');
          }

        case kRpcOpenDispute:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.openDispute(offerId, userPubkey);
          if (success) {
            return {'message': 'Offer marked as open dispute successfully'};
          } else {
            throw Exception(
                'Failed to mark offer as dispute. Offer might be in the wrong state, not found, or taker ID mismatch.');
          }

        case kRpcUpdateTakerInvoice:
          final offerId = params['offer_id'] as String?;
          final bolt11 = params['bolt11'] as String?;

          if (offerId == null || bolt11 == null) {
            throw Exception('Missing required parameters: offer_id, bolt11');
          }

          final success = await _coordinatorService.updateTakerInvoice(
              offerId, bolt11, userPubkey);
          if (success) {
            return {'message': 'Taker invoice updated'};
          } else {
            throw Exception('Failed to update taker invoice');
          }

        case kRpcRetryTakerPayment:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final error =
              await _coordinatorService.retryTakerPayment(offerId, userPubkey);
          if (error == null) {
            return {'message': 'Taker payment retried'};
          } else {
            throw Exception(error);
          }

        case kRpcGetSuccessfulOffersStats:
          return await _coordinatorService.getSuccessfulOffersWithStats();

        default:
          throw Exception('Unknown method: $method');
      }
    } catch (e) {
      throw Exception('Error processing request: $e');
    }
  }

  /// Send a successful response
  Future<void> _sendResponse(String recipientPubkey, String requestId,
      Map<String, dynamic> result) async {
    await _sendEncryptedResponse(
        recipientPubkey, NostrResponse(id: requestId, result: result));
  }

  /// Send an error response
  Future<void> _sendErrorResponse(String recipientPubkey, String? requestId,
      String errorCode, String errorMessage) async {
    await _sendEncryptedResponse(
      recipientPubkey,
      NostrResponse(
        id: requestId,
        error: {'code': errorCode, 'message': errorMessage},
      ),
    );
  }

  /// Send an encrypted [NostrResponse] to a recipient.
  Future<void> _sendEncryptedResponse(
      String recipientPubkey, NostrResponse response) async {
    try {
      final privateKey = _signer.privateKey;
      if (privateKey == null) {
        throw Exception('No private key available for encryption');
      }

      final event = await ProtocolCodec.encryptResponse(
        response: response,
        senderPrivateKeyHex: privateKey,
        senderPubkeyHex: _signer.getPublicKey(),
        recipientPubkey: recipientPubkey,
      );

      await _signer.sign(event);
      await _ndk.broadcast.broadcast(
        nostrEvent: event,
        customSigner: _signer,
        specificRelays: _broadcastRelays,
      );

      AppLogger.info(
        'Sent RPC response id=${response.id ?? '-'} to=${_shortKey(recipientPubkey)}',
      );
    } catch (e) {
      AppLogger.info(
        'Error sending encrypted message to ${_shortKey(recipientPubkey)} id=${response.id ?? '-'} ${_describeResponse(response)}: $e',
      );
    }
  }

  /// Get the coordinator's public key
  String? get coordinatorPubkey => _signer.getPublicKey();

  /// Refresh coordinator info (republish)
  Future<void> refreshInfo() async {
    await _publishCoordinatorInfo();
  }

  /// Disconnect and cleanup
  Future<void> disconnect() async {
    _relayRefreshTimer?.cancel();
    _relayGraceTimer?.cancel();
    if (_requestSubscription != null) {
      await _ndk.requests.closeSubscription(_requestSubscription!.requestId);
    }
    await _ndk.destroy();
  }

  /// Broadcast a NIP-69 peer-to-peer order event based on Offer data
  // PILA also broadcast on other state changes
  // reserved, blikReceived, blikSentToTaker = in-progress
  // cancelled/expired = canceled
  // takerPaid = success
  // * reszta = ?

  Future<void> broadcastNip69OrderFromOffer(
    Offer offer, {
    String orderType = 'sell',
    // Default to this coordinator's payment system so the `pm` (method) and `y`
    // (platform) tags match the market it serves; clients filter on `#y`.
    List<String>? paymentSystems,
    String? platform,
    int? expiration,
    // Defaults to the offer's own premium so status re-broadcasts preserve it.
    double? premium,
    String network = "mainnet",
    String layer = "lightning",
    String? name,
    String? geohash,
    String? ratingJson,
    String document = 'order',
    String bond = "0",
  }) async {
    final status = _mapOfferStatusToNip69Status(offer.status);
    final premiumValue = premium ?? offer.premiumPercent;
    final ps = _coordinatorService.paymentSystem;
    final resolvedPaymentSystems = paymentSystems ?? [ps.label];
    final resolvedPlatform = platform ?? ps.platformTag;
    try {
      final nowSecs = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      final lastSecs = _lastOfferEventCreatedAtById[offer.id] ?? 0;
      final eventCreatedAt = nowSecs <= lastSecs ? lastSecs + 1 : nowSecs;

      final tags = <List<String>>[
        ['d', offer.id],
        ['k', orderType],
        ['f', offer.fiatCurrency],
        ['s', status],
        ['amt', offer.amountSats.toString()],
        ['fa', offer.fiatAmount.toString()],
        ['pm', ...resolvedPaymentSystems],
        ['premium', premiumValue.toString()],
        if (ratingJson != null) ['rating', ratingJson],
        [
          'source',
          "https://${_coordinatorService.frontendDomain}/offers/${offer.id}",
        ],
        ['network', network],
        ['layer', layer],
        ['name', name ?? ''],
        if (geohash != null) ['g', geohash],
        ['bond', bond],
        if (expiration != null) ['expiration', expiration.toString()],
        ['y', resolvedPlatform],
        ['z', document],
        [
          'reserved_at',
          offer.reservedAt != null
              ? (offer.reservedAt!.millisecondsSinceEpoch ~/ 1000).toString()
              : ''
        ],
        [
          'created_at',
          (offer.createdAt.millisecondsSinceEpoch ~/ 1000).toString()
        ],
        [
          'paid_at',
          offer.takerPaidAt != null
              ? (offer.takerPaidAt!.millisecondsSinceEpoch ~/ 1000).toString()
              : ''
        ],
        if (offer.category != null) ['category', offer.category!.name],
        if (offer.takerFees != null && offer.takerFees! > 0)
          ['taker_fees', offer.takerFees.toString()],
        if (offer.makerFees > 0) ['maker_fees', offer.makerFees.toString()],
      ];

      final event = Nip01Event(
        kind: kKindOffer,
        pubKey: _signer.getPublicKey(),
        content: '',
        tags: tags,
        createdAt: eventCreatedAt,
      );

      await _ndk.broadcast.broadcast(
          nostrEvent: event,
          customSigner: _signer,
          specificRelays: _broadcastRelays);
      _lastOfferEventCreatedAtById[offer.id] = eventCreatedAt;
      // AppLogger.info(
      //     'Broadcasted NIP-69 order event for offer ${offer.id}, status: ${status} id:${event.id}',
      //     offerId: offer.id);
    } catch (e) {
      AppLogger.info(
          'Error broadcasting NIP-69 order event for offer ${offer.id}: $e',
          offerId: offer.id);
    }
  }

  /// Rebroadcast all offers to update their status on Nostr relays
  Future<void> rebroadcastOffers(List<Offer> offers) async {
    AppLogger.info('Starting rebroadcast of offers...');

    try {
      for (final offer in offers) {
        // final status = _mapOfferStatusToNip69Status(offer.status);

        AppLogger.info(
            'Rebroadcasting offer ${offer.id} with status ${offer.status.name}',
            offerId: offer.id);
        // Calculate expiration if the offer is still active
        int? expiration;
        if (offer.status == OfferStatus.funded) {
          // Use the same expiration logic as in the original broadcast
          expiration = offer.createdAt
                  .add(Duration(seconds: 600)) // _fundedExpireTimeoutSeconds
                  .millisecondsSinceEpoch ~/
              1000;
        }

        await broadcastNip69OrderFromOffer(
          offer,
          expiration: expiration,
        );

        // Small delay between broadcasts to avoid overwhelming relays
        await Future.delayed(Duration(milliseconds: 500));
      }

      AppLogger.info('Completed rebroadcasting offers');
    } catch (e) {
      AppLogger.info('Error during rebroadcast of offers: $e');
    }
  }

  /// Map internal offer status to NIP-69 status
  String _mapOfferStatusToNip69Status(OfferStatus status) {
    switch (status) {
      case OfferStatus.created:
      case OfferStatus.funded:
        return 'pending';
      case OfferStatus.reserved:
      case OfferStatus.blikReceived:
      case OfferStatus.blikSentToMaker:
      case OfferStatus.makerConfirmed:
      case OfferStatus.settled:
      case OfferStatus.payingTaker:
      case OfferStatus.takerPaymentFailed:
      case OfferStatus.invalidBlik:
      case OfferStatus.expiredBlik:
      case OfferStatus.expiredSentBlik:
      case OfferStatus.takerCharged:
        return 'in-progress';
      case OfferStatus.takerPaid:
        return 'success';
      case OfferStatus.cancelled:
      case OfferStatus.expired:
        return 'canceled';
      case OfferStatus.conflict:
      case OfferStatus.dispute:
        return 'dispute';
      case OfferStatus.unknown:
        // Coordinator never emits offers in `unknown` state — sentinel exists
        // only on the client side for forward-compat decoding.
        return 'canceled';
    }
  }
}
