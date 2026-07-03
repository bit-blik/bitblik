import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart'
    show activeOfferProvider, initializedApiServiceProvider;
import '../widgets/progress_indicators.dart' show CircularCountdownTimer;
import 'flow_actions_bar.dart';
import 'flow_controller.dart';
import 'flow_timeout.dart';

/// Signature for a body that renders one (state, role) of a flow-driven screen.
typedef FlowBody = Widget Function(
  BuildContext context,
  WidgetRef ref,
  Offer offer,
  FlowEngine engine,
  FlowActor role,
);

// ─── shared bits ────────────────────────────────────────────────────────────

String _amount(Offer o) => '${o.fiatAmount} ${o.fiatCurrency}';

/// The shared circular countdown for the current state's yaml timeout, with an
/// optional [caption] below it. Renders nothing when the state has no timeout.
Widget flowCountdownFor(
  BuildContext context,
  FlowEngine engine,
  Offer offer, {
  String? caption,
}) {
  final tm = flowStateTimer(engine, offer.statusRaw, offer);
  if (tm == null) return const SizedBox.shrink();
  final scheme = Theme.of(context).colorScheme;
  return Padding(
    padding: const EdgeInsets.only(top: 16),
    child: Column(
      children: [
        CircularCountdownTimer(
          startTime: tm.start,
          maxDuration: tm.max,
          size: 96,
          strokeWidth: 9,
          fontSize: 26,
          progressColor: scheme.primary,
          backgroundColor: scheme.surfaceContainerHighest,
        ),
        if (caption != null) ...[
          const SizedBox(height: 8),
          Text(caption, style: Theme.of(context).textTheme.bodySmall),
        ],
      ],
    ),
  );
}

Widget _titled(BuildContext context, String title, List<Widget> children) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineSmall),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    ),
  );
}

/// Big monospace TWINT code display.
Widget _codeBox(BuildContext context, String? code) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(
      code ?? '—',
      style: const TextStyle(
          fontSize: 34, fontWeight: FontWeight.bold, letterSpacing: 4),
    ),
  );
}

// ─── maker: funded / reserved (waiting) ──────────────────────────────────────

final FlowBody twintMakerWaitBody =
    (context, ref, offer, engine, role) {
  final waitingForTaker = offer.statusRaw == 'funded';
  return _titled(
    context,
    waitingForTaker ? 'Offer live' : 'Taker is paying',
    [
      Text(_amount(offer), style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      Text('Your TWINT code'),
      const SizedBox(height: 8),
      _codeBox(context, offer.blikCode),
      flowCountdownFor(context, engine, offer,
          caption: waitingForTaker ? 'Offer expires' : 'Auto-expires'),
      const SizedBox(height: 24),
      // Only `funded` exposes cancel_offer in the yaml → the bar renders it
      // only there, automatically.
      FlowActionsBar(
        offer: offer,
        engine: engine,
        role: role,
        labels: const {'cancel_offer': 'Cancel offer'},
        confirmEvents: const {'cancel_offer'},
      ),
    ],
  );
};

// ─── maker: takerCharged (verify receipt) ────────────────────────────────────

final FlowBody twintMakerVerifyBody =
    (context, ref, offer, engine, role) {
  return _titled(
    context,
    'Did you receive the payment?',
    [
      Text('The taker reports paying ${_amount(offer)} to your TWINT code.',
          textAlign: TextAlign.center),
      const SizedBox(height: 8),
      Text('Check your TWINT app, then confirm or open a dispute.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall),
      flowCountdownFor(context, engine, offer, caption: 'Auto-confirms'),
      const SizedBox(height: 24),
      FlowActionsBar(
        offer: offer,
        engine: engine,
        role: role,
        labels: const {
          'confirm_payment': 'Confirm received',
          'start_dispute': 'Open dispute',
        },
        confirmEvents: const {'start_dispute'},
      ),
    ],
  );
};

// ─── maker: invalidTwint (enter a new code) ──────────────────────────────────

final FlowBody twintMakerReCodeBody =
    (context, ref, offer, engine, role) =>
        _TwintReCodeBody(offer: offer, engine: engine, role: role);

class _TwintReCodeBody extends ConsumerStatefulWidget {
  final Offer offer;
  final FlowEngine engine;
  final FlowActor role;
  const _TwintReCodeBody(
      {required this.offer, required this.engine, required this.role});

  @override
  ConsumerState<_TwintReCodeBody> createState() => _TwintReCodeBodyState();
}

class _TwintReCodeBodyState extends ConsumerState<_TwintReCodeBody> {
  final _controller = TextEditingController();
  bool _busy = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;
    setState(() => _busy = true);
    try {
      await fireFlowAction(ref, widget.offer, 'enter_new_twint',
          extraParams: {'blik_code': code});
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('$e'),
            backgroundColor: Theme.of(context).colorScheme.error));
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _titled(context, 'Offer expired', [
      const Text(
        'No taker completed the trade. Enter a new TWINT code to re-list this '
        'offer, or cancel it.',
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 20),
      TextField(
        controller: _controller,
        keyboardType: TextInputType.number,
        decoration: const InputDecoration(
          labelText: 'New TWINT code',
          border: OutlineInputBorder(),
        ),
      ),
      flowCountdownFor(context, widget.engine, widget.offer, caption: 'Auto-cancels'),
      const SizedBox(height: 20),
      SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _busy ? null : _submit,
          child: _busy
              ? const SizedBox(
                  height: 18, width: 18, child: CircularProgressIndicator())
              : const Text('Re-list with new code'),
        ),
      ),
      const SizedBox(height: 8),
      // cancel_offer is the other yaml action from invalidTwint.
      FlowActionsBar(
        offer: widget.offer,
        engine: widget.engine,
        role: widget.role,
        labels: const {'cancel_offer': 'Cancel offer'},
        // enter_new_twint is handled by the custom field above.
        overrides: {'enter_new_twint': (_) => const SizedBox.shrink()},
        confirmEvents: const {'cancel_offer'},
      ),
    ]);
  }
}

