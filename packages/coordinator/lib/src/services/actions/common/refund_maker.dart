part of '../../coordinator_service.dart';

/// Pays the maker's (pre-validated — see `require_maker_refund_invoice` or
/// `require_maker_refund_payout`)
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
    final bolt12Offer = offer.makerRefundOffer;
    if ((invoice == null) == (bolt12Offer == null) ||
        flow._c._paymentBackend == null) {
      throw StateError(
        'Cannot refund maker for offer ${offer.id}: invalid persisted refund instruction or payment backend.',
      );
    }
    final refundSats = offer.amountSats + offer.makerFees;
    final feeLimit = (refundSats * 0.01).ceil().clamp(10, refundSats);
    // PILA refund maker should not attempt to pay taker, WTF!?
    final res = await flow._c._attemptOutgoingPayment(
      offer: offer,
      purpose: 'maker_refund',
      invoice: invoice,
      bolt12Offer: bolt12Offer,
      amountSats: refundSats,
      feeLimitSat: feeLimit,
    );
    if (res.isSuccess) {
      AppLogger.info(
          'Dispute refund paid to maker for offer ${offer.id} '
          '($refundSats sats).',
          offerId: offer.id);
      return;
    }
    if (res.status == PaymentStatus.FAILED) {
      throw FlowTransitionFailure(
        res.error ?? 'Dispute refund payment failed',
      );
    }
    throw StateError(
      res.error ??
          'Refund state is ${res.status.name}; reconciliation required',
    );
  }
}
