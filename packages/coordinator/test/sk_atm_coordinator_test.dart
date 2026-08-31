import 'dart:async';
import 'dart:convert';

import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/models/create_hold_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/invoice_status.dart';
import 'package:bitblik_coordinator/src/models/invoice_update.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_coordinator/src/services/telegram_service.dart';
import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

class _FakeTelegramService extends TelegramService {
  String? lastMessage;

  _FakeTelegramService()
      : super(botToken: 'test-bot-token', chatIds: const ['test-chat-id']);

  @override
  Future<TelegramSendResult> sendMessageDetailed(String message,
      {List<String>? chatIds}) async {
    lastMessage = message;
    return const TelegramSendResult(
      allSucceeded: true,
      sentMessages: [
        TelegramSentMessage(chatId: 'test-chat-id', messageId: 1),
      ],
    );
  }

  @override
  Future<bool> editMessage({
    required String chatId,
    required int messageId,
    required String text,
  }) async =>
      true;

  @override
  Future<bool> deleteMessage({
    required String chatId,
    required int messageId,
  }) async =>
      true;
}

/// Records every message sent, so a test can assert both the count (was the
/// offer re-announced?) and the content (does it carry the bank label?).
class _CountingTelegramService extends TelegramService {
  final List<String> sentMessages = [];

  _CountingTelegramService()
      : super(botToken: 'test-bot-token', chatIds: const ['test-chat-id']);

  @override
  Future<TelegramSendResult> sendMessageDetailed(String message,
      {List<String>? chatIds}) async {
    sentMessages.add(message);
    return const TelegramSendResult(
      allSucceeded: true,
      sentMessages: [
        TelegramSentMessage(chatId: 'test-chat-id', messageId: 1),
      ],
    );
  }
}

