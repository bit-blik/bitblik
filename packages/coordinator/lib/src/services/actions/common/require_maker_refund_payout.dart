part of '../../coordinator_service.dart';

/// Validates exactly one maker refund instruction before the committed refund
/// state is entered.
class RequireMakerRefundPayoutAction extends FlowAction {
  @override
  String get name => 'require_maker_refund_payout';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final expected = ctx.offer.amountSats + ctx.offer.makerFees;
    final payment = await flow._c._validateOutgoingInstruction(
      invoice: _cleanParam(ctx.params['maker_invoice']),
      offer: _cleanParam(ctx.params['maker_offer']),
      expectedAmountSats: expected,
      action: 'refund_maker',
    );
    ctx.write.makerRefundInvoice = payment.invoice;
    ctx.write.makerRefundOffer = payment.offer;
  }
}
