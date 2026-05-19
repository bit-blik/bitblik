import 'dart:developer' as Logger;

import '../../../i18n/gen/strings.g.dart'; // Import Slang
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../models/offer.dart'; // Import Offer which contains OfferStatus
import '../../providers/providers.dart';
import '../../widgets/progress_indicators.dart'; // Import for TakerProgressIndicator

enum PaymentStep {
  makerConfirmed,
  makerSettled,
  payingTaker,
  takerPaid,
  takerPaymentFailed, // Add failed state
}

final Map<PaymentStep, OfferStatus> stepToStatusMapping = {
  PaymentStep.makerConfirmed: OfferStatus.makerConfirmed,
  PaymentStep.makerSettled: OfferStatus.settled,
  PaymentStep.payingTaker: OfferStatus.payingTaker,
  PaymentStep.takerPaid: OfferStatus.takerPaid,
  PaymentStep.takerPaymentFailed: OfferStatus.takerPaymentFailed,
};

// Define the order of successful steps
const List<PaymentStep> successfulStepsOrder = [
  PaymentStep.makerConfirmed,
  PaymentStep.makerSettled,
  PaymentStep.payingTaker,
  PaymentStep.takerPaid,
];

class TakerPaymentProcessScreen extends ConsumerWidget {
  const TakerPaymentProcessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const TakerProgressIndicator(activeStep: 3),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child:
                // paymentHash == null
                //     ? _buildErrorContent(
                //       context,
                //       t.taker.paymentProcess.errors.missingPaymentHash,
                //     )
                //     :
                _buildPollingContent(
                  context,
                  ref,
                  // , paymentHash
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPollingContent(
    BuildContext context,
    WidgetRef ref,
    // String paymentHash,
  ) {
    // Watch the active offer for real-time updates
    final offer = ref.watch(activeOfferProvider);

    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (next != null && next.id == offer!.id) {
        try {
          final status = OfferStatus.values.byName(next.status);
          print(status);
        } catch (e) {
          print(e);
        }
      }
    });

    if (offer == null) {
      // Offer might be loading or cleared, show a loading indicator.
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text(t.taker.paymentProcess.waitingForOfferUpdate),
        ],
      );
    }

    OfferStatus? currentStatus;
    try {
      currentStatus = OfferStatus.values.byName(offer.status);
    } catch (e) {
      return _buildErrorContent(
        context,
        t.offers.errors.loading(
          details: "Invalid offer status: ${offer.status}",
        ),
      );
    }

    // Build the checklist UI based on the current status from the active offer
    return _PaymentChecklist(
      currentStatus: currentStatus,
      // paymentHash: paymentHash, // Pass paymentHash
    );
  }

  // Helper for displaying general errors (like missing hash or polling failure)
  Widget _buildErrorContent(BuildContext context, String errorMessage) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error_outline,
          color: Theme.of(context).colorScheme.error,
          size: 60,
        ),
        const SizedBox(height: 20),
        Text(
          errorMessage,
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).colorScheme.error,
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
          onPressed: () => context.go('/'), // Go home on error
          child: Text(t.common.buttons.goHome),
        ),
      ],
    );
  }
}

// --- Checklist Widgets ---

class _PaymentChecklist extends ConsumerWidget {
  // Make ConsumerWidget
  final OfferStatus currentStatus;
  // final String paymentHash; // Add paymentHash field

  const _PaymentChecklist({
    required this.currentStatus,
    // required this.paymentHash, // Add paymentHash to constructor
  });

