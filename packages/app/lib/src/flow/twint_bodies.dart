import 'dart:async';
import 'dart:ui' as ui show TextDirection;

import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'
    show Clipboard, ClipboardData, FilteringTextInputFormatter;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../i18n/gen/strings.g.dart';

import '../providers/providers.dart'
    show
        activeOfferProvider,
        coordinatorDisputeEvidenceDurationProvider,
        initializedApiServiceProvider,
        selectedPaymentSystemProvider;
import '../screens/maker_flow/twint_code_scanner_screen.dart';
import '../widgets/dispute_conversation_card.dart';
import '../widgets/maker_waiting_body.dart';
import '../widgets/progress_indicators.dart' show CircularCountdownTimer;
import 'flow_actions_bar.dart';
import 'flow_controller.dart';
import 'flow_timeout.dart';

/// Signature for a body that renders one (state, role) of a flow-driven screen.
typedef FlowBody =
    Widget Function(
  BuildContext context,
  WidgetRef ref,
  Offer offer,
  FlowEngine engine,
  FlowActor role,
);

// ─── shared bits ────────────────────────────────────────────────────────────

String _amount(Offer o) => '${o.fiatAmount} ${o.fiatCurrency}';

/// TWINT-specific maker breadcrumbs: "Create offer > Wait for taker > Confirm".
/// Unlike [MakerProgressIndicator], step 3 is "Confirm" (not "Use ${code}"),
/// because TWINT is a maker-provides-code flow.
class TwintMakerProgressIndicator extends ConsumerWidget {
  final int activeStep; // 1, 2, or 3

  const TwintMakerProgressIndicator({super.key, this.activeStep = 1});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final labels = [
      t.twint.flow.progress.step1,
      t.twint.flow.progress.step2,
      t.twint.flow.progress.step3,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          for (var i = 0; i < labels.length; i++) ...[
            if (i > 0)
              const Text(
                '>',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            Text(
              labels[i],
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                    i + 1 <= activeStep ? FontWeight.w500 : FontWeight.w400,
                color: i + 1 == activeStep ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// TWINT-specific taker breadcrumbs: "Pay TWINT > Get sats". A simpler 2-step
/// flow because TWINT is a maker-provides-code method — the taker has no
/// separate confirm step.
class TwintTakerProgressIndicator extends ConsumerWidget {
  final int activeStep; // 1 or 2

  const TwintTakerProgressIndicator({super.key, this.activeStep = 1});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final offer = ref.watch(activeOfferProvider);
    final method =
        offer != null
        ? (paymentSystemForCurrency(offer.fiatCurrency) ?? kBlik)
        : ref.watch(selectedPaymentSystemProvider);
    final code = method.codeLabel;
    final labels = [
      t.twint.flow.takerProgress.step1(code: code),
      t.twint.flow.takerProgress.step2,
    ];
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8.0,
        runSpacing: 4.0,
        children: [
          for (var i = 0; i < labels.length; i++) ...[
            if (i > 0)
              const Text(
                '>',
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
            Text(
              labels[i],
              style: TextStyle(
                fontSize: 13,
                fontWeight:
                    i + 1 <= activeStep ? FontWeight.w500 : FontWeight.w400,
                color: i + 1 == activeStep ? Colors.black : Colors.grey,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

/// The shared circular countdown for the current state's yaml timeout, with an
/// optional [caption] below it. Renders nothing when the state has no timeout.
Widget flowCountdownFor(
  BuildContext context,
  FlowEngine engine,
  Offer offer, {
  String? caption,
  double size = 96,
  double strokeWidth = 9,
  double fontSize = 26,
  Color? progressColor,
  Color? backgroundColor,
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
          size: size,
          strokeWidth: strokeWidth,
          fontSize: fontSize,
          progressColor: progressColor ?? scheme.primary,
          backgroundColor: backgroundColor ?? scheme.surfaceContainerHighest,
        ),
        if (caption != null) ...[
          const SizedBox(height: 8),
          Text(caption, style: Theme.of(context).textTheme.bodySmall),
        ],
      ],
    ),
  );
}

Widget _titled(
  BuildContext context,
  String title,
  List<Widget> children, {
  Widget? breadcrumb,
}) {
  return Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (breadcrumb != null) ...[breadcrumb, const SizedBox(height: 20)],
          Text(
            title,
              textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 20),
          ...children,
        ],
      ),
    ),
  );
}

/// Big monospace TWINT code display, with a copy button when a code is shown.
Widget _codeBox(BuildContext context, String? code) {
  return Container(
    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
    decoration: BoxDecoration(
      color: Theme.of(context).colorScheme.surfaceContainerHighest,
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          code ?? '—',
          style: const TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
            letterSpacing: 4,
          ),
        ),
        if (code != null && code.isNotEmpty) ...[
          const SizedBox(width: 8),
          IconButton(
            icon: const Icon(Icons.copy, size: 24),
            tooltip: MaterialLocalizations.of(context).copyButtonLabel,
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: code));
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      Translations.of(context).common.clipboard.copied,
                    ),
                    duration: const Duration(seconds: 2),
                  ),
                );
              }
            },
          ),
        ],
      ],
    ),
  );
}

