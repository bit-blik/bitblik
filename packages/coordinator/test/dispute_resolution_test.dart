import 'dart:async';

import 'package:bitblik_coordinator/src/models/pay_invoice_result.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_core/core.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:clock/clock.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

void main() {
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
    late MockPaymentService payment;
    late CoordinatorService service;
    late String currentStatus;
    String? storedMakerInvoice;
    String? storedMakerHash;
    String? storedTakerInvoice;
    int amountSats = 1490;
    int makerFees = 10;
    int takerFees = 0;
    final transitionMeta = <StateTransitionMeta>[];

    Offer currentOffer() => Offer(
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
          expectedTakerPubkey: anyNamed('expectedTakerPubkey'),
          takerPubkey: anyNamed('takerPubkey'),
          code: anyNamed('code'),
          takerInvoice: anyNamed('takerInvoice'),
          makerRefundInvoice: anyNamed('makerRefundInvoice'),
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
        currentStatus = invocation.positionalArguments[1] as String;
        storedMakerInvoice =
            invocation.namedArguments[const Symbol('makerRefundInvoice')]
                    as String? ??
                storedMakerInvoice;
        storedMakerHash =
            invocation.namedArguments[const Symbol('makerRefundPaymentHash')]
                    as String? ??
                storedMakerHash;
        final meta =
            invocation.namedArguments[#transitionMeta] as StateTransitionMeta?;
        if (meta != null) transitionMeta.add(meta);
        return true;
      });
    }

    setUp(() async {
      db = MockDatabaseService();
      payment = MockPaymentService();
      currentStatus = 'dispute';
      storedMakerInvoice = null;
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

    test('failed maker refund requests a fresh invoice and can retry',
        () async {
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

      expect(currentStatus, 'refundedMaker');
      verify(
        payment.payInvoice(
          invoice: invoice,
          amountSat: 1500,
          feeLimitSat: anyNamed('feeLimitSat'),
        ),
      ).called(2);
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
