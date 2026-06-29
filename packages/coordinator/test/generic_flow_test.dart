import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:clock/clock.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'coordinator_service_test.mocks.dart';

/// Coordinator-level tests for the generic (yaml-driven) TWINT executor.
/// Verifies routing, enforcement and identity guards without the full payout
/// chain (covered structurally by core's twint_flow_test).
void main() {
  late MockDatabaseService db;
  late MockPaymentService pay;
  late CoordinatorService svc;

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
    svc = CoordinatorService(
      db,
      paymentServiceForTest: pay,
      clock: const Clock(),
      paymentSystemIdForTest: 'twint',
    );
    await svc.init(); // loads twint.yml -> engine
  });

  test('twint coordinator runs in generic mode', () {
    expect(svc.isGenericFlow, isTrue);
    expect(svc.genericHandlesRpc('reserve_offer'), isTrue);
    // Query/info + payout-tail RPCs are not generic-handled.
    expect(svc.genericHandlesRpc('get_offer_details'), isFalse);
    expect(svc.genericHandlesRpc('update_taker_invoice'), isFalse);
  });

  test('rejects an action from the wrong actor (taker confirming)', () async {
    when(db.getOfferById('o1'))
        .thenAnswer((_) async => twintOffer('twint_charged', takerPubkey: taker));

    expect(
      () => svc.handleGenericRpc('confirm_payment', {'offer_id': 'o1'}, taker),
      throwsA(isA<Exception>()),
    );
    verifyNever(db.updateOfferRawStatusIfCurrent(any, any));
  });

  test('rejects a disallowed transition for the state', () async {
    // confirm_payment is not valid from `funded`.
    when(db.getOfferById('o1')).thenAnswer((_) async => twintOffer('funded'));
    expect(
      () => svc.handleGenericRpc('confirm_payment', {'offer_id': 'o1'}, maker),
      throwsA(isA<Exception>()),
    );
  });

  test('maker_cancels: funded -> cancelled (terminal) with field clear',
      () async {
    final offer = twintOffer('funded');
    when(db.getOfferById('o1')).thenAnswer((_) async => offer);
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
    )).thenAnswer((_) async => true);

    final res =
        await svc.handleGenericRpc('cancel_offer', {'offer_id': 'o1'}, maker);
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
    )).captured;

    expect(captured[0], 'cancelled'); // target
    expect(captured[1], ['funded']); // expected-current CAS guard
    expect(captured[2], isTrue); // clearTakerFields
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
      expect(bsvc.genericHandlesRpc('submit_blik'), isTrue);
      expect(bsvc.genericHandlesRpc('get_blik'), isTrue);
    });

    test('get_blik advances blik_received -> blik_sent_to_maker, returns code',
        () async {
      var offer = blikOffer('blik_received',
          takerPubkey: taker, blikCode: '123456');
      when(bdb.getOfferById('b1')).thenAnswer((_) async => offer);
      when(bdb.updateOfferRawStatusIfCurrent(
        'b1',
        'blik_sent_to_maker',
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
      )).thenAnswer((_) async {
        offer = blikOffer('blik_sent_to_maker',
            takerPubkey: taker, blikCode: '123456');
        return true;
      });

      final res =
          await bsvc.handleGenericRpc('get_blik', {'offer_id': 'b1'}, maker);
      expect(res['blik_code'], '123456');
    });

    test('get_blik by non-maker is rejected', () async {
      when(bdb.getOfferById('b1')).thenAnswer((_) async =>
          blikOffer('blik_received', takerPubkey: taker, blikCode: '123456'));
      expect(
        () => bsvc.handleGenericRpc('get_blik', {'offer_id': 'b1'}, taker),
        throwsA(isA<Exception>()),
      );
    });
  });
}
