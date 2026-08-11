part of '../../coordinator_service.dart';

/// Cancels the maker's hold invoice after a cancelling/expiring state has been
/// committed. A failure leaves that durable state in place for retry.
class CancelHoldInvoiceAction extends FlowAction {
  @override
  String get name => 'cancel_hold_invoice';

  @override
  bool get requiresCommittedState => true;

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final offer = ctx.offer;
    final backend = flow._c._paymentBackend;
    final paymentHash = offer.holdInvoicePaymentHash;
    if (backend == null || paymentHash == null) {
      throw StateError('Cannot cancel offer ${offer.id}: missing payment '
          'backend or hold-invoice payment hash.');
    }
    try {
      await backend.cancelInvoice(paymentHashHex: paymentHash);
    } catch (_) {
      // The cancellation may have succeeded just before a process/transport
      // failure. Confirm the desired terminal invoice state before retrying.
      final invoice = await backend.lookupInvoice(paymentHashHex: paymentHash);
      if (invoice.status == InvoiceStatus.CANCELED) return;
      rethrow;
    }
  }
}
