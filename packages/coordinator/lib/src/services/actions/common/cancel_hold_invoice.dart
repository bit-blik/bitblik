part of '../../coordinator_service.dart';

/// Cancels the maker's hold invoice (funds return to the maker). A failure
/// here propagates so the transition does not commit and can be retried.
class CancelHoldInvoiceAction extends FlowAction {
  @override
  String get name => 'cancel_hold_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final offer = ctx.offer;
    if (flow._c._paymentBackend == null ||
        offer.holdInvoicePaymentHash == null) {
      return;
    }
    await flow._c._paymentBackend!
        .cancelInvoice(paymentHashHex: offer.holdInvoicePaymentHash!);
  }
}
