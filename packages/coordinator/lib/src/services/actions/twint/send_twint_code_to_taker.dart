part of '../../coordinator_service.dart';

/// TWINT, informational no-op: the reserve RPC response and
/// get_offer_details reveal the code to the assigned taker.
class SendTwintCodeToTakerAction extends FlowAction {
  @override
  String get name => 'send_twint_code_to_taker';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {}
}
