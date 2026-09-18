import 'dart:async';
import 'dart:collection';

import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';

/// Supervises the ephemeral RPC listener without replaying financial actions.
/// A replacement REQ must be sent before the old subscription is removed.
class CoordinatorRequestListener {
  final Requests requests;
  final String pubkey;
  final Future<void> Function(Nip01Event) onRequest;
  final void Function(Object) onError;
  final Future<void> Function(
      String requestId, List<String> relays, Duration timeout) waitUntilSent;
  final Duration readyTimeout;
  final Duration retryDelay;
  final _recent = LinkedHashSet<String>();
  final _processing = <String>{};
  Future<void> _updates = Future.value();
  NdkResponse? _response;
  StreamSubscription<Nip01Event>? _listener;
  Timer? _retry;
  List<String> _desired = [];
  bool _closed = false;
  bool _healthy = false;

  CoordinatorRequestListener({
    required this.requests,
    required this.pubkey,
    required this.onRequest,
    required this.onError,
    required this.waitUntilSent,
    this.readyTimeout = const Duration(seconds: 6),
    this.retryDelay = const Duration(seconds: 5),
  });

  bool get isActive => _healthy && _response != null && _listener != null;

  Future<void> replace(List<String> relays) {
    if (_closed) return Future.value();
    _desired = List.of(relays);
    final update = _updates.then((_) => _replace());
    _updates = update.then<void>((_) {}, onError: (Object error) {
      onError(error);
      _scheduleRetry();
    });
    return _updates;
  }

  Future<void> _replace() async {
    if (_closed) return;
    _retry?.cancel();
    final next = requests.subscription(
      name: 'coordinator-requests',
      filter: Filter(
        kinds: [kKindCoordinatorRequest],
        pTags: [pubkey],
        // Allow modest clock skew without inviting unbounded request history
        // from non-compliant relays that retain ephemeral events.
        since: DateTime.now().millisecondsSinceEpoch ~/ 1000 - 30,
      ),
      explicitRelays: _desired,
    );
    var interrupted = false;
    void interruption([Object? error]) {
      interrupted = true;
      if (error != null) onError(error);
      if (identical(_response, next)) {
        _healthy = false;
        // Keep the handle until replacement/disposal cleans it up.
        _scheduleRetry();
      }
    }

    final listener = next.stream.listen(_dispatch,
        onError: (Object error) => interruption(error), onDone: interruption);
    try {
      await waitUntilSent(next.requestId, _desired, readyTimeout);
      if (_closed || interrupted) {
        throw StateError('Coordinator request subscription ended before ready');
      }
    } catch (_) {
      await listener.cancel();
      await requests.closeSubscription(next.requestId);
      rethrow;
    }
    final previous = _response;
    final previousListener = _listener;
    _response = next;
    _listener = listener;
    _healthy = true;
    await previousListener?.cancel();
    if (previous != null) await requests.closeSubscription(previous.requestId);
  }

  void _scheduleRetry() {
    if (_closed || (_retry?.isActive ?? false)) return;
    _retry = Timer(retryDelay, () => unawaited(replace(_desired)));
  }

  void _dispatch(Nip01Event event) {
    // Overlapping subscriptions may deliver the same signed event twice.
    // Bound completed-event memory; never evict an in-flight operation.
    if (_closed || _recent.contains(event.id) || !_processing.add(event.id)) {
      return;
    }
    unawaited(Future.sync(() => onRequest(event)).then<void>((_) {
      _recent.add(event.id);
      if (_recent.length > 4096) _recent.remove(_recent.first);
    }, onError: onError).whenComplete(() => _processing.remove(event.id)));
  }

  Future<void> close() async {
    _closed = true;
    _healthy = false;
    _retry?.cancel();
    await _updates;
    await _listener?.cancel();
    _listener = null;
    final response = _response;
    _response = null;
    if (response != null) await requests.closeSubscription(response.requestId);
    _recent.clear();
  }
}