// ─── maker: funded / reserved (waiting) ──────────────────────────────────────

final FlowBody twintMakerWaitBody = (context, ref, offer, engine, role) {
  final t = Translations.of(context);
  final waitingForTaker = offer.statusRaw == 'funded';
  const codeLabel = 'TWINT';
  return MakerWaitingBody(
    offer: offer,
    // Funded → step 2 (waiting for taker); reserved → step 3 (confirm).
    progressIndicator: TwintMakerProgressIndicator(
      activeStep: waitingForTaker ? 2 : 3,
    ),
    // Reserved: the info box below explains the state — no spinner line.
    message: waitingForTaker ? t.maker.waitTaker.message : null,
    // Once reserved, explain what the taker is doing (BLIK-style info box).
    extra:
        waitingForTaker
        ? const []
        : [
            Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                    Icon(
                      Icons.info_outline,
                      color: Colors.blue.shade700,
                      size: 22,
                    ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      t.twint.flow.makerWait.reservedInfo(code: codeLabel),
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          ],
    // Countdown comes from the state's yaml timeout. Funded: big green on
    // white (matching the BLIK wait-taker screen). Reserved: half-size, blue
    // (matching the BLIK in-progress timers) — the trade is live, not merely
    // waiting.
    countdown: flowCountdownFor(
      context,
      engine,
      offer,
      caption:
          waitingForTaker
          ? t.twint.flow.makerWait.offerExpires(code: codeLabel)
          : t.twint.flow.makerWait.codeExpiresIn(code: codeLabel),
      size: waitingForTaker ? 200 : 100,
      strokeWidth: waitingForTaker ? 16 : 8,
      fontSize: waitingForTaker ? 48 : 24,
      progressColor: waitingForTaker ? Colors.green : Colors.blue,
      backgroundColor: waitingForTaker ? Colors.white : null,
    ),
    // funded exposes cancel_offer, reserved exposes confirm_payment — the bar
    // renders whatever the yaml allows; confirm_payment gets the bespoke green
    // success button + irreversibility dialog; cancel_offer gets the BLIK-style
    // red outlined button.
    actions: FlowActionsBar(
      offer: offer,
      engine: engine,
      role: role,
      labels: {'cancel_offer': t.twint.flow.makerWait.cancelOffer},
      confirmEvents: const {'cancel_offer'},
      overrides: {
        'confirm_payment':
            (_) => _makerConfirmPaymentButton(context, ref, offer, t),
        'cancel_offer':
            (_) => _makerCancelButton(
              context,
              ref,
              offer,
              t.twint.flow.makerWait.cancelOffer,
            ),
      },
    ),
  );
};

/// Red outlined cancel button matching the BLIK maker-wait-taker screen style:
/// circular close icon + label, used for the maker's `cancel_offer` action.
Widget _makerCancelButton(
  BuildContext context,
  WidgetRef ref,
  Offer offer,
  String label,
) {
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red, width: 2),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: () async {
        try {
          await fireFlowAction(ref, offer, 'cancel_offer');
          await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
          if (context.mounted) context.go('/');
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
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: const Icon(Icons.close, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

/// Green success button (BLIK confirm-screen style) for the maker's
/// `confirm_payment`, guarded by an explicit irreversibility dialog: confirming
/// settles the hold invoice and pays the taker.
Widget _makerConfirmPaymentButton(
  BuildContext context,
  WidgetRef ref,
  Offer offer,
  Translations t,
) {
  const codeLabel = 'TWINT';
  final strings = t.twint.flow.makerWait;
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder:
              (dialogContext) => AlertDialog(
            title: Text(strings.confirmDialog.title),
            content: Text(strings.confirmDialog.content(code: codeLabel)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(strings.confirmDialog.cancel),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(strings.confirmDialog.confirmButton),
              ),
            ],
          ),
        );
        if (confirmed != true || !context.mounted) return;
        try {
          await fireFlowAction(ref, offer, 'confirm_payment');
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
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          Text(
            strings.confirmReceived,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

// ─── maker: expiredTwint (code expired, taker may still have paid) ───────────

final FlowBody twintMakerExpiredBody = (context, ref, offer, engine, role) {
  final t = Translations.of(context);
  const codeLabel = 'TWINT';
  final strings = t.twint.flow.makerExpired;
  return _titled(context, strings.title(code: codeLabel), [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.warning_amber_rounded,
              color: Colors.orange,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              strings.warning(code: codeLabel),
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
          ),
        ],
      ),
    ),
    // Countdown until the yaml timeout moves the offer on (expiredTwint →
    // invalidTwint). Orange to match the warning tone.
    flowCountdownFor(
      context,
      engine,
      offer,
      caption: strings.timerCaption,
      size: 100,
      strokeWidth: 8,
      fontSize: 24,
      progressColor: Colors.orange,
    ),
    const SizedBox(height: 14),
    Text(
      strings.disputeHint,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: 13, height: 1.4, color: Colors.grey[700]),
    ),
    const SizedBox(height: 24),
    // Yaml allows confirm_payment for the maker here — same green success
    // button + irreversibility dialog as in `reserved`.
    FlowActionsBar(
      offer: offer,
      engine: engine,
      role: role,
      overrides: {
        'confirm_payment':
            (_) => _makerConfirmPaymentButton(context, ref, offer, t),
      },
    ),
  ], breadcrumb: const TwintMakerProgressIndicator(activeStep: 3));
};

