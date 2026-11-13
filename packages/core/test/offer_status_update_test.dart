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

  // The maker of a multi-bank offer learns from this which bank's ATM to use.
  test('a multi-bank offer\'s running bank round-trips', () {
    final json = payload()..['bank'] = 'vub';
    final update = OfferStatusUpdate.fromJson(json, 'coordinator');
    expect(update.bankId, 'vub');
    expect(update.toJson(), json);
  });

  test('status messages without a bank leave it null', () {
    final update = OfferStatusUpdate.fromJson(payload(), 'coordinator');
    expect(update.bankId, isNull);
    expect(update.toJson().containsKey('bank'), isFalse);
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
