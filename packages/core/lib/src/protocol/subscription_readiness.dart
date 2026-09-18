import 'dart:async';

import 'package:ndk/ndk.dart';

import '../constants/relays.dart';

bool subscriptionHasOpenTransport(
    Ndk ndk, String requestId, Iterable<String> relays) {
  final targets = relays.map(normalizeRelayUrl).toSet();
  return ndk.relays.globalState.relays.values.any((relay) =>
      targets.contains(normalizeRelayUrl(relay.url)) &&
      relay.isConnected &&
      relay.stats.openRequestIds.contains(requestId));
}

/// Wait until this exact REQ has been sent on a connected target transport.
///
/// Pinned NDK does not expose EOSE for live subscriptions (only for queries).
/// Its per-connection openRequestIds is updated after transport.send and cleared
/// on socket loss/CLOSED. Checking it avoids publishing before the reply REQ,
/// without treating any unrelated connection or a merely allocated REQ as ready.
/// This is a local send barrier, not proof of remote AUTH/REQ acceptance.
Future<void> awaitSubscriptionSent(
  Ndk ndk,
  String requestId,
  Iterable<String> relays,
  Duration timeout,
) async {
  final targets = relays.map(normalizeRelayUrl).toSet();
  final clock = Stopwatch()..start();
  while (true) {
    if (subscriptionHasOpenTransport(ndk, requestId, targets)) return;
    final remaining = timeout - clock.elapsed;
    if (remaining <= Duration.zero) {
      throw TimeoutException(
          'Response/request subscription was not sent on a target relay',
          timeout);
    }
    await Future<void>.delayed(remaining < const Duration(milliseconds: 20)
        ? remaining
        : const Duration(milliseconds: 20));
  }
}
