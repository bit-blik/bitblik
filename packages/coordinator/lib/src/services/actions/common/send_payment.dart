part of '../../coordinator_service.dart';

/// Pays out the taker over Lightning. In schema v2 this action runs inside the
/// detached `auto` attempt itself: success commits the transition to its normal
/// `to:` target, while definitive failure throws [FlowTransitionFailure] and
/// the executor routes to `on_fail:`.
class SendPaymentAction extends FlowAction {
  @override
  String get name => 'send_payment';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final c = flow._c;
    final offer = ctx.offer;
    final takerFees = c._effectiveTakerFeeSats(offer);
    final netAmountSats = offer.amountSats - takerFees;

    var invoice = offer.takerInvoice;
    if (invoice == null || invoice.isEmpty) {
      final lnAddr = offer.takerLightningAddress;
      if (lnAddr == null || lnAddr.isEmpty) {
        throw const FlowTransitionFailure(
            'Missing both taker invoice and Lightning Address');
      }
      invoice = await c._resolveLnurlPay(lnAddr, netAmountSats);
      if (invoice == null || invoice.isEmpty) {
        throw const FlowTransitionFailure(
            'Failed to get invoice from lightning address (LNURL resolution failed)');
      }
      ctx.write.takerInvoice = invoice;
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
    ctx.write.takerPaidAt = ctx.now;
    ctx.write.audit.addAll({
      'taker_fees': takerFees,
      'fee_sats': res.result?.feeSat ?? 0,
      'preimage': res.result?.paymentPreimage,
    });
  }

  @override
  List<String> validate(
      FlowEngine engine, FlowState state, FlowTransition edge) {
    if (edge.trigger != FlowTriggerType.auto) {
      return [
        'state "${state.name}": send_payment must run on an auto transition'
      ];
    }
    if (edge.onFailTarget == null) {
      return [
        'state "${state.name}": send_payment transition must declare on_fail'
      ];
    }
    return const [];
  }
}
