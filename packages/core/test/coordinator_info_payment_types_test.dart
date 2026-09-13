import 'package:bitblik_core/core.dart';
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

  test('round trips advertised BOLT12 capability', () {
    final json = baseJson()..['outgoing_payment_types'] = ['bolt11', 'bolt12'];
    final info = CoordinatorInfo.fromJson(json);
    expect(info.outgoingPaymentTypes, ['bolt11', 'bolt12']);
    expect(info.toJson()['outgoing_payment_types'], ['bolt11', 'bolt12']);
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
