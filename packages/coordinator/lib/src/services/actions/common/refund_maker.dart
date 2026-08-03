part of '../../coordinator_service.dart';

/// Pays the maker's (pre-validated — see `require_maker_refund_invoice`)
/// dispute-refund invoice. The refunding state is committed first and remains
/// in place for retry until the payment succeeds.
class RefundMakerAction extends FlowAction {
  @override
  String get name => 'refund_maker';

  @override
  bool get requiresCommittedState => true;

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final offer = ctx.offer;
    final invoice = offer.makerRefundInvoice;
    if (invoice == null || flow._c._paymentBackend == null) {
      throw StateError('Cannot refund maker for offer ${offer.id}: missing '
          'persisted refund invoice or payment backend.');
    }
    final refundSats = offer.amountSats + offer.makerFees;
    final feeLimit = (refundSats * 0.01).ceil().clamp(10, refundSats);
    // PILA refund maker should not attempt to pay taker, WTF!?
    final res =
        await flow._c._attemptTakerPayment(invoice, refundSats, feeLimit);
    if (res.ok) {
      AppLogger.info(
          'Dispute refund paid to maker for offer ${offer.id} '
          '($refundSats sats).',
          offerId: offer.id);
      return;
    }
    throw FlowTransitionFailure(res.error ?? 'Dispute refund payment failed');
  }
}
