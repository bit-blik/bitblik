part of '../../coordinator_service.dart';

/// Pays out the taker over Lightning after `payingTaker` has been committed as
/// the durable work claim. Success/failure is finalized by that state's auto
/// completion edge.
class SendPaymentAction extends FlowAction {
  @override
  String get name => 'send_payment';

  @override
  bool get requiresCommittedState => true;

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final c = flow._c;
    final offer = ctx.offer;
    final takerFees = c._effectiveTakerFeeSats(offer);
    final netAmountSats = offer.amountSats - takerFees;

    var invoice = offer.takerInvoice;
    if (invoice == null || invoice.isEmpty) {
      // Payout is bolt11-only: the taker must have supplied an invoice by
      // this point (submit / reserve / update_taker_invoice).
      throw const FlowTransitionFailure('Missing taker invoice');
    }

    try {
      c._validateTakerInvoiceAmount(offer, invoice, action: 'pay_taker');
    } catch (e) {
      throw FlowTransitionFailure(e.toString());
    }

    final feeLimitSat = (takerFees * kTakerFeeLimitFactor).ceil();
    final res =
        await c._attemptTakerPayment(invoice, netAmountSats, feeLimitSat);
    if (!res.ok) {
      throw FlowTransitionFailure(res.error ?? 'Payment failed');
    }

    ctx.write.takerFees = takerFees;
    ctx.write.takerInvoiceFees = res.result?.feeSat ?? 0;
    ctx.write.takerPaidAt = ctx.now;
    ctx.write.audit.addAll({
      'taker_fees': takerFees,
      'fee_sats': res.result?.feeSat ?? 0,
      'payment_succeeded': true,
    });
  }

  @override
  List<String> validate(
      FlowEngine engine, FlowState state, FlowTransition edge) {
    return const [];
  }
}
