import 'dart:convert';

import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

void main() {
  group('Offer dispute states', () {
    test('refunding maker remains an active dispute', () {
      final offer = Offer.fromJson({
        'id': 'offer-refund-invoice',
        'amount_sats': 1000,
        'maker_fees': 10,
        'fiat_amount': 12.5,
        'fiat_currency': 'PLN',
        'status': OfferStatus.refundingMaker.name,
        'created_at': DateTime.utc(2026, 1, 2).toIso8601String(),
        'maker_pubkey': 'maker-pubkey',
        'coordinator_pubkey': 'coordinator-pubkey',
      });

      expect(offer.status, OfferStatus.refundingMaker);
      expect(offer.statusRaw, 'refundingMaker');
      expect(offer.isDispute, isTrue);
      expect(offer.toJson()['status'], 'refundingMaker');
    });
  });

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
        category: OfferCategory.online,
      );

      final decoded = Offer.fromJson(offer.toJson());

      expect(decoded.category, OfferCategory.online);
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
          ['category', 'atm'],
        ],
        content: '',
      );

      final offer = Offer.fromNostrEvent(event);

      expect(offer.category, OfferCategory.atm);
    });

    test('nostr event parses public dispute timestamp', () {
      final event = Nip01Event(
        pubKey: 'coordinator-pubkey',
        kind: kKindOffer,
        tags: const [
          ['d', 'offer-dispute'],
          ['amt', '250000'],
          ['fa', '100.0'],
          ['f', 'PLN'],
          ['s', 'dispute'],
          ['created_at', '1767225600'],
          ['p', 'coordinator-pubkey'],
          ['dispute_at', '1767301200'],
        ],
        content: '',
      );

      final offer = Offer.fromNostrEvent(event);

      expect(
          offer.disputeAt,
          DateTime.fromMillisecondsSinceEpoch(
            1767301200 * 1000,
            isUtc: true,
          ));
    });
  });

  group('Offer bank (backward compatibility)', () {
    test('legacy offer json without a bank key → bankId null', () {
      final offer = Offer.fromJson({
        'id': 'offer-nobank',
        'amount_sats': 1000,
        'maker_fees': 10,
        'fiat_amount': 12.5,
        'fiat_currency': 'PLN',
        'status': 'funded',
        'created_at': DateTime.utc(2026, 1, 2).toIso8601String(),
        'maker_pubkey': 'maker-pubkey',
        'coordinator_pubkey': 'coordinator-pubkey',
      });
      expect(offer.bankId, isNull);
    });

    test('legacy nostr offer event without a bank tag → bankId null', () {
      // An offer published by a BLIK/MB WAY coordinator carries no `bank` tag.
      final event = Nip01Event(
        pubKey: 'maker-pubkey',
        kind: 30402,
        tags: const [
          ['d', 'offer-legacy'],
          ['amt', '250000'],
          ['fa', '100.0'],
          ['f', 'PLN'],
          ['s', 'pending'],
          ['created_at', '1767225600'],
          ['maker', 'maker-pubkey'],
          ['p', 'coordinator-pubkey'],
          ['y', 'Bitblik'],
          ['category', 'atm'],
        ],
        content: '',
      );
      final offer = Offer.fromNostrEvent(event);
      expect(offer.bankId, isNull);
      expect(offer.paymentSystemId, 'blik');
    });

    test('new nostr offer event parses the bank tag (SK)', () {
      final event = Nip01Event(
        pubKey: 'maker-pubkey',
        kind: 30402,
        tags: const [
          ['d', 'offer-sk'],
          ['amt', '250000'],
          ['fa', '100.0'],
          ['f', 'EUR'],
          ['s', 'pending'],
          ['created_at', '1767225600'],
          ['maker', 'maker-pubkey'],
          ['p', 'coordinator-pubkey'],
          ['y', 'Bitvyber'],
          ['category', 'atm'],
          ['bank', 'vub'],
        ],
        content: '',
      );
      final offer = Offer.fromNostrEvent(event);
      expect(offer.paymentSystemId, 'sk');
      expect(offer.bankId, 'vub');
    });
  });

  group('Offer RPC json', () {
    test('omits bulky and sensitive fields by default', () {
      final offer = Offer(
        id: 'offer-rpc-1',
        amountSats: 123456,
        makerFees: 1234,
        status: OfferStatus.blikReceived,
        fiatAmount: 100.5,
        fiatCurrency: 'PLN',
        createdAt: DateTime.utc(2026, 1, 2, 3, 4, 5),
        makerPubkey: 'maker-pubkey',
        coordinatorPubkey: 'coordinator-pubkey',
        blikCode: '123456',
        holdInvoice: 'lnbc1holdinvoice',
        holdInvoicePreimage: 'super-secret-preimage',
        takerInvoice: 'x' * 70000,
        category: OfferCategory.online,
      );

      final rpcJson = offer.toRpcJson();
      final payload = jsonEncode({'id': '1', 'result': rpcJson});

      expect(rpcJson['hold_invoice'], 'lnbc1holdinvoice');
      expect(rpcJson.containsKey('blik_code'), isFalse);
      expect(rpcJson.containsKey('hold_invoice_preimage'), isFalse);
      expect(rpcJson.containsKey('taker_invoice'), isFalse);
      expect(rpcJson['category'], OfferCategory.online.name);
      expect(utf8.encode(payload).length, lessThan(65535));
    });
  });
}
