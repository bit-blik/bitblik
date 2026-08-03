part of '../../coordinator_service.dart';

/// Guard for dispute refunds: the hold invoice was already settled entering
/// the dispute, so the maker is repaid via a fresh invoice they provided out
/// of band (`maker_invoice` param). Validating pre-commit rejects the whole
/// resolution on a bad/missing invoice instead of stranding a cancelled offer;
/// the payment itself is the post-commit `refund_maker` action.
class RequireMakerRefundInvoiceAction extends FlowAction {
  @override
  String get name => 'require_maker_refund_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final invoice = _cleanParam(ctx.params['maker_invoice']);
    if (invoice == null) {
      throw Exception(
          'Missing maker_invoice for the dispute refund resolution.');
    }
    final expected = ctx.offer.amountSats + ctx.offer.makerFees;
    final req = Bolt11PaymentRequest(invoice);
    final invoiceAmountSats =
        (req.amount * Decimal.fromInt(100000000)).toBigInt().toInt();
    if (invoiceAmountSats <= 0) {
      throw Exception('maker_invoice must encode an amount (~$expected sats).');
    }
    if (invoiceAmountSats > expected + 10 ||
        invoiceAmountSats < expected - 100) {
      throw Exception(
          'maker_invoice amount $invoiceAmountSats sats does not match the '
          'expected refund of ~$expected sats.');
    }
    ctx.write.makerRefundInvoice = invoice;
  }
}