// ─── maker: takerCharged (verify receipt) ────────────────────────────────────

final FlowBody twintMakerVerifyBody = (context, ref, offer, engine, role) {
  final t = Translations.of(context);
  const codeLabel = 'TWINT';
  return _titled(context, t.twint.flow.makerVerify.title, [
    Text(
      t.twint.flow.makerVerify.body(amount: _amount(offer), code: codeLabel),
      textAlign: TextAlign.center,
          ),
      const SizedBox(height: 8),
    Text(
      t.twint.flow.makerVerify.hint,
          textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.bodySmall,
    ),
      flowCountdownFor(
        context,
        engine,
        offer,
        caption: t.twint.flow.makerVerify.autoConfirms,
      ),
      const SizedBox(height: 24),
      FlowActionsBar(
        offer: offer,
        engine: engine,
        role: role,
      labels: {'confirm_payment': t.twint.flow.makerVerify.confirmReceived},
        overrides: {
        'confirm_payment':
            (_) => _makerConfirmPaymentButton(context, ref, offer, t),
        'start_dispute':
            (_) => _makerStartDisputeButton(context, ref, offer, t),
        },
      ),
  ], breadcrumb: const TwintMakerProgressIndicator(activeStep: 3));
};

/// Red dispute button for the maker's `start_dispute`, guarded by the same
/// consequences dialog the BLIK flow uses (dispute fee risk, immediate hold
/// invoice settlement, manual coordinator verification — only proceed if
/// certain the payment did NOT arrive).
Widget _makerStartDisputeButton(
  BuildContext context,
  WidgetRef ref,
  Offer offer,
  Translations t,
) {
  const codeLabel = 'TWINT';
  final dialogStrings = t.maker.confirmPayment.invalidBlikDisputeDialog;
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.error,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder:
              (dialogContext) => AlertDialog(
            title: Text(dialogStrings.title),
            content: Text(dialogStrings.content(code: codeLabel)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(dialogStrings.cancel),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.error,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(dialogStrings.confirmButton),
              ),
            ],
          ),
        );
        if (confirmed != true || !context.mounted) return;
        try {
          await fireFlowAction(ref, offer, 'start_dispute');
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
      },
      child: Text(
        t.twint.flow.makerVerify.openDispute,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    ),
  );
}

