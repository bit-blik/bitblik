import 'dart:async';
import 'dart:math';

import 'package:ndk/ndk.dart';

import '../constants/kinds.dart';
import '../constants/relays.dart';
import 'protocol_codec.dart';
import 'rpc_envelope.dart';

const Duration kRelayRequestGrace = Duration(seconds: 3);

/// Client-side transport for the Bitblik JSON-RPC over Nostr.
///
/// Owns:
///   - the subscription to kind [kKindCoordinatorResponse] events tagged for
///     this client's pubkey,
///   - the id→Completer table that matches incoming responses to outgoing
///     requests,
///   - request id generation and timeout enforcement.
///
/// Does **not** own NDK lifecycle, relay configuration, or the signer — those
/// are supplied by the caller so app, cli, and future agents can plug in their
/// own connection management without forking transport logic.
class BitblikRpcClient {
  final Ndk ndk;
  final Bip340EventSigner signer;

  /// Initial/bootstrap relays for the response subscription and the default
  /// broadcast target. Per-coordinator routing overrides the broadcast target
  /// via [send]'s `relays`, and the response subscription via
  /// [updateResponseRelays].
  final List<String> relays;
  final Duration timeout;

  final Map<String, _PendingRpcRequest> _pending = {};
  final Random _random = Random.secure();
  NdkResponse? _subscription;

  /// Relays the current response subscription listens on. Starts as [relays].
  late List<String> _responseRelays = List.from(relays);

  /// Optional name suffix for the relay subscription (helps debugging when
  /// multiple clients share an NDK instance).
  final String subscriptionName;

  /// Client identifier stamped onto every outgoing request as
  /// `NostrRequest.client` (e.g. `app-bitblik-android/0.8.0`,
  /// `cli-bitway-linux/0.1.0`). The coordinator records this so it knows which
  /// client build issued each request. A per-request `client` (rarely set)
  /// takes precedence over this default.
  final String? clientId;

  BitblikRpcClient({
    required this.ndk,
    required this.signer,
    required this.relays,
    this.timeout = const Duration(seconds: 5),
    this.subscriptionName = 'bitblik-rpc-responses',
    this.clientId,
  });

  /// Subscribe to incoming responses. Must be called before [send].
  Future<void> start() async {
    await _openSubscription(_responseRelays);
  }

