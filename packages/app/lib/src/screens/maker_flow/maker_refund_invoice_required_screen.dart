import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../i18n/gen/strings.g.dart';
import '../../flow/flow_controller.dart';
import '../../providers/providers.dart';
import '../../utils/bitcoin_display.dart';
import '../../widgets/dispute_conversation_card.dart';
import '../../widgets/receiving_invoice_form.dart';

/// The coordinator has committed a maker-favor ruling and now needs the maker
/// to choose where the exact refund should be paid.
class MakerRefundInvoiceRequiredScreen extends ConsumerStatefulWidget {
  final Offer offer;

  const MakerRefundInvoiceRequiredScreen({super.key, required this.offer});

  @override
  ConsumerState<MakerRefundInvoiceRequiredScreen> createState() =>
      _MakerRefundInvoiceRequiredScreenState();
}

class _MakerRefundInvoiceRequiredScreenState
    extends ConsumerState<MakerRefundInvoiceRequiredScreen> {
  String? error;

  Future<void> _submit(String invoice) async {
    if (mounted) setState(() => error = null);
    try {
      await fireFlowAction(
        ref,
        widget.offer,
        kRpcSubmitMakerRefundInvoice,
        extraParams: {'bolt11': invoice},
      );
    } catch (exception) {
      if (!mounted) return;
      final raw = exception.toString().toLowerCase();
      final errors = Translations.of(context).maker.refundInvoice.errors;
      final localized =
          raw.contains('no lightning payment backend')
              ? errors.backendUnavailable
              : raw.contains('missing maker refund invoice')
              ? errors.missing
              : raw.contains('invalid bolt11')
              ? errors.invalid
              : raw.contains('unsupported lightning network')
              ? errors.unsupportedNetwork
              : raw.contains('invoice is for')
              ? errors.wrongNetwork
              : raw.contains('must be exactly')
              ? errors.wrongAmount
              : raw.contains('invalid expiry')
              ? errors.invalidExpiry
              : raw.contains('timestamp is in the future')
              ? errors.futureTimestamp
              : raw.contains('has expired')
              ? errors.expired
              : raw.contains('no valid payment hash')
              ? errors.invalidPaymentHash
              : raw.contains('reuses the offer hold invoice')
              ? errors.reusedInvoice
              : errors.unknown;
      setState(() => error = localized);
    }
  }

  @override
  Widget build(BuildContext context) {
    final strings = Translations.of(context);
    final amountSats = widget.offer.amountSats + widget.offer.makerFees;
    final formattedAmount = formatBitcoinAmount(
      context,
      ref.watch(bitcoinDisplayUnitProvider),
      amountSats,
    );
    final failure = widget.offer.takerPaymentFailureReason?.trim();

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Icon(Icons.gavel_rounded, size: 72, color: Colors.green),
          const SizedBox(height: 12),
          Text(
            strings.maker.refundInvoice.title,
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            strings.maker.refundInvoice.instructions(amount: formattedAmount),
            textAlign: TextAlign.center,
          ),
          if (failure != null && failure.isNotEmpty) ...[
            const SizedBox(height: 12),
            Text(
              strings.maker.refundInvoice.paymentFailed,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
              textAlign: TextAlign.center,
            ),
          ],
          if (error != null) ...[
            const SizedBox(height: 12),
            Text(
              strings.maker.refundInvoice.submitFailed(details: error!),
              style: TextStyle(color: Theme.of(context).colorScheme.error),
              textAlign: TextAlign.center,
            ),
          ],
          const SizedBox(height: 20),
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ReceivingInvoiceForm(
                amountSats: amountSats,
                labels: ReceivingInvoiceFormLabels(
                  walletSectionTitle:
                      strings.taker.paymentFailed.walletSection.title,
                  defaultWalletLabel:
                      strings.taker.paymentFailed.walletSection.defaultLabel,
                  tapToGenerate:
                      (amount) => strings.taker.paymentFailed.walletSection
                          .tapToGenerate(amountSats: amount),
                  invoiceLabel: strings.maker.refundInvoice.invoiceLabel,
                  invoiceHint: strings.taker.paymentFailed.form.newInvoiceHint,
                  submitLabel: strings.maker.refundInvoice.submit,
                  emptyInvoiceError:
                      strings.taker.paymentFailed.errors.enterValidInvoice,
                  generationError:
                      (error) => strings.taker.paymentFailed.errors
                          .generateFailed(details: error),
                  addWalletLabel: strings.maker.refundInvoice.addWallet,
                  noReceivingWalletMessage:
                      strings.maker.refundInvoice.noReceivingWallet,
                  walletUnavailableError:
                      strings.receivingInvoice.errors.walletUnavailable,
                  missingBolt11Error: strings.receivingInvoice.errors.noBolt11,
                ),
                onSubmit: _submit,
              ),
            ),
          ),
          const SizedBox(height: 16),
          DisputeConversationCard(offer: widget.offer),
        ],
      ),
    );
  }
}
