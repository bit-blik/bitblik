import 'dart:async';

import 'package:ndk/ndk.dart';

/// Guarantees websocket transports to relays are actually reconnected after the
/// app returns to the foreground.
///
/// iOS PWA problem: when the PWA is backgrounded, iOS freezes the event loop and
/// silently tears down the underlying TCP sockets. On resume, the
/// `web_socket_client` transport still reports itself `Connected`/`Reconnected`
/// (so `isOpen()` returns true) even though the socket is dead — a zombie. Any
/// data sent in that window is lost, and `Ndk.connectivity.tryReconnect()` alone
/// does NOT help because it skips relays whose `isConnected` (i.e. `isOpen()`)
/// lies as true.
///
/// [forceReconnect] closes every relay transport first — `resetTransport` nulls
/// `relayTransport` so `isConnected` becomes false while keeping the relay entry
/// and metadata — then calls `tryReconnect()`, which now actually redials the
/// relays on fresh sockets and re-subscribes in-flight subscriptions.
///
/// [ensureReady] lets send paths await any in-flight reconnect before writing,
/// so on foreground we never publish onto a zombie socket.
class RelayReconnectGate {
  RelayReconnectGate._();

  static final RelayReconnectGate instance = RelayReconnectGate._();

  Completer<void>? _inFlight;

  /// Awaited by send paths before writing data. Returns immediately when no
  /// reconnect is running; otherwise blocks (bounded by [timeout]) until the
  /// in-flight foreground reconnect settles.
  Future<void> ensureReady({
    Duration timeout = const Duration(seconds: 8),
  }) async {
    final c = _inFlight;
    if (c == null || c.isCompleted) return;
    try {
      await c.future.timeout(timeout);
    } on TimeoutException {
      // Proceed anyway; the caller's own send/RPC timeout still applies.
      Logger.log.w(
        () => '[RelayReconnectGate] ensureReady timed out after $timeout',
      );
    }
  }

  /// Hard-resets all relay transports then reconnects. Deduped: concurrent
  /// callers share the same in-flight future, so multiple resume/focus events
  /// collapse into a single reconnect cycle.
  Future<void> forceReconnect(Ndk ndk) {
    final existing = _inFlight;
    if (existing != null && !existing.isCompleted) return existing.future;

    final completer = Completer<void>();
    _inFlight = completer;
    unawaited(
      _run(ndk).whenComplete(() {
        if (!completer.isCompleted) completer.complete();
        if (identical(_inFlight, completer)) _inFlight = null;
      }),
    );
    return completer.future;
  }

  Future<void> _run(Ndk ndk) async {
    try {
      // 1. Kill zombie sockets. resetTransport closes the transport and nulls
      //    relayTransport (so isConnected becomes false), but keeps the relay
      //    entry + metadata so tryReconnect below will actually redial them.
      final urls =
          ndk.relays.globalState.relays.keys.map((key) => key.url).toSet();
      for (final url in urls) {
        try {
          await ndk.relays.resetTransport(url);
        } catch (e) {
          Logger.log.w(
            () => '[RelayReconnectGate] resetTransport $url failed: $e',
          );
        }
      }
      // 2. Reconnect on fresh sockets + re-subscribe in-flight subscriptions.
      await ndk.connectivity.tryReconnect();
    } catch (e) {
      Logger.log.w(() => '[RelayReconnectGate] forceReconnect failed: $e');
    }
  }
}
