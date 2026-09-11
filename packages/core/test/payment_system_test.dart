import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

/// The SK ATM instrument and its banks, resolved from the market.
InstrumentSpec get _skAtm => kSlovakia.instrumentFor(OfferCategory.atm)!;
BankSpec _skBank(String id) => _skAtm.bankById(id)!;

void main() {
  group('PaymentSystem registry (market/instrument split)', () {
    test('blik: single bank-agnostic numeric instrument, 6 digits/2 min/PLN',
        () {
      expect(kBlik.currency, 'PLN');
      final i = kBlik.instrumentFor(OfferCategory.atm)!;
      expect(i.kind, InstrumentKind.numericCode);
      expect(i.direction, InstrumentDirection.takerProvides);
      expect(i.hasBanks, isFalse);
      expect(i.codeLength, 6);
      expect(i.validity, const Duration(minutes: 2));
      // Same instrument shared across all three categories.
      expect(kBlik.supportedCategories.toSet(),
          {OfferCategory.shop, OfferCategory.atm, OfferCategory.online});
    });

    test('mbway: 10 digits, 30 min, EUR, pull-style ATM only', () {
      final i = kMbway.instrumentFor(OfferCategory.atm)!;
      expect(i.codeLength, 10);
      expect(i.validity, const Duration(minutes: 30));
      expect(kMbway.currency, 'EUR');
      expect(i.requiresCodeConfirmation, isFalse);
      expect(kMbway.supportedCategories, [OfferCategory.atm]);
    });

    test('twint: 5 digits, 5 min, CHF, maker-provided, generic engine', () {
      final i = kTwint.instrumentFor(OfferCategory.online)!;
      expect(i.codeLength, 5);
      expect(i.validity, const Duration(minutes: 5));
      expect(kTwint.currency, 'CHF');
      expect(i.makerProvidesCode, isTrue);
      expect(i.flowId, isNotEmpty);
      expect(kTwint.supportedCategories, [OfferCategory.online]);
      expect(kTwint.hasCategoryChoice, isFalse);
    });

    test('instrument.validate enforces exact length and digits-only', () {
      final blik = kBlik.instrumentFor(OfferCategory.atm)!;
      expect(blik.validate('123456'), isTrue);
      expect(blik.validate('12345'), isFalse);
      expect(blik.validate('1234567'), isFalse);
      expect(blik.validate('12345a'), isFalse);
      expect(_skAtm.validate('123456'), isTrue);
      expect(_skAtm.validate('12345'), isFalse);
    });

    test('canDispenseAtmAmount respects banknote combinations', () {
      final mbway = kMbway.instrumentFor(OfferCategory.atm)!;
      expect(mbway.canDispenseAtmAmount(15), isFalse); // no 5/10 notes
      expect(mbway.canDispenseAtmAmount(70), isTrue); // 50+20
      expect(mbway.canDispenseAtmAmount(20), isTrue);
      expect(mbway.canDispenseAtmAmount(5), isFalse);
      expect(mbway.canDispenseAtmAmount(0), isFalse);
      expect(mbway.canDispenseAtmAmount(-10), isFalse);
      expect(mbway.canDispenseAtmAmount(20.5), isFalse);
      final blik = kBlik.instrumentFor(OfferCategory.atm)!;
      expect(blik.canDispenseAtmAmount(30), isTrue); // 10+20
      expect(blik.canDispenseAtmAmount(5), isFalse); // no 5 PLN note
    });

    test('platformTag falls back to brandName, SK overrides to Bitvyber', () {
      expect(kBlik.platformTag, kBlik.brandName);
      expect(kMbway.platformTag, kMbway.brandName);
      expect(kSlovakia.platformTag, 'Bitvyber');
      expect(kSlovakia.brandName, 'Bitvýber');
    });

    test('paymentSystemById maps legacy SK ids to sk, else falls back to blik',
        () {
      expect(paymentSystemById('mbway'), kMbway);
      expect(paymentSystemById('blik'), kBlik);
      expect(paymentSystemById('twint'), kTwint);
      expect(paymentSystemById('sk'), kSlovakia);
      // Legacy per-bank market ids collapse to the single SK market.
      expect(paymentSystemById('tatrabanka'), kSlovakia);
      expect(paymentSystemById('slsp'), kSlovakia);
      expect(paymentSystemById('vub'), kSlovakia);
      expect(paymentSystemById('nope'), kBlik);
      expect(paymentSystemById(null), kBlik);
    });

    test('paymentSystemForCurrency: EUR still resolves to mbway (first EUR)',
        () {
      expect(paymentSystemForCurrency('PLN'), kBlik);
      expect(paymentSystemForCurrency('eur'), kMbway);
      expect(paymentSystemForCurrency('chf'), kTwint);
      expect(paymentSystemForCurrency('USD'), isNull);
      expect(paymentSystemForCurrency(null), isNull);
    });

    test('SK: one market, one tag, four ATM banks', () {
      expect(kSlovakia.currency, 'EUR');
      expect(kSlovakia.country, 'SK');
      expect(kSlovakia.supportedCategories, [OfferCategory.atm]);
      expect(_skAtm.requiresCodeConfirmation, isFalse);
      expect(_skAtm.direction, InstrumentDirection.takerProvides);
      expect(_skAtm.banks.map((b) => b.id).toList(),
          ['tatrabanka', 'slsp', 'vub', 'primabanka']);
    });

    test('SK: per-bank validity windows (20 / 15 / 10 / 30 min)', () {
      expect(_skAtm.validityFor(_skBank('tatrabanka')),
          const Duration(minutes: 20));
      expect(_skAtm.validityFor(_skBank('slsp')), const Duration(minutes: 15));
      // VÚB lets the code holder pick 10–60 min; 10 is the floor they can
      // choose, so it is the only window every VÚB code is guaranteed to have.
      expect(_skAtm.validityFor(_skBank('vub')), const Duration(minutes: 10));
      expect(_skAtm.validityFor(_skBank('primabanka')),
          const Duration(minutes: 30));
      // Unknown/absent bank falls back to the instrument default.
      expect(_skAtm.validityFor(null), const Duration(minutes: 15));
    });

    test('SK: 6-digit codes, per-bank presets, dispensable amounts', () {
      expect(_skAtm.codeLengthFor(_skBank('tatrabanka')), 6);
      expect(_skAtm.validate('123456'), isTrue);
      expect(_skAtm.validate('12345a'), isFalse);
      final slsp = _skBank('slsp');
      expect(_skAtm.canDispenseAtmAmount(30, bank: slsp), isTrue); // 10+20
      expect(_skAtm.canDispenseAtmAmount(70, bank: slsp), isTrue); // 50+20
      expect(_skAtm.canDispenseAtmAmount(500, bank: slsp), isTrue); // 5x100
      expect(_skAtm.canDispenseAtmAmount(5, bank: slsp), isFalse);
      expect(_skAtm.canDispenseAtmAmount(15, bank: slsp), isFalse);
      // All SK banks share the same quick-pick presets, starting at 10 EUR.
      expect(_skAtm.presetsFor(_skBank('tatrabanka')), [10, 20, 50, 100, 200]);
      expect(_skAtm.presetsFor(_skBank('slsp')), [10, 20, 50, 100, 200]);
      expect(_skAtm.presetsFor(_skBank('vub')), [10, 20, 50, 100, 200]);
      expect(_skAtm.presetsFor(_skBank('primabanka')), [10, 20, 50, 100, 200]);
    });

    test('SK: per-bank cardless withdrawal cap (Prima banka 200 EUR)', () {
      // Tatra / SLSP / VÚB cap a single cardless withdrawal at 500 EUR, which
      // the market-wide MAX_AMOUNT_SATS already covers, so they carry no
      // bank-level cap. Prima banka caps each code at 200 EUR.
      expect(_skAtm.maxAmountFor(_skBank('tatrabanka')), isNull);
      expect(_skAtm.maxAmountFor(_skBank('slsp')), isNull);
      expect(_skAtm.maxAmountFor(_skBank('vub')), isNull);
      expect(_skAtm.maxAmountFor(_skBank('primabanka')), 200);
      // No bank chosen: the instrument default (uncapped) applies.
      expect(_skAtm.maxAmountFor(null), isNull);

      final prima = _skBank('primabanka');
      expect(_skAtm.isWithinAtmLimit(200, bank: prima), isTrue);
      expect(_skAtm.isWithinAtmLimit(150, bank: prima), isTrue);
      expect(_skAtm.isWithinAtmLimit(201, bank: prima), isFalse);
      expect(_skAtm.isWithinAtmLimit(500, bank: prima), isFalse);
      // Uncapped banks accept anything the market limits allow.
      expect(_skAtm.isWithinAtmLimit(500, bank: _skBank('slsp')), isTrue);
      expect(_skAtm.isWithinAtmLimit(500), isTrue);
    });

    test('registry: market ids and platform tags are unique', () {
      final ids = kPaymentSystems.map((m) => m.id).toList();
      final tags = kPaymentSystems.map((m) => m.platformTag).toList();
      expect(ids.toSet().length, ids.length, reason: 'ids unique');
      expect(tags.toSet().length, tags.length, reason: 'tags unique');
    });
  });

  group('CoordinatorInfo banks + bank channel links', () {
    CoordinatorInfo base({
      String method = 'sk',
      List<String> currencies = const ['EUR'],
      List<String> banks = const [],
      Map<String, String> channelLinks = const {},
      Map<String, Map<String, String>> bankChannelLinks = const {},
      int? disputeEvidencePeriodSeconds = 48 * 60 * 60,
    }) =>
        CoordinatorInfo(
          name: 'c',
          reservationSeconds: 30,
          makerFee: 0.5,
          takerFee: 0.5,
          minAmountSats: 1000,
          maxAmountSats: 250000,
          currencies: currencies,
          paymentSystem: method,
          banks: banks,
          channelLinks: channelLinks,
          bankChannelLinks: bankChannelLinks,
          disputeEvidencePeriodSeconds: disputeEvidencePeriodSeconds,
          nostrNpub: null,
        );

    test('json round-trips payment_system, banks, bank_channel_links', () {
      final info = base(
        banks: ['tatrabanka', 'slsp'],
        channelLinks: {'telegram': 'https://t.me/sk'},
        bankChannelLinks: {
          'tatrabanka': {'telegram': 'https://t.me/tatra'},
        },
      );
      final decoded = CoordinatorInfo.fromJson(info.toJson());
      expect(decoded.paymentSystem, 'sk');
      expect(decoded.banks, ['tatrabanka', 'slsp']);
      expect(decoded.bankChannelLinks['tatrabanka']!['telegram'],
          'https://t.me/tatra');
      expect(decoded.disputeEvidencePeriodSeconds, 48 * 60 * 60);
    });

    test('fromJson derives method from currencies when absent', () {
      final json = base(method: 'mbway').toJson();
      json.remove('payment_system');
      expect(CoordinatorInfo.fromJson(json).paymentSystem, 'mbway');
    });

    test('channelLink prefers bank-scoped, falls back to market-wide', () {
      final info = base(
        channelLinks: {'telegram': 'https://t.me/sk'},
        bankChannelLinks: {
          'tatrabanka': {'telegram': 'https://t.me/tatra'},
        },
      );
      expect(info.channelLink('telegram', bankId: 'tatrabanka'),
          'https://t.me/tatra');
      // No SLSP-scoped link → market-wide default.
      expect(info.channelLink('telegram', bankId: 'slsp'), 'https://t.me/sk');
      // No bank → market-wide.
      expect(info.channelLink('telegram'), 'https://t.me/sk');
      // Unknown messenger → null.
      expect(info.channelLink('matrix', bankId: 'tatrabanka'), isNull);
    });

    test('bank-agnostic coordinator emits no banks on the wire (old markets)',
        () {
      // A BLIK/MB WAY/TWINT coordinator has no banks. Its JSON must omit the
      // `banks`/`bank_channel_links` keys and its Nostr event must omit the
      // `banks` tag + any suffixed channel-link tags, so nothing changes on the
      // wire for existing markets and old clients see exactly what they did.
      final info = base(
        method: 'blik',
        currencies: const ['PLN'],
        channelLinks: {'telegram': 'https://t.me/blik'},
      );
      final json = info.toJson();
      expect(json.containsKey('banks'), isFalse);
      expect(json.containsKey('bank_channel_links'), isFalse);
      final tags = info.toNostrTags();
      expect(tags.any((t) => t[0] == 'banks'), isFalse);
      expect(tags.any((t) => t[0].contains('_channel_link_')), isFalse);
      // Market-wide channel link still emitted the historical way.
      expect(
          tags.any((t) =>
              t[0] == 'telegram_channel_link' && t[1] == 'https://t.me/blik'),
          isTrue);
    });

    test('decodes an old info event with no banks (forward-compat)', () {
      // Round-trip a bank-agnostic info: banks + bankChannelLinks come back
      // empty, never null, so callers can treat them uniformly.
      final info = base(method: 'mbway');
      final decoded = CoordinatorInfo.fromJson(info.toJson());
      expect(decoded.banks, isEmpty);
      expect(decoded.bankChannelLinks, isEmpty);
      expect(decoded.channelLink('telegram'), isNull);
    });

    test('nostr tags round-trip banks and suffixed bank channel links', () {
      final info = base(
        banks: ['tatrabanka', 'vub'],
        channelLinks: {'telegram': 'https://t.me/sk'},
        bankChannelLinks: {
          'tatrabanka': {'telegram': 'https://t.me/tatra'},
          'vub': {'matrix': 'https://matrix.to/vub'},
        },
      );
      final tags = info.toNostrTags();
      // Suffixed tag key format: <messenger>_channel_link_<bankId>.
      expect(
          tags.any((t) =>
              t[0] == 'telegram_channel_link_tatrabanka' &&
              t[1] == 'https://t.me/tatra'),
          isTrue);
      expect(
          tags.any((t) => t[0] == 'banks' && t[1] == 'tatrabanka,vub'), isTrue);
      expect(
          tags.any((t) =>
              t[0] == 'dispute_evidence_period_seconds' && t[1] == '172800'),
          isTrue);
    });

    test('old coordinator info has no evidence period', () {
      final json = base().toJson()..remove('dispute_evidence_period_seconds');

      final decoded = CoordinatorInfo.fromJson(json);
      expect(decoded.disputeEvidencePeriodSeconds, isNull);
      expect(decoded.toJson().containsKey('dispute_evidence_period_seconds'),
          isFalse);
      expect(
          decoded
              .toNostrTags()
              .any((tag) => tag[0] == 'dispute_evidence_period_seconds'),
          isFalse);
    });

    test('old Nostr info event has no evidence period', () {
      final event = Nip01Event(
        pubKey:
            '0000000000000000000000000000000000000000000000000000000000000000',
        kind: kKindCoordinatorInfo,
        tags: const [
          ['name', 'old coordinator'],
          ['currencies', 'PLN'],
          ['payment_system', 'blik'],
        ],
        content: '',
      );

      expect(CoordinatorInfo.fromNostrEvent(event).disputeEvidencePeriodSeconds,
          isNull);
    });
  });

  group('offer bank resolution', () {
    Offer offerWith({
      String? paymentSystemId,
      String? bankId,
      OfferCategory? category = OfferCategory.atm,
      String currency = 'EUR',
    }) =>
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
          category: category,
          paymentSystemId: paymentSystemId,
          bankId: bankId,
        );

    test('legacy per-bank id resolves to the SK market', () {
      expect(paymentSystemForOffer(offerWith(paymentSystemId: 'tatrabanka')),
          kSlovakia);
      expect(
          paymentSystemForOffer(offerWith(paymentSystemId: 'sk')), kSlovakia);
    });

    test('bankForOffer / validityForOffer resolve per-bank', () {
      final tatra = offerWith(paymentSystemId: 'sk', bankId: 'tatrabanka');
      expect(bankForOffer(tatra)!.id, 'tatrabanka');
      expect(validityForOffer(tatra), const Duration(minutes: 20));
      final vub = offerWith(paymentSystemId: 'sk', bankId: 'vub');
      expect(validityForOffer(vub), const Duration(minutes: 10));
      // No bank on a SK offer → instrument default validity.
      final noBank = offerWith(paymentSystemId: 'sk');
      expect(bankForOffer(noBank), isNull);
      expect(validityForOffer(noBank), const Duration(minutes: 15));
    });

    test('bank-agnostic market: bankForOffer is null', () {
      final blik = offerWith(paymentSystemId: 'blik', currency: 'PLN');
      expect(bankForOffer(blik), isNull);
      expect(validityForOffer(blik), const Duration(minutes: 2));
    });

    test('paymentSystemForPlatformTag maps Bitvyber to the SK market', () {
      expect(paymentSystemForPlatformTag('Bitvyber'), kSlovakia);
      expect(paymentSystemForPlatformTag('Bitway'), kMbway);
      expect(paymentSystemForPlatformTag('Bitblik'), kBlik);
      expect(paymentSystemForPlatformTag('nonsense'), isNull);
      expect(paymentSystemForPlatformTag(null), isNull);
    });

    test('offer json round-trips the bank field', () {
      final o = offerWith(paymentSystemId: 'sk', bankId: 'slsp');
      final decoded = Offer.fromJson(o.toJson());
      expect(decoded.bankId, 'slsp');
      expect(decoded.paymentSystemId, 'sk');
      expect(bankForOffer(decoded)!.id, 'slsp');
    });

    test('offer fromJson reads bank + payment_system', () {
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
        'category': 'atm',
        'payment_system': 'sk',
        'bank': 'vub',
      });
      expect(o.paymentSystemId, 'sk');
      expect(o.bankId, 'vub');
      expect(validityForOffer(o), const Duration(minutes: 10));
    });
  });
}
