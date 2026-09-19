import 'dart:async';
import 'dart:math';

import 'package:ndk/ndk.dart';

import '../constants/kinds.dart';
import '../constants/relays.dart';
import 'protocol_codec.dart';
import 'rpc_envelope.dart';
import 'subscription_readiness.dart';

const Duration kRelayRequestGrace = Duration(seconds: 3);

/// A timeout is not proof that the coordinator was offline. Keep transport
/// evidence separate so callers do not penalize it for local/relay failures.
class RpcTimeoutException extends TimeoutException {
  final String method;
  final String stage;
  final bool relayAccepted;
  final bool responsePathAvailable;

  RpcTimeoutException({
    required this.method,
    required this.stage,
    required this.relayAccepted,
    required this.responsePathAvailable,
    required Duration duration,
    Object? cause,
  }) : super(
            'Bitblik RPC $method timed out during $stage'
            '${cause == null ? '' : ': $cause'}',
            duration);

  bool get coordinatorResponseMissing => relayAccepted && responsePathAvailable;
}

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
  EventSigner _signer;
  EventSigner get signer => _signer;

  /// Initial/bootstrap relays for the response subscription and the default
  /// broadcast target. Per-coordinator routing overrides the broadcast target
  /// via [send]'s `relays`, and the response subscription via
  /// [updateResponseRelays].
  final List<String> relays;
  final Duration timeout;

  final Map<String, _PendingRpcRequest> _pending = {};
  final Random _random = Random.secure();
  NdkResponse? _subscription;
  final Map<String, StreamSubscription<Nip01Event>> _listeners = {};
  final Set<String> _retiredSubscriptions = {};
  Timer? _subscriptionRetry;
  bool _stopped = false;
  Future<void>? _rebindInFlight;
  Future<void> _responseRelayUpdates = Future.value();
  final Map<String, List<String>> _activeRequestRelays = {};
  late Set<String> _configuredResponseRelays = relays.toSet();

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
    required EventSigner signer,
    required this.relays,
    this.timeout = const Duration(seconds: 5),
    this.subscriptionName = 'bitblik-rpc-responses',
    this.clientId,
  }) : _signer = signer;

  /// Subscribe to incoming responses. Must be called before [send].
  Future<void> start() async {
    _stopped = false;
    await _syncResponseRelays();
  }

  /// Switches the client identity without replacing the shared [Ndk] instance.
  ///
  /// Existing requests are allowed to finish with the old signer. New sends
  /// wait until the response subscription has been reopened for [newSigner].
  Future<void> rebindSigner(EventSigner newSigner) async {
    final existing = _rebindInFlight;
    if (existing != null) {
      await existing;
      if (signer.getPublicKey() == newSigner.getPublicKey()) return;
    }
    if (signer.getPublicKey() == newSigner.getPublicKey()) return;

    final operation = _performSignerRebind(newSigner);
    _rebindInFlight = operation;
    try {
      await operation;
    } finally {
      if (identical(_rebindInFlight, operation)) _rebindInFlight = null;
    }
  }

  Future<void> _performSignerRebind(EventSigner newSigner) async {
    final deadline = DateTime.now().add(timeout + kRelayRequestGrace);
    while (_pending.isNotEmpty && DateTime.now().isBefore(deadline)) {
      await Future<void>.delayed(const Duration(milliseconds: 25));
    }
    if (_pending.isNotEmpty) {
      throw StateError(
        'Cannot switch the RPC signer while requests are still pending.',
      );
    }

    await stop();
    _signer = newSigner;
    await start();
  }

  Future<void> _openSubscription(List<String> relays) async {
    final filter = Filter(
      kinds: [kKindCoordinatorResponse],
      pTags: [signer.getPublicKey()],
      // Ephemeral responses need no history filter. A relay/coordinator clock
      // behind ours must not silently filter a live reply.
    );
    _subscription = ndk.requests.subscription(
      name: subscriptionName,
      filter: filter,
      explicitRelays: relays,
    );
    final subscription = _subscription!;
    void interrupted() {
      if (_stopped || !identical(_subscription, subscription)) return;
      _subscription = null;
      _retiredSubscriptions.add(subscription.requestId);
      _subscriptionRetry?.cancel();
      _subscriptionRetry = Timer(const Duration(seconds: 1), () {
        if (!_stopped) {
          unawaited(_syncResponseRelays().catchError((Object error) {
            Logger.log
                .w(() => 'RPC response subscription recovery failed: $error');
          }));
        }
      });
    }

    _listeners[subscription.requestId] = subscription.stream.listen(
      _onResponse,
      onError: (Object error) {
        Logger.log.w(() => 'RPC response subscription interrupted: $error');
        interrupted();
      },
      onDone: interrupted,
    );
    _responseRelays = List.from(relays);
  }

  /// Re-point the response subscription at [relays] (the union of the relays
  /// of all coordinators we expect to hear from). No-op when the set is
  /// unchanged. Falls back to the bootstrap [relays] when [relays] is empty so
  /// the client is never left without a subscription.
  Future<void> updateResponseRelays(Set<String> relays) async {
    _configuredResponseRelays =
        relays.isEmpty ? this.relays.toSet() : Set.of(relays);
    await _syncResponseRelays();
  }

  Future<void> _syncResponseRelays() {
    // Serialize replacements and compute the union when the update runs, so
    // concurrent sends cannot overwrite one another's relay additions.
    final update = _responseRelayUpdates.then((_) => _applyResponseRelays());
    _responseRelayUpdates = update.then<void>((_) {}, onError: (Object _) {});
    return update;
  }

  Future<void> _applyResponseRelays() async {
    if (_stopped) return;
    final target = <String>{
      ..._configuredResponseRelays,
      for (final relays in _activeRequestRelays.values) ...relays,
    };
    final current = _responseRelays.toSet();
    if (_subscription != null &&
        current.containsAll(target) &&
        (target.length == current.length || _pending.isNotEmpty)) {
      await _closeRetiredSubscriptions();
      return;
    }
    final previous = _subscription;
    // Listen before closing the old subscription, including while health
    // probes for disabled coordinators are still waiting for replies.
    await _openSubscription(target.toList(growable: false));
    if (previous != null) {
      _retiredSubscriptions.add(previous.requestId);
    }
    // Keep old listeners through in-flight calls. Opening an NDK subscription
    // is synchronous; its REQ may not yet have reached the relay.
    await _closeRetiredSubscriptions();
  }

  Future<void> _closeRetiredSubscriptions() async {
    if (_pending.isNotEmpty) return;
    for (final id in _retiredSubscriptions.toList()) {
      await _listeners.remove(id)?.cancel();
      await ndk.requests.closeSubscription(id);
      _retiredSubscriptions.remove(id);
    }
  }

  /// Close the response subscription. Pending request futures will hang until
  /// their timeout fires — callers should ensure no in-flight requests remain.
  Future<void> stop() async {
    _stopped = true;
    _subscriptionRetry?.cancel();
    await _responseRelayUpdates;
    final ids = {
      ..._retiredSubscriptions,
      if (_subscription != null) _subscription!.requestId
    };
    _subscription = null;
    for (final id in ids) {
      await _listeners.remove(id)?.cancel();
      await ndk.requests.closeSubscription(id);
    }
    _retiredSubscriptions.clear();
  }

  /// Send an encrypted request to [coordinatorPubkey] and await the matching
  /// response. One deadline covers setup, publication and response processing:
  /// [timeout] (or [timeoutOverride]) plus [kRelayRequestGrace] for transport.
  Future<NostrResponse> send(
    NostrRequest request,
    String coordinatorPubkey, {
    Duration? timeoutOverride,
    List<String>? relays,
  }) async {
    final effectiveTimeout = timeoutOverride ?? timeout;
    final budget = effectiveTimeout + kRelayRequestGrace;
    final clock = Stopwatch()..start();
    var stage = 'signer';
    Object? broadcastFailure;
    var relayAccepted = false;
    List<String> responseTargets = const [];
    StreamSubscription? broadcastUpdates;
    RpcTimeoutException deadlineError() => RpcTimeoutException(
          method: request.method,
          stage: stage,
          relayAccepted: relayAccepted,
          responsePathAvailable: _subscription != null &&
              subscriptionHasOpenTransport(
                  ndk, _subscription!.requestId, responseTargets),
          duration: budget,
          cause: broadcastFailure,
        );
    Duration remaining() {
      final value = budget - clock.elapsed;
      if (value <= Duration.zero) throw deadlineError();
      return value;
    }

    final rebind = _rebindInFlight;
    if (rebind != null) {
      await rebind.timeout(remaining(), onTimeout: () => throw deadlineError());
    }

    final targetRelays =
        (relays == null || relays.isEmpty) ? this.relays : relays;
    // A connected socket can reject/rate-limit publication. Keep all known
    // routes: NDK sends in parallel and a valid reply already wins over slow
    // ACKs, so dropping a disconnected-but-usable route gains nothing.
    final broadcastRelays =
        targetRelays.map(normalizeRelayUrl).toSet().toList();
    responseTargets = broadcastRelays;
    final id = request.id ?? _nextId();
    if (_pending.containsKey(id)) {
      throw StateError('RPC request $id is already in flight.');
    }
    final reqWithId = NostrRequest(
      method: request.method,
      params: request.params,
      id: id,
      client: request.client ?? clientId,
    );

    final completer = Completer<NostrResponse>();
    _pending[id] = _PendingRpcRequest(
      completer: completer,
      coordinatorPubkey: coordinatorPubkey,
    );
    // Pin before awaiting subscription changes. Registry updates may narrow
    // configured relays to enabled coordinators during a bulk health check.
    _activeRequestRelays[id] = broadcastRelays;

    try {
      stage = 'response subscription';
      await _syncResponseRelays().timeout(
        remaining(),
        onTimeout: () => throw deadlineError(),
      );
      final subscription = _subscription;
      if (subscription == null) {
        throw StateError('RPC response listener is unavailable.');
      }
      try {
        await awaitSubscriptionSent(
            ndk, subscription.requestId, broadcastRelays, remaining());
      } on TimeoutException {
        throw deadlineError();
      }
      stage = 'encryption';
      final event = await ProtocolCodec.encryptRequestWithSigner(
        request: reqWithId,
        signer: signer,
        coordinatorPubkey: coordinatorPubkey,
      ).timeout(remaining(), onTimeout: () => throw deadlineError());
      stage = 'publication/response';
      final broadcastResponse = ndk.broadcast.broadcast(
        nostrEvent: event,
        customSigner: signer,
        specificRelays: broadcastRelays,
        timeout: remaining(),
        saveToCache: false,
      );
      // NDK's stream reports each relay result; its future additionally waits
      // for every relay and delivery bookkeeping. Health needs early evidence.
      // Some adapters expose a single-subscription stream already consumed by
      // their completion future. Those adapters provide final evidence only.
      if (broadcastResponse.broadcastDone.isBroadcast) {
        broadcastUpdates = broadcastResponse.broadcastDone.listen((results) {
          if (results.any((result) => result.broadcastSuccessful)) {
            relayAccepted = true;
            stage = 'coordinator response';
          }
        }, onError: (Object error) {
          broadcastFailure = error;
        });
      }
      // A coordinator response proves delivery. A slow relay ACK or cache
      // write must never delay or invalidate it. Consume late broadcast errors
      // as well, including after this request has already completed.
      unawaited(broadcastResponse.broadcastDoneFuture.then<void>((results) {
        if (results.any((result) => result.broadcastSuccessful)) {
          relayAccepted = true;
          stage = 'coordinator response';
        } else {
          broadcastFailure = StateError('No relay accepted the RPC request: '
              '${results.map((r) => '${r.relayUrl}: ${r.msg}').join(', ')}');
        }
      }, onError: (Object error) {
        broadcastFailure = error;
      }));
      return await completer.future.timeout(
        remaining(),
        onTimeout: () => throw deadlineError(),
      );
    } finally {
      final updates = broadcastUpdates;
      if (updates != null) {
        unawaited(updates.cancel().catchError((Object _) {}));
      }
      _pending.remove(id);
      _activeRequestRelays.remove(id);
      // Releasing a temporary relay must not turn a successful RPC into an
      // error if subscription cleanup fails; the next update retries it.
      unawaited(_syncResponseRelays().catchError((Object _) {}));
    }
  }

  Future<void> _onResponse(Nip01Event event) async {
    try {
      final response =
          await ProtocolCodec.decryptResponseWithSigner(event, signer);
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
