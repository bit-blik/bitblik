part of '../../coordinator_service.dart';

/// TWINT, informational no-op: the maker learns of the charge via the
/// targeted status update published on state entry.
class NotifyMakerOfChargeAction extends FlowAction {
  @override
  String get name => 'notify_maker_of_charge';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {}
}
