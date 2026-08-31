import 'dart:async';
import 'dart:io';

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
  /// Where a freshly generated coordinator key is persisted (owner-only) when
  /// no `NOSTR_PRIVATE_KEY` is configured, so the identity survives restarts.
  static const String _generatedKeyFilePath = 'coordinator_private_key.hex';

  final CoordinatorService _coordinatorService;
  late final Ndk _ndk;
  late final MemCacheManager _cacheManager;
  late Bip340EventSigner _signer;
  final RustEventVerifier rustEventVerifier = RustEventVerifier();
  static const Duration _relayRefreshInterval = Duration(seconds: 60);
  static const Duration _relayChangeGracePeriod = Duration(minutes: 5);
  static const Duration _relayQueryTimeout = Duration(seconds: 6);
  static const Duration _cacheEvictionStartupDelay = Duration(seconds: 30);
  static const Duration _cacheEvictionInterval = Duration(minutes: 1);
  static const Duration _pendingDeliveryRetryInterval = Duration(minutes: 1);
  // relay.mostro.network rate-limits to 5 events per minute per IP, and
  // several coordinators share the same egress IP, so startup rebroadcasts
  // must leave most of that budget free for live offer traffic.
  static const Duration _rebroadcastSpacing = Duration(seconds: 60);

  // Requests/responses/status updates are ephemeral and should be discarded
  // aggressively. Public offers are parameterized replaceable by `d`, but the
  // in-memory cache keys by event id, so repeated state broadcasts accumulate.
  // Metadata (kind 0) and NIP-65 relay lists (10002) are low-volume, but still
  // need a cap here because the default protected set would otherwise exempt
  // them from cap-based eviction entirely.
  static final Set<int> _cacheEvictionProtectedKinds =
      Set<int>.of(EvictionPolicy.kDefaultProtectedKinds)
        ..remove(Metadata.kKind)
        ..remove(Nip65.kKind);
  static final EvictionPolicy _cacheEvictionPolicy = EvictionPolicy(
    kindCaps: const {
      kKindCoordinatorRequest: 0,
      kKindCoordinatorResponse: 0,
      kKindOfferStatusUpdate: 0,
      kKindOffer: 500,
      Metadata.kKind: 100,
      Nip65.kKind: 50,
    },
    protectedKinds: _cacheEvictionProtectedKinds,
  );

  // Relay configuration.
  //
  // [_envRelays] is the seed set from config (NOSTR_RELAYS). [_relays] is the
  // working set actually used for info/offers/responses/status — resolved at
  // [init] from the coordinator's own NIP-65 event when one already exists,
  // otherwise published fresh from [_envRelays].
  final List<String> _envRelays;
  List<String> _relays;
  final List<String> _blossomServers;

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
  // Dart-side listener over [_requestSubscription]. Must be cancelled when the
  // ndk subscription is closed, otherwise the listener closure + any buffered
  // events stay reachable until GC walks them. Each relay refresh/grace flip
  // allocates a new one, so without explicit cancel the leak accumulates.
  StreamSubscription<Nip01Event>? _requestListenerSub;
  Timer? _relayRefreshTimer;
  Timer? _relayGraceTimer;
  int _requestsReceived = 0;
  int _responsesSent = 0;
  int _responseErrors = 0;
  final Map<String, int> _rpcMethodCounts = {};

  // NIP-69 offer events are parameterized replaceable. If two state changes for
  // the same offer are published within the same second, some relays may keep
  // the older one and reject the newer with "have newer event". Keep a
  // monotonic created_at per offer id so every replacement wins deterministically.
  //
  // Write-heavy: every broadcast updates this map. Terminal offers never
  // broadcast again, so callers must [forgetOfferTracking] once an offer
  // reaches a terminal state to keep the map bounded.
  final Map<String, int> _lastOfferEventCreatedAtById = {};

  NostrService(
    this._coordinatorService, {
    List<String> relays = const [
      'wss://relay.damus.io',
      'wss://relay.primal.net',
    ],
    List<String> blossomServers = const [],
  })  : _envRelays = relays,
        _relays = List.from(relays),
        _blossomServers = _validateBlossomServers(blossomServers);

  static List<String> _validateBlossomServers(List<String> values) {
    final result = <String>[];
    for (final value in values) {
      final trimmed = value.trim();
      if (trimmed.isEmpty) continue;
      final uri = Uri.tryParse(trimmed);
      if (uri == null ||
          !const {'https', 'http'}.contains(uri.scheme) ||
          uri.host.isEmpty) {
        throw ArgumentError.value(value, 'blossomServers', 'Invalid URL');
      }
      final normalized = uri.toString().replaceFirst(RegExp(r'/+$'), '');
      if (!result.contains(normalized)) result.add(normalized);
    }
    return List.unmodifiable(result);
  }

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
    _cacheManager = MemCacheManager();

    // Generate or load coordinator keys. Precedence: explicit env key, then
    // the generated-key file from a previous run (keeps the identity stable
    // across restarts), then a fresh key.
    if (privateKey.isNotEmpty) {
      final decodedKey = _decodeNsecKey(privateKey);
      if (decodedKey == null) {
        throw Exception(
            'Invalid private key format. Use hex or nsec1... format.');
      }
      // Fail fast on a malformed or out-of-range scalar instead of signing
      // with a silently reduced key.
      final validatedKey = requireValidSecp256k1PrivateKeyHex(decodedKey);
      _signer = Bip340EventSigner(
        privateKey: validatedKey,
        publicKey: bip340.getPublicKey(validatedKey),
      );
    } else {
      final keyFile = File(_generatedKeyFilePath);
      String? fileKey;
      if (await keyFile.exists()) {
        final raw = (await keyFile.readAsString()).trim();
        // Throws on a corrupted/tampered key file — better to refuse to
        // start than to sign with a bad key.
        fileKey = requireValidSecp256k1PrivateKeyHex(raw);
      }
      final privateKeyHex = fileKey ?? generateSecp256k1PrivateKeyHex();
      _signer = Bip340EventSigner(
        privateKey: privateKeyHex,
        publicKey: bip340.getPublicKey(privateKeyHex),
      );
      if (fileKey == null) {
        // Persist with owner-only permissions so the identity survives
        // restarts. NEVER log the private key — logs are shipped to the
        // audit DB and log aggregators.
        await keyFile.writeAsString('$privateKeyHex\n');
        if (!Platform.isWindows) {
          await Process.run('chmod', ['600', keyFile.path]);
        }
        AppLogger.info('Generated new coordinator keypair. '
            'Public key: ${_signer.getPublicKey()}');
        AppLogger.info(
            'Private key stored in ${keyFile.path} (mode 600). To pin the '
            'identity explicitly, set NOSTR_PRIVATE_KEY in .env instead.');
      } else {
        AppLogger.info('Loaded coordinator key from ${keyFile.path}. '
            'Public key: ${_signer.getPublicKey()}');
      }
    }

    // Bootstrap only after the signer has been resolved. NDK starts relay
    // connectivity as part of construction and can otherwise attempt a
    // pending-delivery flush with no logged-in account.
    final bootstrap = {...kDiscoveryRelays, ..._envRelays}.toList();
    _ndk = Ndk(
      NdkConfig(
        cache: _cacheManager,
        eventVerifier: rustEventVerifier,
        bootstrapRelays: bootstrap,
        logLevel: LogLevel.info,
        cacheEvictionEnabled: true,
        cacheEvictionPolicy: _cacheEvictionPolicy,
        cacheEvictionStartupDelay: _cacheEvictionStartupDelay,
        cacheEvictionInterval: _cacheEvictionInterval,
        // Slow down NDK's local-first rebroadcast pump so relay.mostro.network
        // does not get hammered by repeated pending-delivery retries.
        pendingDeliveryRetryInterval: _pendingDeliveryRetryInterval,
      ),
    );

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
    await _publishDmRelayList();
    await _publishBlossomServerList();

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

  Future<void> _publishDmRelayList() async {
    if (_relays.isEmpty) return;
    try {
      await _ndk.dms.publishDmRelays(
        relayUrlsOrdered: _relays,
        broadcastRelays: _discoveryTargets,
      );
      AppLogger.info('Published NIP-17 DM inbox relay list.');
    } catch (e) {
      AppLogger.warning('Could not publish NIP-17 DM inbox relay list: $e');
    }
  }

  Future<void> _publishBlossomServerList() async {
    if (_blossomServers.isEmpty) {
      AppLogger.warning(
        'BLOSSOM_SERVERS is empty; encrypted dispute evidence uploads are disabled.',
      );
      return;
    }
    try {
      await _ndk.blossomUserServerList.publishUserServerList(
        serverUrlsOrdered: _blossomServers,
      );
      AppLogger.info(
        'Published standard kind-10063 Blossom server list '
        '(${_blossomServers.length} server(s)).',
      );
    } catch (e) {
      AppLogger.warning('Could not publish Blossom server list: $e');
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
    await _publishDmRelayList();

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
      final broadcastResponse = _ndk.broadcast.broadcast(
        nostrEvent: event,
        customSigner: _signer,
        specificRelays: _broadcastRelays,
        saveToCache: false,
      );
      await broadcastResponse.broadcastDoneFuture;
      await _clearEphemeralBroadcastTracking(event.id);
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
        await _requestListenerSub?.cancel();
        _requestListenerSub = null;
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

      _requestListenerSub = response.stream.listen(
        _handleRequest,
        onError: (Object e) {
          AppLogger.info('!!!!!!!!!!!!!! Error in request listener: $e');
          AppLogger.info('!!!!!!!!!!!!!! SHOULD RETRY subscription');
        },
        cancelOnError: false,
      );

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
    _requestsReceived++;
    _rpcMethodCounts.update(request.method, (count) => count + 1,
        ifAbsent: () => 1);
    final id = request.id;
    AppLogger.info(
      '${request.client} - ${request.method} from=${_shortKey(event.pubKey)} '
      'paramKeys=${request.params.keys.toList()..sort()}',
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
      // Offer-action RPCs (the state machine) are owned by the active flow
      // strategy — YAML-driven generic flow. Query/info RPCs fall through to
      // the shared handlers below.
      if (_coordinatorService.flow.handlesRpc(method)) {
        return await _coordinatorService.flow.handleRpc(
            method, params, userPubkey,
            clientVersion: clientVersion);
      }

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
          final bank = params['bank'] as String?;

          return await _coordinatorService.initiateOfferFiat(
            fiatAmount: fiatAmount,
            makerId: userPubkey,
            fiatCurrency: fiatCurrency,
            category: category,
            premiumPercent: premiumPercent,
            blikCode: blikCode,
            bank: bank,
            clientVersion: clientVersion,
          );

        // DEPRECATED: clients now resolve a local-only offer (id == payment
        // hash, no UUID yet) via `get_offer_details` with a `payment_hash`
        // param instead of this dedicated lookup. Kept for old clients.
        case kRpcGetMyActiveOffer:
          final activeOffers =
              await _coordinatorService.getMyActiveOffers(userPubkey);
          if (activeOffers.isNotEmpty) {
            final offer = activeOffers.first;
            return <String, dynamic>{
              ...offer.toRpcJson(forTaker: offer.makerPubkey != userPubkey),
              // Stamp this coordinator's market so clients resolve the right
              // method (EUR alone is ambiguous across the Slovak banks).
              'payment_system': _coordinatorService.paymentSystem.id,
            };
          } else {
            return {};
          }

        case kRpcListDisputes:
          final coordinatorKey = coordinatorPubkey;
          final isCoordinator = coordinatorKey != null &&
              userPubkey.toLowerCase() == coordinatorKey.toLowerCase();
          if (!isCoordinator) {
            throw StateError(
              'Only the authenticated coordinator can list dispute history.',
            );
          }
          final requestedLimit = (params['limit'] as num?)?.toInt() ?? 25;
          final limit = requestedLimit.clamp(1, 25).toInt();
          final cursor = params['cursor'];
          DateTime? beforeDisputeAt;
          DateTime? beforeCreatedAt;
          String? beforeId;
          if (cursor != null) {
            if (cursor is! Map) {
              throw const FormatException('Invalid dispute-list cursor.');
            }
            beforeDisputeAt = DateTime.tryParse(
              cursor['dispute_at']?.toString() ?? '',
            )?.toUtc();
            beforeCreatedAt = DateTime.tryParse(
              cursor['created_at']?.toString() ?? '',
            )?.toUtc();
            beforeId = cursor['id']?.toString();
            if (beforeDisputeAt == null ||
                beforeCreatedAt == null ||
                beforeId == null ||
                beforeId.isEmpty) {
              throw const FormatException('Invalid dispute-list cursor.');
            }
          }
          final disputes = await _coordinatorService.getDisputedOffers(
            limit: limit + 1,
            beforeDisputeAt: beforeDisputeAt,
            beforeCreatedAt: beforeCreatedAt,
            beforeId: beforeId,
          );
          final hasMore = disputes.length > limit;
          final page = (hasMore ? disputes.take(limit) : disputes).toList(
            growable: false,
          );
          final last = page.isEmpty ? null : page.last;
          return <String, dynamic>{
            'offers': page
                .map(
                  (offer) => <String, dynamic>{
                    'id': offer.id,
                    'amount_sats': offer.amountSats,
                    'maker_fees': offer.makerFees,
                    'status': offer.statusRaw,
                    'created_at': offer.createdAt.toUtc().toIso8601String(),
                    'dispute_at': offer.disputeAt?.toUtc().toIso8601String(),
                    'fiat_amount': offer.fiatAmount,
                    'fiat_currency': offer.fiatCurrency,
                    'maker_pubkey': offer.makerPubkey,
                    'taker_pubkey': offer.takerPubkey,
                    'coordinator_pubkey': coordinatorKey,
                  },
                )
                .toList(growable: false),
            'next_cursor': hasMore && last != null
                ? <String, dynamic>{
                    'dispute_at': last.disputeAt!.toUtc().toIso8601String(),
                    'created_at': last.createdAt.toUtc().toIso8601String(),
                    'id': last.id,
                  }
                : null,
          };

        case kRpcGetOfferDetails:
          final offerId = params['offer_id'] as String?;
          final paymentHash = params['payment_hash'] as String?;
          // Nostr pubkeys are hex identifiers; compare their canonical form so
          // a valid signed coordinator request is never downgraded to the
          // participant lookup path because a signer encoded uppercase hex.
          final coordinatorKey = coordinatorPubkey;
          final isCoordinator = coordinatorKey != null &&
              userPubkey.toLowerCase() == coordinatorKey.toLowerCase();
          final offer = isCoordinator
              ? (offerId != null && offerId.isNotEmpty
                  ? await _coordinatorService.getOfferById(offerId)
                  : paymentHash != null && paymentHash.isNotEmpty
                      ? await _coordinatorService
                          .getOfferByPaymentHash(paymentHash)
                      : throw ArgumentError(
                          'offerId or paymentHash is required'))
              : await _coordinatorService.getOfferDetailsForParticipant(
                  userPubkey,
                  offerId: offerId,
                  paymentHash: paymentHash,
                );
          if (offer == null) {
            return {};
          }
          final includeBlikCode = isCoordinator ||
              _coordinatorService.offerUsesMakerProvidedCode(offer) &&
                  offer.takerPubkey == userPubkey;
          // Coordinator authorization derives only from the signed request
          // author matching this running service's own key. Participant
          // responses preserve the existing maker-identity redaction.
          return <String, dynamic>{
            ...offer.toRpcJson(
              includeBlikCode: includeBlikCode,
              includeTakerInvoice: isCoordinator,
              forTaker: !isCoordinator && offer.makerPubkey != userPubkey,
            ),
            // The running signer's key is authoritative even for legacy DB
            // rows created before coordinator_pubkey was persisted.
            if (coordinatorKey != null)
              'coordinator_pubkey': coordinatorKey.toLowerCase(),
            'payment_system': _coordinatorService.paymentSystem.id,
            if (isCoordinator || offer.makerPubkey == userPubkey)
              'maker_refund_invoice_ready': offer.makerRefundInvoice != null &&
                  offer.makerRefundPaymentHash != null,
            if (isCoordinator)
              'state_history':
                  await _coordinatorService.getOfferStateHistory(offer.id),
            if (isCoordinator)
              'payment_backend': {
                'type': _coordinatorService.paymentBackendType,
                'available': _coordinatorService.paymentBackendType != 'none',
              },
            if (isCoordinator)
              'decision_amounts': {
                'maker_refund_sats': _coordinatorService
                    .disputeDecisionAmounts(offer)
                    .makerRefundSats,
                'taker_payout_sats': _coordinatorService
                    .disputeDecisionAmounts(offer)
                    .takerPayoutSats,
              },
          };

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

          final finishedList = finished
              .map((offer) => <String, dynamic>{
                    ...offer.toRpcJson(
                        forTaker: offer.makerPubkey != userPubkey),
                    'payment_system': _coordinatorService.paymentSystem.id,
                  })
              .toList();
          return {'offers': finishedList};

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
      final broadcastResponse = _ndk.broadcast.broadcast(
        nostrEvent: event,
        customSigner: _signer,
        specificRelays: _broadcastRelays,
        saveToCache: false,
      );
      await broadcastResponse.broadcastDoneFuture;
      await _clearEphemeralBroadcastTracking(event.id);
      _responsesSent++;

      AppLogger.info(
        'Sent RPC response id=${response.id ?? '-'} to=${_shortKey(recipientPubkey)}',
      );
    } catch (e) {
      _responseErrors++;
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
    await _requestListenerSub?.cancel();
    _requestListenerSub = null;
    if (_requestSubscription != null) {
      await _ndk.requests.closeSubscription(_requestSubscription!.requestId);
    }
    await _ndk.destroy();
  }

  /// Drop in-memory tracking entries for [offerId]. Called by the flow layer
  /// once an offer reaches a terminal state — terminal offers never broadcast
  /// again, so the monotonic-created_at guard is dead weight from here on.
  /// Keeps [_lastOfferEventCreatedAtById] bounded across the process lifetime.
  void forgetOfferTracking(String offerId) {
    _lastOfferEventCreatedAtById.remove(offerId);
  }

  Map<String, dynamic> debugSnapshot() => {
        'request_subscription_active': _requestSubscription != null,
        'request_listener_active': _requestListenerSub != null,
        'relay_refresh_timer_active': _relayRefreshTimer?.isActive ?? false,
        'relay_grace_timer_active': _relayGraceTimer?.isActive ?? false,
        'env_relay_count': _envRelays.length,
        'working_relay_count': _relays.length,
        'discovery_relay_count': _discoveryRelays.length,
        'grace_relay_count': _graceRelays.length,
        'offer_tracking_count': _lastOfferEventCreatedAtById.length,
        'requests_received': _requestsReceived,
        'responses_sent': _responsesSent,
        'response_errors': _responseErrors,
        'rpc_method_counts': Map<String, int>.from(_rpcMethodCounts),
        'ndk_runtime': _ndkRuntimeSnapshot(),
        'cache_event_count': _cacheManager.events.length,
        'cache_event_source_count': _cacheManager.eventSources.length,
        'cache_delivery_record_count':
            _cacheManager.eventDeliveryRecords.length,
        'cache_delivery_status_counts': _cacheDeliveryStatusCounts(),
        'cache_event_kind_counts': _cacheEventKindCounts(),
      };

  Map<String, int> _cacheEventKindCounts() {
    final counts = <String, int>{};
    for (final event in _cacheManager.events.values) {
      final key = event.kind.toString();
      counts.update(key, (count) => count + 1, ifAbsent: () => 1);
    }
    return counts;
  }

  Map<String, int> _cacheDeliveryStatusCounts() {
    final counts = <String, int>{};
    for (final record in _cacheManager.eventDeliveryRecords.values) {
      final key = record.status.name;
      counts.update(key, (count) => count + 1, ifAbsent: () => 1);
    }
    return counts;
  }

  Map<String, dynamic> _ndkRuntimeSnapshot() {
    final globalState = _ndk.relays.globalState;
    final requestStates = globalState.inFlightRequests.values.toList();
    final broadcastStates = globalState.inFlightBroadcasts.values.toList();
    final relayStates = globalState.relays.values.toList();

    final requestRelaySlots =
        requestStates.fold<int>(0, (sum, state) => sum + state.requests.length);
    final requestReturnedIds = requestStates.fold<int>(
        0, (sum, state) => sum + state.returnedIds.length);
    final requestSubscriptions =
        requestStates.where((state) => state.isSubscription).length;
    final requestOneShots = requestStates.length - requestSubscriptions;
    final requestDoneCount =
        requestStates.where((state) => state.didAllRequestsFinish).length;
    final requestControllerOpenCount =
        requestStates.where((state) => !state.controller.isClosed).length;
    final requestNetworkControllerOpenCount = requestStates
        .where((state) => !state.networkController.isClosed)
        .length;
    final requestCacheControllerOpenCount =
        requestStates.where((state) => !state.cacheController.isClosed).length;

    final broadcastRelaySlots = broadcastStates.fold<int>(
      0,
      (sum, state) => sum + state.broadcasts.length,
    );
    final broadcastDoneCount =
        broadcastStates.where((state) => state.publishDone).length;
    final broadcastControllerOpenCount = broadcastStates
        .where((state) => !state.networkController.isClosed)
        .length;

    final connectedRelayCount =
        relayStates.where((relay) => relay.isConnected).length;
    final connectingRelayCount =
        relayStates.where((relay) => relay.relay.connecting).length;
    final disconnectedRelayCount =
        relayStates.length - connectedRelayCount - connectingRelayCount;

    final relaySourceCounts = <String, int>{};
    for (final relay in relayStates) {
      final key = relay.relay.connectionSource.name;
      relaySourceCounts.update(key, (count) => count + 1, ifAbsent: () => 1);
    }

    return {
      'inflight_request_count': requestStates.length,
      'inflight_request_subscription_count': requestSubscriptions,
      'inflight_request_one_shot_count': requestOneShots,
      'inflight_request_done_count': requestDoneCount,
      'inflight_request_relay_slots': requestRelaySlots,
      'inflight_request_returned_ids': requestReturnedIds,
      'inflight_request_controller_open_count': requestControllerOpenCount,
      'inflight_request_network_controller_open_count':
          requestNetworkControllerOpenCount,
      'inflight_request_cache_controller_open_count':
          requestCacheControllerOpenCount,
      'inflight_broadcast_count': broadcastStates.length,
      'inflight_broadcast_done_count': broadcastDoneCount,
      'inflight_broadcast_relay_slots': broadcastRelaySlots,
      'inflight_broadcast_controller_open_count': broadcastControllerOpenCount,
      'inflight_negotiation_count': globalState.inFlightNegotiations.length,
      'relay_total_count': relayStates.length,
      'relay_connected_count': connectedRelayCount,
      'relay_connecting_count': connectingRelayCount,
      'relay_disconnected_count': disconnectedRelayCount,
      'blocked_relay_count': globalState.blockedRelays.length,
      'relay_connection_source_counts': relaySourceCounts,
    };
  }

  Future<void> _clearEphemeralBroadcastTracking(String eventId) async {
    await _cacheManager.removeRelayDeliveryTargets(eventId);
    await _cacheManager.removeEventDeliveryRecord(eventId);
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
    // Flow states declare the NIP-69 category in YAML. The raw/enum fallback
    // handles historical rows whose state is not present in the active flow.
    final status = _coordinatorService.nip69CategoryForRaw(offer.statusRaw) ??
        _mapRawStatusToNip69Status(offer.statusRaw, offer.status);
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
        // Bank the maker will withdraw at, for bank-scoped markets (SK). Lets
        // takers filter the feed to banks whose app they hold.
        if (offer.bankId != null && offer.bankId!.isNotEmpty)
          ['bank', offer.bankId!],
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
      if (_coordinatorService.isTerminalOffer(offer)) {
        _lastOfferEventCreatedAtById.remove(offer.id);
      }
      // AppLogger.info(
      //     'Broadcasted NIP-69 order event for offer ${offer.id}, status: ${status} id:${event.id}',
      //     offerId: offer.id);
    } catch (e) {
      AppLogger.info(
          'Error broadcasting NIP-69 order event for offer ${offer.id}: $e',
          offerId: offer.id);
    }
  }

  /// Rebroadcast all offers to update their status on Nostr relays.
  ///
  /// Runs slowly in the background: active offers go out first, and events
  /// are spaced [_rebroadcastSpacing] apart to respect shared-IP relay rate
  /// limits. Terminal-status offers are only a safety net (their addressable
  /// events normally already replaced the older state on the relays).
  Future<void> rebroadcastOffers(List<Offer> offers) async {
    AppLogger.info('Starting rebroadcast of ${offers.length} offers...');

    final ordered = [
      ...offers.where((o) => !_coordinatorService.isTerminalOffer(o)),
      ...offers.where((o) => _coordinatorService.isTerminalOffer(o)),
    ];

    try {
      for (final offer in ordered) {
        AppLogger.info(
            'Rebroadcasting offer ${offer.id} with status ${offer.status.name}',
            offerId: offer.id);
        // Calculate expiration if the offer is still active
        int? expiration;
        if (offer.status == OfferStatus.funded) {
          // The funded expiry comes from the YAML state definition.
          expiration = offer.createdAt
                  .add(Duration(
                      seconds: _coordinatorService.fundedExpirySeconds))
                  .millisecondsSinceEpoch ~/
              1000;
        }

        await broadcastNip69OrderFromOffer(
          offer,
          expiration: expiration,
        );

        await Future.delayed(_rebroadcastSpacing);
      }

      AppLogger.info('Completed rebroadcasting offers');
    } catch (e) {
      AppLogger.info('Error during rebroadcast of offers: $e');
    }
  }

  /// Map a raw status string to a NIP-69 status, covering generic
  /// (yaml-driven) state names that have no [OfferStatus] value. Falls back to
  /// the enum mapping when the raw name is a known enum value.
  String _mapRawStatusToNip69Status(String raw, OfferStatus enumStatus) {
    if (enumStatus != OfferStatus.unknown) {
      return _mapOfferStatusToNip69Status(enumStatus);
    }
    switch (raw) {
      case 'funded':
        return 'pending';
      case 'taker_paid':
        return 'success';
      case 'cancelled':
      case 'expired':
        return 'canceled';
      case 'dispute':
      case 'securingDispute':
      case 'payingMaker':
        return 'dispute';
      // reserved, twint_charged, expired_twint (retake-able), conflict, and any
      // other live generic state.
      default:
        return 'in-progress';
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
      case OfferStatus.refundingMaker:
        return 'dispute';
      case OfferStatus.unknown:
        // Coordinator never emits offers in `unknown` state — sentinel exists
        // only on the client side for forward-compat decoding.
        return 'canceled';
    }
  }
}
