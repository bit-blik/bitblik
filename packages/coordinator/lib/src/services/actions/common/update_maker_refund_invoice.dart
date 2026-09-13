part of '../../coordinator_service.dart';

/// Persists the maker's exact-amount dispute payout instruction before the flow
/// enters `payingMaker`. Authorization comes from the signed RPC author and the
/// YAML `by: maker` actor guard, never from a pubkey parameter.
class UpdateMakerRefundInvoiceAction extends FlowAction {
  @override
  String get name => 'update_maker_refund_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final invoice = _cleanParam(ctx.params['maker_invoice']) ??
        _cleanParam(ctx.params['bolt11']);
    final validated = await flow._c._validateMakerRefundPayout(
      ctx.offer,
      invoice: invoice,
      bolt12Offer: _cleanParam(ctx.params['maker_offer']),
    );
    ctx.write.makerRefundInvoice = validated.invoice;
    ctx.write.makerRefundOffer = validated.offer;
    ctx.write.makerRefundPaymentHash = validated.paymentHash;
    ctx.write.audit.addAll({
      'maker_refund_invoice_ready': validated.invoice != null,
      'payment_type': validated.invoice != null ? 'bolt11' : 'bolt12',
      'maker_refund_amount_sats': validated.amountSats,
    });
  }
}
