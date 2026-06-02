import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';

/// A compact row of connection dots for a fixed set of relay [relays],
/// colored from the live [relayConnectivityProvider] (green=connected,
/// blue/orange=connecting/reconnecting, red=disconnected/unknown). Tapping
/// opens the relay-status overlay (same as the top-bar dots) unless an explicit
/// [onTap] is given.
class RelayDots extends ConsumerWidget {
  final Iterable<String> relays;
  final VoidCallback? onTap;
  final double size;

  /// Show a `connected/total` counter after the dots.
  final bool showCount;

  /// Title for the default tap overlay. Defaults to the generic "Relays".
  final String? overlayTitle;

  const RelayDots({
    super.key,
    required this.relays,
    this.onTap,
    this.size = 8,
    this.showCount = false,
    this.overlayTitle,
  });

  static Color colorFor(RelayConnectionState? state) {
    switch (state) {
      case RelayConnectionState.connected:
        return Colors.green;
      case RelayConnectionState.connecting:
        return Colors.blue;
      case RelayConnectionState.reconnecting:
        return Colors.orange;
      case RelayConnectionState.disconnected:
      case null:
        return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final conn = ref.watch(relayConnectivityProvider);
    final byNorm = <String, RelayStatus>{
      for (final e in conn.entries) normalizeRelayUrl(e.key): e.value,
    };

    // Status per requested relay; absent (not in NDK pool) = disconnected.
    final statuses = <String, RelayStatus>{};
    for (final relay in relays) {
      statuses[relay] = byNorm[normalizeRelayUrl(relay)] ??
          RelayStatus(url: relay, state: RelayConnectionState.disconnected);
    }

    final dots = <Widget>[];
    for (final status in statuses.values) {
      final color = colorFor(status.state);
      final isConnecting = status.state == RelayConnectionState.connecting ||
          status.state == RelayConnectionState.reconnecting;
      dots.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: isConnecting
              ? SizedBox(
                  width: size,
                  height: size,
                  child: CircularProgressIndicator(
                    strokeWidth: 1.5,
                    color: color,
                  ),
                )
              : Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: color,
                  ),
                ),
        ),
      );
    }

    if (showCount) {
      final connected = statuses.values.where((s) => s.isConnected).length;
      dots.add(const SizedBox(width: 4));
      dots.add(
        Text(
          '$connected/${statuses.length}',
          style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
        ),
      );
    }

    final row = Row(mainAxisSize: MainAxisSize.min, children: dots);
    final t = Translations.of(context);
    final ndk = ref.read(apiServiceProvider).ndk;
    final effectiveOnTap = onTap ??
        () => showRelayStatusOverlay(
              context,
              relays,
              title: overlayTitle ?? t.relays.title,
              onReconnect:
                  ndk == null ? null : () => ndk.connectivity.tryReconnect(),
            );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: effectiveOnTap,
      child: MouseRegion(cursor: SystemMouseCursors.click, child: row),
    );
  }
}

String _stateName(RelayConnectionState state, Translations t) {
  switch (state) {
    case RelayConnectionState.connected:
      return t.relays.status.connected;
    case RelayConnectionState.connecting:
      return t.relays.status.connecting;
    case RelayConnectionState.reconnecting:
      return t.relays.status.reconnecting;
    case RelayConnectionState.disconnected:
      return t.relays.status.disconnected;
  }
}

/// Top-right relay-status overlay listing each of [relayUrls] with its live
/// connection state, under [title]. The list is rebuilt reactively from
/// [relayConnectivityProvider] (via a [Consumer]) so it updates while open —
/// e.g. after tapping the reconnect button. Shared by the top-bar indicator
/// and the coordinator management screen.
void showRelayStatusOverlay(
  BuildContext context,
  Iterable<String> relayUrls, {
  required String title,
  VoidCallback? onReconnect,
}) {
  final t = Translations.of(context);
  final urls = relayUrls.toList();

  showDialog(
    context: context,
    barrierColor: Colors.transparent,
    builder: (dialogContext) {
      return Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(dialogContext).pop(),
              child: Container(color: Colors.transparent),
            ),
          ),
          Positioned(
            top: kToolbarHeight + MediaQuery.of(context).padding.top + 8,
            right: 16,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(8),
              color: Colors.white,
              child: Container(
                padding: const EdgeInsets.all(12),
                constraints: const BoxConstraints(maxWidth: 280),
                child: Consumer(
                  builder: (context, ref, _) {
                    final conn = ref.watch(relayConnectivityProvider);
                    final byNorm = <String, RelayStatus>{
                      for (final e in conn.entries)
                        normalizeRelayUrl(e.key): e.value,
                    };
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                            if (onReconnect != null)
                              InkWell(
                                onTap: onReconnect,
                                borderRadius: BorderRadius.circular(16),
                                child: const Padding(
                                  padding: EdgeInsets.all(4),
                                  child: Icon(
                                    Icons.refresh,
                                    size: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        ...urls.map((url) {
                          final state = (byNorm[normalizeRelayUrl(url)])?.state ??
                              RelayConnectionState.disconnected;
                          final shortUrl = url
                              .replaceFirst('wss://', '')
                              .replaceFirst('ws://', '');
                          final stateColor = RelayDots.colorFor(state);
                          final stateName = _stateName(state, t);
                          final isConnecting =
                              state == RelayConnectionState.connecting ||
                                  state == RelayConnectionState.reconnecting;

                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (isConnecting)
                                  SizedBox(
                                    width: 12,
                                    height: 12,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: stateColor,
                                    ),
                                  )
                                else
                                  Container(
                                    width: 12,
                                    height: 12,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: stateColor,
                                    ),
                                  ),
                                const SizedBox(width: 8),
                                Flexible(
                                  child: Text(
                                    shortUrl,
                                    style: const TextStyle(fontSize: 13),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  stateName,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: stateColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      );
    },
  );
}
