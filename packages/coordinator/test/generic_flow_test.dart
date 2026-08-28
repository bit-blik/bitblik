import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/models/cancel_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/pay_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/outgoing_payment_attempt.dart';
import 'package:bitblik_coordinator/src/models/bolt12_offer_info.dart';
import 'package:bitblik_coordinator/src/models/pay_offer_result.dart';
import 'package:bitblik_coordinator/src/models/payment_status.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_coordinator/src/services/telegram_service.dart';
import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

void _stubOutgoingPaymentAttempts(
  MockDatabaseService db, {
  OutgoingPaymentAttemptState initialState =
      OutgoingPaymentAttemptState.prepared,
  String? backendPaymentId,
}) {
  OutgoingPaymentAttempt? current;
  when(db.getOrCreateOutgoingPaymentAttempt(
    id: anyNamed('id'),
    offerId: anyNamed('offerId'),
    purpose: anyNamed('purpose'),
    paymentType: anyNamed('paymentType'),
    encoded: anyNamed('encoded'),
    expectedAmountSats: anyNamed('expectedAmountSats'),
    feeLimitSats: anyNamed('feeLimitSats'),
    backendType: anyNamed('backendType'),
  )).thenAnswer((invocation) async {
    final now = DateTime.now().toUtc();
    current ??= OutgoingPaymentAttempt(
      id: invocation.namedArguments[#id] as String,
      offerId: invocation.namedArguments[#offerId] as String,
      purpose: invocation.namedArguments[#purpose] as String,
      generation: 0,
      paymentType:
          invocation.namedArguments[#paymentType] as OutgoingPaymentType,
      bolt11Invoice:
          invocation.namedArguments[#paymentType] == OutgoingPaymentType.bolt11
              ? invocation.namedArguments[#encoded] as String
              : null,
      bolt12Offer:
          invocation.namedArguments[#paymentType] == OutgoingPaymentType.bolt12
              ? invocation.namedArguments[#encoded] as String
              : null,
      expectedAmountSats: invocation.namedArguments[#expectedAmountSats] as int,
      feeLimitSats: invocation.namedArguments[#feeLimitSats] as int?,
      backendType: invocation.namedArguments[#backendType] as String,
      backendPaymentId: backendPaymentId,
      state: initialState,
      createdAt: now,
      updatedAt: now,
    );
    return current!;
  });
  when(db.updateOutgoingPaymentAttempt(
    any,
    state: anyNamed('state'),
    backendPaymentId: anyNamed('backendPaymentId'),
    paymentHash: anyNamed('paymentHash'),
    preimage: anyNamed('preimage'),
    payerProof: anyNamed('payerProof'),
    feePaidSats: anyNamed('feePaidSats'),
    failureReason: anyNamed('failureReason'),
  )).thenAnswer((invocation) async {
    final old = current!;
    final now = DateTime.now().toUtc();
    current = OutgoingPaymentAttempt(
      id: old.id,
      offerId: old.offerId,
      purpose: old.purpose,
      generation: old.generation,
      paymentType: old.paymentType,
      bolt11Invoice: old.bolt11Invoice,
      bolt12Offer: old.bolt12Offer,
      expectedAmountSats: old.expectedAmountSats,
      feeLimitSats: old.feeLimitSats,
      backendType: old.backendType,
      backendPaymentId:
          invocation.namedArguments[#backendPaymentId] as String? ??
              old.backendPaymentId,
      state: invocation.namedArguments[#state] as OutgoingPaymentAttemptState,
      preimage: invocation.namedArguments[#preimage] as String? ?? old.preimage,
      payerProof:
          invocation.namedArguments[#payerProof] as String? ?? old.payerProof,
      feePaidSats:
          invocation.namedArguments[#feePaidSats] as int? ?? old.feePaidSats,
      failureReason: invocation.namedArguments[#failureReason] as String? ??
          old.failureReason,
      createdAt: old.createdAt,
      updatedAt: now,
      settledAt: invocation.namedArguments[#state] ==
              OutgoingPaymentAttemptState.succeeded
          ? now
          : old.settledAt,
    );
    return current!;
  });
}

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

class _BlockingTelegramService extends TelegramService {
  final Completer<TelegramSendResult> _sendCompleter =
      Completer<TelegramSendResult>();

  _BlockingTelegramService()
      : super(botToken: 'test-bot-token', chatIds: const ['test-chat-id']);

  @override
  Future<TelegramSendResult> sendMessageDetailed(String message,
          {List<String>? chatIds}) =>
      _sendCompleter.future;

  void complete() {
    if (_sendCompleter.isCompleted) return;
    _sendCompleter.complete(const TelegramSendResult(
      allSucceeded: true,
      sentMessages: [
        TelegramSentMessage(chatId: 'test-chat-id', messageId: 1),
      ],
    ));
  }
}

/// Coordinator-level tests for the generic (yaml-driven) TWINT executor.
/// Verifies routing, enforcement and identity guards without the full payout
/// chain (covered structurally by core's twint_flow_test).
void main() {
  test('legacy payout action names remain registered as compatibility aliases',
      () {
    final actionsByName = {
      for (final action in allFlowActions) action.name: action,
    };

    expect(
        actionsByName['accept_taker_invoice'], isA<AcceptTakerInvoiceAction>());
    expect(actionsByName['resolve_taker_invoice'],
        isA<ResolveTakerInvoiceAction>());
    expect(
        actionsByName['update_taker_invoice'], isA<UpdateTakerInvoiceAction>());
    expect(actionsByName['require_maker_refund_invoice'],
        isA<RequireMakerRefundInvoiceAction>());

    expect(actionsByName, contains('accept_taker_payout'));
    expect(actionsByName, contains('resolve_taker_payout'));
    expect(actionsByName, contains('update_taker_payout'));
    expect(actionsByName, contains('require_maker_refund_payout'));
  });

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

  test('twint coordinator derives actions from its YAML flow', () {
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
    when(db.getOfferById('o1')).thenAnswer(
        (_) async => twintOffer('twint_charged', takerPubkey: taker));

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
      code: anyNamed('code'),
      codeReceivedAt: anyNamed('codeReceivedAt'),
      disputeAt: anyNamed('disputeAt'),
      takerFees: anyNamed('takerFees'),
      takerInvoiceFees: anyNamed('takerInvoiceFees'),
      failureReason: anyNamed('failureReason'),
      clearTakerFields: captureAnyNamed('clearTakerFields'),
      preserveCodeOnClear: captureAnyNamed('preserveCodeOnClear'),
      transitionMeta: anyNamed('transitionMeta'),
    )).captured;

    // The first CAS durably claims cancellation and clears taker fields; only
    // then does cancel_hold_invoice run. Its completion edge is a second CAS.
    expect(captured[0], 'cancelling');
    expect(captured[1], ['funded']);
    expect(captured[2], isTrue);
    // TWINT: the code is the maker's — it survives taker-field clears.
    expect(captured[3], isTrue);
    expect(captured[4], 'cancelled');
    expect(captured[5], ['cancelling']);
    expect(telegram.editCalls, 1);
    expect(telegram.lastEditedText, '<s>New offer</s>');
    verify(db.deleteTelegramOfferMessages('o1')).called(1);
  });

  test('losing cancellation CAS never cancels the hold invoice', () async {
    when(db.getOfferById('o1')).thenAnswer((_) async => twintOffer('funded'));
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
      makerRefundInvoice: anyNamed('makerRefundInvoice'),
      code: anyNamed('code'),
      codeReceivedAt: anyNamed('codeReceivedAt'),
      disputeAt: anyNamed('disputeAt'),
      takerFees: anyNamed('takerFees'),
      takerInvoiceFees: anyNamed('takerInvoiceFees'),
      failureReason: anyNamed('failureReason'),
      clearTakerFields: anyNamed('clearTakerFields'),
      preserveCodeOnClear: anyNamed('preserveCodeOnClear'),
      transitionMeta: anyNamed('transitionMeta'),
    )).thenAnswer((_) async => false);

    await expectLater(
      svc.flow.handleRpc('cancel_offer', {'offer_id': 'o1'}, maker),
      throwsA(isA<Exception>()),
    );

    verifyNever(pay.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')));
  });

  group('blik generic engine', () {
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
      );
      await bsvc.init(); // loads blik.yml
    });

    test('handles submit_blik / get_blik from the YAML flow', () {
      expect(bsvc.flow.handlesRpc('submit_blik'), isTrue);
      expect(bsvc.flow.handlesRpc('get_blik'), isTrue);
    });

    test('get_blik advances blikReceived -> blikSentToMaker, returns code',
        () async {
      var offer =
          blikOffer('blikReceived', takerPubkey: taker, blikCode: '123456');
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
        code: anyNamed('code'),
        codeReceivedAt: anyNamed('codeReceivedAt'),
        disputeAt: anyNamed('disputeAt'),
        takerFees: anyNamed('takerFees'),
        takerInvoiceFees: anyNamed('takerInvoiceFees'),
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

    test(
        'stale funded enterState cannot overwrite a newer reserved timer after timeout relist',
        () {
      fakeAsync((async) {
        final testClock = async.getClock(DateTime.utc(2026, 7, 14, 13, 45, 0));
        final blockingTelegram = _BlockingTelegramService();
        final timerDb = MockDatabaseService();
        final timerSvc = CoordinatorService(
          timerDb,
          paymentServiceForTest: MockPaymentService(),
          clock: Clock(() => testClock.now()),
          telegramServiceForTest: blockingTelegram,
          paymentSystemIdForTest: 'blik',
        );

        var currentStatus = 'reserved';
        var currentUpdatedAt = testClock.now().toUtc();
        var currentReservedAt = testClock.now().toUtc();
        String? currentTakerPubkey = taker;
        final createdAt =
            testClock.now().toUtc().subtract(const Duration(minutes: 1));

        Offer currentOffer() => Offer(
              id: 'b-race',
              amountSats: 10000,
              makerFees: 50,
              takerFees: 50,
              status: OfferStatus.unknown,
              statusRaw: currentStatus,
              fiatAmount: 10,
              fiatCurrency: 'PLN',
              createdAt: createdAt,
              updatedAt: currentUpdatedAt,
              reservedAt: currentReservedAt,
              makerPubkey: maker,
              coordinatorPubkey: 'coord',
              takerPubkey: currentTakerPubkey,
              holdInvoicePaymentHash: 'hash',
              holdInvoicePreimage: 'preimage',
            );

        when(timerDb.getOffersNotInRawStatuses(any))
            .thenAnswer((_) async => [currentOffer()]);
        when(timerDb.getOffersByRawStatus(any, limit: anyNamed('limit')))
            .thenAnswer((_) async => []);
        when(timerDb.getOfferById('b-race'))
            .thenAnswer((_) async => currentOffer());
        when(timerDb.updateOfferRawStatusIfCurrent(
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
          if (expected != null && !expected.contains(currentStatus)) {
            return false;
          }

          currentStatus = inv.positionalArguments[1] as String;
          currentUpdatedAt = testClock.now().toUtc();

          final takerPubkey =
              inv.namedArguments[const Symbol('takerPubkey')] as String?;
          final reservedAt =
              inv.namedArguments[const Symbol('reservedAt')] as DateTime?;
          final clearTakerFields =
              inv.namedArguments[const Symbol('clearTakerFields')] as bool? ??
                  false;

          if (takerPubkey != null) currentTakerPubkey = takerPubkey;
          if (reservedAt != null) currentReservedAt = reservedAt.toUtc();
          if (clearTakerFields) currentTakerPubkey = null;

          return true;
        });

        timerSvc.init();
        async.flushMicrotasks();

        timerSvc.flow.recoverTimers();
        async.flushMicrotasks();

        async.elapse(const Duration(seconds: 61));
        async.flushMicrotasks();

        expect(currentStatus, 'funded');

        timerSvc.flow.handleRpc('reserve_offer', {'offer_id': 'b-race'}, taker);
        async.flushMicrotasks();

        expect(currentStatus, 'reserved');

        blockingTelegram.complete();
        async.flushMicrotasks();

        async.elapse(const Duration(seconds: 61));
        async.flushMicrotasks();

        expect(currentStatus, 'funded');
      });
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
    late MockCombinedPaymentService gpay;
    late CoordinatorService gsvc;
    late _FakeTelegramService gtelegram;
    late String current;

    Offer payoutOffer(
            {String? takerInvoice,
            String? takerOffer,
            int amountSats = 1550,
            int takerFees = 50}) =>
        Offer(
          id: 'p1',
          amountSats: amountSats,
          makerFees: 0,
          takerFees: takerFees,
          status: OfferStatus.unknown,
          statusRaw: current,
          fiatAmount: 10,
          fiatCurrency: 'PLN',
          createdAt: DateTime.now().toUtc(),
          makerPubkey: maker,
          coordinatorPubkey: 'coord',
          takerPubkey: taker,
          takerInvoice: takerInvoice,
          takerOffer: takerOffer,
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
        code: anyNamed('code'),
        codeReceivedAt: anyNamed('codeReceivedAt'),
        disputeAt: anyNamed('disputeAt'),
        takerFees: anyNamed('takerFees'),
        takerInvoiceFees: anyNamed('takerInvoiceFees'),
        failureReason: anyNamed('failureReason'),
        clearTakerFields: anyNamed('clearTakerFields'),
        transitionMeta: anyNamed('transitionMeta'),
      )).thenAnswer((inv) async {
        final target = inv.positionalArguments[1] as String;
        final expected =
            inv.namedArguments[const Symbol('expectedCurrentStatuses')]
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
      gpay = MockCombinedPaymentService();
      _stubOutgoingPaymentAttempts(gdb);
      gtelegram = _FakeTelegramService();
      gsvc = CoordinatorService(
        gdb,
        paymentServiceForTest: gpay,
        clock: const Clock(),
        telegramServiceForTest: gtelegram,
        paymentSystemIdForTest: 'blik',
      );
      await gsvc.init();
      current = 'blikSentToMaker';
      when(gpay.settleInvoice(preimageHex: anyNamed('preimageHex')))
          .thenAnswer((_) async {});
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
      // The Lightning routing fee reported by the backend is persisted to
      // taker_invoice_fees as part of the takerPaid transition.
      final capturedInvoiceFees = verify(gdb.updateOfferRawStatusIfCurrent(
        any,
        'takerPaid',
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
        takerInvoiceFees: captureAnyNamed('takerInvoiceFees'),
        failureReason: anyNamed('failureReason'),
        clearTakerFields: anyNamed('clearTakerFields'),
        transitionMeta: anyNamed('transitionMeta'),
      )).captured;
      expect(capturedInvoiceFees.single, 1);
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
      )).thenAnswer((_) async => PayInvoiceResult(paymentError: 'no route'));
      when(gpay.reconcileOutgoingPayment(invoice: anyNamed('invoice')))
          .thenAnswer((_) async => null);

      await gsvc.flow.handleRpc('confirm_payment', {'offer_id': 'p1'}, maker);
      await pumpEventQueue(times: 100);

      expect(current, 'takerPaymentFailed');
    });

    test('variable BOLT12 payout sends exact amount and needs no preimage',
        () async {
      const offer =
          'lno1zcss9mk8y3wkklfvevcrszlmu23kfrxh49px20665dqwmn4p72pksese';
      when(gdb.getOfferById('p1'))
          .thenAnswer((_) async => payoutOffer(takerOffer: offer));
      stubCas();
      when(gpay.isBolt12Available).thenReturn(true);
      when(gpay.decodeOffer(offer: anyNamed('offer'))).thenAnswer(
        (_) async => const Bolt12OfferInfo(
          normalized: offer,
          offerId:
              '0000000000000000000000000000000000000000000000000000000000000000',
          network: 'mainnet',
          amountMsat: null,
          isExpired: false,
          isVariableAmount: true,
        ),
      );
      when(gpay.reconcileOutgoingOffer(
        offer: anyNamed('offer'),
        paymentAttemptId: anyNamed('paymentAttemptId'),
        paymentId: anyNamed('paymentId'),
      )).thenAnswer((_) async => null);
      when(gpay.payOffer(
        offer: anyNamed('offer'),
        amountSat: anyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
        paymentAttemptId: anyNamed('paymentAttemptId'),
      )).thenAnswer(
        (_) async => const PayOfferResult(
          status: PaymentStatus.SUCCEEDED,
          paymentId: 'wallet-transaction',
          feeSat: 2,
        ),
      );

      await gsvc.flow.handleRpc('confirm_payment', {'offer_id': 'p1'}, maker);
      await pumpEventQueue(times: 100);

      expect(current, 'takerPaid');
      final amounts = verify(gpay.payOffer(
        offer: offer,
        amountSat: captureAnyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
        paymentAttemptId: anyNamed('paymentAttemptId'),
      )).captured;
      expect(amounts.single, 1500);
    });

    test('submitted unknown attempt is reconciled and never resent', () async {
      _stubOutgoingPaymentAttempts(
        gdb,
        initialState: OutgoingPaymentAttemptState.submitted,
      );
      when(gdb.getOfferById('p1'))
          .thenAnswer((_) async => payoutOffer(takerInvoice: invoice));
      stubCas();
      when(gpay.reconcileOutgoingPayment(invoice: anyNamed('invoice')))
          .thenAnswer((_) async => null);

      await gsvc.flow.handleRpc('confirm_payment', {'offer_id': 'p1'}, maker);
      await pumpEventQueue(times: 100);

      expect(current, 'payingTaker');
      verifyNever(gpay.payInvoice(
        invoice: anyNamed('invoice'),
        amountSat: anyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
      ));
    });

    test('submitted attempt finalized from reconciliation is not resent',
        () async {
      _stubOutgoingPaymentAttempts(
        gdb,
        initialState: OutgoingPaymentAttemptState.submitted,
      );
      when(gdb.getOfferById('p1'))
          .thenAnswer((_) async => payoutOffer(takerInvoice: invoice));
      stubCas();
      when(gpay.reconcileOutgoingPayment(invoice: anyNamed('invoice')))
          .thenAnswer(
        (_) async => PayInvoiceResult(
          status: PaymentStatus.SUCCEEDED,
          paymentId: 'wallet-transaction',
          feeSat: 3,
        ),
      );

      await gsvc.flow.handleRpc('confirm_payment', {'offer_id': 'p1'}, maker);
      await pumpEventQueue(times: 100);

      expect(current, 'takerPaid');
      verifyNever(gpay.payInvoice(
        invoice: anyNamed('invoice'),
        amountSat: anyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
      ));
    });

    test('setup failure (no invoice) -> takerPaymentFailed', () async {
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
      when(gdb.getOffersNotInRawStatuses(any)).thenAnswer((_) async => []);
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
      when(gdb.getOffersNotInRawStatuses(any)).thenAnswer((_) async => []);
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

  group('generic update_taker_invoice', () {
    const invoice =
        'lnbc15u1p3xnhl2pp5jptserfk3zk4qy42tlucycrfwxhydvlemu9pqr93tuzlv9cc7g3sdqsvfhkcap3xyhx7un8cqzpgxqzjcsp5f8c52y2stc300gl6s4xswtjpc37hrnnr3c9wvtgjfuvqmpm35evq9qyyssqy4lgd8tj637qcjp05rdpxxykjenthxftej7a2zzmwrmrl70fyj9hvj0rewhzj7jfyuwkwcg9g2jpwtk3wkjtwnkdks84hsnu8xps5vsq4gj5hs';

    late MockDatabaseService gdb;
    late MockCombinedPaymentService gpay;
    late CoordinatorService gsvc;
    late _FakeTelegramService gtelegram;
    late String current;
    // The invoice the fake DB "stores"; CAS writes update it so the detached
    // auto payout re-fetches the fresh invoice, like the real DB.
    late String? storedInvoice;

    Offer failedOffer() => Offer(
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
          takerInvoice: storedInvoice,
        );

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
        code: anyNamed('code'),
        codeReceivedAt: anyNamed('codeReceivedAt'),
        disputeAt: anyNamed('disputeAt'),
        takerFees: anyNamed('takerFees'),
        takerInvoiceFees: anyNamed('takerInvoiceFees'),
        failureReason: anyNamed('failureReason'),
        clearTakerFields: anyNamed('clearTakerFields'),
        transitionMeta: anyNamed('transitionMeta'),
      )).thenAnswer((inv) async {
        final target = inv.positionalArguments[1] as String;
        final expected =
            inv.namedArguments[const Symbol('expectedCurrentStatuses')]
                as List<String>?;
        if (expected == null || expected.contains(current)) {
          current = target;
          final written =
              inv.namedArguments[const Symbol('takerInvoice')] as String?;
          if (written != null) storedInvoice = written;
          return true;
        }
        return false;
      });
    }

    setUp(() async {
      gdb = MockDatabaseService();
      gpay = MockCombinedPaymentService();
      _stubOutgoingPaymentAttempts(gdb);
      gtelegram = _FakeTelegramService();
      gsvc = CoordinatorService(
        gdb,
        paymentServiceForTest: gpay,
        clock: const Clock(),
        telegramServiceForTest: gtelegram,
        paymentSystemIdForTest: 'blik',
      );
      await gsvc.init();
      current = 'takerPaymentFailed';
      storedInvoice = 'old-broken-invoice';
      when(gdb.getOfferById('p1')).thenAnswer((_) async => failedOffer());
      when(gdb.deleteTelegramOfferMessages(any)).thenAnswer((_) async {});
      when(gdb.getTelegramOfferMessages(any)).thenAnswer((_) async => [
            TelegramOfferMessage(
              offerId: 'p1',
              chatId: 'test-chat-id',
              messageId: 1,
              messageText: 'New offer',
            ),
          ]);
      stubCas();
    });

    test('valid bolt11 is stored and the payout retries with it', () async {
      when(gpay.payInvoice(
        invoice: anyNamed('invoice'),
        amountSat: anyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
      )).thenAnswer(
          (_) async => PayInvoiceResult(paymentPreimage: 'pre', feeSat: 1));

      await gsvc.flow.handleRpc(
          'update_taker_invoice', {'offer_id': 'p1', 'bolt11': invoice}, taker);
      await pumpEventQueue(times: 100);

      expect(storedInvoice, invoice);
      expect(current, 'takerPaid');
      verify(gpay.payInvoice(
        invoice: invoice,
        amountSat: anyNamed('amountSat'),
        feeLimitSat: anyNamed('feeLimitSat'),
      )).called(1);
    });

    test('missing invoice rejects the RPC and stays in takerPaymentFailed',
        () async {
      await expectLater(
        gsvc.flow.handleRpc('update_taker_invoice', {'offer_id': 'p1'}, taker),
        throwsA(isA<Exception>()),
      );
      await pumpEventQueue(times: 100);

      expect(storedInvoice, 'old-broken-invoice');
      expect(current, 'takerPaymentFailed');
    });

    test('supplying both invoice and offer rejects the replacement', () async {
      const offer =
          'lno1zcss9mk8y3wkklfvevcrszlmu23kfrxh49px20665dqwmn4p72pksese';
      await expectLater(
        gsvc.flow.handleRpc(
          'update_taker_invoice',
          {'offer_id': 'p1', 'bolt11': invoice, 'taker_offer': offer},
          taker,
        ),
        throwsA(isA<Exception>()),
      );
      expect(current, 'takerPaymentFailed');
    });

    test('lno is rejected in the invoice field', () async {
      const offer =
          'lno1zcss9mk8y3wkklfvevcrszlmu23kfrxh49px20665dqwmn4p72pksese';
      await expectLater(
        gsvc.flow.handleRpc(
          'update_taker_invoice',
          {'offer_id': 'p1', 'bolt11': offer},
          taker,
        ),
        throwsA(isA<Exception>()),
      );
      expect(current, 'takerPaymentFailed');
    });

    test('wrong-amount invoice rejects the RPC and stays in takerPaymentFailed',
        () async {
      when(gdb.getOfferById('p1')).thenAnswer((_) async => Offer(
            id: 'p1',
            amountSats: 10000,
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
            takerInvoice: storedInvoice,
          ));

      await expectLater(
        gsvc.flow.handleRpc('update_taker_invoice',
            {'offer_id': 'p1', 'bolt11': invoice}, taker),
        throwsA(isA<Exception>()),
      );
      await pumpEventQueue(times: 100);

      expect(storedInvoice, 'old-broken-invoice');
      expect(current, 'takerPaymentFailed');
    });
  });
}
