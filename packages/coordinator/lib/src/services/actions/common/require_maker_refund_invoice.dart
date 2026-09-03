part of '../../coordinator_service.dart';

/// Guard for dispute refunds. The maker must have submitted the payout invoice
/// through their own authenticated RPC before the coordinator rules. Chat and
/// coordinator-supplied ruling parameters are never financial source of truth.
class RequireMakerRefundInvoiceAction extends FlowAction {
  @override
  String get name => 'require_maker_refund_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final invoice = ctx.offer.makerRefundInvoice;
    if (invoice == null) {
      throw Exception('The maker has not submitted a refund invoice.');
    }
    final validated = flow._c._validateMakerRefundInvoice(ctx.offer, invoice);
    if (ctx.offer.makerRefundPaymentHash != validated.paymentHash) {
      throw Exception(
          'Persisted maker refund invoice metadata is inconsistent.');
    }
    ctx.write.audit['maker_refund_invoice_ready'] = true;
  }
}