// ─── maker: invalidTwint (enter a new code) ──────────────────────────────────

final FlowBody twintMakerReCodeBody =
    (context, ref, offer, engine, role) =>
        _TwintReCodeBody(offer: offer, engine: engine, role: role);

class _TwintReCodeBody extends ConsumerStatefulWidget {
  final Offer offer;
  final FlowEngine engine;
  final FlowActor role;
  const _TwintReCodeBody({
    required this.offer,
    required this.engine,
    required this.role,
  });

  @override
  ConsumerState<_TwintReCodeBody> createState() => _TwintReCodeBodyState();
}

class _TwintReCodeBodyState extends ConsumerState<_TwintReCodeBody> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _busy = false;
  bool _showManualEntry = false;

  PaymentSystem get _method => ref.read(selectedPaymentSystemProvider);
  String get _placeholder => List.filled(_method.codeLength, '0').join();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _scanCode() async {
    final result = await Navigator.of(context).push<TwintScanResult>(
      MaterialPageRoute(
        // The amount is fixed on a re-list — scan only the code.
        builder: (_) => const TwintCodeScannerScreen(scanAmount: false),
      ),
    );
    if (!mounted) return;
    setState(() => _showManualEntry = true);
    if (result?.code != null && result!.code!.isNotEmpty) {
      _controller.text = result.code!;
      FocusScope.of(context).unfocus();
    } else {
      _focusNode.requestFocus();
    }
  }

  void _showManual() {
    setState(() => _showManualEntry = true);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _focusNode.requestFocus();
    });
  }

  Future<void> _submit() async {
    final code = _controller.text.trim();
    if (code.isEmpty) return;
    setState(() => _busy = true);
    try {
      await fireFlowAction(
        ref,
        widget.offer,
        'enter_new_twint',
        extraParams: {'blik_code': code},
      );
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Widget _gradientButton({
    required VoidCallback? onPressed,
    required Widget child,
  }) {
    return Container(
      width: double.infinity,
      height: 56,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient:
            onPressed != null
            ? const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFFFF0000), Color(0xFFFF007F)],
              )
            : null,
        color: onPressed == null ? Colors.grey[300] : null,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(24),
          child: Center(child: child),
        ),
      ),
    );
  }

  /// Same visual language as the scan card in MakerAmountForm.
  Widget _scanCard(Translations t) {
    const accent = Color(0xFF0D8C7A);
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 18),
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: const Color(0xFFF2FBF9),
        border: Border.all(color: const Color(0xFFCFEDE7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFFDDF5F0),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.qr_code_scanner_rounded, color: accent),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      t.twint.flow.makerRecode.scanCardTitle(
                        code: _method.codeLabel,
                      ),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      t.twint.flow.makerRecode.scanCardBody,
                      style: TextStyle(
                        fontSize: 13,
                        height: 1.4,
                        color: Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _gradientButton(
            onPressed: _scanCode,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.camera_alt_rounded, color: Colors.white),
                const SizedBox(width: 10),
                Text(
                  t.maker.amountForm.twintScan.scanButton,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: _showManual,
              child: Text(t.maker.amountForm.twintScan.manualButton),
            ),
          ),
        ],
      ),
    );
  }

  /// Same visual language as the code field in MakerAmountForm: label +
  /// rescan, auto-sized centered code with a left-anchored cursor, helper.
  Widget _codeField(Translations t) {
    final hasValue = _controller.text.trim().isNotEmpty;
    return Container(
      margin: const EdgeInsets.only(top: 4, bottom: 14),
      padding: const EdgeInsets.fromLTRB(18, 16, 14, 14),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                t.twint.flow.makerRecode.fieldLabel(code: _method.codeLabel),
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  color: Colors.grey[700],
                ),
              ),
              const Spacer(),
              TextButton.icon(
                onPressed: _scanCode,
                icon: const Icon(Icons.center_focus_strong, size: 16),
                label: Text(t.maker.amountForm.twintScan.rescan),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.grey[700],
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          LayoutBuilder(
            builder: (context, constraints) {
              final available = constraints.maxWidth.clamp(
                0.0,
                double.infinity,
              );
              final perChar =
                  _method.codeLength > 0 ? available / _method.codeLength : 0.0;
              final fontSize = (perChar / 1.25).clamp(28.0, 52.0);
              final letterSpacing = (fontSize * 0.22).clamp(4.0, 10.0);
              final textStyle = TextStyle(
                fontSize: fontSize,
                fontWeight: FontWeight.w600,
                letterSpacing: letterSpacing,
                height: 1.1,
              );
              // Size the field to exactly fit the full code and center that
              // box: the text block sits centered while the field itself is
              // left-aligned so the cursor starts at its left edge.
              final placeholderPainter = TextPainter(
                text: TextSpan(text: _placeholder, style: textStyle),
                textDirection: ui.TextDirection.ltr,
              )..layout();
              final fieldWidth = (placeholderPainter.width + 4).clamp(
                0.0,
                available,
              );
              return Center(
                child: SizedBox(
                  width: fieldWidth,
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    keyboardType: TextInputType.number,
                    maxLength: _method.codeLength,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    textAlign: TextAlign.left,
                    style: textStyle,
                    decoration: InputDecoration(
                      hintText: _placeholder,
                      hintStyle: TextStyle(
                        fontSize: fontSize,
                        fontWeight: FontWeight.w400,
                        letterSpacing: letterSpacing,
                        color: Colors.grey[350],
                        height: 1.1,
                      ),
                      border: InputBorder.none,
                      counterText: '',
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 8),
          Text(
            hasValue
                ? t.maker.amountForm.twintScan.helperFilled(
                  code: _method.codeLabel,
                )
                : t.maker.amountForm.twintScan.helperEmpty(
                  digits: _method.codeLength,
                ),
            style: TextStyle(
              fontSize: 12.5,
              height: 1.35,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    const codeLabel = 'TWINT';
    final manualVisible =
        _showManualEntry || _controller.text.trim().isNotEmpty;
    final code = _controller.text.trim();
    final codeComplete = code.length == _method.codeLength;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TwintMakerProgressIndicator(activeStep: 2),
          const SizedBox(height: 20),
          Text(
            t.twint.flow.makerRecode.title,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            t.twint.flow.makerRecode.body(code: codeLabel),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          if (!manualVisible) _scanCard(t) else _codeField(t),
          flowCountdownFor(
            context,
            widget.engine,
            widget.offer,
            caption: t.twint.flow.makerRecode.autoCancels,
          ),
          const SizedBox(height: 20),
          if (manualVisible)
            _gradientButton(
              onPressed: _busy || !codeComplete ? null : _submit,
              child:
                  _busy
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                    )
                  : Text(
                      t.twint.flow.makerRecode.relist,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                    ),
            ),
          const SizedBox(height: 8),
          // cancel_offer is the other yaml action from invalidTwint.
          FlowActionsBar(
            offer: widget.offer,
            engine: widget.engine,
            role: widget.role,
            labels: {'cancel_offer': t.twint.flow.makerRecode.cancelOffer},
            // enter_new_twint is handled by the custom field above.
            overrides: {
              'enter_new_twint': (_) => const SizedBox.shrink(),
              'cancel_offer':
                  (_) => _makerCancelButton(
                    context,
                    ref,
                    widget.offer,
                    t.twint.flow.makerRecode.cancelOffer,
                  ),
            },
          ),
        ],
      ),
    );
  }
}

// ─── taker: reserved (pay the TWINT code) ────────────────────────────────────

// Taker pays the TWINT code externally, then taps "I've paid". The payout
// invoice was already captured at reserve, so mark_twint_charged carries no
// params. This body also hydrates the maker's code (server-only) for display.
FlowBody twintTakerPayBody =
    (context, ref, offer, engine, role) =>
    _TwintTakerPayBody(offer: offer, engine: engine, role: role);

class _TwintTakerPayBody extends ConsumerStatefulWidget {
  final Offer offer;
  final FlowEngine engine;
  final FlowActor role;
  const _TwintTakerPayBody({
    required this.offer,
    required this.engine,
    required this.role,
  });

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
        widget.offer,
        widget.offer.coordinatorPubkey,
      );
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
    final t = Translations.of(context);
    const codeLabel = 'TWINT';
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TwintTakerProgressIndicator(activeStep: 1),
          const SizedBox(height: 20),
          Text(
            t.twint.flow.takerPay.title(code: codeLabel),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 8),
          Text(
            t.twint.flow.takerPay.body(
              code: codeLabel,
              amount: _amount(widget.offer),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Center(child: _codeBox(context, widget.offer.blikCode)),
          flowCountdownFor(
            context,
            widget.engine,
            widget.offer,
            caption: t.twint.flow.takerPay.codeExpires,
          ),
          const SizedBox(height: 24),
          FlowActionsBar(
            offer: widget.offer,
            engine: widget.engine,
            role: widget.role,
            labels: {
              'mark_twint_charged': t.twint.flow.takerPay.paid,
              'cancel_reservation': t.twint.flow.takerPay.cancel,
            },
            overrides: {
              'mark_twint_charged':
                  (_) => _takerPaidButton(context, ref, widget.offer, t),
              'cancel_reservation':
                  (_) => _takerCancelButton(context, ref, widget.offer, t),
            },
          ),
        ],
      ),
    );
  }
}