// ─── taker: reserved (pay the TWINT code) ────────────────────────────────────

// Taker pays the TWINT code externally, then taps "I've paid". The payout
// invoice was already captured at reserve, so mark_twint_charged carries no
// params. This body also hydrates the maker's code (server-only) for display.
FlowBody twintTakerPayBody = (context, ref, offer, engine, role) =>
    _TwintTakerPayBody(offer: offer, engine: engine, role: role);

class _TwintTakerPayBody extends ConsumerStatefulWidget {
  final Offer offer;
  final FlowEngine engine;
  final FlowActor role;
  const _TwintTakerPayBody(
      {required this.offer, required this.engine, required this.role});

  @override
  ConsumerState<_TwintTakerPayBody> createState() => _TwintTakerPayBodyState();
}

class _TwintTakerPayBodyState extends ConsumerState<_TwintTakerPayBody> {
  @override
  void initState() {
    super.initState();
    _ensureCode();
  }

  /// The maker's TWINT code is server-only: the public offer + status updates
  /// don't carry it, and it isn't hydrated on `reserved`. Fetch it via
  /// get_offer_details (the coordinator reveals it to the taker for
  /// maker-provides-code methods) and merge it into the active offer so the
  /// code box renders it.
  Future<void> _ensureCode() async {
    if ((widget.offer.blikCode ?? '').isNotEmpty) return;
    try {
      final api = await ref.read(initializedApiServiceProvider.future);
      final remote = await api.getOfferDetails(
          widget.offer, widget.offer.coordinatorPubkey);
      final code = remote?['blik_code'] as String?;
      if (code == null || code.isEmpty) return;
      final cur = ref.read(activeOfferProvider);
      if (cur != null &&
          cur.id == widget.offer.id &&
          (cur.blikCode ?? '').isEmpty) {
        ref
            .read(activeOfferProvider.notifier)
            .setActiveOffer(cur.copyWith(blikCode: code));
      }
    } catch (_) {
      // Best-effort; the code box shows a placeholder until the next mount.
    }
  }

  @override
  Widget build(BuildContext context) {
    return _titled(context, 'Pay with TWINT', [
      Text('Open your TWINT app and pay ${_amount(widget.offer)} using:',
          textAlign: TextAlign.center),
      const SizedBox(height: 12),
      _codeBox(context, widget.offer.blikCode),
      flowCountdownFor(context, widget.engine, widget.offer,
          caption: 'Code expires'),
      const SizedBox(height: 24),
      FlowActionsBar(
        offer: widget.offer,
        engine: widget.engine,
        role: widget.role,
        labels: const {
          'mark_twint_charged': "I've paid",
          'cancel_reservation': 'Cancel',
        },
        confirmEvents: const {'cancel_reservation'},
        leaveEvents: const {'cancel_reservation'},
      ),
    ]);
  }
}

// ─── taker: takerCharged (wait for maker) ────────────────────────────────────

final FlowBody twintTakerWaitConfirmBody =
    (context, ref, offer, engine, role) {
  return _titled(context, 'Waiting for the maker', [
    const CircularProgressIndicator(),
    const SizedBox(height: 16),
    const Text('The maker is verifying your TWINT payment.',
        textAlign: TextAlign.center),
    flowCountdownFor(context, engine, offer, caption: 'Auto-confirms'),
  ]);
};

// ─── taker: expiredTwint ─────────────────────────────────────────────────────

final FlowBody twintTakerExpiredBody =
    (context, ref, offer, engine, role) {
  return _titled(context, 'Reservation expired', [
    const Text(
      "The TWINT code wasn't paid in time. You can cancel to release the offer.",
      textAlign: TextAlign.center,
    ),
    flowCountdownFor(context, engine, offer, caption: 'Auto-releases'),
    const SizedBox(height: 24),
    FlowActionsBar(
      offer: offer,
      engine: engine,
      role: role,
      labels: const {'cancel_reservation': 'Cancel'},
      leaveEvents: const {'cancel_reservation'},
    ),
  ]);
};

// Payout-tail + terminal states have no bespoke body — they render via
// genericFlowBody (offer details + spinner/countdown + any yaml actions).
