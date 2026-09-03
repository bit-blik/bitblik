import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

void main() {
  CoordinatorInfo info(String name, double makerFee) =>
      CoordinatorInfo.fromJson({
        'name': name,
        'reservation_seconds': 20,
        'maker_fee': makerFee,
        'taker_fee': 0.01,
        'min_amount_sats': 100,
        'max_amount_sats': 10000,
        'currencies': ['PLN'],
      });

  test('equal reliability scores fall back to the cheapest maker fee', () {
    final expensive = CoordinatorRecord(
      pubkeyHex: 'expensive',
      info: info('A', 1.0),
    );
    final cheap = CoordinatorRecord(
      pubkeyHex: 'cheap',
      info: info('Z', 0.5),
    );

    final records = [expensive, cheap]
      ..sort((a, b) => a.compareForRanking(b));

    expect(records, [cheap, expensive]);
  });

  test('reliability score remains more important than maker fee', () {
    final reliable = CoordinatorRecord(
      pubkeyHex: 'reliable',
      info: info('Reliable', 1.0),
      responsive: true,
    );
    final cheap = CoordinatorRecord(
      pubkeyHex: 'cheap',
      info: info('Cheap', 0.0),
      responsive: false,
    );

    final records = [cheap, reliable]
      ..sort((a, b) => a.compareForRanking(b));

    expect(records, [reliable, cheap]);
  });
}
