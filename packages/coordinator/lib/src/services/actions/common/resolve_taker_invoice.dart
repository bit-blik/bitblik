part of '../../coordinator_service.dart';

/// Ensures the taker's payout invoice — accepts a bolt11 from the params
/// (validated against the expected net amount) or resolves one from the
/// taker's Lightning address via LNURL.
class ResolveTakerInvoiceAction extends FlowAction {
  @override
  String get name => 'resolve_taker_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final lnAddr = _cleanParam(ctx.params['taker_lightning_address']);
    var inv = _cleanParam(ctx.params['taker_invoice']);
    if (inv == null) {
      if (lnAddr == null) {
        throw Exception(
            'Missing taker invoice and lightning address for submit.');
      }
      inv = await flow._c._resolveLnurlPay(
          lnAddr, flow._c._expectedTakerNetAmountSats(ctx.offer));
      if (inv == null || inv.isEmpty) {
        throw Exception('Could not resolve a taker invoice from $lnAddr.');
      }
    } else {
      flow._c
          ._validateTakerInvoiceAmount(ctx.offer, inv, action: 'submit_blik');
    }
    ctx.write.takerInvoice = inv;
    ctx.write.takerLightningAddress = lnAddr;
  }
}
