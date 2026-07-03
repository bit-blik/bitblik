import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart' show activeOfferProvider;
import 'flow_controller.dart';

/// Renders the action buttons a [role] may take from [offer]'s current state,
/// derived from the flow yaml (`engine.userActionsFor`). One button per allowed
/// transition — so the UI can never offer an action the flow forbids, and it
/// updates automatically when the yaml changes.
///
/// Actions that need user input (e.g. entering a new code) supply a custom
/// widget via [overrides] keyed by event; everything else renders a default
/// button that fires the event with no extra params.
class FlowActionsBar extends ConsumerWidget {
  final Offer offer;
  final FlowEngine engine;
  final FlowActor role;

  /// event -> human label (falls back to a humanized event name).
  final Map<String, String> labels;

  /// event -> custom widget (for input-carrying actions). When present, the
  /// default button for that event is not rendered.
  final Map<String, Widget Function(FlowTransition)> overrides;

  /// event -> whether the default button should ask for confirmation first.
  final Set<String> confirmEvents;

  /// Events after which the user leaves the offer (e.g. a taker cancelling a
  /// reservation → the offer relists without them, and no status update reaches
  /// this ex-participant). On success we clear the active offer and return to
  /// the offer list.
  final Set<String> leaveEvents;

  const FlowActionsBar({
    super.key,
    required this.offer,
    required this.engine,
    required this.role,
    this.labels = const {},
    this.overrides = const {},
    this.confirmEvents = const {},
    this.leaveEvents = const {},
  });

  String _label(String event) =>
      labels[event] ??
      event
          .split('_')
          .map((w) => w.isEmpty ? w : '${w[0].toUpperCase()}${w.substring(1)}')
          .join(' ');

  Future<void> _fire(BuildContext context, WidgetRef ref, String event) async {
    if (confirmEvents.contains(event)) {
      final ok = await showDialog<bool>(
        context: context,
        builder: (c) => AlertDialog(
          content: Text('${_label(event)}?'),
          actions: [
            TextButton(
                onPressed: () => Navigator.pop(c, false),
                child: const Text('No')),
            TextButton(
                onPressed: () => Navigator.pop(c, true),
                child: const Text('Yes')),
          ],
        ),
      );
      if (ok != true) return;
    }
    try {
      await fireFlowAction(ref, offer, event);
      if (leaveEvents.contains(event)) {
        await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
        if (context.mounted) context.go('/offers');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final actions = engine.userActionsFor(offer.statusRaw, role);
    if (actions.isEmpty) return const SizedBox.shrink();
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final t in actions)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 6),
            child: overrides[t.event] != null
                ? overrides[t.event]!(t)
                : SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () => _fire(context, ref, t.event!),
                      child: Text(_label(t.event!)),
                    ),
                  ),
          ),
      ],
    );
  }
}
