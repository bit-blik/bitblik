import '../../../i18n/gen/strings.g.dart'; // Corrected Slang import
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import 'package:ndk/shared/logger/logger.dart';

import 'package:bitblik_core/core.dart';
import '../../flow/flow_provider.dart' show flowRoute;
import '../../providers/providers.dart';
import '../../utils/bitcoin_display.dart';
import '../../widgets/progress_indicators.dart';
import '../../widgets/receiving_invoice_form.dart';

// Enum to manage screen state
enum PaymentRetryState { initial, loading, success, failed }

class TakerPaymentFailedScreen extends ConsumerStatefulWidget {
  // Changed to StatefulWidget
  final Offer offer;

  const TakerPaymentFailedScreen({super.key, required this.offer});

  @override
  ConsumerState<TakerPaymentFailedScreen> createState() =>
      _TakerPaymentFailedScreenState();
}

class _TakerPaymentFailedScreenState
    extends ConsumerState<TakerPaymentFailedScreen> {
  // State class
  PaymentRetryState _currentState = PaymentRetryState.initial; // Initial state
  String? _errorMessage; // To store error messages

  BuildContext? _retryDialogContext;

  void _closeRetryDialog() {
    final ctx = _retryDialogContext;
    _retryDialogContext = null;
    if (ctx != null && ctx.mounted) {
      Navigator.of(ctx).pop();
    }
  }

  void _handleStatusUpdate(OfferStatus? status) {
    if (status == null || !mounted) return;

    if (status == OfferStatus.takerPaid) {
      _closeRetryDialog();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) context.go(flowRoute);
      });
    } else if (status == OfferStatus.takerPaymentFailed) {
      _closeRetryDialog();
      if (mounted) {
        setState(() {
          _currentState = PaymentRetryState.failed;
          _errorMessage = t.taker.paymentFailed.errors.paymentRetryFailed;
        });
      }
    }
  }

  Future<void> _retryPayment(String newInvoice) async {
    if (!mounted) return;

    setState(() => _errorMessage = null);

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        _retryDialogContext = ctx;
        return PopScope(
          canPop: false,
          child: AlertDialog(
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 16),
                Text(t.taker.paymentFailed.loading.processingPayment),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() => _retryDialogContext = null);

    try {
      final apiService = ref.read(apiServiceProvider);
      final userPubkey = widget.offer.takerPubkey;
      if (userPubkey == null || userPubkey.isEmpty) {
        throw Exception(t.taker.paymentFailed.errors.takerPublicKeyNotFound);
      }
      await apiService.updateTakerInvoice(
        offerId: widget.offer.id,
        newBolt11: newInvoice,
        userPubkey: userPubkey,
        coordinatorPubkey: widget.offer.coordinatorPubkey,
      );
      // update_taker_invoice already transitions the YAML flow directly to
      // payingTaker. retry_taker_payment is only for reusing the stored invoice.
      // Dialog stays open — waiting for coordinator status update via ref.listen
    } catch (e) {
      _closeRetryDialog();
      if (mounted) {
        setState(() {
          _currentState = PaymentRetryState.failed;
          _errorMessage = t.taker.paymentFailed.errors.updatingInvoice(
            details: e.toString(),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the activeOfferProvider for status changes
    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (next != null && next.id == widget.offer.id) {
        try {
          final status = next.status;
          _handleStatusUpdate(status);
        } catch (e) {
          Logger.log.e(
            () => "Error parsing offer status in TakerPaymentFailedScreen: $e",
          );
        }
      }
    });

    // Calculate net amount (moved here for access to widget.offer)
    // Fallback uses 0.5% — historical default when no offer-level fee was
    // recorded. New offers always carry takerFees, so this branch is rare.
    final takerFees =
        widget.offer.takerFees ??
        OfferQuote.takerFeeSats(widget.offer.amountSats, 0.5);
    final netAmountSats = widget.offer.amountSats - takerFees;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Dismiss keyboard when tapping outside of text field
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TakerProgressIndicator(activeStep: 3),
              const SizedBox(height: 24),
              _buildContent(context, netAmountSats),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build content based on state
  Widget _buildContent(BuildContext context, int netAmountSats) {
    switch (_currentState) {
      case PaymentRetryState.loading:
      case PaymentRetryState.success:
      case PaymentRetryState.initial:
      case PaymentRetryState.failed:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              t.taker.paymentFailed.title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            if (widget.offer.takerLightningAddress != null &&
                widget.offer.takerLightningAddress!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Text(
                  t.lightningAddress.labels.short(
                    address: widget.offer.takerLightningAddress!,
                  ),
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey),
                ),
              ),
            const SizedBox(height: 8),
            if (widget.offer.takerPaymentFailureReason != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.offer.takerPaymentFailureReason!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.error,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_currentState == PaymentRetryState.failed &&
                _errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ),
            Text(
              t.taker.paymentFailed.instructions(
                netAmount: formatBitcoinAmount(
                  context,
                  ref.watch(bitcoinDisplayUnitProvider),
                  netAmountSats,
                ),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ReceivingInvoiceForm(
              amountSats: netAmountSats,
              labels: ReceivingInvoiceFormLabels(
                walletSectionTitle: t.taker.paymentFailed.walletSection.title,
                defaultWalletLabel:
                    t.taker.paymentFailed.walletSection.defaultLabel,
                tapToGenerate:
                    (amount) => t.taker.paymentFailed.walletSection
                        .tapToGenerate(amountSats: amount),
                invoiceLabel: t.taker.paymentFailed.form.newInvoiceLabel,
                invoiceHint: t.taker.paymentFailed.form.newInvoiceHint,
                submitLabel: t.taker.paymentFailed.actions.retryPayment,
                emptyInvoiceError:
                    t.taker.paymentFailed.errors.enterValidInvoice,
                generationError:
                    (error) => t.taker.paymentFailed.errors.generateFailed(
                      details: error.toString(),
                    ),
                addWalletLabel: t.nfc.actions.addWallet,
                noReceivingWalletMessage: t.wallet.missingReceiving.message,
                walletUnavailableError:
                    t.receivingInvoice.errors.walletUnavailable,
                missingBolt11Error: t.receivingInvoice.errors.noBolt11,
              ),
              onSubmit: _retryPayment,
            ),
          ],
        );
    }
  }
}
