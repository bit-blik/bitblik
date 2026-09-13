part of '../../coordinator_service.dart';

/// Resolves and validates exactly one taker payout instruction.
class ResolveTakerPayoutAction extends FlowAction {
  @override
  String get name => 'resolve_taker_payout';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final payment = await flow._c._validateTakerPayoutInstruction(
      ctx.offer,
      ctx.params,
      action: 'submit_blik',
    );
    ctx.write.takerInvoice = payment.invoice;
    ctx.write.takerOffer = payment.offer;
  }
}
