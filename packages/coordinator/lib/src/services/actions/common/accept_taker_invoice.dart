part of '../../coordinator_service.dart';

/// Stores the taker's payout invoice / Lightning address verbatim from the
/// params (e.g. captured at reserve time in TWINT).
class AcceptTakerInvoiceAction extends FlowAction {
  @override
  String get name => 'accept_taker_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.takerInvoice = _cleanParam(ctx.params['taker_invoice']);
    ctx.write.takerLightningAddress =
        _cleanParam(ctx.params['taker_lightning_address']);
  }
}
