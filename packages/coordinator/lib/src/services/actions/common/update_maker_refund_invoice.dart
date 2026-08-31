part of '../../coordinator_service.dart';

/// Persists the maker's exact-amount dispute payout invoice before the flow
/// enters `payingMaker`. Authorization comes from the signed RPC author and the
/// YAML `by: maker` actor guard, never from a pubkey parameter.
class UpdateMakerRefundInvoiceAction extends FlowAction {
  @override
  String get name => 'update_maker_refund_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final invoice = _cleanParam(ctx.params['maker_invoice']) ??
        _cleanParam(ctx.params['bolt11']);
    if (invoice == null) {
      throw Exception('Missing maker refund invoice (bolt11).');
    }

    final validated = flow._c._validateMakerRefundInvoice(ctx.offer, invoice);
    ctx.write.makerRefundInvoice = validated.invoice;
    ctx.write.makerRefundPaymentHash = validated.paymentHash;
    ctx.write.audit.addAll({
      'maker_refund_invoice_ready': true,
      'maker_refund_amount_sats': validated.amountSats,
    });
  }
}
