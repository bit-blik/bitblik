import 'dart:async';
import 'dart:io';

import 'package:bitblik_coordinator/src/models/outgoing_payment_attempt.dart';
import 'package:bitblik_coordinator/src/models/pay_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/payment_status.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_core/core.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';
import 'package:clock/clock.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../test/test_mocks.mocks.dart';

const invoice =
    'lnbc15u1p3xnhl2pp5jptserfk3zk4qy42tlucycrfwxhydvlemu9pqr93tuzlv9cc7g3sdqsvfhkcap3xyhx7un8cqzpgxqzjcsp5f8c52y2stc300gl6s4xswtjpc37hrnnr3c9wvtgjfuvqmpm35evq9qyyssqy4lgd8tj637qcjp05rdpxxykjenthxftej7a2zzmwrmrl70fyj9hvj0rewhzj7jfyuwkwcg9g2jpwtk3wkjtwnkdks84hsnu8xps5vsq4gj5hs';

class _FailOnceDatabase extends DatabaseService {
  bool failNextSuccess = false;

  @override
  Future<OutgoingPaymentAttempt> updateOutgoingPaymentAttempt(
    String id, {
    required OutgoingPaymentAttemptState state,
    required int expectedRevision,
    String? backendPaymentId,
    String? paymentHash,
    String? preimage,
    String? payerProof,
    int? feePaidSats,
    String? failureReason,
  }) {
    if (state == OutgoingPaymentAttemptState.succeeded && failNextSuccess) {
      failNextSuccess = false;
      throw StateError(
          'Synthetic crash after wallet success, before database commit');
    }
    return super.updateOutgoingPaymentAttempt(id,
        state: state,
        expectedRevision: expectedRevision,
        backendPaymentId: backendPaymentId,
        paymentHash: paymentHash,
        preimage: preimage,
        payerProof: payerProof,
        feePaidSats: feePaidSats,
        failureReason: failureReason);
  }
}

