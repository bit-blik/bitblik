part of '../../coordinator_service.dart';

/// Pays the maker's (pre-validated — see `require_maker_refund_invoice`)
/// dispute-refund invoice. A payment failure here is logged for manual
/// follow-up — the state has already moved to cancelled and the funds stay
/// with the coordinator until the operator retries.
class RefundMakerAction extends FlowAction {
  @override
  String get name => 'refund_maker';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final offer = ctx.offer;
    final invoice = _cleanParam(ctx.params['maker_invoice']);
    if (invoice == null || flow._c._paymentBackend == null) return;
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
