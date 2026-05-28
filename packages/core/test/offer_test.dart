import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

void main() {
  group('Offer category', () {
    test('json roundtrip preserves category', () {
      final offer = Offer(
        id: 'offer-1',
        amountSats: 123456,
        makerFees: 1234,
        status: OfferStatus.funded,
        fiatAmount: 100.5,
        fiatCurrency: 'PLN',
        createdAt: DateTime.utc(2026, 1, 2, 3, 4, 5),
        makerPubkey: 'maker-pubkey',
        coordinatorPubkey: 'coordinator-pubkey',
        category: OfferCategory.onlineService,
      );

      final decoded = Offer.fromJson(offer.toJson());

      expect(decoded.category, OfferCategory.onlineService);
    });

    test('missing category stays null', () {
      final offer = Offer.fromJson({
        'id': 'offer-2',
        'amount_sats': 1000,
        'maker_fees': 10,
        'fiat_amount': 12.5,
        'fiat_currency': 'PLN',
        'status': 'funded',
        'created_at': DateTime.utc(2026, 1, 2).toIso8601String(),
        'maker_pubkey': 'maker-pubkey',
        'coordinator_pubkey': 'coordinator-pubkey',
      });

      expect(offer.category, isNull);
    });

    test('nostr event parses category tag', () {
      final event = Nip01Event(
        pubKey: 'maker-pubkey',
        kind: 30402,
        tags: const [
          ['d', 'offer-3'],
          ['amt', '250000'],
          ['maker_fees', '1500'],
          ['fa', '100.0'],
          ['f', 'PLN'],
          ['s', 'pending'],
          ['created_at', '1767225600'],
          ['maker', 'maker-pubkey'],
          ['p', 'coordinator-pubkey'],
          ['category', 'atmCashout'],
        ],
        content: '',
      );

      final offer = Offer.fromNostrEvent(event);

      expect(offer.category, OfferCategory.atmCashout);
    });
  });
}
