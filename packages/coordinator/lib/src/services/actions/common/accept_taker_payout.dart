part of '../../coordinator_service.dart';

/// Validates and stores at most one typed taker payout instruction captured by
/// an early flow action such as reservation.
class AcceptTakerPayoutAction extends FlowAction {
  @override
  String get name => 'accept_taker_payout';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final payment = await flow._c._validateTakerPayoutInstruction(
      ctx.offer,
      ctx.params,
      action: 'reserve_offer',
      required: false,
    );
    ctx.write.takerInvoice = payment.invoice;
    ctx.write.takerOffer = payment.offer;
  }
}
