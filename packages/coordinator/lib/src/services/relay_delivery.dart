import 'dart:async';

import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/broadcast_state.dart';

/// Complete on the first positive relay ACK, not the slowest relay. NDK's
/// completion future also persists delivery tracking, so cleanup must wait for
/// that future even when the caller has already continued.
Future<void> awaitRelayAcceptance(
  NdkBroadcastResponse broadcast, {
  Duration timeout = const Duration(seconds: 3),
  required Future<void> Function() onAcceptedSettled,
  required void Function(Object error) onBackgroundError,
}) async {
  final accepted = Completer<void>();
  var sawAcceptance = false;
  StreamSubscription<List<RelayBroadcastResponse>>? updates;

  void observe(List<RelayBroadcastResponse> results) {
    if (results.any((result) => result.broadcastSuccessful)) {
      sawAcceptance = true;
      if (!accepted.isCompleted) accepted.complete();
    }
  }

  // The pinned NDK uses a broadcast state stream. Single-subscription adapters
  // may already consume it in broadcastDoneFuture; use their final results.
  if (broadcast.broadcastDone.isBroadcast) {
    updates = broadcast.broadcastDone
        .listen(observe, onError: (Object error) => onBackgroundError(error));
  }
  unawaited(broadcast.broadcastDoneFuture.then<void>((results) async {
    observe(results);
    if (sawAcceptance) {
      await onAcceptedSettled();
    } else {
      requireRelayAcceptance(results);
    }
  }).catchError((Object error) {
    if (!accepted.isCompleted) {
      accepted.completeError(error);
    } else {
      onBackgroundError(error);
    }
  }));

  try {
    await accepted.future.timeout(timeout);
  } finally {
    final subscription = updates;
    if (subscription != null) {
      unawaited(subscription.cancel().catchError(onBackgroundError));
    }
  }
}

/// A completed broadcast future can contain only rejections/timeouts. Keep
/// pending-delivery tracking in that case instead of claiming success.
void requireRelayAcceptance(List<RelayBroadcastResponse> results) {
  if (results.any((result) => result.broadcastSuccessful)) return;
  throw StateError('No relay accepted the event: '
      '${results.map((result) => '${result.relayUrl}: ${result.msg}').join(', ')}');
}
