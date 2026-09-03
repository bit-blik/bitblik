import 'package:bitblik/src/utils/code_label_ext.dart';
import '../../../i18n/gen/strings.g.dart'; // Import Slang
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:bitblik_core/core.dart';
import '../../flow/flow_provider.dart' show flowEngineProvider, flowRoute;
import '../../flow/flow_timeout.dart';
import '../../providers/providers.dart';
import '../../widgets/dispute_conversation_card.dart';

class MakerConflictScreen extends ConsumerStatefulWidget {
  final Offer offer;

  final FlowEngine? engine;

  const MakerConflictScreen({super.key, required this.offer, this.engine});

  @override
  ConsumerState<MakerConflictScreen> createState() =>
      _MakerConflictScreenState();
}

class _MakerConflictScreenState extends ConsumerState<MakerConflictScreen> {
  bool _isDisputeOpened = false;
  bool _isSubmitting = false;
  // final _formKey = GlobalKey<FormState>(); // Not used currently
  // final _lnAddressController = TextEditingController(); // Not used currently

  // @override
  // void dispose() {
  //   _lnAddressController.dispose(); // Not used currently
  //   super.dispose();
  // }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(t.maker.confirmPayment.confirmDialog.title),
          content: Text(
            t.maker.confirmPayment.confirmDialog.content(
              code: paymentSystemForOffer(widget.offer).localizedCodeLabel,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.maker.confirmPayment.confirmDialog.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text(t.maker.confirmPayment.confirmDialog.confirmButton),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      await _confirmPayment(context, ref);
    }
  }

  Future<void> _confirmPayment(BuildContext context, WidgetRef ref) async {
    final apiService = ref.read(apiServiceProvider);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final makerId = await ref.read(publicKeyProvider.future);
    if (!context.mounted) return;

    if (makerId == null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(t.maker.amountForm.errors.publicKeyNotLoaded)),
      );
      return;
    }
    ref.read(errorProvider.notifier).state = null;
    setState(() => _isSubmitting = true);

    try {
      await apiService.confirmMakerPayment(
        widget.offer.id,
        makerId,
        widget.offer.coordinatorPubkey,
      );
      if (!context.mounted) return;

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: Text(t.maker.confirmPayment.feedback.confirmedTakerPaid),
        ),
      );
      context.go(flowRoute, extra: widget.offer);
    } catch (e) {
      final errorMsg = t.maker.confirmPayment.errors.confirming(
        details: e.toString(),
      );
      ref.read(errorProvider.notifier).state = errorMsg;
      if (context.mounted) {
        scaffoldMessenger.showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  Future<void> _openDispute(BuildContext context, WidgetRef ref) async {
    // return;
    final apiService = ref.read(apiServiceProvider);
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final makerId = await ref.read(publicKeyProvider.future);
    if (!context.mounted) return;

    if (makerId == null) {
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(t.maker.amountForm.errors.publicKeyNotLoaded)),
      );
      return;
    }

    final bool? confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(t.maker.conflict.disputeDialog.title),
          content: Text(t.maker.conflict.disputeDialog.contentDetailed),
          actions: <Widget>[
            TextButton(
              child: Text(t.common.buttons.cancel),
              onPressed: () => context.pop(false),
            ),
            ElevatedButton(
              child: Text(t.maker.conflict.disputeDialog.actions.confirm),
              onPressed: () => context.pop(true),
            ),
          ],
        );
      },
    );

    if (confirmed != true) {
      return;
    }
    if (!context.mounted) return;

    ref.read(errorProvider.notifier).state = null;
    setState(() => _isSubmitting = true);

    try {
      await apiService.openDispute(
        widget.offer.id,
        widget.offer.coordinatorPubkey,
      );
      if (!context.mounted) return;

      setState(() {
        _isDisputeOpened = true;
      });
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(t.maker.conflict.feedback.disputeOpenedSuccess)),
      );
    } catch (e) {
      final errorMsg = t.maker.conflict.errors.openingDispute(
        error: e.toString(),
      );
      ref.read(errorProvider.notifier).state = errorMsg;
      if (context.mounted) {
        scaffoldMessenger.showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final engine = widget.engine ?? ref.watch(flowEngineProvider).valueOrNull;
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 24),
            const Icon(Icons.gavel_rounded, size: 80, color: Colors.deepPurple),
            const SizedBox(height: 24),
            Text(
              t.maker.conflict.headline,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              _isDisputeOpened || widget.offer.isDispute
                  ? t.maker.conflict.feedback.disputeOpenedSuccess
                  : t.maker.conflict.body(
                    code:
                        paymentSystemForOffer(widget.offer).localizedCodeLabel,
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            if (_isDisputeOpened || widget.offer.isDispute) ...[
              DisputeConversationCard(
                offer:
                    widget.offer.isDispute
                        ? widget.offer
                        : widget.offer.copyWith(
                          status: OfferStatus.dispute,
                          statusRaw: OfferStatus.dispute.name,
                        ),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: Text(t.common.buttons.goHome),
              ),
            ] else
              Column(
                children: [
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Icons.hourglass_top_rounded),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(t.maker.conflict.instructions),
                                const SizedBox(height: 12),
                                if (engine != null)
                                  FlowCountdown(
                                    deadline: flowStateDeadline(
                                      engine,
                                      widget.offer.statusRaw,
                                      widget.offer,
                                    ),
                                    label:
                                        (time) => t.maker.conflict.timeoutLabel(
                                          time: time,
                                        ),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.deepOrange,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                    ),
                    // Keep the conflict explanation and countdown visible
                    // while the request is running; only disable its actions.
                    onPressed:
                        _isSubmitting
                            ? null
                            : () => _showConfirmationDialog(context, ref),
                    child: Text(
                      t.maker.conflict.actions.confirmPayment(
                        code:
                            paymentSystemForOffer(
                              widget.offer,
                            ).localizedCodeLabel,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.error,
                      foregroundColor: Colors.white,
                    ),
                    onPressed:
                        _isSubmitting ? null : () => _openDispute(context, ref),
                    child: Text(
                      t.maker.conflict.actions.openDispute(
                        code:
                            paymentSystemForOffer(
                              widget.offer,
                            ).localizedCodeLabel,
                      ),
                    ),
                  ),
                  // const SizedBox(height: 16),
                  // TextButton(
                  //   onPressed: () => context.go('/'),
                  //   child: Text(t.common.actions.cancelAndReturnHome),
                  // ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
