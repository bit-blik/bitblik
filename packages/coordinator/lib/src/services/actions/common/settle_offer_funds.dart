part of '../../coordinator_service.dart';

/// Composite: stamp settlement time and settle the maker's hold invoice.
class SettleOfferFundsAction extends FlowAction {
  @override
  String get name => 'settle_offer_funds';

  @override
  bool get requiresCommittedState => true;

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.settledAt = ctx.now;
    final offer = ctx.offer;
    final backend = flow._c._paymentBackend;
    final preimage = offer.holdInvoicePreimage;
    final paymentHash = offer.holdInvoicePaymentHash;
    if (backend == null || preimage == null || paymentHash == null) {
      throw StateError('Cannot settle offer ${offer.id}: missing payment '
          'backend, preimage, or payment hash.');
    }
    try {
      await backend.settleInvoice(preimageHex: preimage);
    } catch (_) {
      // Settlement is idempotent at the flow level: if the backend applied it
      // before a crash/transport error, finalize without issuing it again.
      final invoice = await backend.lookupInvoice(paymentHashHex: paymentHash);
      if (invoice.status == InvoiceStatus.SETTLED) return;
      rethrow;
    }
  }
}
