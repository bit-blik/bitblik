import 'dart:async';

import 'package:bitblik_coordinator/src/models/pay_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/pay_offer_result.dart';
import 'package:bitblik_coordinator/src/models/bolt12_offer_info.dart';
import 'package:bitblik_coordinator/src/models/payment_status.dart';
import 'package:bitblik_coordinator/src/models/outgoing_payment_attempt.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_core/core.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:clock/clock.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';
import 'outgoing_payment_attempt_stub.dart';

int _stateRevision = 0;

void main() {
  setUp(() => _stateRevision = 0);
  const maker = 'maker';
  const taker = 'taker';
  const coordinator = 'coordinator';
  const invoice =
      'lnbc15u1p3xnhl2pp5jptserfk3zk4qy42tlucycrfwxhydvlemu9pqr93tuzlv9cc7g3sdqsvfhkcap3xyhx7un8cqzpgxqzjcsp5f8c52y2stc300gl6s4xswtjpc37hrnnr3c9wvtgjfuvqmpm35evq9qyyssqy4lgd8tj637qcjp05rdpxxykjenthxftej7a2zzmwrmrl70fyj9hvj0rewhzj7jfyuwkwcg9g2jpwtk3wkjtwnkdks84hsnu8xps5vsq4gj5hs';
  const testnetInvoice =
      'lntb20m1pvjluezhp58yjmdan79s6qqdhdzgynm4zwqd5d7xmw5fk98klysy043l2ahrqspp5qqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqqqsyqcyq5rqwzqfqypqfpp3x9et2e20v6pu37c5d9vax37wxq72un98kmzzhznpurw9sgl2v0nklu2g4d0keph5t7tj9tcqd8rexnd07ux4uv2cjvcqwaxgj7v4uwn5wmypjd5n69z2xm3xgksg28nwht7f6zspwp3f9t';

  final decoded = Bolt11PaymentRequest(invoice);
  final invoiceCreatedAt = DateTime.fromMillisecondsSinceEpoch(
    decoded.timestamp.toInt() * 1000,
    isUtc: true,
  );

  group('structured dispute resolution', () {
    late MockDatabaseService db;
    late MockCombinedPaymentService payment;
    late CoordinatorService service;
    late String currentStatus;
    String? storedMakerInvoice;
    String? storedMakerOffer;
    String? storedMakerHash;
    String? storedTakerInvoice;
    int amountSats = 1490;
    int makerFees = 10;
    int takerFees = 0;
    final transitionMeta = <StateTransitionMeta>[];

    Offer currentOffer() => Offer(
          stateRevision: _stateRevision,
          id: 'dispute-1',
          amountSats: amountSats,
          makerFees: makerFees,
          takerFees: takerFees,
          status: OfferStatus.unknown,
          statusRaw: currentStatus,
          fiatAmount: 100,
          fiatCurrency: 'PLN',
          createdAt: invoiceCreatedAt,
          makerPubkey: maker,
          takerPubkey: taker,
          coordinatorPubkey: coordinator,
          takerInvoice: storedTakerInvoice,
          makerRefundInvoice: storedMakerInvoice,
          makerRefundOffer: storedMakerOffer,
          makerRefundPaymentHash: storedMakerHash,
          holdInvoicePaymentHash:
              'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff',
          holdInvoicePreimage: 'secured-preimage',
        );

    void stubStatefulCas() {
      when(
        db.updateOfferRawStatusIfCurrent(
          any,
          any,
          expectedCurrentStatuses: anyNamed('expectedCurrentStatuses'),
          expectedStateRevision: anyNamed('expectedStateRevision'),
          expectedPaymentAttempt: anyNamed('expectedPaymentAttempt'),
          expectedTakerPubkey: anyNamed('expectedTakerPubkey'),
          takerPubkey: anyNamed('takerPubkey'),
          code: anyNamed('code'),
          takerInvoice: anyNamed('takerInvoice'),
          makerRefundInvoice: anyNamed('makerRefundInvoice'),
          makerRefundOffer: anyNamed('makerRefundOffer'),
          makerRefundPaymentHash: anyNamed('makerRefundPaymentHash'),
          reservedAt: anyNamed('reservedAt'),
          codeReceivedAt: anyNamed('codeReceivedAt'),
          takerChargedAt: anyNamed('takerChargedAt'),
          makerConfirmedAt: anyNamed('makerConfirmedAt'),
          settledAt: anyNamed('settledAt'),
          takerPaidAt: anyNamed('takerPaidAt'),
          disputeAt: anyNamed('disputeAt'),
          takerFees: anyNamed('takerFees'),
          takerInvoiceFees: anyNamed('takerInvoiceFees'),
          failureReason: anyNamed('failureReason'),
          clearTakerFields: anyNamed('clearTakerFields'),
          preserveCodeOnClear: anyNamed('preserveCodeOnClear'),
          transitionMeta: anyNamed('transitionMeta'),
        ),
      ).thenAnswer((invocation) async {
        final expected = invocation
            .namedArguments[const Symbol('expectedCurrentStatuses')] as List?;
        if (expected != null && !expected.contains(currentStatus)) return false;
        _stateRevision++;
        currentStatus = invocation.positionalArguments[1] as String;
        final newInvoice =
            invocation.namedArguments[#makerRefundInvoice] as String?;
        final newOffer =
            invocation.namedArguments[#makerRefundOffer] as String?;
        if (newInvoice != null) {
          storedMakerInvoice = newInvoice;
          storedMakerOffer = null;
        }
        if (newOffer != null) {
          storedMakerOffer = newOffer;
          storedMakerInvoice = null;
          storedMakerHash = null;
        } else {
          storedMakerHash =
              invocation.namedArguments[#makerRefundPaymentHash] as String? ??
                  storedMakerHash;
        }
        final meta =
            invocation.namedArguments[#transitionMeta] as StateTransitionMeta?;
        if (meta != null) transitionMeta.add(meta);
        return true;
      });
    }

    setUp(() async {
      db = MockDatabaseService();
      stubOutgoingPaymentAttempts(db);
      payment = MockCombinedPaymentService();
      currentStatus = 'dispute';
      storedMakerInvoice = null;
      storedMakerOffer = null;
      storedMakerHash = null;
      storedTakerInvoice = null;
      amountSats = 1490;
      makerFees = 10;
      takerFees = 0;
      transitionMeta.clear();
      when(db.getOfferById('dispute-1'))
          .thenAnswer((_) async => currentOffer());
      stubStatefulCas();
      when(
        payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      ).thenAnswer(
        (_) async => PayInvoiceResult(paymentPreimage: 'paid', feeSat: 1),
      );
      service = CoordinatorService(
        db,
        paymentServiceForTest: payment,
        paymentSystemIdForTest: 'blik',
        coordinatorPubkeyForTest: coordinator,
        clock: Clock.fixed(invoiceCreatedAt.add(const Duration(minutes: 1))),
      );
      await service.init();
    });

    Future<void> submitMakerInvoice([String value = invoice]) =>
        service.flow.handleRpc(
          kRpcSubmitMakerRefundInvoice,
          {'offer_id': 'dispute-1', 'bolt11': value},
          maker,
        );

    const bolt12 =
        'lno1zcss9mk8y3wkklfvevcrszlmu23kfrxh49px20665dqwmn4p72pksese';

    Future<Map<String, dynamic>> retryAsCoordinator(
            {String? expectedState, String actor = coordinator}) =>
        service.flow.handleRpc(
            kRpcRetryCoordinatorPayment,
            {
              'offer_id': 'dispute-1',
              'expected_state': expectedState ?? currentStatus
            },
            actor);

    test('coordinator retry rejects participant and stale state', () async {
      currentStatus = 'payingTaker';
      storedTakerInvoice = invoice;
      await expectLater(retryAsCoordinator(actor: maker), throwsStateError);
      await expectLater(retryAsCoordinator(expectedState: 'takerPaymentFailed'),
          throwsStateError);
      verifyNever(payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat')));
    });

    test('coordinator cannot retry refund without maker instruction', () async {
      currentStatus = 'refundingMaker';
      await expectLater(retryAsCoordinator(),
          throwsA(predicate((e) => '$e'.contains('Maker must submit'))));
      expect(currentStatus, 'refundingMaker');
      verifyNever(payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat')));
    });

    test('coordinator resumes unknown taker payment by reconciliation only',
        () async {
      currentStatus = 'payingTaker';
      amountSats = 1500;
      storedTakerInvoice = invoice;
      stubOutgoingPaymentAttempts(db,
          initialState: OutgoingPaymentAttemptState.unknown);
      when(payment.reconcileOutgoingPayment(invoice: invoice)).thenAnswer(
          (_) async => PayInvoiceResult(paymentPreimage: 'paid', feeSat: 1));
      await retryAsCoordinator();
      expect(currentStatus, 'takerPaid');
      verifyNever(payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat')));
    });

    test('coordinator retries failed maker refund and preserves amount',
        () async {
      currentStatus = 'refundingMaker';
      storedMakerInvoice = invoice;
      storedMakerHash = 'hash';
      await retryAsCoordinator();
      expect(currentStatus, 'refundedMaker');
      verify(payment.payInvoice(
              invoice: invoice, amountSat: 1500, feeLimitSat: 15))
          .called(1);
      expect(transitionMeta.first.event, kRpcRetryCoordinatorPayment);
      expect(transitionMeta.first.actorPubkey, coordinator);
    });

    test('manual retry does not resend unresolved payment and exposes error',
        () async {
      currentStatus = 'payingTaker';
      amountSats = 1500;
      storedTakerInvoice = invoice;
      stubOutgoingPaymentAttempts(db,
          initialState: OutgoingPaymentAttemptState.unknown);
      await retryAsCoordinator();
      expect(currentStatus, 'payingTaker');
      verifyNever(payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat')));
      final diagnostics = await service.getPaymentDiagnostics(currentOffer());
      expect(diagnostics['retry_supported'], isTrue);
      expect((diagnostics['last_error'] as Map)['message'], isNotEmpty);
      expect((diagnostics['last_error'] as Map)['stack_trace'], isNotEmpty);
      verify(db.recordOfferTransition(
        offerId: 'dispute-1',
        fromState: 'payingTaker',
        toState: 'payingTaker',
        meta: argThat(
            predicate<StateTransitionMeta>((m) => m.trigger == 'payment_error'),
            named: 'meta'),
      )).called(1);
    });

    test('diagnostics expose attempt details but never payment proofs',
        () async {
      when(db.getOutgoingPaymentAttempts('dispute-1')).thenAnswer((_) async => [
            OutgoingPaymentAttempt(
                id: 'attempt-1',
                offerId: 'dispute-1',
                purpose: 'refund',
                generation: 2,
                paymentType: OutgoingPaymentType.bolt11,
                expectedAmountSats: 1500,
                feeLimitSats: 15,
                backendType: 'nwc',
                state: OutgoingPaymentAttemptState.unknown,
                createdAt: invoiceCreatedAt,
                updatedAt: invoiceCreatedAt,
                bolt11Invoice: invoice,
                preimage: 'private-preimage',
                payerProof: 'private-proof',
                failureReason:
                    'InvoiceRequestExpired private-proof private-preimage $invoice'),
          ]);
      final diagnostics = await service.getPaymentDiagnostics(currentOffer());
      final attempt = (diagnostics['attempts'] as List).single as Map;
      expect(attempt['generation'], 2);
      expect(attempt['backend_type'], 'nwc');
      expect(attempt['fee_limit_sats'], 15);
      expect(attempt['failure_reason'], contains('InvoiceRequestExpired'));
      expect(attempt.containsKey('preimage'), isFalse);
      for (final secret in ['private-proof', 'private-preimage', invoice]) {
        expect(diagnostics.toString(), isNot(contains(secret)));
      }
    });

    test('manual retry requires a fresh invoice after definitive failure',
        () async {
      currentStatus = 'payingTaker';
      amountSats = 1500;
      storedTakerInvoice = invoice;
      when(payment.reconcileOutgoingPayment(invoice: invoice)).thenAnswer(
          (_) async => PayInvoiceResult(
              status: PaymentStatus.FAILED, paymentError: 'RouteNotFound'));
      await retryAsCoordinator();
      expect(currentStatus, 'takerPaymentFailed');
      verifyNever(payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat')));
      await retryAsCoordinator();
      expect(currentStatus, 'takerPaymentFailed');
      verifyNever(payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat')));
    });

    for (final result in [PaymentStatus.SUCCEEDED, PaymentStatus.FAILED]) {
      test(
          'stale $result worker cannot complete a newer payingMaker incarnation',
          () async {
        currentStatus = 'payingMaker';
        storedMakerInvoice = invoice;
        final sent = Completer<void>();
        final finish = Completer<PayInvoiceResult>();
        when(payment.payInvoice(
                invoice: invoice,
                amountSat: anyNamed('amountSat'),
                feeLimitSat: anyNamed('feeLimitSat')))
            .thenAnswer((_) {
          sent.complete();
          return finish.future;
        });
        final oldWorker = retryAsCoordinator();
        await sent.future;
        // Another executor advanced through refundingMaker back to payingMaker.
        _stateRevision += 2;
        final newRevision = _stateRevision;
        finish.complete(PayInvoiceResult(status: result));
        await oldWorker;
        expect(currentStatus, 'payingMaker');
        expect(_stateRevision, newRevision);
      });
    }

    test('concurrent coordinator retries submit only once', () async {
      currentStatus = 'payingMaker';
      storedMakerInvoice = invoice;
      final sent = Completer<void>();
      final finish = Completer<PayInvoiceResult>();
      when(payment.payInvoice(
              invoice: invoice,
              amountSat: anyNamed('amountSat'),
              feeLimitSat: anyNamed('feeLimitSat')))
          .thenAnswer((_) {
        sent.complete();
        return finish.future;
      });
      final first = retryAsCoordinator();
      await sent.future;
      final second = await retryAsCoordinator();
      expect(second['message'], contains('already running'));
      finish.complete(PayInvoiceResult(paymentPreimage: 'paid', feeSat: 1));
      await first;
      expect(currentStatus, 'refundedMaker');
      verify(payment.payInvoice(
              invoice: invoice,
              amountSat: anyNamed('amountSat'),
              feeLimitSat: anyNamed('feeLimitSat')))
          .called(1);
    });

    void stubBolt12(
        {int? amountMsat,
        String network = 'mainnet',
        bool expired = false,
        bool available = true}) {
      when(payment.isBolt12Available).thenReturn(available);
      when(payment.decodeOffer(offer: anyNamed('offer'))).thenAnswer(
          (_) async => Bolt12OfferInfo(
              normalized: bolt12,
              offerId: 'offer-id',
              network: network,
              amountMsat: amountMsat,
              isExpired: expired,
              isVariableAmount: amountMsat == null));
      when(payment.payOffer(
              offer: anyNamed('offer'),
              amountSat: anyNamed('amountSat'),
              feeLimitSat: anyNamed('feeLimitSat'),
              paymentAttemptId: anyNamed('paymentAttemptId')))
          .thenAnswer((_) async =>
              PayOfferResult(status: PaymentStatus.SUCCEEDED, feeSat: 1));
    }

    Future<void> ruleForMaker() => service.flow.handleRpc(
        'resolve_dispute_refund_maker', {'offer_id': 'dispute-1'}, coordinator);

    Future<void> submitMakerOffer(
            {String author = maker, bool withInvoice = false}) =>
        service.flow.handleRpc(
            kRpcSubmitMakerRefundInvoice,
            {
              'offer_id': 'dispute-1',
              'maker_offer': bolt12,
              if (withInvoice) 'bolt11': invoice
            },
            author);

    for (final fixedAmount in [false, true]) {
      test(
          'maker can refund through ${fixedAmount ? "fixed" : "variable"}-amount BOLT12 offer',
          () async {
        stubBolt12(amountMsat: fixedAmount ? 1500000 : null);
        await ruleForMaker();
        await submitMakerOffer();
        await pumpEventQueue(times: 100);
        expect(currentStatus, 'refundedMaker');
        expect(storedMakerOffer, bolt12);
        expect(storedMakerInvoice, isNull);
        expect(storedMakerHash, isNull);
        verify(payment.payOffer(
                offer: bolt12,
                amountSat: 1500,
                feeLimitSat: anyNamed('feeLimitSat'),
                paymentAttemptId: anyNamed('paymentAttemptId')))
            .called(1);
        verifyNever(payment.payInvoice(
            invoice: anyNamed('invoice'),
            amountSat: anyNamed('amountSat'),
            feeLimitSat: anyNamed('feeLimitSat')));
      });
    }

    test(
        'maker BOLT12 submission preserves authorization and one-of validation',
        () async {
      stubBolt12();
      await expectLater(submitMakerOffer(), throwsException);
      await ruleForMaker();
      for (final author in [taker, coordinator]) {
        await expectLater(submitMakerOffer(author: author), throwsException);
      }
      await expectLater(submitMakerOffer(withInvoice: true), throwsException);
      expect(currentStatus, 'refundingMaker');
      expect(storedMakerOffer, isNull);
    });

    test(
        'maker BOLT12 rejects unavailable, expired, wrong-network and inexact offers',
        () async {
      await ruleForMaker();
      stubBolt12(available: false);
      await expectLater(submitMakerOffer(), throwsException);
      stubBolt12(expired: true);
      await expectLater(submitMakerOffer(), throwsException);
      stubBolt12(network: 'testnet');
      await expectLater(submitMakerOffer(), throwsException);
      // Both values fit the old taker tolerance, but not an exact maker refund.
      for (final amount in [1499000, 1501000]) {
        stubBolt12(amountMsat: amount);
        await expectLater(submitMakerOffer(), throwsException);
      }
      expect(currentStatus, 'refundingMaker');
      expect(storedMakerOffer, isNull);
    });

    test('failed BOLT11 refund can switch to a BOLT12 destination', () async {
      when(payment.payInvoice(
              invoice: anyNamed('invoice'),
              amountSat: anyNamed('amountSat'),
              feeLimitSat: anyNamed('feeLimitSat')))
          .thenAnswer((_) async => PayInvoiceResult(paymentError: 'no route'));
      await ruleForMaker();
      await submitMakerInvoice();
      await pumpEventQueue(times: 100);
      expect(currentStatus, 'refundingMaker');
      expect(storedMakerHash, isNotNull);
      stubBolt12();
      await submitMakerOffer();
      await pumpEventQueue(times: 100);
      expect(currentStatus, 'refundedMaker');
      expect(storedMakerInvoice, isNull);
      expect(storedMakerHash, isNull);
      expect(storedMakerOffer, bolt12);
    });

    for (final settled in [false, true]) {
      test(
          'restart reconciles BOLT12 maker refund without resending ($settled)',
          () async {
        stubBolt12();
        storedMakerOffer = bolt12;
        currentStatus = 'payingMaker';
        stubOutgoingPaymentAttempts(db,
            initialState: OutgoingPaymentAttemptState.submitted,
            backendPaymentId: 'wallet-payment');
        when(payment.reconcileOutgoingOffer(
                offer: anyNamed('offer'),
                paymentAttemptId: anyNamed('paymentAttemptId'),
                paymentId: anyNamed('paymentId')))
            .thenAnswer((_) async => PayOfferResult(
                status:
                    settled ? PaymentStatus.SUCCEEDED : PaymentStatus.UNKNOWN));
        when(db.getOffersNotInRawStatuses(any))
            .thenAnswer((_) async => [currentOffer()]);
        final restarted = CoordinatorService(db,
            paymentServiceForTest: payment,
            paymentSystemIdForTest: 'blik',
            coordinatorPubkeyForTest: coordinator,
            clock:
                Clock.fixed(invoiceCreatedAt.add(const Duration(minutes: 2))));
        await restarted.init();
        await restarted.doInitialCheckStatuses();
        await pumpEventQueue(times: 100);
        expect(currentStatus, settled ? 'refundedMaker' : 'payingMaker');
        verifyNever(payment.payOffer(
            offer: anyNamed('offer'),
            amountSat: anyNamed('amountSat'),
            feeLimitSat: anyNamed('feeLimitSat'),
            paymentAttemptId: anyNamed('paymentAttemptId')));
      });
    }

    test('coordinator ruling waits for maker invoice, then refunds', () async {
      await service.flow.handleRpc(
        'resolve_dispute_refund_maker',
        {'offer_id': 'dispute-1'},
        coordinator,
      );
      expect(currentStatus, 'refundingMaker');

      await submitMakerInvoice();
      await pumpEventQueue(times: 100);

      expect(storedMakerInvoice, invoice);
      expect(storedMakerHash, isNotNull);
      expect(currentStatus, 'refundedMaker');
      final submission = transitionMeta.singleWhere(
        (meta) => meta.event == 'submit_maker_refund_invoice',
      );
      expect(
          submission.extra, containsPair('maker_refund_payout_updated', true));
      for (final meta in transitionMeta) {
        expect((meta.extra ?? const {}).keys, isNot(contains('blik_code')));
        expect((meta.extra ?? const {}).keys, isNot(contains('taker_invoice')));
        expect((meta.extra ?? const {}).keys, isNot(contains('taker_offer')));
        expect((meta.extra ?? const {}).keys, isNot(contains('maker_invoice')));
        expect((meta.extra ?? const {}).keys, isNot(contains('maker_offer')));
        expect((meta.extra ?? const {}).values, isNot(contains(invoice)));
      }
      verify(
        payment.payInvoice(
          invoice: invoice,
          amountSat: 1500,
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      ).called(1);
    });

    test('maker ruling commits without a previously persisted invoice',
        () async {
      await service.flow.handleRpc(
        'resolve_dispute_refund_maker',
        {'offer_id': 'dispute-1'},
        coordinator,
      );
      expect(currentStatus, 'refundingMaker');
      verifyNever(
        payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      );
    });

    test('only maker can submit and only coordinator can decide', () async {
      await expectLater(
        service.flow.handleRpc(
          'resolve_dispute_refund_maker',
          {'offer_id': 'dispute-1'},
          maker,
        ),
        throwsA(isA<Exception>()),
      );
      expect(currentStatus, 'dispute');

      await service.flow.handleRpc(
        'resolve_dispute_refund_maker',
        {'offer_id': 'dispute-1'},
        coordinator,
      );
      await expectLater(
        service.flow.handleRpc(
          kRpcSubmitMakerRefundInvoice,
          {'offer_id': 'dispute-1', 'bolt11': invoice},
          taker,
        ),
        throwsA(isA<Exception>()),
      );
      await submitMakerInvoice();
      await pumpEventQueue(times: 100);
      expect(currentStatus, 'refundedMaker');
    });

    test('rejects wrong amount, wrong network, expired and reused invoices',
        () async {
      await service.flow.handleRpc(
        'resolve_dispute_refund_maker',
        {'offer_id': 'dispute-1'},
        coordinator,
      );
      amountSats = 1491;
      await expectLater(submitMakerInvoice(), throwsA(isA<Exception>()));
      amountSats = 1490;
      await expectLater(
        submitMakerInvoice(testnetInvoice),
        throwsA(isA<Exception>()),
      );

      final expiredService = CoordinatorService(
        db,
        paymentServiceForTest: payment,
        paymentSystemIdForTest: 'blik',
        coordinatorPubkeyForTest: coordinator,
        clock: Clock.fixed(invoiceCreatedAt.add(const Duration(hours: 2))),
      );
      await expiredService.init();
      await expectLater(
        expiredService.flow.handleRpc(
          kRpcSubmitMakerRefundInvoice,
          {'offer_id': 'dispute-1', 'bolt11': invoice},
          maker,
        ),
        throwsA(isA<Exception>()),
      );
      when(db.getOfferById('dispute-1')).thenAnswer(
        (_) async => currentOffer().copyWith(
          holdInvoicePaymentHash: Bolt11PaymentRequest(invoice)
              .tags
              .firstWhere((tag) => tag.type == 'payment_hash')
              .data as String,
        ),
      );
      await expectLater(submitMakerInvoice(), throwsA(isA<Exception>()));
    });

    test('concurrent duplicate maker rulings commit only once', () async {
      Future<Object> attempt() async {
        try {
          return await service.flow.handleRpc(
            'resolve_dispute_refund_maker',
            {'offer_id': 'dispute-1'},
            coordinator,
          );
        } catch (error) {
          return error;
        }
      }

      final results = await Future.wait([
        attempt(),
        attempt(),
      ]);
      await pumpEventQueue(times: 100);

      expect(results, hasLength(2));
      expect(results.whereType<Map<String, dynamic>>(), hasLength(1));
      expect(results.whereType<Exception>(), hasLength(1));
      expect(currentStatus, 'refundingMaker');
      verifyNever(
        payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      );
    });

    test('failed maker refund cannot resend the same invoice', () async {
      when(
        payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      ).thenAnswer((_) async => PayInvoiceResult(paymentError: 'no route'));

      await service.flow.handleRpc(
        'resolve_dispute_refund_maker',
        {'offer_id': 'dispute-1'},
        coordinator,
      );
      await submitMakerInvoice();
      await pumpEventQueue(times: 100);

      expect(currentStatus, 'refundingMaker');

      when(
        payment.payInvoice(
          invoice: anyNamed('invoice'),
          amountSat: anyNamed('amountSat'),
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      ).thenAnswer(
        (_) async => PayInvoiceResult(paymentPreimage: 'paid', feeSat: 1),
      );
      await submitMakerInvoice();
      await pumpEventQueue(times: 100);

      expect(currentStatus, 'refundingMaker');
      verify(
        payment.payInvoice(
          invoice: invoice,
          amountSat: 1500,
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      ).called(1);
    });

    test('coordinator can rule for taker without maker invoice', () async {
      amountSats = 1550;
      takerFees = 50;
      storedTakerInvoice = invoice;

      await service.flow.handleRpc(
        'resolve_dispute_pay_taker',
        {'offer_id': 'dispute-1'},
        coordinator,
      );
      await pumpEventQueue(times: 100);

      expect(currentStatus, 'takerPaid');
      verify(
        payment.payInvoice(
          invoice: invoice,
          amountSat: 1500,
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      ).called(1);
      final ruling = transitionMeta.singleWhere(
        (meta) => meta.event == 'resolve_dispute_pay_taker',
      );
      expect(ruling.actor, 'coordinator');
      expect(ruling.actorPubkey, coordinator);
      expect(
          ruling.extra, containsPair('decision', 'resolve_dispute_pay_taker'));
      expect(ruling.extra, containsPair('decision_recipient', 'taker'));
      expect(ruling.extra, containsPair('decision_amount_sats', 1500));
    });

    test('restart resumes a committed maker payout exactly once', () async {
      storedMakerInvoice = invoice;
      storedMakerHash = Bolt11PaymentRequest(invoice)
          .tags
          .firstWhere((tag) => tag.type == 'payment_hash')
          .data as String;
      currentStatus = 'payingMaker';
      when(
        db.getOffersNotInRawStatuses(any),
      ).thenAnswer((_) async => [currentOffer()]);

      final restarted = CoordinatorService(
        db,
        paymentServiceForTest: payment,
        paymentSystemIdForTest: 'blik',
        coordinatorPubkeyForTest: coordinator,
        clock: Clock.fixed(invoiceCreatedAt.add(const Duration(minutes: 2))),
      );
      await restarted.init();
      await restarted.doInitialCheckStatuses();
      await pumpEventQueue(times: 100);

      expect(currentStatus, 'refundedMaker');
      verify(
        payment.payInvoice(
          invoice: invoice,
          amountSat: 1500,
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      ).called(1);
    });
  });
}
