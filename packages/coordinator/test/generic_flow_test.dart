import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/models/cancel_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/pay_invoice_result.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_coordinator/src/services/telegram_service.dart';
import 'package:clock/clock.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'coordinator_service_test.mocks.dart';

class _FakeTelegramService extends TelegramService {
  int editCalls = 0;
  int deleteCalls = 0;
  String? lastEditedText;

  _FakeTelegramService()
      : super(botToken: 'test-bot-token', chatIds: const ['test-chat-id']);

  @override
  Future<bool> editMessage({
    required String chatId,
    required int messageId,
    required String text,
  }) async {
    editCalls++;
    lastEditedText = text;
    return true;
  }

  @override
  Future<bool> deleteMessage({
    required String chatId,
    required int messageId,
  }) async {
    deleteCalls++;
    return true;
  }
}

/// Coordinator-level tests for the generic (yaml-driven) TWINT executor.
/// Verifies routing, enforcement and identity guards without the full payout
/// chain (covered structurally by core's twint_flow_test).
void main() {
  late MockDatabaseService db;
  late MockPaymentService pay;
  late CoordinatorService svc;
  late _FakeTelegramService telegram;

  const maker = 'maker_pubkey';
  const taker = 'taker_pubkey';

  Offer twintOffer(String statusRaw, {String? takerPubkey}) => Offer(
        id: 'o1',
        amountSats: 10000,
        makerFees: 50,
        status: OfferStatus.unknown,
        statusRaw: statusRaw,
        fiatAmount: 10,
        fiatCurrency: 'CHF',
        createdAt: DateTime.now().toUtc(),
        makerPubkey: maker,
        coordinatorPubkey: 'coord',
        takerPubkey: takerPubkey,
        holdInvoicePaymentHash: 'hash',
        holdInvoicePreimage: 'preimage',
      );

  setUp(() async {
    db = MockDatabaseService();
    pay = MockPaymentService();
    telegram = _FakeTelegramService();
    svc = CoordinatorService(
      db,
      paymentServiceForTest: pay,
      clock: const Clock(),
      telegramServiceForTest: telegram,
      paymentSystemIdForTest: 'twint',
    );
    await svc.init(); // loads twint.yml -> engine
    when(pay.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
        .thenAnswer((_) async => const CancelInvoiceResult.cancelled());
    when(db.deleteTelegramOfferMessages(any)).thenAnswer((_) async {});
    when(db.getTelegramOfferMessages(any)).thenAnswer((_) async => [
          TelegramOfferMessage(
            offerId: 'o1',
            chatId: 'test-chat-id',
            messageId: 1,
            messageText: 'New offer',
          ),
        ]);
  });

  test('twint coordinator runs in generic mode', () {
    expect(svc.isGenericFlow, isTrue);
    // handlesRpc is now derived from the flow's user-action events, so every
    // twint event routes to the generic controller — including the payout-tail
    // retry events and twint-specific ones.
    expect(svc.flow.handlesRpc('reserve_offer'), isTrue);
    expect(svc.flow.handlesRpc('mark_twint_charged'), isTrue);
    expect(svc.flow.handlesRpc('enter_new_twint'), isTrue);
    expect(svc.flow.handlesRpc('update_taker_invoice'), isTrue);
    // Query/info RPCs are not flow events → not generic-handled.
    expect(svc.flow.handlesRpc('get_offer_details'), isFalse);
  });

  test('rejects an action from the wrong actor (taker confirming)', () async {
    when(db.getOfferById('o1'))
        .thenAnswer((_) async => twintOffer('twint_charged', takerPubkey: taker));

    expect(
      () => svc.flow.handleRpc('confirm_payment', {'offer_id': 'o1'}, taker),
      throwsA(isA<Exception>()),
    );
    verifyNever(db.updateOfferRawStatusIfCurrent(any, any));
  });

  test('rejects a disallowed transition for the state', () async {
    // confirm_payment is not valid from `funded`.
    when(db.getOfferById('o1')).thenAnswer((_) async => twintOffer('funded'));
    expect(
      () => svc.flow.handleRpc('confirm_payment', {'offer_id': 'o1'}, maker),
      throwsA(isA<Exception>()),
    );
  });

  test('maker_cancels: funded -> cancelled (terminal) with field clear',
      () async {
    // Stateful so the post-apply re-fetch reflects the new state, as the real
    // DB would. handleGenericRpc returns the re-fetched offer json.
    var currentStatus = 'funded';
    when(db.getOfferById('o1'))
        .thenAnswer((_) async => twintOffer(currentStatus));
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
      takerLightningAddress: anyNamed('takerLightningAddress'),
      code: anyNamed('code'),
      codeReceivedAt: anyNamed('codeReceivedAt'),
      disputeAt: anyNamed('disputeAt'),
      takerFees: anyNamed('takerFees'),
      failureReason: anyNamed('failureReason'),
      clearTakerFields: anyNamed('clearTakerFields'),
      preserveCodeOnClear: anyNamed('preserveCodeOnClear'),
      transitionMeta: anyNamed('transitionMeta'),
    )).thenAnswer((inv) async {
      currentStatus = inv.positionalArguments[1] as String;
      return true;
    });

    final res =
        await svc.flow.handleRpc('cancel_offer', {'offer_id': 'o1'}, maker);
    expect(res['status'], 'cancelled');

    final captured = verify(db.updateOfferRawStatusIfCurrent(
      'o1',
      captureAny,
      expectedCurrentStatuses: captureAnyNamed('expectedCurrentStatuses'),
      expectedTakerPubkey: anyNamed('expectedTakerPubkey'),
      takerPubkey: anyNamed('takerPubkey'),
      reservedAt: anyNamed('reservedAt'),
      takerChargedAt: anyNamed('takerChargedAt'),
      makerConfirmedAt: anyNamed('makerConfirmedAt'),
      settledAt: anyNamed('settledAt'),
      takerPaidAt: anyNamed('takerPaidAt'),
      takerInvoice: anyNamed('takerInvoice'),
      takerLightningAddress: anyNamed('takerLightningAddress'),
      code: anyNamed('code'),
      codeReceivedAt: anyNamed('codeReceivedAt'),
      disputeAt: anyNamed('disputeAt'),
      takerFees: anyNamed('takerFees'),
      failureReason: anyNamed('failureReason'),
      clearTakerFields: captureAnyNamed('clearTakerFields'),
      preserveCodeOnClear: captureAnyNamed('preserveCodeOnClear'),
      transitionMeta: anyNamed('transitionMeta'),
    )).captured;

    expect(captured[0], 'cancelled'); // target
    expect(captured[1], ['funded']); // expected-current CAS guard
    expect(captured[2], isTrue); // clearTakerFields
    // TWINT: the code is the maker's — it survives taker-field clears.
    expect(captured[3], isTrue); // preserveCodeOnClear
    expect(telegram.editCalls, 1);
    expect(telegram.lastEditedText, '<s>New offer</s>');
    verify(db.deleteTelegramOfferMessages('o1')).called(1);
  });

  group('blik forced onto the generic engine (FLOW_MODE=generic)', () {
    late MockDatabaseService bdb;
    late CoordinatorService bsvc;

    Offer blikOffer(String statusRaw,
            {String? takerPubkey, String? blikCode}) =>
        Offer(
          id: 'b1',
          amountSats: 10000,
          makerFees: 50,
          takerFees: 50,
          status: OfferStatus.unknown,
          statusRaw: statusRaw,
          fiatAmount: 10,
          fiatCurrency: 'PLN',
          createdAt: DateTime.now().toUtc(),
          makerPubkey: maker,
          coordinatorPubkey: 'coord',
          takerPubkey: takerPubkey,
          blikCode: blikCode,
          holdInvoicePaymentHash: 'hash',
          holdInvoicePreimage: 'preimage',
        );

    setUp(() async {
      bdb = MockDatabaseService();
      bsvc = CoordinatorService(
        bdb,
        paymentServiceForTest: MockPaymentService(),
        clock: const Clock(),
        paymentSystemIdForTest: 'blik',
        flowModeForTest: FlowEngineMode.generic,
      );
      await bsvc.init(); // loads blik.yml
    });

    test('isGenericFlow + handles submit_blik / get_blik', () {
      expect(bsvc.isGenericFlow, isTrue);
      expect(bsvc.flow.handlesRpc('submit_blik'), isTrue);
      expect(bsvc.flow.handlesRpc('get_blik'), isTrue);
    });

    test('get_blik advances blikReceived -> blikSentToMaker, returns code',
        () async {
      var offer = blikOffer('blikReceived',
          takerPubkey: taker, blikCode: '123456');
      when(bdb.getOfferById('b1')).thenAnswer((_) async => offer);
      when(bdb.updateOfferRawStatusIfCurrent(
        'b1',
        'blikSentToMaker',
        expectedCurrentStatuses: anyNamed('expectedCurrentStatuses'),
        expectedTakerPubkey: anyNamed('expectedTakerPubkey'),
        takerPubkey: anyNamed('takerPubkey'),
        reservedAt: anyNamed('reservedAt'),
        takerChargedAt: anyNamed('takerChargedAt'),
        makerConfirmedAt: anyNamed('makerConfirmedAt'),
        settledAt: anyNamed('settledAt'),
        takerPaidAt: anyNamed('takerPaidAt'),
        takerInvoice: anyNamed('takerInvoice'),
        takerLightningAddress: anyNamed('takerLightningAddress'),
        code: anyNamed('code'),
        codeReceivedAt: anyNamed('codeReceivedAt'),
        disputeAt: anyNamed('disputeAt'),
        takerFees: anyNamed('takerFees'),
        failureReason: anyNamed('failureReason'),
        clearTakerFields: anyNamed('clearTakerFields'),
        transitionMeta: anyNamed('transitionMeta'),
      )).thenAnswer((_) async {
        offer = blikOffer('blikSentToMaker',
            takerPubkey: taker, blikCode: '123456');
        return true;
      });

      final res =
          await bsvc.flow.handleRpc('get_blik', {'offer_id': 'b1'}, maker);
      expect(res['blik_code'], '123456');
    });

    test('get_blik by non-maker is rejected', () async {
      when(bdb.getOfferById('b1')).thenAnswer((_) async =>
          blikOffer('blikReceived', takerPubkey: taker, blikCode: '123456'));
      expect(
        () => bsvc.flow.handleRpc('get_blik', {'offer_id': 'b1'}, taker),
        throwsA(isA<Exception>()),
      );
    });
  });

  // ─── generic (forked) yml-driven payout tail ──────────────────────────
  // Drives confirm_payment -> makerConfirmed -> start_payout -> settled and the
  // async _runPayout chain (settled -> payingTaker -> takerPaid / Failed),
  // exercising the real generic payout against a mocked payment backend.
  group('generic payout (forked)', () {
    // 1500-sat invoice (15u); offer net = amountSats - takerFees = 1500.
    const invoice =
        'lnbc15u1p3xnhl2pp5jptserfk3zk4qy42tlucycrfwxhydvlemu9pqr93tuzlv9cc7g3sdqsvfhkcap3xyhx7un8cqzpgxqzjcsp5f8c52y2stc300gl6s4xswtjpc37hrnnr3c9wvtgjfuvqmpm35evq9qyyssqy4lgd8tj637qcjp05rdpxxykjenthxftej7a2zzmwrmrl70fyj9hvj0rewhzj7jfyuwkwcg9g2jpwtk3wkjtwnkdks84hsnu8xps5vsq4gj5hs';

    late MockDatabaseService gdb;
    late MockPaymentService gpay;
    late CoordinatorService gsvc;
    late _FakeTelegramService gtelegram;
    late String current;

    Offer payoutOffer({String? takerInvoice, String? lnAddr}) => Offer(
          id: 'p1',
          amountSats: 1550,
          makerFees: 0,
          takerFees: 50,
          status: OfferStatus.unknown,
          statusRaw: current,
          fiatAmount: 10,
          fiatCurrency: 'PLN',
          createdAt: DateTime.now().toUtc(),
          makerPubkey: maker,
          coordinatorPubkey: 'coord',
          takerPubkey: taker,
          takerInvoice: takerInvoice,
          takerLightningAddress: lnAddr,
          blikCode: '123456',
          holdInvoicePaymentHash: 'hash',
          holdInvoicePreimage: 'preimage',
        );

    // Stateful compare-and-set: advances `current` when the guard matches.
    void stubCas() {
      when(gdb.updateOfferRawStatusIfCurrent(
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
        takerLightningAddress: anyNamed('takerLightningAddress'),
        code: anyNamed('code'),
        codeReceivedAt: anyNamed('codeReceivedAt'),
        disputeAt: anyNamed('disputeAt'),
        takerFees: anyNamed('takerFees'),
        failureReason: anyNamed('failureReason'),
        clearTakerFields: anyNamed('clearTakerFields'),
        transitionMeta: anyNamed('transitionMeta'),
      )).thenAnswer((inv) async {
        final target = inv.positionalArguments[1] as String;
        final expected = inv.namedArguments[const Symbol('expectedCurrentStatuses')]
            as List<String>?;
        if (expected == null || expected.contains(current)) {
          current = target;
          return true;
        }
        return false;
      });
    }

    setUp(() async {
      gdb = MockDatabaseService();
      gpay = MockPaymentService();
      gtelegram = _FakeTelegramService();
      gsvc = CoordinatorService(
        gdb,
        paymentServiceForTest: gpay,
        clock: const Clock(),
        telegramServiceForTest: gtelegram,
        paymentSystemIdForTest: 'blik',
        flowModeForTest: FlowEngineMode.generic,
      );
      await gsvc.init();
      current = 'blikSentToMaker';
      when(gpay.settleInvoice(preimageHex: anyNamed('preimageHex')))
          .thenAnswer((_) async {});
      when(gdb.updateTakerInvoice(any, any)).thenAnswer((_) async => true);
      when(gdb.updateTakerInvoiceFees(any, any)).thenAnswer((_) async => true);
      when(gdb.deleteTelegramOfferMessages(any)).thenAnswer((_) async {});
      when(gdb.getTelegramOfferMessages(any)).thenAnswer((_) async => [
            TelegramOfferMessage(
              offerId: 'p1',
              chatId: 'test-chat-id',
              messageId: 1,
              messageText: 'New offer',
            ),
          ]);
    });

    test('confirm_payment -> settled -> payingTaker -> takerPaid on success',
        () async {
      when(gdb.getOfferById('p1'))
          .thenAnswer((_) async => payoutOffer(takerInvoice: invoice));
      stubCas();
      when(gpay.payInvoice(
        invoice: anyNamed('invoice'),
        amountSat: anyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
      )).thenAnswer(
          (_) async => PayInvoiceResult(paymentPreimage: 'pre', feeSat: 1));

      await gsvc.flow.handleRpc('confirm_payment', {'offer_id': 'p1'}, maker);
      await pumpEventQueue(times: 100);

      expect(current, 'takerPaid');
      // Paid the net amount (offer 1550 - taker fee 50 = 1500).
      final paidAmounts = verify(gpay.payInvoice(
        invoice: anyNamed('invoice'),
        amountSat: captureAnyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
      )).captured;
      expect(paidAmounts.single, 1500);
      expect(gtelegram.deleteCalls, 1);
      verify(gdb.deleteTelegramOfferMessages('p1')).called(1);
    });

    test('payment failure (no reconcile) -> takerPaymentFailed', () async {
      when(gdb.getOfferById('p1'))
          .thenAnswer((_) async => payoutOffer(takerInvoice: invoice));
      stubCas();
      when(gpay.payInvoice(
        invoice: anyNamed('invoice'),
        amountSat: anyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
      )).thenAnswer(
          (_) async => PayInvoiceResult(paymentError: 'no route'));
      when(gpay.reconcileOutgoingPayment(invoice: anyNamed('invoice')))
          .thenAnswer((_) async => null);

      await gsvc.flow.handleRpc('confirm_payment', {'offer_id': 'p1'}, maker);
      await pumpEventQueue(times: 100);

      expect(current, 'takerPaymentFailed');
    });

    test('setup failure (no invoice / no ln address) -> takerPaymentFailed',
        () async {
      when(gdb.getOfferById('p1')).thenAnswer((_) async => payoutOffer());
      stubCas();

      await gsvc.flow.handleRpc('confirm_payment', {'offer_id': 'p1'}, maker);
      await pumpEventQueue(times: 100);

      expect(current, 'takerPaymentFailed');
      verifyNever(gpay.payInvoice(
        invoice: anyNamed('invoice'),
        amountSat: anyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
      ));
    });

    test('startup reconcile: wallet-settled takerPaymentFailed -> takerPaid',
        () async {
      current = 'takerPaymentFailed';
      when(gdb.getOffersNotInRawStatuses(any))
          .thenAnswer((_) async => []);
      when(gdb.getOffersByRawStatus('takerPaymentFailed',
              limit: anyNamed('limit')))
          .thenAnswer((_) async => [payoutOffer(takerInvoice: invoice)]);
      when(gdb.getOfferById('p1'))
          .thenAnswer((_) async => payoutOffer(takerInvoice: invoice));
      stubCas();
      when(gpay.reconcileOutgoingPayment(invoice: anyNamed('invoice')))
          .thenAnswer(
              (_) async => PayInvoiceResult(paymentPreimage: 'pre', feeSat: 2));

      await gsvc.flow.recoverTimers();
      await pumpEventQueue(times: 100);

      expect(current, 'takerPaid');
    });

    test('startup reconcile: still-unpaid stays takerPaymentFailed', () async {
      current = 'takerPaymentFailed';
      when(gdb.getOffersNotInRawStatuses(any))
          .thenAnswer((_) async => []);
      when(gdb.getOffersByRawStatus('takerPaymentFailed',
              limit: anyNamed('limit')))
          .thenAnswer((_) async => [payoutOffer(takerInvoice: invoice)]);
      when(gdb.getOfferById('p1'))
          .thenAnswer((_) async => payoutOffer(takerInvoice: invoice));
      stubCas();
      when(gpay.reconcileOutgoingPayment(invoice: anyNamed('invoice')))
          .thenAnswer((_) async => null);

      await gsvc.flow.recoverTimers();
      await pumpEventQueue(times: 100);

      expect(current, 'takerPaymentFailed');
    });
  });
}