  Future<void> _openSubscription(List<String> relays) async {
    final filter = Filter(
      kinds: [kKindCoordinatorResponse],
      pTags: [signer.getPublicKey()],
      since: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
    _subscription = ndk.requests.subscription(
      name: subscriptionName,
      filter: filter,
      explicitRelays: relays,
    );
    _subscription!.stream.listen(_onResponse);
    _responseRelays = List.from(relays);
  }

  /// Re-point the response subscription at [relays] (the union of the relays
  /// of all coordinators we expect to hear from). No-op when the set is
  /// unchanged. Falls back to the bootstrap [relays] when [relays] is empty so
  /// the client is never left without a subscription.
  Future<void> updateResponseRelays(Set<String> relays) async {
    final target = relays.isEmpty ? this.relays.toSet() : relays;
    final current = _responseRelays.toSet();
    if (_subscription != null &&
        target.length == current.length &&
        target.containsAll(current)) {
      return;
    }
    if (_subscription != null) {
      await ndk.requests.closeSubscription(_subscription!.requestId);
      _subscription = null;
    }
    await _openSubscription(target.toList(growable: false));
  }

  /// Close the response subscription. Pending request futures will hang until
  /// their timeout fires — callers should ensure no in-flight requests remain.
  Future<void> stop() async {
    if (_subscription != null) {
      await ndk.requests.closeSubscription(_subscription!.requestId);
      _subscription = null;
    }
  }

  /// Send an encrypted request to [coordinatorPubkey] and await the matching
  /// response. Throws [TimeoutException] after [timeout] (or [timeoutOverride]) elapses.
  Future<NostrResponse> send(
    NostrRequest request,
    String coordinatorPubkey, {
    Duration? timeoutOverride,
    List<String>? relays,
  }) async {
    final targetRelays =
        (relays == null || relays.isEmpty) ? this.relays : relays;
    final effectiveTimeout = timeoutOverride ?? timeout;
    // Prefer relays that are currently connected to avoid paying a connect
    // timeout on dead relays. Fall back to the full set when none are
    // connected, so NDK still attempts to (re)connect and we never end up
    // broadcasting to nothing.
    final connected = _connectedAmong(targetRelays);
    final broadcastRelays = connected.isNotEmpty ? connected : targetRelays;
    final id = request.id ?? _nextId();
    final reqWithId = NostrRequest(
      method: request.method,
      params: request.params,
      id: id,
      client: request.client ?? clientId,
    );

    // Ensure we are listening for the response on the relays we are about to
    // broadcast to. Per-coordinator routing may target relays the current
    // subscription doesn't cover (e.g. a freshly discovered coordinator);
    // expanding here removes the race between discovery and the app's
    // [updateResponseRelays] call.
    final needed = broadcastRelays.toSet();
    if (!_responseRelays.toSet().containsAll(needed)) {
      await updateResponseRelays(_responseRelays.toSet()..addAll(needed));
    }

    final completer = Completer<NostrResponse>();
    _pending[id] = _PendingRpcRequest(
      completer: completer,
      coordinatorPubkey: coordinatorPubkey,
    );

    try {
      final event = await ProtocolCodec.encryptRequest(
        request: reqWithId,
        senderPrivateKeyHex: signer.privateKey!,
        senderPubkeyHex: signer.getPublicKey(),
        coordinatorPubkey: coordinatorPubkey,
      );
      final broadcastResponse = ndk.broadcast.broadcast(
        nostrEvent: event,
        customSigner: signer,
        specificRelays: broadcastRelays,
      );
      final relayResults = await broadcastResponse.broadcastDoneFuture.timeout(
        effectiveTimeout + kRelayRequestGrace,
        onTimeout: () => throw TimeoutException(
          'Bitblik RPC broadcast timed out',
          effectiveTimeout + kRelayRequestGrace,
        ),
      );
      final anyRelayAccepted = relayResults.any(
        (response) => response.broadcastSuccessful,
      );
      if (!anyRelayAccepted) {
        final details = relayResults
            .map((response) => '${response.relayUrl}: ${response.msg}')
            .join(', ');
        throw StateError(
          'Failed to broadcast RPC request to relays: $details',
        );
      }

      return await completer.future.timeout(
        effectiveTimeout,
        onTimeout: () {
          _pending.remove(id);
          throw TimeoutException(
            'Bitblik RPC request timed out',
            effectiveTimeout,
          );
        },
      );
    } catch (_) {
      _pending.remove(id);
      rethrow;
    }
  }

  /// Subset of [urls] whose relay is currently connected in NDK's pool.
  /// Matches on normalized URLs (NDK may store a cleaned form).
  List<String> _connectedAmong(List<String> urls) {
    final connected = <String>{};
    ndk.relays.globalState.relays.forEach((url, rc) {
      try {
        if (rc.isConnected) connected.add(normalizeRelayUrl(url.url));
      } catch (_) {}
    });
    return urls
        .where((u) => connected.contains(normalizeRelayUrl(u)))
        .toList(growable: false);
  }

  Future<void> _onResponse(Nip01Event event) async {
    try {
      final response = await ProtocolCodec.decryptResponse(
        event,
        signer.privateKey!,
      );
      final id = response.id;
      if (id == null) return;
      final pending = _pending[id];
      if (pending == null) return;
      if (event.pubKey != pending.coordinatorPubkey) {
        return;
      }
      _pending.remove(id);
      if (!pending.completer.isCompleted) {
        pending.completer.complete(response);
      }
    } catch (_) {
      // Malformed/foreign response — ignore.
    }
  }

  String _nextId() {
    final bytes = List<int>.generate(16, (_) => _random.nextInt(256));
    return bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();
  }
}

class _PendingRpcRequest {
  final Completer<NostrResponse> completer;
  final String coordinatorPubkey;

  const _PendingRpcRequest({
    required this.completer,
    required this.coordinatorPubkey,
  });
}
