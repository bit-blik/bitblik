import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

void main() {
  Map<String, dynamic> baseJson() => {
        'name': 'test',
        'reservation_seconds': 20,
        'maker_fee': 0.01,
        'taker_fee': 0.01,
        'min_amount_sats': 100,
        'max_amount_sats': 10000,
        'currencies': ['PLN'],
      };

  test('legacy coordinator defaults to BOLT11 only', () {
    expect(
      CoordinatorInfo.fromJson(baseJson()).outgoingPaymentTypes,
      ['bolt11'],
    );
  });

  test('shop QR capability requires explicit advertisement and round trips',
      () {
    final legacy = CoordinatorInfo.fromJson(baseJson());
    expect(legacy.supportsTwintShopQr, isFalse);
    expect(legacy.toJson().containsKey('twint_shop_qr_v1'), isFalse);
    for (final advertised in [false, true]) {
      final info = CoordinatorInfo.fromJson(baseJson()
        ..['payment_system'] = 'twint'
        ..['twint_shop_qr_v1'] = advertised);
      expect(CoordinatorInfo.fromJson(info.toJson()).supportsTwintShopQr,
          advertised);
      final event = Nip01Event(
        pubKey: 'a' * 64,
        kind: kKindCoordinatorInfo,
        tags: info.toNostrTags(),
        content: '',
      );
      expect(CoordinatorInfo.fromNostrEvent(event).supportsTwintShopQr,
          advertised);
    }
  });

  test('round trips advertised BOLT12 capability', () {
    final json = baseJson()..['outgoing_payment_types'] = ['bolt11', 'bolt12'];
    final info = CoordinatorInfo.fromJson(json);
    expect(info.outgoingPaymentTypes, ['bolt11', 'bolt12']);
    expect(info.toJson()['outgoing_payment_types'], ['bolt11', 'bolt12']);
  });

  test('initiation recovery requires explicit capability and round trips', () {
    for (final advertised in [null, false, true, 'true']) {
      final info = CoordinatorInfo.fromJson(
          baseJson()..['offer_initiation_v1'] = advertised);
      final enabled = advertised == true;
      expect(info.supportsOfferInitiationRecovery, enabled);
      expect(
          CoordinatorInfo.fromJson(info.toJson())
              .supportsOfferInitiationRecovery,
          enabled);
      expect(
          CoordinatorInfo.fromNostrEvent(Nip01Event(
                  pubKey: 'a' * 64,
                  kind: kKindCoordinatorInfo,
                  tags: info.toNostrTags(),
                  content: ''))
              .supportsOfferInitiationRecovery,
          enabled);
      expect(info.toJson().containsKey('offer_initiation_v1'), enabled);
    }
  });

  test('coordinator record exposes capabilities with legacy fallback', () {
    const legacy = CoordinatorRecord(pubkeyHex: 'legacy');
    expect(legacy.outgoingPaymentTypes, ['bolt11']);
    expect(legacy.supportsBolt12Payouts, isFalse);

    final info = CoordinatorInfo.fromJson(
      baseJson()..['outgoing_payment_types'] = ['bolt11', 'bolt12'],
    );
    final capable = CoordinatorRecord(pubkeyHex: 'capable', info: info);
    expect(capable.outgoingPaymentTypes, ['bolt11', 'bolt12']);
    expect(capable.supportsBolt12Payouts, isTrue);
  });
}
