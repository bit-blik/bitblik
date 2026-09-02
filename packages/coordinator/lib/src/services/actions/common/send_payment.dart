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

    final invoice = offer.takerInvoice;
    final bolt12Offer = offer.takerOffer;
    if ((invoice == null) == (bolt12Offer == null)) {
      throw const FlowTransitionFailure(
        'Exactly one taker payout instruction is required',
      );
    }

    try {
      await c._validateOutgoingInstruction(
        invoice: invoice,
        offer: bolt12Offer,
        expectedAmountSats: netAmountSats,
        action: 'pay_taker',
      );
    } catch (e) {
      throw FlowTransitionFailure(e.toString());
    }

    final feeLimitSat = (takerFees * kTakerFeeLimitFactor).ceil();
    final res = await c._attemptOutgoingPayment(
      offer: offer,
      purpose: 'taker_payout',
      invoice: invoice,
      bolt12Offer: bolt12Offer,
      amountSats: netAmountSats,
      feeLimitSat: feeLimitSat,
    );
    if (res.status == PaymentStatus.FAILED) {
      throw FlowTransitionFailure(res.error ?? 'Payment failed');
    }
    if (!res.isSuccess) {
      throw StateError(
        res.error ??
            'Payment state is ${res.status.name}; reconciliation required',
      );
    }

    ctx.write.takerFees = takerFees;
    ctx.write.takerInvoiceFees = res.feeSat;
    ctx.write.takerPaidAt = ctx.now;
    ctx.write.audit.addAll({
      'taker_fees': takerFees,
      'fee_sats': res.feeSat,
      'payment_type': invoice != null ? 'bolt11' : 'bolt12',
    });
  }

  @override
  List<String> validate(
      FlowEngine engine, FlowState state, FlowTransition edge) {
    return const [];
  }
}
