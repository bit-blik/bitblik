part of '../../coordinator_service.dart';

/// Writes the taker's replacement payout invoice after a payout failure
/// (`update_taker_invoice` from `takerPaymentFailed`). Without this action the
/// transition committed with `do: []` and the fresh invoice was silently
/// dropped, looping the offer back into the same failing payment.
///
/// Payout is bolt11-only: the new invoice is validated against the expected
/// net amount pre-commit so a bad invoice rejects the transition (and the
/// RPC) instead of re-entering `payingTaker` with an invoice that can never
/// pay. Accepts the legacy wire param `bolt11` (what the app sends) as well
/// as `taker_invoice`.
class UpdateTakerInvoiceAction extends FlowAction {
  @override
  String get name => 'update_taker_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final inv = _cleanParam(ctx.params['taker_invoice']) ??
        _cleanParam(ctx.params['bolt11']);
    if (inv == null) {
      throw Exception('Missing taker invoice (bolt11) for update.');
    }
    flow._c._validateTakerInvoiceAmount(ctx.offer, inv,
        action: 'update_taker_invoice');
    ctx.write.takerInvoice = inv;
  }
}
