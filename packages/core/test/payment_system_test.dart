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

    test('twint spec: 5 digits, 5 min, CHF, maker-provided code', () {
      expect(kTwint.codeLength, 5);
      expect(kTwint.confirmationWindow, const Duration(minutes: 5));
      expect(kTwint.currency, 'CHF');
      expect(kTwint.makerProvidesCodeAtOfferCreation, isTrue);
    });

    test('isValidCode enforces exact length and digits-only', () {
      expect(kBlik.isValidCode('123456'), isTrue);
      expect(kBlik.isValidCode('12345'), isFalse);
      expect(kBlik.isValidCode('1234567'), isFalse);
      expect(kBlik.isValidCode('12345a'), isFalse);
      expect(kMbway.isValidCode('1234567890'), isTrue);
      expect(kMbway.isValidCode('123456'), isFalse);
      expect(kTwint.isValidCode('12345'), isTrue);
      expect(kTwint.isValidCode('1234'), isFalse);
    });

    test('canDispenseAtmAmount respects banknote combinations', () {
      // mbway notes: 20,50,100,200
      expect(kMbway.canDispenseAtmAmount(15), isFalse); // no 5/10 notes
      expect(kMbway.canDispenseAtmAmount(70), isTrue); // 50+20
      expect(kMbway.canDispenseAtmAmount(20), isTrue);
      expect(kMbway.canDispenseAtmAmount(5), isFalse); // below smallest note
      expect(kMbway.canDispenseAtmAmount(3), isFalse); // below smallest note
      expect(kMbway.canDispenseAtmAmount(0), isFalse);
      expect(kMbway.canDispenseAtmAmount(-10), isFalse);
      expect(kMbway.canDispenseAtmAmount(20.5), isFalse); // not whole
      expect(kBlik.canDispenseAtmAmount(30), isTrue); // 10+20
      expect(kBlik.canDispenseAtmAmount(5), isFalse); // no 5 PLN note
    });

    test('platformTag falls back to brandName, override wins', () {
      // Existing markets keep their historical tag (== brandName).
      expect(kBlik.platformTag, kBlik.brandName);
      expect(kMbway.platformTag, kMbway.brandName);
      // An explicit override replaces the tag without touching the brand.
      const p = PaymentSystem(
        id: 'x',
        label: 'X',
        brandName: 'BitBlik',
        platformTagOverride: 'WireTagX',
        country: 'XX',
        flag: '🏳️',
        currency: 'EUR',
        currencySymbol: '€',
        codeLength: 6,
        codeValidityMinutes: 10,
        supportedCategories: [OfferCategory.atm],
        atmPresetAmounts: [10],
        atmBanknoteDenominations: [10],
      );
      expect(p.platformTag, 'WireTagX');
      expect(p.brandName, 'BitBlik');
    });

    test('paymentSystemById falls back to blik for unknown/null', () {
      expect(paymentSystemById('mbway'), kMbway);
      expect(paymentSystemById('blik'), kBlik);
      expect(paymentSystemById('twint'), kTwint);
      expect(paymentSystemById('nope'), kBlik);
      expect(paymentSystemById(null), kBlik);
    });

    test('paymentSystemForCurrency maps currency to method', () {
      expect(paymentSystemForCurrency('PLN'), kBlik);
      expect(paymentSystemForCurrency('eur'), kMbway);
      expect(paymentSystemForCurrency('chf'), kTwint);
      expect(paymentSystemForCurrency('USD'), isNull);
      expect(paymentSystemForCurrency(null), isNull);
    });

    test('slovak banks: 6 digits, EUR, ATM-only, pull-style', () {
      for (final b in [kTatraBanka, kSlsp, kVub]) {
        expect(b.codeLength, 6, reason: b.id);
        expect(b.currency, 'EUR', reason: b.id);
        expect(b.country, 'SK', reason: b.id);
        expect(b.requiresCodeConfirmation, isFalse, reason: b.id);
        expect(b.supportedCategories, [OfferCategory.atm], reason: b.id);
      }
      expect(kTatraBanka.confirmationWindow, const Duration(minutes: 20));
      expect(kSlsp.confirmationWindow, const Duration(minutes: 15));
      // VÚB cardless-withdrawal codes are only valid for 3 minutes.
      expect(kVub.confirmationWindow, const Duration(minutes: 3));
    });

    test('slovak banks: valid 6-digit code, dispensable amounts', () {
      expect(kTatraBanka.isValidCode('123456'), isTrue);
      expect(kTatraBanka.isValidCode('12345'), isFalse);
      expect(kTatraBanka.isValidCode('1234567'), isFalse);
      expect(kTatraBanka.isValidCode('12345a'), isFalse);
      expect(kSlsp.canDispenseAtmAmount(30), isTrue); // 10+20
      expect(kSlsp.canDispenseAtmAmount(70), isTrue); // 50+20
      expect(kSlsp.canDispenseAtmAmount(500), isTrue); // 5x100
      expect(kSlsp.canDispenseAtmAmount(5), isFalse); // below smallest note
      expect(kSlsp.canDispenseAtmAmount(15), isFalse); // not composable
      expect(kSlsp.canDispenseAtmAmount(0), isFalse);
      expect(kSlsp.canDispenseAtmAmount(20.5), isFalse);
    });

    test('registry: SK banks resolvable and uniquely tagged', () {
      expect(paymentSystemById('tatrabanka'), kTatraBanka);
      expect(paymentSystemById('slsp'), kSlsp);
      expect(paymentSystemById('vub'), kVub);
      expect(paymentSystemById('nope'), kBlik); // unchanged fallback
      final ids = kPaymentSystems.map((m) => m.id).toList();
      final tags = kPaymentSystems.map((m) => m.platformTag).toList();
      expect(ids.toSet().length, ids.length, reason: 'ids unique');
      expect(tags.toSet().length, tags.length, reason: 'platformTags unique');
      // Regression: EUR still maps to mbway (first EUR market).
      expect(paymentSystemForCurrency('EUR'), kMbway);
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

  group('paymentSystemForOffer', () {
    Offer offerWith({String? paymentSystemId, String currency = 'EUR'}) =>
        Offer(
          id: 'o1',
          amountSats: 1000,
          makerFees: 0,
          status: OfferStatus.funded,
          fiatAmount: 10,
          fiatCurrency: currency,
          createdAt: DateTime.utc(2026),
          makerPubkey: 'm',
          coordinatorPubkey: 'c',
          paymentSystemId: paymentSystemId,
        );

    test('resolves EUR markets by explicit id, not by currency', () {
      // Regression: Tatra/SLSP/VÚB all settle in EUR; resolving by currency
      // collapses them onto the first EUR entry (MB WAY). The id must win.
      expect(paymentSystemForOffer(offerWith(paymentSystemId: 'tatrabanka')),
          kTatraBanka);
      expect(paymentSystemForOffer(offerWith(paymentSystemId: 'slsp')), kSlsp);
      expect(paymentSystemForOffer(offerWith(paymentSystemId: 'vub')), kVub);
      expect(
          paymentSystemForOffer(offerWith(paymentSystemId: 'mbway')), kMbway);
    });

    test('falls back to currency for legacy offers without an id', () {
      expect(paymentSystemForOffer(offerWith(currency: 'PLN')), kBlik);
      // EUR with no id keeps the historical first-EUR (MB WAY) behavior.
      expect(paymentSystemForOffer(offerWith(currency: 'EUR')), kMbway);
    });

    test('paymentSystemForPlatformTag maps the wire y-tag to its system', () {
      expect(paymentSystemForPlatformTag('BitblikSK-Tatra'), kTatraBanka);
      expect(paymentSystemForPlatformTag('BitblikSK-SLSP'), kSlsp);
      expect(paymentSystemForPlatformTag('BitblikSK-VUB'), kVub);
      expect(paymentSystemForPlatformTag('Bitway'), kMbway);
      expect(paymentSystemForPlatformTag('Bitblik'), kBlik);
      expect(paymentSystemForPlatformTag('nonsense'), isNull);
      expect(paymentSystemForPlatformTag(null), isNull);
    });

    test('fromJson reads the payment_system id and resolves it', () {
      final o = Offer.fromJson({
        'id': 'x',
        'amount_sats': 1,
        'maker_fees': 0,
        'fiat_amount': 10,
        'fiat_currency': 'EUR',
        'status': 'funded',
        'created_at': DateTime.utc(2026).toIso8601String(),
        'maker_pubkey': 'm',
        'coordinator_pubkey': 'c',
        'payment_system': 'tatrabanka',
      });
      expect(o.paymentSystemId, 'tatrabanka');
      expect(paymentSystemForOffer(o), kTatraBanka);
    });
  });
}