/// Green "I've paid" button for the taker's `mark_twint_charged` action,
/// matching the style used in the expired-TWINT body and BLIK confirm buttons.
/// Shows the same markPaidDialog as the expired-TWINT body: confirms the
/// taker understands the maker must verify, and a dispute may follow.
Widget _takerPaidButton(
  BuildContext context,
  WidgetRef ref,
  Offer offer,
  Translations t,
) {
  const codeLabel = 'TWINT';
  final dialog = t.twint.flow.takerExpired.markPaidDialog;
  return SizedBox(
    width: double.infinity,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder:
              (dialogContext) => AlertDialog(
            title: Text(dialog.title),
            content: Text(dialog.content(code: codeLabel)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(dialog.cancel),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(dialog.confirmButton),
              ),
            ],
          ),
        );
        if (confirmed != true || !context.mounted) return;
        try {
          await fireFlowAction(ref, offer, 'mark_twint_charged');
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
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.check, color: Colors.white, size: 24),
          const SizedBox(width: 8),
          Text(
            t.twint.flow.takerPay.paid,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    ),
  );
}

/// Red outlined cancel button for the taker's `cancel_reservation` action,
/// matching the BLIK taker-submit cancel button style. Shows the same
/// irreversibility dialog as the expired-TWINT body, then clears the offer
/// and returns home.
Widget _takerCancelButton(
  BuildContext context,
  WidgetRef ref,
  Offer offer,
  Translations t,
) {
  const codeLabel = 'TWINT';
  final dialog = t.twint.flow.takerExpired.cancelDialog;
  return SizedBox(
    width: double.infinity,
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: const BorderSide(color: Colors.red, width: 2),
        foregroundColor: Colors.red,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: () async {
        final confirmed = await showDialog<bool>(
          context: context,
          barrierDismissible: false,
          builder:
              (dialogContext) => AlertDialog(
            title: Text(dialog.title),
            content: Text(dialog.content(code: codeLabel)),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(dialogContext).pop(false),
                child: Text(dialog.cancel),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                onPressed: () => Navigator.of(dialogContext).pop(true),
                child: Text(dialog.confirmButton),
              ),
            ],
          ),
        );
        if (confirmed != true || !context.mounted) return;
        try {
          await fireFlowAction(ref, offer, 'cancel_reservation');
          await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
          if (context.mounted) context.go('/');
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
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.red,
            ),
            child: const Icon(Icons.close, size: 16, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Text(
            t.twint.flow.takerPay.cancel,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}

// ─── taker: takerCharged (wait for maker) ────────────────────────────────────

final FlowBody twintTakerWaitConfirmBody = (context, ref, offer, engine, role) {
  final t = Translations.of(context);
  const codeLabel = 'TWINT';
  return _titled(context, t.twint.flow.takerWait.title, [
      // Green info box: what's happening right now.
      Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.green.withValues(alpha: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 20,
            ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                t.twint.flow.takerWait.body(code: codeLabel),
                style: const TextStyle(fontSize: 13, color: Colors.green),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 20),
      // Big green/white countdown matching the BLIK takerCharged circle.
      flowCountdownFor(
        context,
        engine,
        offer,
        caption: t.twint.flow.takerWait.autoConfirms,
        size: 200,
        strokeWidth: 16,
        fontSize: 48,
        progressColor: Colors.green,
        backgroundColor: Colors.white,
      ),
      const SizedBox(height: 20),
      // Blue info box: auto-confirm explanation.
      Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.blue.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.blue.withValues(alpha: 0.3)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 2),
            child: Icon(Icons.info_outline, color: Colors.blue, size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                t.twint.flow.takerWait.info,
                style: const TextStyle(fontSize: 13, color: Colors.blue),
                softWrap: true,
              ),
            ),
          ],
        ),
      ),
  ], breadcrumb: const TwintTakerProgressIndicator(activeStep: 2));
};

