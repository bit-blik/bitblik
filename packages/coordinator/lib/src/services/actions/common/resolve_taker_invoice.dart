part of '../../coordinator_service.dart';

/// Ensures the taker's payout invoice — requires a bolt11 from the params and
/// validates it against the expected net amount. Lightning-address (LNURL)
/// payout is not supported: the taker must supply an invoice.
class ResolveTakerInvoiceAction extends FlowAction {
  @override
  String get name => 'resolve_taker_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final inv = _cleanParam(ctx.params['taker_invoice']) ??
        _cleanParam(ctx.params['bolt11']);
    if (inv == null) {
      throw Exception('Missing taker invoice (bolt11) for submit.');
    }
    flow._c._validateTakerInvoiceAmount(ctx.offer, inv, action: 'submit_blik');
    ctx.write.takerInvoice = inv;
  }
}
