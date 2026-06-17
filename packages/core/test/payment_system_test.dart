import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

void main() {
  group('PaymentSystem registry', () {
    test('blik spec: 6 digits, 2 min, PLN', () {
      expect(kBlik.codeLength, 6);
      expect(kBlik.confirmationWindow, const Duration(minutes: 2));
      expect(kBlik.currency, 'PLN');
    });

    test('mbway spec: 10 digits, 30 min, EUR', () {
      expect(kMbway.codeLength, 10);
      expect(kMbway.confirmationWindow, const Duration(minutes: 30));
      expect(kMbway.currency, 'EUR');
    });

    test('isValidCode enforces exact length and digits-only', () {
      expect(kBlik.isValidCode('123456'), isTrue);
      expect(kBlik.isValidCode('12345'), isFalse);
      expect(kBlik.isValidCode('1234567'), isFalse);
      expect(kBlik.isValidCode('12345a'), isFalse);
      expect(kMbway.isValidCode('1234567890'), isTrue);
      expect(kMbway.isValidCode('123456'), isFalse);
    });

    test('canDispenseAtmAmount respects banknote combinations', () {
      // mbway notes: 5,10,20,50,100,200
      expect(kMbway.canDispenseAtmAmount(15), isTrue); // 5+10
      expect(kMbway.canDispenseAtmAmount(70), isTrue); // 50+20
      expect(kMbway.canDispenseAtmAmount(5), isTrue);
      expect(kMbway.canDispenseAtmAmount(3), isFalse); // below smallest note
      expect(kMbway.canDispenseAtmAmount(0), isFalse);
      expect(kMbway.canDispenseAtmAmount(-10), isFalse);
      expect(kMbway.canDispenseAtmAmount(20.5), isFalse); // not whole
      expect(kBlik.canDispenseAtmAmount(30), isTrue); // 10+20
      expect(kBlik.canDispenseAtmAmount(5), isFalse); // no 5 PLN note
    });

    test('paymentSystemById falls back to blik for unknown/null', () {
      expect(paymentSystemById('mbway'), kMbway);
      expect(paymentSystemById('blik'), kBlik);
      expect(paymentSystemById('nope'), kBlik);
      expect(paymentSystemById(null), kBlik);
    });

    test('paymentSystemForCurrency maps currency to method', () {
      expect(paymentSystemForCurrency('PLN'), kBlik);
      expect(paymentSystemForCurrency('eur'), kMbway);
      expect(paymentSystemForCurrency('USD'), isNull);
      expect(paymentSystemForCurrency(null), isNull);
    });
  });

  group('CoordinatorInfo payment method', () {
    CoordinatorInfo base(String method, List<String> currencies) =>
        CoordinatorInfo(
          name: 'c',
          reservationSeconds: 30,
          makerFee: 0.5,
          takerFee: 0.5,
          minAmountSats: 1000,
          maxAmountSats: 250000,
          currencies: currencies,
          paymentSystem: method,
          nostrNpub: null,
        );

    test('json round-trips payment_system', () {
      final info = base('mbway', ['EUR']);
      final decoded = CoordinatorInfo.fromJson(info.toJson());
      expect(decoded.paymentSystem, 'mbway');
    });

    test('fromJson derives method from currencies when absent', () {
      final json = base('mbway', ['EUR']).toJson();
      json.remove('payment_system');
      expect(CoordinatorInfo.fromJson(json).paymentSystem, 'mbway');
    });
  });
}