/// Slovak multi-bank ATM market on the generic engine (one `sk_atm` flow serves
/// all banks; per-bank code validity comes from `$code_validity`).
void main() {
  const maker = 'maker_pubkey';
  const taker = 'taker_pubkey';

  group('SK market loads on the generic engine', () {
    late MockDatabaseService db;
    late CoordinatorService svc;

    setUp(() async {
      db = MockDatabaseService();
      svc = CoordinatorService(
        db,
        paymentServiceForTest: MockPaymentService(),
        clock: const Clock(),
        telegramServiceForTest: _FakeTelegramService(),
        paymentSystemIdForTest: 'sk',
      );
      await svc
          .init(); // loads + validates sk_atm.yml (proves $code_validity ok)
    });

    test('loads the YAML flow and handles the pull-style events', () {
      expect(svc.paymentSystem.id, 'sk');
      expect(svc.flow.handlesRpc('reserve_offer'), isTrue);
      expect(svc.flow.handlesRpc('submit_blik'), isTrue);
      expect(svc.flow.handlesRpc('get_blik'), isTrue);
      expect(svc.flow.handlesRpc('confirm_payment'), isTrue);
    });

    test('serves every bank of the market when BANKS is unset', () {
      expect(svc.servedBanks.toSet(),
          {'tatrabanka', 'slsp', 'vub', 'primabanka'});
    });

    test('coordinator info advertises the market id', () async {
      final info = await svc.getCoordinatorInfo();
      expect(info.paymentSystem, 'sk');
    });
  });

  group('offer creation requires a valid, served bank', () {
    late CoordinatorService svc;

    setUp(() async {
      svc = CoordinatorService(
        MockDatabaseService(),
        paymentServiceForTest: MockPaymentService(),
        clock: const Clock(),
        telegramServiceForTest: _FakeTelegramService(),
        paymentSystemIdForTest: 'sk',
      );
      await svc.init();
    });

    test('missing bank is rejected before any invoice work', () {
      expect(
        () => svc.initiateOfferFiat(
          fiatAmount: 50,
          makerId: maker,
          category: OfferCategory.atm,
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('unknown bank is rejected', () {
      expect(
        () => svc.initiateOfferFiat(
          fiatAmount: 50,
          makerId: maker,
          category: OfferCategory.atm,
          bank: 'does_not_exist',
        ),
        throwsA(isA<Exception>()),
      );
    });

    // Prima banka pays out at most 200 EUR per cardless code. Catching this at
    // creation matters: past the cap the offer would fund normally and only
    // fail at the ATM, with the maker's sats already locked.
    test('over Prima banka\'s 200 EUR cardless cap is rejected', () {
      expect(
        () => svc.initiateOfferFiat(
          fiatAmount: 300,
          makerId: maker,
          category: OfferCategory.atm,
          bank: 'primabanka',
        ),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            allOf(contains('Prima banka'), contains('200')),
          ),
        ),
      );
    });

    // The same amount is fine at a bank with no cardless cap of its own, so the
    // rejection above is the bank's limit and not a market-wide one.
    test('the same amount passes the cap check at an uncapped bank', () {
      final atm = svc.paymentSystem.instrumentFor(OfferCategory.atm)!;
      expect(
        atm.isWithinAtmLimit(300, bank: atm.bankById('slsp')),
        isTrue,
      );
      expect(
        atm.isWithinAtmLimit(300, bank: atm.bankById('primabanka')),
        isFalse,
      );
    });
  });

  // ─── the headline: one flow, four per-bank timeout windows ───────────────
  // A blikReceived offer times out to expiredBlik after exactly its bank's code
  // validity (Tatra 20 min, SLSP 15 min, VÚB 10 min, Prima banka 30 min), all
  // from `$code_validity` in the single sk_atm.yml.
  group('per-bank code-validity timeout (one flow)', () {
    void runBankScenario(String bank, Duration window) {
      fakeAsync((async) {
        final testClock = async.getClock(DateTime.utc(2026, 7, 18, 12));
        final db = MockDatabaseService();
        final svc = CoordinatorService(
          db,
          paymentServiceForTest: MockPaymentService(),
          clock: Clock(() => testClock.now()),
          telegramServiceForTest: _FakeTelegramService(),
          paymentSystemIdForTest: 'sk',
        );

        var status = 'blikReceived';
        final codeReceivedAt = testClock.now().toUtc();
        // Bumped by each CAS, as the real DB would — so a follow-on state's
        // timer (measured from updated_at) is based on when it was entered, not
        // the offer's creation.
        var updatedAt = codeReceivedAt;

        Offer offer() => Offer(
              id: 'sk1',
              amountSats: 90000,
              makerFees: 0,
              takerFees: 50,
              status: OfferStatus.unknown,
              statusRaw: status,
              fiatAmount: 50,
              fiatCurrency: 'EUR',
              category: OfferCategory.atm,
              paymentSystemId: 'sk',
              bankId: bank,
              createdAt: codeReceivedAt.subtract(const Duration(minutes: 1)),
              updatedAt: updatedAt,
              blikReceivedAt: codeReceivedAt,
              makerPubkey: maker,
              coordinatorPubkey: 'coord',
              takerPubkey: taker,
              blikCode: '123456',
              holdInvoicePaymentHash: 'hash',
              holdInvoicePreimage: 'preimage',
            );

        when(db.getOffersNotInRawStatuses(any))
            .thenAnswer((_) async => [offer()]);
        when(db.getOffersByRawStatus(any, limit: anyNamed('limit')))
            .thenAnswer((_) async => []);
        when(db.getOfferById('sk1')).thenAnswer((_) async => offer());
        when(db.getTelegramOfferMessages(any)).thenAnswer((_) async => []);
        when(db.deleteTelegramOfferMessages(any)).thenAnswer((_) async {});
        when(db.updateOfferRawStatusIfCurrent(
          any,
          any,
          expectedCurrentStatuses: anyNamed('expectedCurrentStatuses'),
          expectedTakerPubkey: anyNamed('expectedTakerPubkey'),
          takerPubkey: anyNamed('takerPubkey'),
          reservedAt: anyNamed('reservedAt'),
          takerChargedAt: anyNamed('takerChargedAt'),
          makerConfirmedAt: anyNamed('makerConfirmedAt'),
          settledAt: anyNamed('settledAt'),
          takerPaidAt: anyNamed('takerPaidAt'),
          takerInvoice: anyNamed('takerInvoice'),
          code: anyNamed('code'),
          codeReceivedAt: anyNamed('codeReceivedAt'),
          disputeAt: anyNamed('disputeAt'),
          takerFees: anyNamed('takerFees'),
          takerInvoiceFees: anyNamed('takerInvoiceFees'),
          failureReason: anyNamed('failureReason'),
          clearTakerFields: anyNamed('clearTakerFields'),
          preserveCodeOnClear: anyNamed('preserveCodeOnClear'),
          transitionMeta: anyNamed('transitionMeta'),
        )).thenAnswer((inv) async {
          final expected =
              inv.namedArguments[const Symbol('expectedCurrentStatuses')]
                  as List<String>?;
          if (expected != null && !expected.contains(status)) return false;
          status = inv.positionalArguments[1] as String;
          updatedAt = testClock.now().toUtc();
          return true;
        });

        svc.init();
        async.flushMicrotasks();
        svc.flow.recoverTimers();
        async.flushMicrotasks();

        // Just before the bank's window: still awaiting the maker.
        async.elapse(window - const Duration(seconds: 2));
        async.flushMicrotasks();
        expect(status, 'blikReceived',
            reason: '$bank should not expire before ${window.inMinutes} min');

        // Just after: the code expired.
        async.elapse(const Duration(seconds: 4));
        async.flushMicrotasks();
        expect(status, 'expiredBlik',
            reason: '$bank should expire at ${window.inMinutes} min');
      });
    }

    test('Tatra banka = 20 min', () {
      runBankScenario('tatrabanka', const Duration(minutes: 20));
    });

    test('SLSP = 15 min', () {
      runBankScenario('slsp', const Duration(minutes: 15));
    });

    test('VÚB = 10 min', () {
      runBankScenario('vub', const Duration(minutes: 10));
    });

    test('Prima banka = 30 min', () {
      runBankScenario('primabanka', const Duration(minutes: 30));
    });
  });

  // The general (market-wide) channel carries offers from all three banks, so
  // the notification has to name the bank — otherwise a taker cannot tell whose
  // ATM the code will work at without opening the offer.
  group('new-offer notification names the bank', () {
    late MockDatabaseService db;
    late MockPaymentService payment;
    late MockClient httpClient;
    late _FakeTelegramService telegram;
    late CoordinatorService svc;
    late StreamController<InvoiceUpdate> invoiceUpdates;

    setUp(() async {
      db = MockDatabaseService();
      payment = MockPaymentService();
      httpClient = MockClient((request) async {
        final body = {
          'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eur':
              jsonEncode({
            'bitcoin': {'eur': 54251.0}
          }),
          'https://api.yadio.io/exrates/eur': jsonEncode({'BTC': 54319.67}),
          'https://blockchain.info/ticker': jsonEncode({
            'EUR': {'last': 54218.15}
          }),
        }[request.url.toString()];
        return body == null
            ? http.Response('Not found', 404)
            : http.Response(body, 200);
      });
      telegram = _FakeTelegramService();
      invoiceUpdates = StreamController<InvoiceUpdate>();

      svc = CoordinatorService(
        db,
        paymentServiceForTest: payment,
        clock: const Clock(),
        httpClient: httpClient,
        telegramServiceForTest: telegram,
        paymentSystemIdForTest: 'sk',
      );
      await svc.init();

      when(payment.createHoldInvoice(
              amountSats: anyNamed('amountSats'),
              memo: anyNamed('memo'),
              paymentHashHex: anyNamed('paymentHashHex')))
          .thenAnswer((invocation) async => CreateHoldInvoiceResult(
                invoice: 'lnbc_funded_invoice',
                paymentHash: invocation
                    .namedArguments[const Symbol('paymentHashHex')] as String,
              ));
      when(payment.subscribeToInvoiceUpdates(
              paymentHashHex: anyNamed('paymentHashHex')))
          .thenAnswer((_) => invoiceUpdates.stream);
      when(db.createOffer(any))
          .thenAnswer((inv) async => inv.positionalArguments.first as Offer);
      when(db.saveTelegramOfferMessage(
        offerId: anyNamed('offerId'),
        chatId: anyNamed('chatId'),
        messageId: anyNamed('messageId'),
        messageText: anyNamed('messageText'),
      )).thenAnswer((_) async {});
    });

    Future<String?> notificationForBank(String bank) async {
      final init = await svc.initiateOfferFiat(
        fiatAmount: 20,
        makerId: maker,
        category: OfferCategory.atm,
        bank: bank,
      );
      invoiceUpdates.add(InvoiceUpdate(
        status: InvoiceStatus.ACCEPTED,
        paymentHash: init['paymentHash'] as String,
      ));
      await invoiceUpdates.close();
      await Future<void>.delayed(Duration.zero);
      return telegram.lastMessage;
    }

    test('Tatra banka offer carries the bank label', () async {
      final message = await notificationForBank('tatrabanka');
      expect(message, contains('Tatra banka'));
      // The rest of the wording is unchanged.
      expect(message, contains('Nová ponuka'));
      expect(message, contains('/offers/'));
    });

    test('SLSP offer carries the bank label', () async {
      expect(
          await notificationForBank('slsp'), contains('Slovenská sporiteľňa'));
    });

    test('VÚB offer carries the bank label', () async {
      expect(await notificationForBank('vub'), contains('VÚB'));
    });
  });

  // Production evidence: offers 0f4947d6 (995768, 892949, 892949, 441484) and
  // 44ad1390 (424180, 233602, 233602, 298827) had the SAME 6-digit code
  // submitted twice, the maker clicking "invalid" up to 4 times per offer.
  // reject_reused_code and limit_code_attempts close that loop.
  group('resubmission guards on the invalid-code loop', () {
    const invoice =
        'lnbc15u1p3xnhl2pp5jptserfk3zk4qy42tlucycrfwxhydvlemu9pqr93tuzlv9cc7g3sdqsvfhkcap3xyhx7un8cqzpgxqzjcsp5f8c52y2stc300gl6s4xswtjpc37hrnnr3c9wvtgjfuvqmpm35evq9qyyssqy4lgd8tj637qcjp05rdpxxykjenthxftej7a2zzmwrmrl70fyj9hvj0rewhzj7jfyuwkwcg9g2jpwtk3wkjtwnkdks84hsnu8xps5vsq4gj5hs'; // 1500-sat invoice (15u); offer net = amountSats - takerFees = 1500.

    late MockDatabaseService db;
    late CoordinatorService svc;
    late String status;
    String? blikCode;
    late List<Map<String, dynamic>> history;

    Offer offer() => Offer(
          id: 'sk-loop',
          amountSats: 1550,
          makerFees: 0,
          takerFees: 50,
          status: OfferStatus.unknown,
          statusRaw: status,
          fiatAmount: 50,
          fiatCurrency: 'EUR',
          category: OfferCategory.atm,
          paymentSystemId: 'sk',
          bankId: 'tatrabanka',
          createdAt: DateTime.now().toUtc(),
          makerPubkey: maker,
          coordinatorPubkey: 'coord',
          takerPubkey: taker,
          blikCode: blikCode,
          holdInvoicePaymentHash: 'hash',
          holdInvoicePreimage: 'preimage',
        );

    setUp(() async {
      db = MockDatabaseService();
      svc = CoordinatorService(
        db,
        paymentServiceForTest: MockPaymentService(),
        clock: const Clock(),
        telegramServiceForTest: _FakeTelegramService(),
        paymentSystemIdForTest: 'sk',
      );
      await svc.init();

      status = 'reserved';
      blikCode = null;
      history = [];

      when(db.getOfferById('sk-loop')).thenAnswer((_) async => offer());
      when(db.getOfferStateHistory('sk-loop'))
          .thenAnswer((_) async => List.of(history));
      when(db.updateOfferRawStatusIfCurrent(
        any,
        any,
        expectedCurrentStatuses: anyNamed('expectedCurrentStatuses'),
        expectedTakerPubkey: anyNamed('expectedTakerPubkey'),
        takerPubkey: anyNamed('takerPubkey'),
        reservedAt: anyNamed('reservedAt'),
        takerChargedAt: anyNamed('takerChargedAt'),
        makerConfirmedAt: anyNamed('makerConfirmedAt'),
        settledAt: anyNamed('settledAt'),
        takerPaidAt: anyNamed('takerPaidAt'),
        takerInvoice: anyNamed('takerInvoice'),
        code: anyNamed('code'),
        codeReceivedAt: anyNamed('codeReceivedAt'),
        disputeAt: anyNamed('disputeAt'),
        takerFees: anyNamed('takerFees'),
        takerInvoiceFees: anyNamed('takerInvoiceFees'),
        failureReason: anyNamed('failureReason'),
        clearTakerFields: anyNamed('clearTakerFields'),
        preserveCodeOnClear: anyNamed('preserveCodeOnClear'),
        transitionMeta: anyNamed('transitionMeta'),
      )).thenAnswer((inv) async {
        final expected =
            inv.namedArguments[const Symbol('expectedCurrentStatuses')]
                as List<String>?;
        if (expected != null && !expected.contains(status)) return false;
        final newStatus = inv.positionalArguments[1] as String;
        final meta = inv.namedArguments[const Symbol('transitionMeta')]
            as StateTransitionMeta?;
        final code = inv.namedArguments[const Symbol('code')] as String?;
        history.add({
          'event': meta?.event,
          'to_state': newStatus,
          'metadata': meta?.extra,
        });
        status = newStatus;
        if (code != null) blikCode = code;
        return true;
      });
    });

    // reserved -[submit_blik]-> blikReceived -[get_blik]-> blikSentToMaker
    // -[mark_blik_invalid]-> invalidBlik: one full cycle of the loop.
    Future<void> loopToInvalidBlik(String code) async {
      await svc.flow.handleRpc(
          'submit_blik',
          {
            'offer_id': 'sk-loop',
            'blik_code': code,
            'taker_invoice': invoice,
          },
          taker);
      await svc.flow.handleRpc('get_blik', {'offer_id': 'sk-loop'}, maker);
      await svc.flow
          .handleRpc('mark_blik_invalid', {'offer_id': 'sk-loop'}, maker);
    }

    test('a resubmitted code is rejected; a fresh one is accepted', () async {
      await loopToInvalidBlik('111111');
      expect(status, 'invalidBlik');

      await svc.flow.handleRpc('reserve_offer', {'offer_id': 'sk-loop'}, taker);
      expect(status, 'reserved');

      await expectLater(
        svc.flow.handleRpc(
            'submit_blik',
            {
              'offer_id': 'sk-loop',
              'blik_code': '111111',
              'taker_invoice': invoice,
            },
            taker),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('already used for this offer'),
        )),
      );
      expect(status, 'reserved',
          reason: 'a rejected submit must not advance the offer');

      await svc.flow.handleRpc(
          'submit_blik',
          {
            'offer_id': 'sk-loop',
            'blik_code': '222222',
            'taker_invoice': invoice,
          },
          taker);
      expect(status, 'blikReceived');
    });

    test('a third mark_blik_invalid blocks re-reservation; a second does not',
        () async {
      await loopToInvalidBlik('111111'); // invalid #1
      await svc.flow.handleRpc('reserve_offer', {'offer_id': 'sk-loop'}, taker);
      expect(status, 'reserved');

      await loopToInvalidBlik('222222'); // invalid #2
      await svc.flow.handleRpc('reserve_offer', {'offer_id': 'sk-loop'}, taker);
      expect(status, 'reserved',
          reason: '2 invalid codes must still allow a re-reservation');

      await loopToInvalidBlik('333333'); // invalid #3
      await expectLater(
        svc.flow.handleRpc('reserve_offer', {'offer_id': 'sk-loop'}, taker),
        throwsA(isA<Exception>().having(
          (e) => e.toString(),
          'message',
          contains('Too many invalid codes'),
        )),
      );
      expect(status, 'invalidBlik',
          reason: 'the 3rd mark_blik_invalid must block re-reservation');
    });
  });

  // ADDENDUM: `funded` re-entries (a cancelled/timed-out reservation reverting
  // to funded) re-announced the offer as if it were new — 42 times since
  // 2026-08-10, one messenger message per re-entry, often for an offer that
  // expired in the same second. The re-entry's notification also lost the
  // bank label: a DB re-fetch always has paymentSystemId == null (not a DB
  // column), so the old bankForOffer(offer) fell back to the first EUR
  // market (MB WAY), which has no `tatrabanka` bank.
  group('funded re-entry: single notification, label survives a DB re-fetch',
      () {
    late MockDatabaseService db;
    late _CountingTelegramService telegram;
    late CoordinatorService svc;
    late String status;
    late List<Map<String, dynamic>> history;

    Offer offer() => Offer(
          id: 'sk-relist',
          amountSats: 148025,
          makerFees: 0,
          takerFees: 50,
          status: OfferStatus.unknown,
          statusRaw: status,
          fiatAmount: 100,
          fiatCurrency: 'EUR',
          category: OfferCategory.atm,
          // A real DB-loaded offer always has this null; it's not a DB
          // column (see coordinator_service.dart, _buildFundedOfferNotification).
          paymentSystemId: null,
          bankId: 'tatrabanka',
          createdAt: DateTime.now().toUtc(),
          makerPubkey: maker,
          coordinatorPubkey: 'coord',
          takerPubkey: taker,
          holdInvoicePaymentHash: 'hash',
          holdInvoicePreimage: 'preimage',
        );

    setUp(() async {
      db = MockDatabaseService();
      telegram = _CountingTelegramService();
      svc = CoordinatorService(
        db,
        paymentServiceForTest: MockPaymentService(),
        clock: const Clock(),
        telegramServiceForTest: telegram,
        paymentSystemIdForTest: 'sk',
      );
      await svc.init();

      status = 'reserved';
      history = [];

      when(db.getOfferById('sk-relist')).thenAnswer((_) async => offer());
      when(db.getOfferStateHistory('sk-relist'))
          .thenAnswer((_) async => List.of(history));
      when(db.updateOfferRawStatusIfCurrent(
        any,
        any,
        expectedCurrentStatuses: anyNamed('expectedCurrentStatuses'),
        expectedTakerPubkey: anyNamed('expectedTakerPubkey'),
        takerPubkey: anyNamed('takerPubkey'),
        reservedAt: anyNamed('reservedAt'),
        takerChargedAt: anyNamed('takerChargedAt'),
        makerConfirmedAt: anyNamed('makerConfirmedAt'),
        settledAt: anyNamed('settledAt'),
        takerPaidAt: anyNamed('takerPaidAt'),
        takerInvoice: anyNamed('takerInvoice'),
        code: anyNamed('code'),
        codeReceivedAt: anyNamed('codeReceivedAt'),
        disputeAt: anyNamed('disputeAt'),
        takerFees: anyNamed('takerFees'),
        takerInvoiceFees: anyNamed('takerInvoiceFees'),
        failureReason: anyNamed('failureReason'),
        clearTakerFields: anyNamed('clearTakerFields'),
        preserveCodeOnClear: anyNamed('preserveCodeOnClear'),
        transitionMeta: anyNamed('transitionMeta'),
      )).thenAnswer((inv) async {
        final expected =
            inv.namedArguments[const Symbol('expectedCurrentStatuses')]
                as List<String>?;
        if (expected != null && !expected.contains(status)) return false;
        final newStatus = inv.positionalArguments[1] as String;
        final meta = inv.namedArguments[const Symbol('transitionMeta')]
            as StateTransitionMeta?;
        history.add({
          'event': meta?.event,
          'to_state': newStatus,
          'metadata': meta?.extra,
        });
        status = newStatus;
        return true;
      });
    });

    test(
        'the first funded entry carries the bank label even without paymentSystemId',
        () async {
      await svc.flow
          .handleRpc('cancel_reservation', {'offer_id': 'sk-relist'}, taker);
      expect(status, 'funded');
      await Future<void>.delayed(Duration.zero);

      expect(telegram.sentMessages, hasLength(1));
      expect(telegram.sentMessages.single, contains('[Tatra banka]'));
    });

    test('a second funded entry (re-list) sends no further notification',
        () async {
      await svc.flow
          .handleRpc('cancel_reservation', {'offer_id': 'sk-relist'}, taker);
      expect(status, 'funded');
      await Future<void>.delayed(Duration.zero);
      expect(telegram.sentMessages, hasLength(1));

      // Taker reserves again and cancels a second time -> a re-list, not a
      // new offer; the kind-38383 relay event still republishes regardless.
      await svc.flow
          .handleRpc('reserve_offer', {'offer_id': 'sk-relist'}, taker);
      expect(status, 'reserved');
      await svc.flow
          .handleRpc('cancel_reservation', {'offer_id': 'sk-relist'}, taker);
      expect(status, 'funded');
      await Future<void>.delayed(Duration.zero);

      expect(telegram.sentMessages, hasLength(1),
          reason: 're-entering funded must not re-announce the offer');
    });
  });
}
