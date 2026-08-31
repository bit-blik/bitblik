import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../providers/providers.dart' show activeOfferProvider;
import '../screens/maker_flow/maker_confirm_payment_screen.dart'
    show MakerConfirmPaymentScreen;
import '../screens/maker_flow/maker_conflict_screen.dart'
    show MakerConflictScreen;
import '../screens/maker_flow/maker_invalid_blik_screen.dart'
    show MakerInvalidBlikScreen;
import '../screens/maker_flow/maker_pay_invoice_screen.dart'
    show MakerPayInvoiceScreen;
import '../screens/maker_flow/maker_refund_invoice_required_screen.dart'
    show MakerRefundInvoiceRequiredScreen;
import '../screens/maker_flow/maker_success_screen.dart'
    show MakerSuccessScreen;
import '../screens/maker_flow/maker_wait_for_blik_screen.dart'
    show MakerWaitForBlikScreen;
import '../screens/maker_flow/maker_wait_taker_screen.dart'
    show MakerWaitTakerScreen;
import '../screens/taker_flow/taker_conflict_screen.dart'
    show TakerConflictScreen;
import '../screens/taker_flow/taker_invalid_blik_screen.dart'
    show TakerInvalidBlikScreen;
import '../screens/taker_flow/taker_payment_failed_screen.dart'
    show TakerPaymentFailedScreen;
import '../screens/taker_flow/taker_payment_process_screen.dart'
    show TakerPaymentProcessScreen;
import '../screens/taker_flow/taker_submit_blik_screen.dart'
    show TakerSubmitBlikScreen;
import '../screens/taker_flow/taker_wait_confirmation_screen.dart'
    show TakerWaitConfirmationScreen;
import '../utils/offer_status_label.dart' show humanizeFlowState;
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
  final title = humanizeFlowState(state);
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
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );

  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
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

/// Payout-tail bodies for the states defined in `common.yml` (makerConfirmed,
/// settled, payingTaker, takerPaid, takerPaymentFailed) — shared verbatim by
/// EVERY flow (twint/blik/mbway). The maker's work is done once they confirm,
/// so they get the success screen (with confetti); the taker watches the
/// payout checklist advance and, on failure, the retry/failure screen. Both
/// screens read only [activeOfferProvider] + [selectedPaymentSystemProvider],
/// so nothing here is flow-specific.
final Map<String, Map<FlowActor, FlowBody>> _payoutTailBodies = {
  for (final state in const [
    'makerConfirmed',
    'settled',
    'payingTaker',
    'takerPaid',
  ])
    state: {
      FlowActor.maker:
          (context, ref, offer, engine, role) =>
              MakerSuccessScreen(completedOffer: offer),
      FlowActor.taker:
          (context, ref, offer, engine, role) =>
              const TakerPaymentProcessScreen(),
    },
  'takerPaymentFailed': {
    FlowActor.maker:
        (context, ref, offer, engine, role) =>
            MakerSuccessScreen(completedOffer: offer),
    FlowActor.taker:
        (context, ref, offer, engine, role) =>
            TakerPaymentFailedScreen(offer: offer),
  },
};

/// Dispute states shared by every payment-method flow.
final Map<String, Map<FlowActor, FlowBody>> _disputeBodies = {
  'dispute': {
    FlowActor.maker: twintDisputeBody,
    FlowActor.taker: twintDisputeBody,
  },
  'refundingMaker': {
    FlowActor.maker:
        (context, ref, offer, engine, role) =>
            MakerRefundInvoiceRequiredScreen(offer: offer),
    FlowActor.taker: twintDisputeBody,
  },
};

/// BLIK and MB WAY share the established code screen set as flow bodies — mbway.yml
/// mirrors blik.yml's state names, and both use the same code-based screens.
/// The screens' internal status navigation routes back through [flowRoute], so
/// FlowScreen
/// stays the navigation owner and simply re-renders the body registered for
/// the next state.
final Map<String, Map<FlowActor, FlowBody>> _codeFlowBodies = {
  // Client-side pre-funding status, same arrangement as TWINT.
  'created': {
    FlowActor.maker:
        (context, ref, offer, engine, role) => const MakerPayInvoiceScreen(),
  },
  'funded': {
    FlowActor.maker:
        (context, ref, offer, engine, role) => const MakerWaitTakerScreen(),
  },
  'reserved': {
    FlowActor.maker:
        (context, ref, offer, engine, role) => const MakerWaitForBlikScreen(),
    FlowActor.taker:
        (context, ref, offer, engine, role) =>
            TakerSubmitBlikScreen(initialOffer: offer),
  },
  'blikReceived': {
    FlowActor.maker:
        (context, ref, offer, engine, role) => const MakerWaitForBlikScreen(),
    FlowActor.taker:
        (context, ref, offer, engine, role) =>
            TakerWaitConfirmationScreen(offer: offer),
  },
  'blikSentToMaker': {
    FlowActor.maker:
        (context, ref, offer, engine, role) =>
            const MakerConfirmPaymentScreen(),
    FlowActor.taker:
        (context, ref, offer, engine, role) =>
            TakerWaitConfirmationScreen(offer: offer),
  },
  'takerCharged': {
    FlowActor.maker:
        (context, ref, offer, engine, role) =>
            const MakerConfirmPaymentScreen(),
    FlowActor.taker:
        (context, ref, offer, engine, role) =>
            TakerWaitConfirmationScreen(offer: offer),
  },
  'expiredSentBlik': {
    FlowActor.maker:
        (context, ref, offer, engine, role) =>
            const MakerConfirmPaymentScreen(),
    FlowActor.taker:
        (context, ref, offer, engine, role) =>
            TakerWaitConfirmationScreen(offer: offer),
  },
  // expiredBlik: maker has no actions there → genericFlowBody; the taker
  // keeps the wait screen (re-take / cancel handling).
  'expiredBlik': {
    FlowActor.taker:
        (context, ref, offer, engine, role) =>
            TakerWaitConfirmationScreen(offer: offer),
  },
  'invalidBlik': {
    FlowActor.maker:
        (context, ref, offer, engine, role) =>
            MakerInvalidBlikScreen(offer: offer),
    FlowActor.taker:
        (context, ref, offer, engine, role) =>
            TakerInvalidBlikScreen(offer: offer),
  },
  'conflict': {
    FlowActor.maker:
        (context, ref, offer, engine, role) =>
            MakerConflictScreen(offer: offer),
    FlowActor.taker:
        (context, ref, offer, engine, role) =>
            TakerConflictScreen(offerId: offer.id),
  },
  // Payout tail (makerConfirmed, settled, payingTaker, takerPaid,
  // takerPaymentFailed) is shared across every flow.
  ..._payoutTailBodies,
  ..._disputeBodies,
  // cancelled / expired terminals fall through to [genericFlowBody].
};

