part of '../../coordinator_service.dart';

/// Stamps when the taker reported being charged.
class StampTakerChargedAtAction extends FlowAction {
  @override
  String get name => 'stamp_taker_charged_at';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.takerChargedAt = ctx.now;
  }
}
