part of '../../coordinator_service.dart';

/// CAS-guards that the acting taker is still the offer's assigned taker at
/// commit time.
class AssertAssignedTakerAction extends FlowAction {
  @override
  String get name => 'assert_assigned_taker';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.expectedTakerPubkey = ctx.offer.takerPubkey;
  }
}
