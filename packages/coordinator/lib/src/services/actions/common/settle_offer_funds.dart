part of '../../coordinator_service.dart';

/// Composite: stamp settlement time and settle the maker's hold invoice.
class SettleOfferFundsAction extends FlowAction {
  @override
  String get name => 'settle_offer_funds';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.settledAt = ctx.now;
    final offer = ctx.offer;
    if (flow._c._paymentBackend == null || offer.holdInvoicePreimage == null) {
      return;
    }
    await flow._c._paymentBackend!
        .settleInvoice(preimageHex: offer.holdInvoicePreimage!);
  }
}
