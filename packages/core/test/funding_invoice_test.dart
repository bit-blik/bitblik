import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

import 'support/funding_invoices.dart';

void main() {
  FundingInvoice validate(String invoice,
          {String hash = fundingHash,
          String network = 'mainnet',
          DateTime? now,
          String? payee}) =>
      FundingInvoice.validate(
          invoice: invoice,
          expectedAmountMsat: BigInt.from(1500000),
          expectedPaymentHash: hash,
          expectedNetwork: network,
          expectedPayeePubkey: payee,
          now: now ?? fundingTime.add(const Duration(minutes: 1)));

  test('valid signed invoice binds exact msats, hash, network and payee', () {
    final result = validate(fundingInvoice(), payee: fundingPayee);
    expect(result.amountMsat, BigInt.from(1500000));
    expect(result.paymentHash, fundingHash);
    expect(result.payeePubkey, fundingPayee);
    expect(validate(fundingInvoice().toUpperCase()).invoice, fundingInvoice());
  });

  test('recovers the payee of an independently encoded existing invoice', () {
    const invoice =
        'lnbc15u1p3xnhl2pp5jptserfk3zk4qy42tlucycrfwxhydvlemu9pqr93tuzlv9cc7g3sdqsvfhkcap3xyhx7un8cqzpgxqzjcsp5f8c52y2stc300gl6s4xswtjpc37hrnnr3c9wvtgjfuvqmpm35evq9qyyssqy4lgd8tj637qcjp05rdpxxykjenthxftej7a2zzmwrmrl70fyj9hvj0rewhzj7jfyuwkwcg9g2jpwtk3wkjtwnkdks84hsnu8xps5vsq4gj5hs';
    final parsed = validate(invoice,
        hash:
            '90570c8d3688ad5012aa5ff982606971ae46b3f9df0a100cb15f05f61718f223',
        now: DateTime.fromMillisecondsSinceEpoch(1651105830000, isUtc: true));
    expect(parsed.payeePubkey, matches(RegExp(r'^0[23][0-9a-f]{64}$')));
  });

  for (final hrp in [
    'lnbc30u',
    'lnbc15000010p',
    'lnbc15000001p',
    'lnbc',
    'lnbc0u',
    'lntb15u',
    'lnbcrt15u'
  ]) {
    test(
        'rejects inflated, fractional, unspecified or wrong-network amount: $hrp',
        () {
      expect(() => validate(fundingInvoice(hrp: hrp)), throwsFormatException);
    });
  }

  test('rejects hash substitution, expired invoice and disallowed payee', () {
    expect(
        () => validate(fundingInvoice(hash: '22' * 32)), throwsFormatException);
    expect(
        () => validate(fundingInvoice(),
            now: fundingTime.add(const Duration(hours: 1))),
        throwsFormatException);
    expect(
        () =>
            validate(fundingInvoice(), payee: '03${fundingPayee.substring(2)}'),
        throwsFormatException);
  });

  test('rejects malformed signature, duplicate hash and missing secret', () {
    expect(() => validate(fundingInvoice(invalidSignature: true)),
        throwsFormatException);
    expect(() => validate(fundingInvoice(duplicateHash: true)),
        throwsFormatException);
    expect(() => validate(fundingInvoice(includeSecret: false)),
        throwsFormatException);
  });

  test('rejects checksum corruption and mixed case', () {
    final invoice = fundingInvoice();
    expect(() => validate('${invoice.substring(0, invoice.length - 1)}!'),
        throwsFormatException);
    expect(() => validate('LN${invoice.substring(2)}'), throwsFormatException);
  });
}
