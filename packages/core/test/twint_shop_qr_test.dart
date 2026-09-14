import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

const sample = 'Q4SIXZB8VXJ5000000000710CHF00025837';

void main() {
  test('confirmed sample preserves payload and decodes CHF 7.10', () {
    final qr = TwintShopQr.tryParse(sample)!;
    expect(qr.payload, sample);
    expect(qr.currency, 'CHF');
    expect(qr.amountCentimes, 710);
    expect(qr.amountText, '7.10');
    expect(qr.matchesAmount(7.10), isTrue);
  });

  test('provisional format rejects unsupported or changed structure', () {
    for (final value in [
      '',
      '12345',
      sample.toLowerCase(),
      ' $sample',
      '$sample\n',
      '${sample}0',
      sample.substring(1),
      sample.replaceFirst('Q4SIX', 'Q3SIX'),
      sample.replaceFirst('ZB8VXJ5', 'ZB8VXJ-'),
      sample.replaceFirst('CHF', 'EUR'),
      sample.replaceFirst('000000000710', '000000000000'),
      sample.replaceFirst('000000000710', '0000000007.1'),
      sample.replaceFirst('00025837', '0002583X'),
      'https://example.test/?qr=$sample',
    ]) {
      expect(TwintShopQr.tryParse(value), isNull, reason: value);
    }
  });

  test('synthetic boundary fixtures exercise centime arithmetic only', () {
    for (final fixture in [
      ('000000000001', 1, '0.01'),
      ('000000000100', 100, '1.00'),
      ('999999999999', 999999999999, '9999999999.99'),
    ]) {
      final qr = TwintShopQr.tryParse(
        sample.replaceFirst('000000000710', fixture.$1),
      )!;
      expect(qr.amountCentimes, fixture.$2);
      expect(qr.amountText, fixture.$3);
      expect(qr.matchesAmount(num.parse(fixture.$3)), isTrue);
    }
  });

  test('amount comparison rejects rounding, mismatch and invalid numbers', () {
    final qr = TwintShopQr.tryParse(sample)!;
    for (final amount in [
      7.09,
      7.11,
      7.100000000001,
      7.101,
      0,
      -7.10,
      double.nan,
      double.infinity,
      1e-7,
      1e10,
    ]) {
      expect(qr.matchesAmount(amount), isFalse, reason: '$amount');
    }
    expect(chfCentimes(7), 700);
    expect(chfCentimes(7.0), 700);
    expect(chfCentimes(0.01), 1);
  });

  test('TWINT categories preserve online and missing-category behavior', () {
    final online = kTwint.instrumentFor(OfferCategory.online)!;
    final shop = kTwint.instrumentFor(OfferCategory.shop)!;
    expect(kTwint.instrumentFor(null), same(online));
    expect(kTwint.instrumentFor(OfferCategory.atm), isNull);
    expect(online.validate('01234'), isTrue);
    expect(online.validate(sample), isFalse);
    expect(shop.kind, InstrumentKind.qrPayload);
    expect(shop.validate(sample), isTrue);
    expect(shop.validate('01234'), isFalse);
    expect(shop.validate('arbitrary nonempty QR'), isFalse);
    expect(shop.makerProvidesCode, isTrue);
    expect(shop.flowId, online.flowId);
    expect(shop.validity, const Duration(minutes: 5));
    expect(online.validity, shop.validity);
  });
}