/// Bespoke bodies per (flowId, state, role). Anything not listed falls back to
/// [genericFlowBody].
final Map<String, Map<String, Map<FlowActor, FlowBody>>> _flowBodies = {
  'twint': {
    // `created` is a client-side pre-funding status (not a yaml state — the
    // coordinator only learns of the offer once the hold invoice is paid), so
    // the invoice screen owns it; it re-enters `/flow` on funding via
    // flowRoute.
    'created': {
      FlowActor.maker:
          (context, ref, offer, engine, role) => const MakerPayInvoiceScreen(),
    },
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
    ..._disputeBodies,
    'expiredTwint': {
      FlowActor.maker: twintMakerExpiredBody,
      FlowActor.taker: twintTakerExpiredBody,
    },
    // Payout tail (makerConfirmed, settled, payingTaker, takerPaid,
    // takerPaymentFailed) reuses the shared success / payout-checklist screens
    // — identical for every flow since these are common.yml states.
    ..._payoutTailBodies,
    // cancelled terminal falls through to [genericFlowBody].
  },
  'blik': _codeFlowBodies,
  'mbway': _codeFlowBodies,
  // Slovak cardless ATM: same pull-style code flow + state names as MB WAY.
  'sk_atm': _codeFlowBodies,
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
    // user left it. Return home without selecting another historical offer.
    ref.listen<Offer?>(activeOfferProvider, (prev, next) {
      if (prev != null && next == null && context.mounted) {
        context.go('/');
      }
    });

    return Scaffold(
      body: SafeArea(
        child: engineAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Flow load error: $e')),
          data: (engine) {
            if (offer == null) {
              return const Center(child: CircularProgressIndicator());
            }
            final role = roleForOffer(ref, offer);
            if (role == null) {
              return _homeError(context, 'You are not a participant.');
            }
            final state = offer.statusRaw;
            final body = _bodyFor(engine.definition.id, state, role)(
              context,
              ref,
              offer,
              engine,
              role,
            );
            final terminal = engine.isTerminal(state);
            return Column(
              children: [
                // Invisible: re-fetches the offer from the coordinator when the
                // state's yaml deadline passes without a pushed update.
                _FlowDeadlineSync(engine: engine, offer: offer),
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
          child: const Text('Home'),
        ),
      ],
    ),
  );
}

/// Client-side safety net for missed status pushes: when the current state's
/// yaml deadline passes, the coordinator has advanced the offer server-side.
/// If the pushed update never arrived (relay hiccup, app in background) the
/// screen would sit on a 0:00 countdown forever — so shortly after the
/// deadline, re-fetch the offer from the coordinator and keep retrying until
/// the state moves (any change rebuilds this widget and re-arms).
class _FlowDeadlineSync extends ConsumerStatefulWidget {
  final FlowEngine engine;
  final Offer offer;
  const _FlowDeadlineSync({required this.engine, required this.offer});

  @override
  ConsumerState<_FlowDeadlineSync> createState() => _FlowDeadlineSyncState();
}

class _FlowDeadlineSyncState extends ConsumerState<_FlowDeadlineSync> {
  Timer? _timer;
  static const _postDeadlineGrace = Duration(seconds: 2);
  static const _retryInterval = Duration(seconds: 10);

  @override
  void initState() {
    super.initState();
    _arm();
    // One-shot sync on entering the flow screen: catches updates missed while
    // the user was away (e.g. an ex-taker resuming an offer that was relisted
    // without them — no push reaches ex-participants who were offline).
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(activeOfferProvider.notifier).reconcileActiveOfferNow();
      }
    });
  }

  @override
  void didUpdateWidget(_FlowDeadlineSync old) {
    super.didUpdateWidget(old);
    if (old.offer.id != widget.offer.id ||
        old.offer.statusRaw != widget.offer.statusRaw ||
        old.offer.updatedAt != widget.offer.updatedAt) {
      _arm();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _arm() {
    _timer?.cancel();
    final deadline = flowStateDeadline(
      widget.engine,
      widget.offer.statusRaw,
      widget.offer,
    );
    if (deadline == null) return;
    final wait = deadline
        .add(_postDeadlineGrace)
        .difference(DateTime.now().toUtc());
    _timer = Timer(wait.isNegative ? Duration.zero : wait, _sync);
  }

  Future<void> _sync() async {
    if (!mounted) return;
    await ref.read(activeOfferProvider.notifier).reconcileActiveOfferNow();
    if (!mounted) return;
    // State still stale (coordinator timer lag / transient fetch failure) —
    // retry until a status change re-arms or unmounts us.
    _timer = Timer(_retryInterval, _sync);
  }

  @override
  Widget build(BuildContext context) => const SizedBox.shrink();
}
