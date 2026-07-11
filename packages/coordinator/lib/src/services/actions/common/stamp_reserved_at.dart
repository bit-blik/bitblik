part of '../../coordinator_service.dart';

/// Stamps the reservation time (the base of reservation windows).
class StampReservedAtAction extends FlowAction {
  @override
  String get name => 'stamp_reserved_at';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.reservedAt = ctx.now.add(const Duration(seconds: 1));
  }
}