/// Only a disposable local database; no wallet, relay or production services.
void main() {
  group('PostgreSQL payment safety', () {
    late _FailOnceDatabase db;
    late _FailOnceDatabase other;
    late Offer offer;

    setUp(() async {
      expect(Platform.environment['DB_HOST'], '127.0.0.1');
      expect(Platform.environment['DB'], 'payment_safety_test');
      for (final key in [
        'SIMPLEX_CHAT_EXEC',
        'SIGNAL_CLI_EXEC',
        'TELEGRAM_BOT_TOKEN',
        'MATRIX_USER'
      ]) {
        expect(Platform.environment[key], '');
      }
      db = _FailOnceDatabase();
      other = _FailOnceDatabase();
      await db.connect();
      await other.connect();
      db.recordStateHistory = true;
      other.recordStateHistory = true;
      addTearDown(db.disconnect);
      addTearDown(other.disconnect);
      offer = Offer(
        id: const Uuid().v4(),
        amountSats: 1500,
        makerFees: 0,
        status: OfferStatus.unknown,
        statusRaw: 'payingMaker',
        fiatAmount: 10,
        fiatCurrency: 'PLN',
        createdAt: DateTime.now().toUtc(),
        makerPubkey: 'maker',
        coordinatorPubkey: 'coordinator',
        makerRefundInvoice: invoice,
        holdInvoicePaymentHash: const Uuid().v4(),
        holdInvoicePreimage: 'synthetic-test-preimage',
      );
      await db.createOffer(offer);
      // createOffer uses the enum; set the generic state through the real CAS.
      await db.updateOfferRawStatusIfCurrent(offer.id, 'payingMaker');
      offer = (await db.getOfferById(offer.id))!;
    });

    Future<OutgoingPaymentAttempt> prepare(DatabaseService database,
            {String encoded = invoice, bool bolt12 = false, int? revision}) =>
        database.getOrCreateOutgoingPaymentAttempt(
          id: const Uuid().v4(),
          offerId: offer.id,
          purpose: 'maker_refund',
          offerStateRevision: revision ?? offer.stateRevision,
          paymentType:
              bolt12 ? OutgoingPaymentType.bolt12 : OutgoingPaymentType.bolt11,
          encoded: encoded,
          expectedAmountSats: 1500,
          feeLimitSats: 15,
          backendType: 'test',
        );

    test('two connections claim once; stale results cannot undo success',
        () async {
      final attempts = await Future.wait([prepare(db), prepare(other)]);
      expect(attempts[0].id, attempts[1].id);
      Future<Object> claim(
          DatabaseService database, OutgoingPaymentAttempt a) async {
        try {
          return await database.updateOutgoingPaymentAttempt(a.id,
              expectedRevision: a.revision,
              state: OutgoingPaymentAttemptState.submitted);
        } catch (e) {
          return e;
        }
      }

      final claims = await Future.wait(
          [claim(db, attempts[0]), claim(other, attempts[1])]);
      expect(claims.whereType<StateError>(), hasLength(1));
      final winner = claims.whereType<OutgoingPaymentAttempt>().single;
      final paid = await db.updateOutgoingPaymentAttempt(winner.id,
          expectedRevision: winner.revision,
          state: OutgoingPaymentAttemptState.succeeded);
      for (final state in [
        OutgoingPaymentAttemptState.unknown,
        OutgoingPaymentAttemptState.failed
      ]) {
        await expectLater(
            other.updateOutgoingPaymentAttempt(winner.id,
                expectedRevision: winner.revision, state: state),
            throwsStateError);
        await expectLater(
            other.updateOutgoingPaymentAttempt(winner.id,
                expectedRevision: paid.revision, state: state),
            throwsStateError);
      }
      expect((await db.getOutgoingPaymentAttempts(offer.id)).single.state,
          OutgoingPaymentAttemptState.succeeded);
    });

    test(
        'unresolved attempts reserve funds across reconnect and reject replacement',
        () async {
      var a = await prepare(db);
      a = await db.updateOutgoingPaymentAttempt(a.id,
          expectedRevision: a.revision,
          state: OutgoingPaymentAttemptState.submitted);
      await db.disconnect();
      await db.connect();
      expect((await prepare(db)).state, OutgoingPaymentAttemptState.submitted);
      for (final state in [
        OutgoingPaymentAttemptState.pending,
        OutgoingPaymentAttemptState.unknown
      ]) {
        a = await db.updateOutgoingPaymentAttempt(a.id,
            expectedRevision: a.revision, state: state);
        await expectLater(
            prepare(other, encoded: 'lno1replacement', bolt12: true),
            throwsStateError);
      }
      a = await db.updateOutgoingPaymentAttempt(a.id,
          expectedRevision: a.revision,
          state: OutgoingPaymentAttemptState.failed);
      expect((await prepare(other)).id, a.id,
          reason: 'Failed BOLT11 hashes are never resent');
      final replacement =
          await prepare(other, encoded: 'lno1replacement', bolt12: true);
      expect(replacement.generation, a.generation + 1);
    });

    test(
        'offer ABA and attempt identity fence both success and failure completion',
        () async {
      var a = await prepare(db);
      a = await db.updateOutgoingPaymentAttempt(a.id,
          expectedRevision: a.revision,
          state: OutgoingPaymentAttemptState.failed);
      await db.updateOfferRawStatusIfCurrent(offer.id, 'refundingMaker',
          expectedStateRevision: offer.stateRevision);
      await db.updateOfferRawStatusIfCurrent(offer.id, 'payingMaker');
      for (final target in ['refundedMaker', 'refundingMaker']) {
        expect(
            await other.updateOfferRawStatusIfCurrent(offer.id, target,
                expectedCurrentStatuses: ['payingMaker'],
                expectedStateRevision: offer.stateRevision,
                expectedPaymentAttempt: a),
            isFalse);
      }
      final current = (await db.getOfferById(offer.id))!;
      await prepare(db,
          encoded: 'lno1new', bolt12: true, revision: current.stateRevision);
      expect(
          await other.updateOfferRawStatusIfCurrent(offer.id, 'refundingMaker',
              expectedStateRevision: current.stateRevision,
              expectedPaymentAttempt: a),
          isFalse,
          reason:
              'Even a matching offer revision cannot complete an older attempt');
      expect((await db.getOfferById(offer.id))!.statusRaw, 'payingMaker');
    });

    test(
        'stale offer snapshot cannot submit; same BOLT12 generation cannot auto-retry',
        () async {
      var a = await prepare(db, encoded: 'lno1test', bolt12: true);
      a = await db.updateOutgoingPaymentAttempt(a.id,
          expectedRevision: a.revision,
          state: OutgoingPaymentAttemptState.failed);
      expect(
          (await prepare(other, encoded: 'lno1test', bolt12: true)).id, a.id);
      await db.updateOfferRawStatusIfCurrent(offer.id, 'refundingMaker');
      await db.updateOfferRawStatusIfCurrent(offer.id, 'payingMaker');
      final current = (await db.getOfferById(offer.id))!;
      a = await prepare(db,
          encoded: 'lno1test', bolt12: true, revision: current.stateRevision);
      await db.updateOfferRawStatusIfCurrent(offer.id, 'refundingMaker');
      await expectLater(
          other.updateOutgoingPaymentAttempt(a.id,
              expectedRevision: a.revision,
              state: OutgoingPaymentAttemptState.submitted),
          throwsStateError);
    });

    for (final loseCommit in [false, true]) {
      test(
          'two workers send once; restart after ${loseCommit ? 'lost database commit' : 'lost wallet response'}',
          () async {
        db.failNextSuccess = loseCommit;
        other.failNextSuccess = loseCommit;
        // Restore the refund instruction (createOffer does not insert this field).
        await db.updateOfferRawStatusIfCurrent(offer.id, 'payingMaker',
            makerRefundInvoice: invoice);
        final pay = MockPaymentService();
        final bothReconciling = Completer<void>();
        var lookups = 0;
        when(pay.reconcileOutgoingPayment(invoice: invoice))
            .thenAnswer((_) async {
          if (++lookups == 2) bothReconciling.complete();
          await bothReconciling.future;
          return null;
        });
        when(pay.payInvoice(
                invoice: invoice,
                amountSat: anyNamed('amountSat'),
                feeLimitSat: anyNamed('feeLimitSat')))
            .thenAnswer((_) async => loseCommit
                ? PayInvoiceResult(
                    status: PaymentStatus.SUCCEEDED, paymentPreimage: 'paid')
                : PayInvoiceResult(
                    status: PaymentStatus.UNKNOWN,
                    paymentError: 'response lost'));
        final testClock = Clock.fixed(DateTime.fromMillisecondsSinceEpoch(
                Bolt11PaymentRequest(invoice).timestamp.toInt() * 1000,
                isUtc: true)
            .add(const Duration(minutes: 1)));
        Future<CoordinatorService> worker(DatabaseService database) async {
          final service = CoordinatorService(database,
              paymentServiceForTest: pay,
              coordinatorPubkeyForTest: 'coordinator',
              paymentSystemIdForTest: 'blik',
              clock: testClock);
          await service.init();
          addTearDown(service.shutdown);
          return service;
        }

        final first = await worker(db);
        final second = await worker(other);
        Future<Object> retry(CoordinatorService service) async {
          try {
            return await service.flow.handleRpc(
                kRpcRetryCoordinatorPayment,
                {'offer_id': offer.id, 'expected_state': 'payingMaker'},
                'coordinator');
          } catch (e) {
            return e;
          }
        }

        await Future.wait([retry(first), retry(second)]);
        verify(pay.payInvoice(
                invoice: invoice, amountSat: 1500, feeLimitSat: 15))
            .called(1);
        expect((await db.getOfferById(offer.id))!.statusRaw, 'payingMaker');
        await expectLater(prepare(db, encoded: 'lno1replacement', bolt12: true),
            throwsStateError);
        await first.shutdown();
        await second.shutdown();
        when(pay.reconcileOutgoingPayment(invoice: invoice)).thenAnswer(
            (_) async => PayInvoiceResult(
                status: PaymentStatus.SUCCEEDED,
                paymentPreimage: 'late-success'));
        clearInteractions(pay);
        db.failNextSuccess = false;
        other.failNextSuccess = false;
        final restarted = await worker(db);
        await retry(restarted);
        expect((await db.getOfferById(offer.id))!.statusRaw, 'refundedMaker');
        verifyNever(pay.payInvoice(
            invoice: anyNamed('invoice'),
            amountSat: anyNamed('amountSat'),
            feeLimitSat: anyNamed('feeLimitSat')));
      });
    }
  }, skip: Platform.environment['PAYMENT_SAFETY_DB_TEST'] != '1');
}
