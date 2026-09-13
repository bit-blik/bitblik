part of '../../coordinator_service.dart';

/// Guard for dispute refunds. The maker must have submitted the payout instruction
/// through their own authenticated RPC before the coordinator rules. Chat and
/// coordinator-supplied ruling parameters are never financial source of truth.
class RequireMakerRefundInvoiceAction extends FlowAction {
  @override
  String get name => 'require_maker_refund_invoice';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final validated = await flow._c._validateMakerRefundPayout(
      ctx.offer,
      invoice: ctx.offer.makerRefundInvoice,
      bolt12Offer: ctx.offer.makerRefundOffer,
    );
    if (ctx.offer.makerRefundPaymentHash != validated.paymentHash) {
      throw Exception(
          'Persisted maker refund payout metadata is inconsistent.');
    }
    ctx.write.audit['maker_refund_invoice_ready'] = validated.invoice != null;
  }
}
