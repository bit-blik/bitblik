part of '../../coordinator_service.dart';

/// Stores the taker's payout invoice verbatim from the params (e.g. captured
/// at reserve time in TWINT). Lightning-address params are ignored — payout
/// requires a bolt11, enforced at resolve/update/send time.
class AcceptTakerInvoiceAction extends FlowAction {
  @override
  String get name => 'accept_taker_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.takerInvoice = _cleanParam(ctx.params['taker_invoice']) ??
        _cleanParam(ctx.params['bolt11']);
  }
}
