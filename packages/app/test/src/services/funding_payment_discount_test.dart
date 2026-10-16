import 'package:bitblik/src/services/funding_payment.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../core/test/support/funding_invoices.dart';

Offer _offer(double premiumPercent) => Offer(
  id: fundingHash,
  amountSats: 1490,
  makerFees: 10,
  status: OfferStatus.created,
  fiatAmount: 10,
  fiatCurrency: 'PLN',
  createdAt: fundingTime,
  makerPubkey: 'maker',
  coordinatorPubkey: 'coordinator',
  holdInvoice: fundingInvoice(),
  holdInvoicePaymentHash: fundingHash,
  premiumPercent: premiumPercent,
);

FundingPaymentAuthorization _review(Offer offer) =>
    FundingPaymentAuthorization.review(
      offer,
      offer.holdInvoice!,
      network: 'mainnet',
      makerPubkey: 'maker',
      now: fundingTime,
    );

void main() {
  test('a discount quote (negative premium) can be approved', () {
    expect(_review(_offer(-3)).premiumPercent, -3);
  });

  test('an impossible discount is still rejected', () {
    for (final premium in [-100.0, -150.0, double.negativeInfinity]) {
      expect(() => _review(_offer(premium)), throwsFormatException);
    }
  });

  test('the discount must match the original client estimate', () {
    const estimate = FundingEstimate(
      coordinatorPubkey: 'coordinator',
      makerPubkey: 'maker',
      fiatAmount: 10,
      fiatCurrency: 'PLN',
      premiumPercent: -3,
      totalSats: 1500,
      makerFeesSats: 10,
    );
    expect(() => estimate.requireMatches(_offer(-3)), returnsNormally);
    // An older coordinator that clamps the discount to 0 is caught.
    expect(() => estimate.requireMatches(_offer(0)), throwsFormatException);
  });
}