// ─── taker: expiredTwint ─────────────────────────────────────────────────────

final FlowBody twintTakerExpiredBody = (context, ref, offer, engine, role) {
  final t = Translations.of(context);
  const codeLabel = 'TWINT';
  final strings = t.twint.flow.takerExpired;

  Widget optionRow(IconData icon, Color color, String text) => Padding(
        padding: const EdgeInsets.only(top: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const SizedBox(width: 12),
            Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 13.5, height: 1.4),
          ),
            ),
          ],
        ),
      );

  Future<void> fireWithDialog({
    required String event,
    required String title,
    required String content,
    required String cancelLabel,
    required String confirmLabel,
    required Color confirmColor,
    bool leavesOffer = false,
  }) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder:
          (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: Text(cancelLabel),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                  backgroundColor: confirmColor,
                  foregroundColor: Colors.white,
                ),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            child: Text(confirmLabel),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;
    try {
      await fireFlowAction(ref, offer, event);
      if (leavesOffer) {
        // Cancelling releases the offer without this taker — no further
        // status updates reach them; return home.
        await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
        if (context.mounted) context.go('/');
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

  return _titled(context, strings.title(code: codeLabel), [
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.orange.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
        ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(top: 2),
                child: Icon(
                  Icons.warning_amber_rounded,
                  color: Colors.orange,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  strings.warning(code: codeLabel),
                  style: const TextStyle(
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          optionRow(
            Icons.check_circle_outline,
            Colors.green,
            strings.optionPaid(code: codeLabel),
          ),
          optionRow(Icons.cancel_outlined, Colors.red, strings.optionCancel),
          optionRow(
            Icons.hourglass_bottom,
            Colors.orange,
            strings.noDecision(code: codeLabel),
          ),
        ],
      ),
    ),
    flowCountdownFor(
      context,
      engine,
      offer,
      caption: strings.timerCaption,
      size: 100,
      strokeWidth: 8,
      fontSize: 24,
      progressColor: Colors.orange,
    ),
    const SizedBox(height: 24),
    FlowActionsBar(
      offer: offer,
      engine: engine,
      role: role,
      overrides: {
        // "I paid" — green success button, commits the taker to the claim.
        'mark_twint_charged':
            (_) => SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                onPressed:
                    () => fireWithDialog(
                  event: 'mark_twint_charged',
                  title: strings.markPaidDialog.title,
                  content: strings.markPaidDialog.content(code: codeLabel),
                  cancelLabel: strings.markPaidDialog.cancel,
                  confirmLabel: strings.markPaidDialog.confirmButton,
                  confirmColor: Colors.green,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check, color: Colors.white, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      strings.markPaid(code: codeLabel),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        // Cancel — red outlined, irreversible walk-away.
        'cancel_reservation':
            (_) => SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.red, width: 2),
                  foregroundColor: Colors.red,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                ),
                ),
                onPressed:
                    () => fireWithDialog(
                  event: 'cancel_reservation',
                  title: strings.cancelDialog.title,
                  content: strings.cancelDialog.content(code: codeLabel),
                  cancelLabel: strings.cancelDialog.cancel,
                  confirmLabel: strings.cancelDialog.confirmButton,
                  confirmColor: Colors.red,
                  leavesOffer: true,
                ),
                child: Text(
                  strings.cancel,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
      },
    ),
  ], breadcrumb: const TwintTakerProgressIndicator(activeStep: 1));
};

