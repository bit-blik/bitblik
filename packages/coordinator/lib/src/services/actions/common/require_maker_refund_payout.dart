part of '../../coordinator_service.dart';

/// Validates exactly one maker refund instruction before the committed refund
/// state is entered.
class RequireMakerRefundPayoutAction extends FlowAction {
  @override
  String get name => 'require_maker_refund_payout';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final payment = await flow._c._validateMakerRefundPayout(
      ctx.offer,
      invoice: _cleanParam(ctx.params['maker_invoice']),
      bolt12Offer: _cleanParam(ctx.params['maker_offer']),
    );
    ctx.write.makerRefundInvoice = payment.invoice;
    ctx.write.makerRefundOffer = payment.offer;
    ctx.write.makerRefundPaymentHash = payment.paymentHash;
  }
}
