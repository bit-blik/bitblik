import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

void main() {
  group('PremiumRange', () {
    test('none offers only market price', () {
      expect(PremiumRange.none.isOffered, isFalse);
      expect(PremiumRange.none.allowsDiscount, isFalse);
      expect(PremiumRange.none.clamp(-3), 0);
      expect(PremiumRange.none.clamp(3), 0);
    });

    test('premium-only range keeps 0 as the bottom', () {
      final range = PremiumRange.sanitized(max: 5);
      expect(range.isOffered, isTrue);
      expect(range.allowsDiscount, isFalse);
      expect(range.clamp(-2), 0);
      expect(range.clamp(7), 5);
    });

    test('a negative minimum allows a discount', () {
      final range = PremiumRange.sanitized(min: -3, max: 3);
      expect(range.isOffered, isTrue);
      expect(range.allowsDiscount, isTrue);
      expect(range.clamp(-2.5), -2.5);
      expect(range.clamp(-10), -3);
      expect(range.clamp(10), 3);
      expect(range.clamp(double.nan), 0);
      expect(PremiumRange.sanitized(min: -3).isOffered, isTrue);
    });

    test('unusable bounds fall back to market price', () {
      expect(PremiumRange.sanitized(min: -100, max: 3),
          PremiumRange.sanitized(max: 3));
      expect(PremiumRange.sanitized(min: double.nan, max: double.infinity),
          PremiumRange.none);
      // min above max: drop the discount, keep a usable premium cap.
      expect(PremiumRange.sanitized(min: 2, max: 1),
          PremiumRange.sanitized(max: 1));
      expect(PremiumRange.sanitized(max: -2), PremiumRange.none);
      // A range entirely below market price is valid.
      final discountOnly = PremiumRange.sanitized(min: -5, max: -1);
      expect(discountOnly.min, -5);
      expect(discountOnly.max, -1);
      expect(discountOnly.clamp(0), -1);
    });

    test('a premium locks fewer sats, a discount more', () {
      expect(PremiumRange.adjustedSats(100000, 0), 100000);
      expect(PremiumRange.adjustedSats(100000, 3), 97000);
      expect(PremiumRange.adjustedSats(100000, -3), 103000);
      expect(PremiumRange.adjustedSats(33333, -2.5), 34166);
    });
  });

  group('CoordinatorInfo min premium', () {
    Map<String, dynamic> baseJson() => {
          'name': 'test',
          'reservation_seconds': 20,
          'maker_fee': 0.01,
          'taker_fee': 0.01,
          'min_amount_sats': 100,
          'max_amount_sats': 10000,
          'max_premium_percent': 3,
          'currencies': ['PLN'],
        };

    CoordinatorInfo viaNostr(CoordinatorInfo info) =>
        CoordinatorInfo.fromNostrEvent(Nip01Event(
          pubKey: 'a' * 64,
          kind: kKindCoordinatorInfo,
          tags: info.toNostrTags(),
          content: '',
        ));

    test('absent from older coordinators means no discount', () {
      final info = CoordinatorInfo.fromJson(baseJson());
      expect(info.minPremiumPercent, 0);
      expect(info.premiumRange, PremiumRange.sanitized(max: 3));
      // Not emitted when 0, so the wire format of existing deployments stays.
      expect(info.toJson().containsKey('min_premium_percent'), isFalse);
      expect(info.toNostrTags().map((tag) => tag.first),
          isNot(contains('min_premium_percent')));
      expect(viaNostr(info).minPremiumPercent, 0);
    });

    test('a negative minimum round trips through JSON and Nostr tags', () {
      final info =
          CoordinatorInfo.fromJson(baseJson()..['min_premium_percent'] = -3);
      expect(info.minPremiumPercent, -3);
      expect(CoordinatorInfo.fromJson(info.toJson()).minPremiumPercent, -3);
      final fromEvent = viaNostr(info);
      expect(fromEvent.minPremiumPercent, -3);
      expect(fromEvent.premiumRange, PremiumRange.sanitized(min: -3, max: 3));
    });

    test('record exposes the range, defaulting to none without info', () {
      final info =
          CoordinatorInfo.fromJson(baseJson()..['min_premium_percent'] = -2);
      final record = CoordinatorRecord(pubkeyHex: 'a' * 64, info: info);
      expect(record.minPremium, -2);
      expect(record.premiumRange, PremiumRange.sanitized(min: -2, max: 3));
      expect(CoordinatorRecord(pubkeyHex: 'b' * 64).premiumRange,
          PremiumRange.none);
    });
  });

  group('Offer discount', () {
    Offer offer(double premium) => Offer(
          id: 'offer-1',
          amountSats: 103000,
          makerFees: 250,
          status: OfferStatus.funded,
          fiatAmount: 20,
          fiatCurrency: 'EUR',
          createdAt: DateTime.utc(2026, 1, 2),
          makerPubkey: 'maker-pubkey',
          coordinatorPubkey: 'coordinator-pubkey',
          premiumPercent: premium,
        );

    test('negative premium survives a JSON round trip', () {
      final decoded = Offer.fromJson(offer(-3).toJson());
      expect(decoded.premiumPercent, -3);
      expect(decoded.hasDiscount, isTrue);
      expect(decoded.hasPremium, isFalse);
    });

    test('new-offer announcement names a discount', () {
      final text = formatFundedOfferNotification(offer(-3),
          frontendDomain: 'bitblik.app',
          paymentSystem: paymentSystemById('sk'));
      expect(text, contains(', -3% discount/zľava -> '));
      expect(text, isNot(contains('premium')));
    });

    test('announcements without a premium are unchanged', () {
      final text = formatFundedOfferNotification(offer(0),
          frontendDomain: 'bitblik.app',
          paymentSystem: paymentSystemById('sk'));
      expect(text, isNot(contains('discount')));
      expect(text, isNot(contains('premium')));
      expect(
          formatFundedOfferNotification(offer(2.5),
              frontendDomain: 'bitblik.app',
              paymentSystem: paymentSystemById('sk')),
          contains(', +2.5% premium/prémia -> '));
    });
  });
}
