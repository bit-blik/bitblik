part of '../../coordinator_service.dart';

/// Composite: bind the first taker and stamp the reservation time.
class ReserveTakerAction extends FlowAction {
  @override
  String get name => 'reserve_taker';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.takerPubkey = ctx.userPubkey;
    ctx.write.reservedAt = ctx.now.add(const Duration(seconds: 1));
  }
}
