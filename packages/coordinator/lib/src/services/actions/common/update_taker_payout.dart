part of '../../coordinator_service.dart';

/// Validates and persists a replacement BOLT11 or BOLT12 taker payout after a
/// definitive failure. The public RPC event remains `update_taker_invoice` for
/// protocol compatibility.
class UpdateTakerPayoutAction extends FlowAction {
  @override
  String get name => 'update_taker_payout';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final payment = await flow._c._validateTakerPayoutInstruction(
      ctx.offer,
      ctx.params,
      action: 'update_taker_invoice',
    );
    ctx.write.takerInvoice = payment.invoice;
    ctx.write.takerOffer = payment.offer;
  }
}
