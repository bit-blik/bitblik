import 'package:bitblik_core/core.dart';
import 'package:test/test.dart';

void main() {
  final opened = DateTime.utc(2026, 9, 14, 10);
  final delivered = opened.add(const Duration(hours: 1));
  Map<String, dynamic> payload() => {
        'offer_id': 'dispute',
        'payment_hash': 'hash',
        'status': 'dispute',
        'timestamp': delivered.millisecondsSinceEpoch ~/ 1000,
      };

  test('dispute clock round-trips separately from notification delivery', () {
    final json = payload()
      ..['dispute_at'] = opened.millisecondsSinceEpoch ~/ 1000;
    final update = OfferStatusUpdate.fromJson(json, 'coordinator');
    expect(update.disputeAt, opened);
    expect(update.timestamp, delivered);
    expect(update.toJson(), json);
  });

  test('old status messages keep dispute timestamp absent', () {
    final update = OfferStatusUpdate.fromJson(payload(), 'coordinator');
    expect(update.disputeAt, isNull);
    expect(update.toJson().containsKey('dispute_at'), isFalse);
  });

  test('private offer details preserve dispute clock for both roles', () {
    final offer = Offer(
      id: 'dispute',
      amountSats: 1000,
      makerFees: 10,
      status: OfferStatus.dispute,
      createdAt: opened,
      disputeAt: opened,
      makerPubkey: 'maker',
      takerPubkey: 'taker',
      coordinatorPubkey: 'coordinator',
      fiatAmount: 7.10,
      fiatCurrency: 'CHF',
    );
    for (final taker in [false, true]) {
      expect(
          Offer.fromJson(offer.toRpcJson(forTaker: taker)).disputeAt, opened);
    }
  });
}