// ─── both roles: dispute ─────────────────────────────────────────────────────

class _DisputeEvidenceDeadlineCard extends ConsumerWidget {
  final Offer offer;

  const _DisputeEvidenceDeadlineCard({required this.offer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final period = ref.watch(
      coordinatorDisputeEvidenceDurationProvider(offer.coordinatorPubkey),
    );
    if (period == null) return const SizedBox.shrink();
    return _DisputeEvidenceCountdownCard(offer: offer, period: period);
  }
}

class _DisputeEvidenceCountdownCard extends StatefulWidget {
  final Offer offer;
  final Duration period;

  const _DisputeEvidenceCountdownCard({
    required this.offer,
    required this.period,
  });

  @override
  State<_DisputeEvidenceCountdownCard> createState() =>
      _DisputeEvidenceCountdownCardState();
}

class _DisputeEvidenceCountdownCardState
    extends State<_DisputeEvidenceCountdownCard> {
  late final Timer _timer;
  DateTime _now = DateTime.now();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() => _now = DateTime.now());
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _format(Duration duration) {
    final seconds = duration.inSeconds.clamp(0, 1 << 31);
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    final remainder = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:'
        '${minutes.toString().padLeft(2, '0')}:'
        '${remainder.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final strings = Translations.of(context).disputeChat.evidenceDeadline;
    final period = widget.period;
    final startedAt = widget.offer.disputeAt;
    final deadline = startedAt?.add(period);
    final remaining = deadline?.difference(_now);
    final expired = remaining != null && remaining <= Duration.zero;
    final color = expired ? Colors.orange : Colors.amber.shade800;
    final message = startedAt == null
        ? strings.period(time: _format(period))
        : expired
            ? strings.expired
            : strings.remaining(time: _format(remaining!));

    return Card(
      color: color.withValues(alpha: 0.10),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              expired ? Icons.timer_off_outlined : Icons.timer_outlined,
              color: color,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    strings.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 4),
                  Text(message),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Shared dispute body (maker + taker): gavel icon, role-appropriate
/// explanation, the offer amount, and the embedded coordinator dispute chat.
/// The FlowScreen terminal footer supplies the Done/home action.
final FlowBody twintDisputeBody = (context, ref, offer, engine, role) {
  final t = Translations.of(context);
  final isMaker = role == FlowActor.maker;
  return _titled(
    context,
    isMaker ? t.maker.conflict.headline : t.taker.dispute.headline,
    [
      const Icon(Icons.gavel_rounded, size: 80, color: Colors.deepPurple),
      const SizedBox(height: 16),
      Text(
        isMaker
            ? t.maker.conflict.feedback.disputeOpenedSuccess
            : t.taker.dispute.body,
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 12),
      Text(_amount(offer), style: Theme.of(context).textTheme.titleLarge),
      _DisputeEvidenceDeadlineCard(offer: offer),
      DisputeConversationCard(offer: offer),
    ],
  );
};

// Payout-tail + other terminal states have no bespoke body — they render via
// genericFlowBody (offer details + spinner/countdown + any yaml actions).
