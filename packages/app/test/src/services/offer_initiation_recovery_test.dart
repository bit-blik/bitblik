import 'dart:async';
import 'dart:io';

import 'package:bitblik/src/services/offer_initiation_recovery.dart';
import 'package:bitblik/src/services/offer_initiation_store.dart';
import 'package:bitblik/src/services/funding_payment.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _FailResultStore extends OfferInitiationStore {
  _FailResultStore(super.database);
  @override
  Future<void> saveResult(
    LocalOfferInitiation attempt,
    Map<String, dynamic> result,
  ) async {
    throw StateError('disk full after RPC');
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  late Database db;
  late Directory directory;
  late OfferInitiationStore store;
  late OfferInitiationRecovery recovery;
  late int sends;
  late int reads;
  late Object? sendError;
  late Object? lookupError;
  late Completer<Map<String, dynamic>>? sendGate;
  late Map<String, dynamic> lookupResult;
  late List<String?> operationIds;
  late Completer<void> lookupStarted;
  const params = {
    'fiat_amount': 20.0,
    'fiat_currency': 'PLN',
    'bank': null,
    'category': 'atm',
    'premium_percent': 0.0,
    'blik_code': null,
  };
  const result = {
    'paymentHash': 'hash',
    'holdInvoice': 'test-invoice',
    'amountSats': 1000,
    'makerFees': 10,
  };
  const estimate = FundingEstimate(
    coordinatorPubkey: 'coordinator',
    makerPubkey: 'maker',
    fiatAmount: 20,
    fiatCurrency: 'PLN',
    premiumPercent: 0,
    totalSats: 1010,
    makerFeesSats: 10,
  );

  Future<Map<String, dynamic>> send(String? id) async {
    sends++;
    operationIds.add(id);
    if (id != null) {
      expect(
        (await store.read('maker'))?.operationId,
        id,
        reason: 'operation must be durable before publication',
      );
    }
    if (sendError != null) throw sendError!;
    return sendGate?.future ??
        {
          ...result,
          '_clientFundingEstimate': {'totalSats': 999999},
        };
  }

  OfferInitiationRecovery controller(OfferInitiationStore target) =>
      OfferInitiationRecovery(
        store: target,
        lookup: (coordinator, id) async {
          reads++;
          if (!lookupStarted.isCompleted) lookupStarted.complete();
          expect(coordinator, 'coordinator');
          expect(id, (await target.read('maker'))!.operationId);
          if (lookupError != null) throw lookupError!;
          return lookupResult;
        },
      );
  Future<Map<String, dynamic>> initiate({
    bool supported = true,
    String coordinator = 'coordinator',
    Map<String, dynamic> input = params,
    Map<String, dynamic>? originalEstimate,
  }) => recovery.initiate(
    maker: 'maker',
    coordinator: coordinator,
    params: input,
    estimate: originalEstimate ?? estimate.toJson(),
    supportsRecovery: supported,
    send: send,
  );

  setUp(() async {
    directory = await Directory.systemTemp.createTemp('initiation-recovery-');
    db = await databaseFactoryFfi.openDatabase('${directory.path}/offers.db');
    await db.execute(
      '''CREATE TABLE offers (id TEXT PRIMARY KEY, maker_pubkey TEXT,
      coordinator_pubkey TEXT, hold_invoice_payment_hash TEXT)''',
    );
    store = OfferInitiationStore(() async => db);
    sends = 0;
    reads = 0;
    sendError = null;
    lookupError = null;
    sendGate = null;
    lookupResult = {'status': 'ready', 'result': result};
    operationIds = [];
    lookupStarted = Completer<void>();
    recovery = controller(store);
  });
  tearDown(() async {
    await db.close();
    await directory.delete(recursive: true);
  });

  test(
    'persists before RPC and preserves client estimate over server field',
    () async {
      final response = await initiate();
      expect(response['_clientFundingEstimate'], estimate.toJson());
      final restored = FundingEstimate.fromJson(
        Map<String, dynamic>.from(response['_clientFundingEstimate'] as Map),
      );
      expect(restored.totalSats, 1010);
      expect(operationIds.single, matches(RegExp(r'^[a-f0-9]{32}$')));
      expect((await store.read('maker'))!.result?['paymentHash'], 'hash');
      expect(sends, 1);
      expect(reads, 0);
    },
  );

  test(
    'lost reply and process restart recover read-only with original estimate',
    () async {
      sendError = TimeoutException('reply lost');
      await expectLater(initiate(), throwsA(isA<UncertainOfferInitiation>()));
      final originalId = (await store.read('maker'))!.operationId;
      await db.close();
      db = await databaseFactoryFfi.openDatabase('${directory.path}/offers.db');
      store = OfferInitiationStore(() async => db);
      recovery = controller(store);
      sendError = null;
      final response = await initiate(
        originalEstimate: {...estimate.toJson(), 'totalSats': 5000},
      );
      expect(response['holdInvoice'], 'test-invoice');
      expect(response['_clientFundingEstimate'], estimate.toJson());
      expect((await store.read('maker'))!.operationId, originalId);
      expect(sends, 1);
      expect(reads, 1);
    },
  );

  test(
    'pending, not_found and malformed replies never authorize another write',
    () async {
      sendError = TimeoutException('unknown outcome');
      await expectLater(initiate(), throwsA(isA<UncertainOfferInitiation>()));
      for (final status in ['pending', 'not_found', 'ready', 'unexpected']) {
        lookupResult = {'status': status};
        await expectLater(initiate(), throwsA(isA<UncertainOfferInitiation>()));
        expect(await store.read('maker'), isNotNull);
      }
      expect(sends, 1);
      expect(reads, 4);
    },
  );

  test('coordinator rollback cannot bypass an existing retry guard', () async {
    sendError = TimeoutException('reply lost');
    await expectLater(initiate(), throwsA(isA<UncertainOfferInitiation>()));
    lookupError = StateError('old coordinator: unknown method');
    await expectLater(
      initiate(supported: false),
      throwsA(isA<UncertainOfferInitiation>()),
    );
    expect(sends, 1);
    expect(reads, 1);
    expect(await store.read('maker'), isNotNull);
  });

  test(
    'changed coordinator or parameters cannot replace unresolved attempt',
    () async {
      sendError = TimeoutException('reply lost');
      await expectLater(initiate(), throwsA(isA<UncertainOfferInitiation>()));
      await expectLater(
        initiate(coordinator: 'other'),
        throwsA(isA<UncertainOfferInitiation>()),
      );
      await expectLater(
        initiate(input: {...params, 'fiat_amount': 30.0}),
        throwsA(isA<UncertainOfferInitiation>()),
      );
      expect(sends, 1);
      expect(reads, 0);
    },
  );

  test('concurrent identical clicks coalesce one RPC', () async {
    sendGate = Completer<Map<String, dynamic>>();
    final first = initiate();
    final second = initiate();
    sendGate!.complete(result);
    expect(await first, await second);
    expect(sends, 1);
    expect(reads, 0);
  });

  test('independent controllers share atomic SQLite claim', () async {
    final otherStore = OfferInitiationStore(() async => db);
    final other = controller(otherStore);
    lookupResult = {'status': 'not_found'};
    sendGate = Completer<Map<String, dynamic>>();
    final sent = Completer<void>();
    Future<Map<String, dynamic>> blockedSend(String? id) async {
      if (!sent.isCompleted) sent.complete();
      return send(id);
    }

    Future<Object> start(OfferInitiationRecovery target) => target
        .initiate(
          maker: 'maker',
          coordinator: 'coordinator',
          params: params,
          supportsRecovery: true,
          send: blockedSend,
        )
        .then<Object>((value) => value, onError: (Object e) => e);
    final first = start(recovery);
    final second = start(other);
    await sent.future;
    // Let the losing claim finish its read-only lookup before releasing send.
    await lookupStarted.future;
    sendGate!.complete(result);
    final outcomes = await Future.wait([first, second]);
    expect(sends, 1);
    expect(outcomes.whereType<UncertainOfferInitiation>(), hasLength(1));
    expect(await store.read('maker'), isNotNull);
  });

  test(
    'retained ready result needs no network and keeps original estimate',
    () async {
      final original = await initiate();
      expect(await initiate(originalEstimate: {'totalSats': 99999}), original);
      expect(sends, 1);
      expect(reads, 0);
    },
  );

  test(
    'acknowledgement requires matching persisted offer; next offer gets new ID',
    () async {
      await initiate();
      await expectLater(store.complete('maker', 'hash'), throwsStateError);
      expect(await store.read('maker'), isNotNull);
      await db.insert('offers', {
        'id': 'hash',
        'maker_pubkey': 'maker',
        'coordinator_pubkey': 'coordinator',
        'hold_invoice_payment_hash': 'hash',
      });
      await store.complete('maker', 'wrong-hash');
      expect(await store.read('maker'), isNotNull);
      await store.complete('maker', 'hash');
      expect(await store.read('maker'), isNull);
      await initiate();
      expect(sends, 2);
      expect(operationIds.toSet(), hasLength(2));
    },
  );

  test('another maker cannot read or complete existing attempt', () async {
    await initiate();
    expect(await store.read('other-maker'), isNull);
    await store.complete('other-maker', 'hash');
    expect(await store.read('maker'), isNotNull);
  });

  test(
    'old coordinators keep single-shot legacy request without operation ID',
    () async {
      final response = await initiate(supported: false);
      expect(operationIds, [null]);
      expect(await store.read('maker'), isNull);
      expect(response['_clientFundingEstimate'], estimate.toJson());
      expect(reads, 0);
    },
  );

  test('storage failure prevents publication', () async {
    final broken = OfferInitiationStore(
      () async => throw StateError('storage unavailable'),
    );
    recovery = controller(broken);
    await expectLater(initiate(), throwsStateError);
    expect(sends, 0);
  });

  test(
    'result persistence failure recovers without repeating mutation',
    () async {
      recovery = controller(_FailResultStore(() async => db));
      await expectLater(initiate(), throwsStateError);
      recovery = controller(OfferInitiationStore(() async => db));
      expect((await initiate())['holdInvoice'], 'test-invoice');
      expect(sends, 1);
      expect(reads, 1);
    },
  );

  test('corrupt journal fails closed instead of replacing operation', () async {
    await initiate();
    await db.update('offer_initiations', {'params': 'invalid json'});
    await expectLater(initiate(), throwsFormatException);
    expect(sends, 1);
  });

  test(
    'additive journal initialization preserves existing offers and version',
    () async {
      await db.execute('PRAGMA user_version = 14');
      await db.insert('offers', {
        'id': 'existing',
        'maker_pubkey': 'maker',
        'coordinator_pubkey': 'coordinator',
        'hold_invoice_payment_hash': 'existing-hash',
      });
      await store.read('maker');
      await OfferInitiationStore(() async => db).read('maker');
      expect((await db.query('offers')).single['id'], 'existing');
      expect(
        (await db.rawQuery('PRAGMA user_version')).single['user_version'],
        14,
      );
      expect(sends, 0);
    },
  );
}
