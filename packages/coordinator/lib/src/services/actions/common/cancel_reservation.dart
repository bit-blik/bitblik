part of '../../coordinator_service.dart';

/// Clear taker-owned fields so the offer becomes open again.
class CancelReservationAction extends FlowAction {
  @override
  String get name => 'cancel_reservation';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.clearTakerFields = true;
    ctx.write.preserveCodeOnClear =
        flow._c._paymentSystem.makerProvidesCodeAtOfferCreation;
  }
}
