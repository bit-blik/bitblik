part of '../../coordinator_service.dart';

/// Stamps when the current payment code was issued/received — the base for
/// code-lifespan timeouts (`from_field: code_received_at`).
class StampCodeReceivedAtAction extends FlowAction {
  @override
  String get name => 'stamp_code_received_at';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.codeReceivedAt = ctx.now;
  }
}
