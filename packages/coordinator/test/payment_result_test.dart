import 'package:bitblik_coordinator/src/models/pay_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/pay_offer_result.dart';
import 'package:bitblik_coordinator/src/models/payment_status.dart';
import 'package:test/test.dart';

void main() {
  test('explicit success does not require a preimage', () {
    expect(
      PayInvoiceResult(status: PaymentStatus.SUCCEEDED).isSuccess,
      isTrue,
    );
    expect(
      const PayOfferResult(status: PaymentStatus.SUCCEEDED).isSuccess,
      isTrue,
    );
  });

  test('pending and unknown are not represented as success', () {
    expect(
      PayInvoiceResult(status: PaymentStatus.PENDING).isSuccess,
      isFalse,
    );
    expect(
      const PayOfferResult(status: PaymentStatus.UNKNOWN).isSuccess,
      isFalse,
    );
  });
}
