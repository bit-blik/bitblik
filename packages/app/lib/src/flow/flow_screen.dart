import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart' show activeOfferProvider;
import 'flow_actions_bar.dart';
import 'flow_controller.dart';
import 'flow_provider.dart';
import 'flow_timeout.dart';
import 'twint_bodies.dart';

/// Generic fallback body for any (state, role) without a bespoke widget: a
/// humanized state title, basic offer details, the yaml-timeout countdown, the
/// role's allowed actions, and a spinner for transient "waiting on coordinator"
/// states (non-terminal, no actions — e.g. `payingTaker`). Guarantees every
/// state renders sensibly, and is what BLIK will use for most states when it is
/// migrated onto the flow-driven UI.
final FlowBody genericFlowBody = (context, ref, offer, engine, role) {
  final state = offer.statusRaw;
  final humanized = state
      .replaceAllMapped(RegExp('([A-Z])'), (m) => ' ${m[1]}')
      .replaceAll('_', ' ')
      .trim();
  final title =
      humanized.isEmpty ? state : '${humanized[0].toUpperCase()}${humanized.substring(1)}';
  final actions = engine.userActionsFor(state, role);
  final terminal = engine.isTerminal(state);
  final hasTimeout = flowStateDeadline(engine, state, offer) != null;
  // A transient auto-driven state (coordinator advances it) with nothing for the
  // user to do and no countdown → show progress.
  final waiting = !terminal && actions.isEmpty && !hasTimeout;

  Widget row(String label, String value) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
            Text(value,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
          ],
        ),
      );

  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center),
          const SizedBox(height: 20),
          row('Amount', '${offer.fiatAmount} ${offer.fiatCurrency}'),
          if ((offer.blikCode ?? '').isNotEmpty) row('Code', offer.blikCode!),
          if (waiting) ...[
            const SizedBox(height: 24),
            const CircularProgressIndicator(),
          ],
          flowCountdownFor(context, engine, offer, caption: 'Auto-advances'),
          const SizedBox(height: 24),
          FlowActionsBar(offer: offer, engine: engine, role: role),
        ],
      ),
    ),
  );
};

/// Bespoke bodies per (flowId, state, role). Anything not listed falls back to
/// [genericFlowBody]. Add a `'blik'` block here to migrate BLIK later.
final Map<String, Map<String, Map<FlowActor, FlowBody>>> _flowBodies = {
  'twint': {
    'funded': {FlowActor.maker: twintMakerWaitBody},
    'reserved': {
      FlowActor.maker: twintMakerWaitBody,
      FlowActor.taker: twintTakerPayBody,
    },
    'takerCharged': {
      FlowActor.maker: twintMakerVerifyBody,
      FlowActor.taker: twintTakerWaitConfirmBody,
    },
    'invalidTwint': {FlowActor.maker: twintMakerReCodeBody},
    'expiredTwint': {FlowActor.taker: twintTakerExpiredBody},
    // Payout-tail (makerConfirmed, settled, payingTaker, takerPaid,
    // takerPaymentFailed) + terminals (cancelled, dispute) intentionally have no
    // bespoke body — they fall through to [genericFlowBody].
  },
};

FlowBody _bodyFor(String flowId, String state, FlowActor role) =>
    _flowBodies[flowId]?[state]?[role] ?? genericFlowBody;

/// The single flow-driven screen for generic (yaml) flows. Renders the body for
/// the active offer's current raw state + the user's role, and re-renders as the
/// coordinator advances the state (no per-state route navigation). Terminal
/// states get a Done action back home.
class FlowScreen extends ConsumerWidget {
  const FlowScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final offer = ref.watch(activeOfferProvider);
    final engineAsync = ref.watch(flowEngineProvider);

    // The active offer being cleared while we're on the flow screen means the
    // user left it (e.g. taker cancelled a reservation → offer relisted and the
    // taker is no longer a participant). Return to the offer list.
    ref.listen<Offer?>(activeOfferProvider, (prev, next) {
      if (prev != null && next == null && context.mounted) {
        context.go('/offers');
      }
    });

    return Scaffold(
      body: SafeArea(
        child: engineAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Flow load error: $e')),
          data: (engine) {
            if (offer == null || engine == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final role = roleForOffer(ref, offer);
            if (role == null) {
              return _homeError(context, 'You are not a participant.');
            }
            final state = offer.statusRaw;
            final body = _bodyFor(engine.definition.id, state, role)(
                context, ref, offer, engine, role);
            final terminal = engine.isTerminal(state);
            return Column(
              children: [
                Expanded(child: body),
                if (terminal)
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          await ref
                              .read(activeOfferProvider.notifier)
                              .setActiveOffer(null);
                          if (context.mounted) context.go('/');
                        },
                        child: const Text('Done'),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _homeError(BuildContext context, String msg) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(msg),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Home')),
          ],
        ),
      );
}
