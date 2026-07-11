part of '../../coordinator_service.dart';

/// Stamps the maker's payment confirmation.
class StampMakerConfirmedAtAction extends FlowAction {
  @override
  String get name => 'stamp_maker_confirmed_at';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.makerConfirmedAt = ctx.now;
  }
}
