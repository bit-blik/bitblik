import 'dart:async';
import 'dart:convert';

import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/models/pending_offer_intent.dart';
import 'package:bitblik_coordinator/src/models/offer_initiation_receipt.dart';
import 'package:bitblik_coordinator/src/models/create_hold_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/cancel_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/invoice_details.dart';
import 'package:bitblik_coordinator/src/models/invoice_update.dart';
import 'package:bitblik_coordinator/src/models/invoice_status.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

void main() {
  late MockDatabaseService db;
  late MockPaymentService wallet;
  late CoordinatorService service;
  late Map<String, PendingOfferIntent> intents;
  late Map<String, Offer> offers;
  late List<StreamController<InvoiceUpdate>> streams;
  late DateTime now;
  late InvoiceStatus walletState;
  late bool walletHasAmbiguousHoldExpiry;
  late int walletCreates;
  late int insertAttempts;
  late bool failSave;
  late bool failInsert;
  late bool loseInsertAck;
  late Completer<void>? insertGate;
  late Completer<void>? saveGate;
  late Completer<CreateHoldInvoiceResult>? invoiceGate;
  late bool lookupFails;
  late Map<String, OfferInitiationReceipt> receipts;
  late bool loseClaimAck;
  late bool failInvoiceSave;
  late String? lookupInvoice;

  Future<CoordinatorService> createService(
      {bool reconcile = true, String? backendType}) async {
    final result = CoordinatorService(db,
        paymentServiceForTest: backendType == null ? wallet : null,
        paymentBackendConnectorForTest: backendType == null
            ? null
            : () async => (backend: wallet, type: backendType),
        paymentSystemIdForTest: 'mbway',
        clock: Clock(() => now),
        httpClient: MockClient((request) async => http.Response(
            jsonEncode(request.url.host == 'api.coingecko.com'
                ? {
                    'bitcoin': {'eur': 50000.0}
                  }
                : request.url.host == 'api.yadio.io'
                    ? {'BTC': 50000.0}
                    : {
                        'EUR': {'last': 50000.0}
                      }),
            200)));
    await result.init();
    if (reconcile) await result.reconcilePendingOffers();
    return result;
  }

  Future<Map<String, dynamic>> initiate() => service.initiateOfferFiat(
      fiatAmount: 20, fiatCurrency: 'EUR', makerId: 'maker');
  Future<Map<String, dynamic>> initiateOnce(
          {String id = 'operation-1',
          String maker = 'maker',
          double amount = 20}) =>
      service.initiateOfferFiat(
          fiatAmount: amount,
          fiatCurrency: 'EUR',
          makerId: maker,
          operationId: id);
  Future<void> flush() => Future<void>.delayed(Duration.zero);

  setUp(() async {
    db = MockDatabaseService();
    wallet = MockPaymentService();
    intents = {};
    offers = {};
    streams = [];
    now = DateTime.utc(2026, 9, 18);
    walletState = InvoiceStatus.OPEN;
    walletHasAmbiguousHoldExpiry = false;
    walletCreates = 0;
    insertAttempts = 0;
    failSave = false;
    failInsert = false;
    loseInsertAck = false;
    lookupFails = false;
    receipts = {};
    loseClaimAck = false;
    failInvoiceSave = false;
    lookupInvoice = null;
    insertGate = null;
    saveGate = null;
    invoiceGate = null;
    when(db.getOfferInitiation(
            paymentSystem: anyNamed('paymentSystem'),
            makerId: anyNamed('makerId'),
            operationId: anyNamed('operationId')))
        .thenAnswer((call) async => receipts[
            '${call.namedArguments[#paymentSystem]}|${call.namedArguments[#makerId]}|${call.namedArguments[#operationId]}']);
    when(db.claimOfferInitiation(
            operationId: anyNamed('operationId'),
            fingerprint: anyNamed('fingerprint'),
            intent: anyNamed('intent'),
            quote: anyNamed('quote')))
        .thenAnswer((call) async {
      if (failSave) throw StateError('disk full');
      final intent = call.namedArguments[#intent] as PendingOfferIntent;
      final key =
          '${intent.paymentSystem}|${intent.data['makerId']}|${call.namedArguments[#operationId]}';
      if (receipts.containsKey(key)) return false;
      receipts[key] = OfferInitiationReceipt(
          fingerprint: call.namedArguments[#fingerprint] as String,
          paymentHash: intent.paymentHash,
          quote: call.namedArguments[#quote] as Map<String, dynamic>);
      intents[intent.paymentHash] = intent;
      if (loseClaimAck) throw StateError('commit acknowledgement lost');
      return true;
    });
    when(db.saveOfferInitiationInvoice(any, any)).thenAnswer((call) async {
      if (failInvoiceSave) throw StateError('database unavailable');
      for (final entry in receipts.entries.toList()) {
        final receipt = entry.value;
        if (receipt.paymentHash != call.positionalArguments.first) continue;
        receipts[entry.key] = OfferInitiationReceipt(
            fingerprint: receipt.fingerprint,
            paymentHash: receipt.paymentHash,
            quote: receipt.quote,
            holdInvoice:
                receipt.holdInvoice ?? call.positionalArguments[1] as String);
      }
    });
    when(db.savePendingOfferIntent(any)).thenAnswer((call) async {
      await saveGate?.future;
      if (failSave) throw StateError('disk full');
      final intent = call.positionalArguments.single as PendingOfferIntent;
      intents[intent.paymentHash] = intent;
    });
    when(db.getPendingOfferIntents(any,
            afterHash: anyNamed('afterHash'), limit: anyNamed('limit')))
        .thenAnswer((call) async => intents.values.toList());
    when(db.deletePendingOfferIntent(any)).thenAnswer((call) async {
      intents.remove(call.positionalArguments.single);
    });
    when(db.getOfferByPaymentHash(any))
        .thenAnswer((call) async => offers[call.positionalArguments.single]);
    when(db.createOffer(any)).thenAnswer((call) async {
      insertAttempts++;
      await insertGate?.future;
      if (failInsert) throw StateError('temporary database outage');
      final offer = call.positionalArguments.single as Offer;
      offers[offer.holdInvoicePaymentHash!] = offer;
      if (loseInsertAck) throw StateError('commit acknowledgement lost');
      return offer;
    });
    when(wallet.createHoldInvoice(
            amountSats: anyNamed('amountSats'),
            memo: anyNamed('memo'),
            paymentHashHex: anyNamed('paymentHashHex')))
        .thenAnswer((call) {
      walletCreates++;
      final hash = call.namedArguments[#paymentHashHex] as String;
      expect(intents.containsKey(hash), isTrue,
          reason: 'intent must precede wallet call');
      return invoiceGate?.future ??
          Future.value(
              CreateHoldInvoiceResult(invoice: 'lnbc_test', paymentHash: hash));
    });
    when(wallet.lookupInvoice(paymentHashHex: anyNamed('paymentHashHex')))
        .thenAnswer((call) async => InvoiceDetails(
            paymentHash: call.namedArguments[#paymentHashHex] as String,
            type: 'incoming',
            invoice: lookupInvoice,
            status: walletState,
            hasAmbiguousHoldExpiry: walletHasAmbiguousHoldExpiry,
            error: lookupFails ? 'wallet unavailable' : null));
    when(wallet.subscribeToInvoiceUpdates(
            paymentHashHex: anyNamed('paymentHashHex')))
        .thenAnswer((_) {
      final stream = StreamController<InvoiceUpdate>();
      streams.add(stream);
      return stream.stream;
    });
    when(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
        .thenAnswer((_) async => const CancelInvoiceResult.cancelled());
    service = await createService();
  });
  tearDown(() async {
    await service.shutdown();
    for (final stream in streams) {
      await stream.close();
    }
  });

  test('persistence failure stops before wallet creation', () async {
    failSave = true;
    await expectLater(initiate(), throwsStateError);
    expect(walletCreates, 0);
    expect(intents, isEmpty);
  });

  test('receipt replays original result after intent cleanup and restart',
      () async {
    final original = await initiateOnce();
    walletState = InvoiceStatus.ACCEPTED;
    await service.reconcilePendingOffers();
    expect(intents, isEmpty);
    await service.shutdown();
    service = await createService();
    expect(await initiateOnce(), original);
    expect(
        await service.getOfferInitiation(
            makerId: 'maker', operationId: 'operation-1'),
        {'status': 'ready', 'result': original});
    expect(walletCreates, 1);
  });

  test('concurrent same-ID initiation claims only one wallet call', () async {
    invoiceGate = Completer<CreateHoldInvoiceResult>();
    final first = initiateOnce();
    await flush();
    await expectLater(
        initiateOnce(),
        throwsA(isA<OfferInitiationException>()
            .having((e) => e.code, 'code', 'INITIATION_PENDING')));
    expect(walletCreates, 1);
    invoiceGate!.complete(CreateHoldInvoiceResult(
        invoice: 'original-invoice', paymentHash: intents.keys.single));
    final original = await first;
    expect(await initiateOnce(), original);
  });

  test('same ID with different offer parameters rejects without wallet call',
      () async {
    await initiateOnce();
    await expectLater(
        initiateOnce(amount: 30),
        throwsA(isA<OfferInitiationException>()
            .having((e) => e.code, 'code', 'INITIATION_CONFLICT')));
    expect(walletCreates, 1);
  });

  test('racing first submissions converge after losing the atomic claim',
      () async {
    invoiceGate = Completer<CreateHoldInvoiceResult>();
    Future<Object> capture() => initiateOnce()
        .then<Object>((value) => value, onError: (Object error) => error);
    final first = capture();
    final second = capture();
    await flush();
    expect(walletCreates, 1);
    invoiceGate!.complete(CreateHoldInvoiceResult(
        invoice: 'winner-invoice', paymentHash: intents.keys.single));
    final outcomes = await Future.wait([first, second]);
    expect(outcomes.whereType<Map<String, dynamic>>(), hasLength(1));
    expect(outcomes.whereType<OfferInitiationException>().single.code,
        'INITIATION_PENDING');
    expect(receipts, hasLength(1));
    expect(intents, hasLength(1));
  });

  test('failed receipt claim cannot call wallet', () async {
    failSave = true;
    await expectLater(initiateOnce(), throwsStateError);
    expect(walletCreates, 0);
    expect(receipts, isEmpty);
    expect(intents, isEmpty);
  });

  test('receipts and read-only lookup are scoped to authenticated maker',
      () async {
    final original = await initiateOnce();
    expect(
        await service.getOfferInitiation(
            makerId: 'stranger', operationId: 'operation-1'),
        {'status': 'not_found'});
    final other = await initiateOnce(maker: 'stranger');
    expect(other['paymentHash'], isNot(original['paymentHash']));
    expect(walletCreates, 2);
    verifyNever(
        wallet.lookupInvoice(paymentHashHex: anyNamed('paymentHashHex')));
  });

  test('lost claim acknowledgement blocks wallet call and duplicate creation',
      () async {
    loseClaimAck = true;
    await expectLater(initiateOnce(), throwsStateError);
    expect(intents, hasLength(1));
    expect(walletCreates, 0);
    await expectLater(
        initiateOnce(),
        throwsA(isA<OfferInitiationException>()
            .having((e) => e.code, 'code', 'INITIATION_PENDING')));
    expect(
        await service.getOfferInitiation(
            makerId: 'maker', operationId: 'operation-1'),
        {'status': 'pending', 'paymentHash': intents.keys.single});
    expect(walletCreates, 0);
  });

  test('invoice result write failure recovers by wallet lookup, not creation',
      () async {
    failInvoiceSave = true;
    await expectLater(initiateOnce(), throwsStateError);
    expect(walletCreates, 1);
    failInvoiceSave = false;
    lookupInvoice = 'recovered-invoice';
    await service.shutdown();
    service = await createService();
    expect((await initiateOnce())['holdInvoice'], 'recovered-invoice');
    expect(walletCreates, 1);
    clearInteractions(db);
    await service.reconcilePendingOffers();
    verifyNever(db.saveOfferInitiationInvoice(any, any));
  });

  test('unknown wallet creation outcome retains receipt and never reissues',
      () async {
    invoiceGate = Completer<CreateHoldInvoiceResult>();
    final creation = initiateOnce();
    await flush();
    invoiceGate!.completeError(StateError('wallet transport failed'));
    await expectLater(creation, throwsStateError);
    await expectLater(initiateOnce(), throwsA(isA<OfferInitiationException>()));
    lookupInvoice = 'found-by-hash';
    await service.reconcilePendingOffers();
    expect((await initiateOnce())['holdInvoice'], 'found-by-hash');
    expect(walletCreates, 1);
  });

  test(
      'late wallet success after RPC deadline still persists retrievable result',
      () async {
    fakeAsync((async) {
      invoiceGate = Completer<CreateHoldInvoiceResult>();
      Object? failure;
      initiateOnce().catchError((Object error) {
        failure = error;
        return <String, dynamic>{};
      });
      async.flushMicrotasks();
      async.elapse(const Duration(seconds: 20));
      expect(failure, isA<TimeoutException>());
      expect(walletCreates, 1);
      invoiceGate!.complete(CreateHoldInvoiceResult(
          invoice: 'late-invoice', paymentHash: intents.keys.single));
      async.flushMicrotasks();
      expect(receipts.values.single.result?['holdInvoice'], 'late-invoice');
    });
    expect((await initiateOnce())['holdInvoice'], 'late-invoice');
    expect(walletCreates, 1);
  });

  test('invalid operation IDs fail before persistence or wallet access',
      () async {
    for (final id in ['', 'contains space', 'x' * 129]) {
      await expectLater(
          initiateOnce(id: id),
          throwsA(isA<OfferInitiationException>()
              .having((e) => e.code, 'code', 'INVALID_OPERATION_ID')));
    }
    expect(receipts, isEmpty);
    expect(intents, isEmpty);
    expect(walletCreates, 0);
  });

  test('stream error preserves intent; lookup recovers funded offer', () async {
    final result = await initiate();
    final hash = result['paymentHash'] as String;
    streams.single.addError(StateError('connection lost'));
    await flush();
    expect(intents, hasLength(1));
    walletState = InvoiceStatus.ACCEPTED;
    await service.reconcilePendingOffers();
    expect(offers[hash]?.makerPubkey, 'maker');
    expect(intents, isEmpty);
    expect(walletCreates, 1);
  });

  test('ended stream reopens without losing data or recreating invoice',
      () async {
    await initiate();
    await streams.single.close();
    await service.reconcilePendingOffers();
    expect(streams, hasLength(2));
    expect(intents, hasLength(1));
    expect(walletCreates, 1);
  });

  test(
      'database failure retains intent; duplicate ACCEPTED serializes insertion',
      () async {
    final hash = (await initiate())['paymentHash'] as String;
    failInsert = true;
    streams.single
        .add(InvoiceUpdate(paymentHash: hash, status: InvoiceStatus.ACCEPTED));
    await flush();
    expect(intents, hasLength(1));
    expect(offers, isEmpty);
    failInsert = false;
    insertGate = Completer();
    for (var i = 0; i < 3; i++) {
      streams.single.add(
          InvoiceUpdate(paymentHash: hash, status: InvoiceStatus.ACCEPTED));
    }
    await flush();
    expect(insertAttempts, 2);
    insertGate!.complete();
    await flush();
    expect(offers, hasLength(1));
    expect(intents, isEmpty);
    expect(insertAttempts, 2);
    expect(walletCreates, 1);
  });

  test('lost INSERT acknowledgement never inserts another offer', () async {
    final hash = (await initiate())['paymentHash'] as String;
    loseInsertAck = true;
    streams.single
        .add(InvoiceUpdate(paymentHash: hash, status: InvoiceStatus.ACCEPTED));
    await flush();
    expect(offers, hasLength(1));
    expect(intents, hasLength(1));
    now = now.add(const Duration(hours: 27));
    walletState = InvoiceStatus.UNKNOWN;
    walletHasAmbiguousHoldExpiry = true;
    clearInteractions(wallet);
    await service.reconcilePendingOffers();
    expect(intents, isEmpty);
    expect(offers, hasLength(1));
    expect(insertAttempts, 1);
    expect(walletCreates, 1);
    verifyNever(
        wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')));
    verifyNever(
        wallet.lookupInvoice(paymentHashHex: anyNamed('paymentHashHex')));
  });

  test('restart recovers funded intent with original preimage and offer ID',
      () async {
    final hash = (await initiate())['paymentHash'] as String;
    final original = intents[hash]!;
    await service.shutdown();
    walletState = InvoiceStatus.ACCEPTED;
    service = await createService();
    expect(offers[hash]?.holdInvoicePreimage, original.data['preimageHex']);
    expect(offers[hash]?.id, original.data['offerId']);
    expect(intents, isEmpty);
    expect(walletCreates, 1);
  });

  test('startup does not recover before Nostr identity is installed', () async {
    await initiate();
    await service.shutdown();
    walletState = InvoiceStatus.ACCEPTED;
    clearInteractions(db);
    service = await createService(reconcile: false);
    await flush();
    verifyNever(db.getPendingOfferIntents(any,
        afterHash: anyNamed('afterHash'), limit: anyNamed('limit')));
    expect(offers, isEmpty);
    expect(intents, hasLength(1));
    expect(walletCreates, 1);
  });

  test('unknown or settled wallet state retains recovery material', () async {
    await initiate();
    now = now.add(const Duration(hours: 27));
    for (final state in [InvoiceStatus.UNKNOWN, InvoiceStatus.SETTLED]) {
      walletState = state;
      await service.reconcilePendingOffers();
      expect(intents, hasLength(1));
      expect(offers, isEmpty);
    }
    lookupFails = true;
    walletState = InvoiceStatus.CANCELED;
    await service.reconcilePendingOffers();
    expect(intents, hasLength(1));
    expect(walletCreates, 1);
    verifyNever(
        wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')));
  });

  test('authoritative cancellation clears intent, not transport error',
      () async {
    await initiate();
    walletState = InvoiceStatus.CANCELED;
    await service.reconcilePendingOffers();
    expect(intents, isEmpty);
    expect(offers, isEmpty);
  });

  test('expired OPEN is canceled; cancellation error keeps intent', () async {
    await initiate();
    now = now.add(const Duration(hours: 27));
    when(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
        .thenThrow(TimeoutException('unknown cancellation outcome'));
    await service.reconcilePendingOffers();
    expect(intents, hasLength(1));
    when(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
        .thenAnswer((_) async => const CancelInvoiceResult.cancelled());
    await service.reconcilePendingOffers();
    expect(intents, isEmpty);
    expect(offers, isEmpty);
  });

  test('NWC pending intent expires two hours after creation', () async {
    await service.shutdown();
    service = await createService(backendType: 'nwc');
    await initiate();
    expect(intents.values.single.expiresAt, now.add(const Duration(hours: 2)));

    now = now.add(const Duration(hours: 2, seconds: 1));
    await service.reconcilePendingOffers();
    expect(intents, isEmpty);
    verify(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
        .called(1);
  });

  test('ambiguous expired hold is canceled only after pending timeout', () async {
    await service.shutdown();
    service = await createService(backendType: 'nwc');
    await initiate();
    walletState = InvoiceStatus.UNKNOWN;
    walletHasAmbiguousHoldExpiry = true;

    now = now.add(const Duration(hours: 1));
    await service.reconcilePendingOffers();
    expect(intents, hasLength(1));
    expect(offers, isEmpty);
    verifyNever(
        wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')));

    now = now.add(const Duration(hours: 1));
    lookupFails = true;
    await service.reconcilePendingOffers();
    expect(intents, hasLength(1));
    verifyNever(
        wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')));

    lookupFails = false;
    await service.reconcilePendingOffers();
    expect(intents, isEmpty);
    expect(offers, isEmpty);
    verify(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
        .called(1);
    expect(walletCreates, 1);
  });

  for (final failure in [
    StateError('wallet unavailable'),
    TimeoutException('unknown cancellation outcome'),
  ]) {
    test('ambiguous hold cancellation retries after restart: $failure', () async {
      await service.shutdown();
      service = await createService(backendType: 'nwc');
      await initiate();
      now = now.add(const Duration(hours: 2));
      walletState = InvoiceStatus.UNKNOWN;
      walletHasAmbiguousHoldExpiry = true;
      when(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
          .thenThrow(failure);

      await service.reconcilePendingOffers();
      expect(intents, hasLength(1));
      expect(offers, isEmpty);
      verify(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
          .called(1);

      await service.shutdown();
      when(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
          .thenAnswer((_) async => failure is TimeoutException
              ? const CancelInvoiceResult.alreadyMissing()
              : const CancelInvoiceResult.cancelled());
      service = await createService(backendType: 'nwc');
      expect(intents, isEmpty);
      expect(offers, isEmpty);
      verify(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
          .called(1);
      expect(walletCreates, 1);
    });
  }

  test('NWC accepted hold remains recoverable after pending timeout', () async {
    await service.shutdown();
    service = await createService(backendType: 'nwc');
    await initiate();

    now = now.add(const Duration(hours: 2, seconds: 1));
    walletState = InvoiceStatus.ACCEPTED;
    await service.reconcilePendingOffers();
    expect(offers, hasLength(1));
    verifyNever(
        wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')));
  });

  test('expired but ACCEPTED is recovered, never canceled as unused', () async {
    await initiate();
    now = now.add(const Duration(hours: 27));
    walletState = InvoiceStatus.ACCEPTED;
    await service.reconcilePendingOffers();
    expect(offers, hasLength(1));
    verifyNever(
        wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')));
  });

  test('deadline during persistence cannot start a late wallet request',
      () async {
    fakeAsync((async) {
      saveGate = Completer();
      Object? error;
      initiate().catchError((Object caught) {
        error = caught;
        return <String, dynamic>{};
      });
      async.flushMicrotasks();
      async.elapse(const Duration(seconds: 20));
      async.flushMicrotasks();
      expect(error, isA<TimeoutException>());
      saveGate!.complete();
      async.flushMicrotasks();
      expect(walletCreates, 0);
      expect(intents, isEmpty);
    });
  });

  test('recovery coalesces scans and caps wallet lookups at two', () async {
    await initiate();
    await initiate();
    await initiate();
    final gate = Completer<void>();
    var active = 0;
    var peak = 0;
    when(wallet.lookupInvoice(paymentHashHex: anyNamed('paymentHashHex')))
        .thenAnswer((call) async {
      active++;
      if (active > peak) peak = active;
      await gate.future;
      active--;
      return InvoiceDetails(
          paymentHash: call.namedArguments[#paymentHashHex] as String,
          status: InvoiceStatus.UNKNOWN);
    });
    final first = service.reconcilePendingOffers();
    await flush();
    expect(active, 2);
    expect(identical(first, service.reconcilePendingOffers()), isTrue);
    gate.complete();
    await first;
    expect(peak, 2);
    expect(walletCreates, 3);
  });

  test('wrong hash or outgoing lookup cannot create a funded offer', () async {
    final hash = (await initiate())['paymentHash'] as String;
    for (final details in [
      InvoiceDetails(paymentHash: 'foreign', status: InvoiceStatus.ACCEPTED),
      InvoiceDetails(
          paymentHash: hash, type: 'outgoing', status: InvoiceStatus.ACCEPTED),
    ]) {
      when(wallet.lookupInvoice(paymentHashHex: anyNamed('paymentHashHex')))
          .thenAnswer((_) async => details);
      await service.reconcilePendingOffers();
      expect(offers, isEmpty);
      expect(intents, hasLength(1));
    }
  });

  test('late ACCEPTED after uncertain cancellation requires fresh lookup',
      () async {
    final hash = (await initiate())['paymentHash'] as String;
    now = now.add(const Duration(hours: 27));
    final cancel = Completer<CancelInvoiceResult>();
    when(wallet.cancelInvoice(paymentHashHex: anyNamed('paymentHashHex')))
        .thenAnswer((_) => cancel.future);
    final pass = service.reconcilePendingOffers();
    await flush();
    streams.single
        .add(InvoiceUpdate(paymentHash: hash, status: InvoiceStatus.ACCEPTED));
    walletState = InvoiceStatus.CANCELED;
    cancel.completeError(TimeoutException('lost cancellation acknowledgement'));
    await pass;
    await flush();
    expect(offers, isEmpty);
    expect(intents, isEmpty);
  });

  test('unexpected returned hash is never handed to the maker', () async {
    invoiceGate = Completer();
    final result = expectLater(initiate(), throwsStateError);
    await flush();
    invoiceGate!.complete(CreateHoldInvoiceResult(
        invoice: 'unmanageable-invoice', paymentHash: 'foreign'));
    await result;
    expect(intents, hasLength(1));
    expect(streams, isEmpty);
    expect(offers, isEmpty);
  });

  test('wallet timeout preserves intent and recovery never reissues creation',
      () async {
    fakeAsync((async) {
      invoiceGate = Completer();
      Object? error;
      initiate().catchError((Object caught) {
        error = caught;
        return <String, dynamic>{};
      });
      async.flushMicrotasks();
      expect(walletCreates, 1);
      async.elapse(const Duration(seconds: 20));
      async.flushMicrotasks();
      expect(error, isA<TimeoutException>());
      expect(intents, hasLength(1));
      invoiceGate!.completeError(TimeoutException('late wallet failure'));
      async.flushMicrotasks();
    });
    walletState = InvoiceStatus.ACCEPTED;
    await service.reconcilePendingOffers();
    expect(offers, hasLength(1));
    expect(walletCreates, 1);
  });
}