  String _getStepText(PaymentStep step) {
    switch (step) {
      case PaymentStep.makerConfirmed:
        return t.taker.paymentProcess.steps.makerConfirmedBlik;
      case PaymentStep.makerSettled:
        return t.taker.paymentProcess.steps.makerInvoiceSettled;
      case PaymentStep.payingTaker:
        return t.taker.paymentProcess.steps.payingTakerInvoice;
      case PaymentStep.takerPaid:
        return t.taker.paymentProcess.steps.takerInvoicePaid;
      case PaymentStep.takerPaymentFailed:
        return t.taker.paymentProcess.steps.takerPaymentFailed;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);

    bool isFailed = currentStatus == OfferStatus.takerPaymentFailed;

    // Find the index corresponding to the current status in the successful flow
    int currentStatusOrderIndex = successfulStepsOrder.indexWhere(
      (s) => stepToStatusMapping[s] == currentStatus,
    );

    return IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...List.generate(successfulStepsOrder.length, (index) {
            final step = successfulStepsOrder[index];
            ChecklistItemStatus itemStatus;
            int stepOrderIndex = index;

            // --- Refactored Status Logic ---
            if (isFailed) {
              if (stepOrderIndex == successfulStepsOrder.length - 1) {
                itemStatus = ChecklistItemStatus.error;
              } else {
                itemStatus = ChecklistItemStatus.completed;
              }
            } else {
              // Normal flow (not failed)
              if (currentStatusOrderIndex >= stepOrderIndex) {
                itemStatus = ChecklistItemStatus.completed;
              } else if (currentStatusOrderIndex == stepOrderIndex - 1) {
                itemStatus = ChecklistItemStatus.active;
              } else {
                itemStatus = ChecklistItemStatus.pending;
              }
            }
            // --- End Refactored Status Logic ---

            // Determine the correct text based on failure state for the last item
            String itemText;
            if (isFailed && stepOrderIndex == successfulStepsOrder.length - 1) {
              itemText = _getStepText(PaymentStep.takerPaymentFailed);
            } else {
              itemText = _getStepText(step);
            }

            return _ChecklistItem(
              text: itemText,
              status: itemStatus,
              // paymentHash: paymentHash, // Pass paymentHash down
              isLastError:
                  isFailed && stepOrderIndex == successfulStepsOrder.length - 1,
            );
          }),
          // Show Done button only when the final step (takerPaid) is completed
          if (currentStatus == OfferStatus.takerPaid) ...[
            const SizedBox(height: 30),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await ref
                      .read(activeOfferProvider.notifier)
                      .setActiveOffer(null);
                  ref.read(holdInvoiceProvider.notifier).state = null;
                  ref.read(paymentHashProvider.notifier).state = null;
                  ref.read(receivedBlikCodeProvider.notifier).state = null;
                  ref.read(errorProvider.notifier).state = null;
                  ref.read(isLoadingProvider.notifier).state = false;
                  ref.invalidate(availableOffersProvider);
                  context.go("/");
                },
                child: Text(t.common.buttons.done),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

enum ChecklistItemStatus { pending, active, completed, error }

class _ChecklistItem extends ConsumerWidget {
  // Make ConsumerWidget
  final String text;
  final ChecklistItemStatus status;
  // final String paymentHash; // Add paymentHash field
  final bool isLastError;

  const _ChecklistItem({
    required this.text,
    required this.status,
    // required this.paymentHash, // Add paymentHash to constructor
    this.isLastError = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Widget leadingIcon;
    Color textColor =
        Theme.of(context).textTheme.bodyMedium?.color ?? Colors.black;
    TextStyle textStyle =
        Theme.of(context).textTheme.titleMedium ?? const TextStyle();

    switch (status) {
      case ChecklistItemStatus.pending:
        leadingIcon = const Icon(
          Icons.circle_outlined,
          size: 24,
          color: Colors.grey,
        );
        textColor = Colors.grey;
        textStyle = textStyle.copyWith(color: textColor);
        break;
      case ChecklistItemStatus.active:
        leadingIcon = const SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(strokeWidth: 3),
        );
        textStyle = textStyle.copyWith(fontWeight: FontWeight.bold);
        break;
      case ChecklistItemStatus.completed:
        leadingIcon = const Icon(
          Icons.check_circle,
          size: 24,
          color: Colors.green,
        );
        break;
      case ChecklistItemStatus.error:
        leadingIcon = Icon(
          Icons.error,
          size: 24,
          color: Theme.of(context).colorScheme.error,
        );
        textColor = Theme.of(context).colorScheme.error;
        textStyle = textStyle.copyWith(
          color: textColor,
          fontWeight: FontWeight.bold,
        );
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              leadingIcon,
              const SizedBox(width: 16),
              Expanded(child: Text(text, style: textStyle)),
            ],
          ),
          if (isLastError) ...[
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: Text(
                t.taker.paymentProcess.errors.takerPaymentFailed,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
                textAlign: TextAlign.left,
              ),
            ),
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.only(left: 40.0),
              child: ElevatedButton.icon(
                icon: const Icon(Icons.arrow_forward),
                label: Text(t.taker.paymentProcess.actions.goToFailureDetails),
                onPressed: () {
                  final offer = ref.read(activeOfferProvider);

                  if (offer != null) {
                    context.go('/taker-failed', extra: offer);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(t.offers.errors.notFound),
                        backgroundColor: Theme.of(context).colorScheme.error,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
