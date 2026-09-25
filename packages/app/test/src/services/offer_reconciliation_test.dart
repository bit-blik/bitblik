import 'dart:async';
import 'dart:io';

import 'package:bitblik/src/flow/taker_charge_report.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/services/api_service_nostr.dart';
import 'package:bitblik/src/services/key_service.dart';
import 'package:bitblik/src/services/offer_db_service.dart';
import 'package:bitblik/src/services/offer_reconciliation.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

Offer trade({
  String id = 'trade',
  OfferStatus status = OfferStatus.expiredSentBlik,
  String? taker = 'taker',
  String? paymentHash,
}) => Offer(
  id: id,
  amountSats: 1000,
  makerFees: 10,
  fiatAmount: 10,
  fiatCurrency: 'PLN',
  status: status,
  createdAt: DateTime.utc(2026, 9, 14),
  makerPubkey: 'maker',
  coordinatorPubkey: 'coordinator',
  takerPubkey: taker,
  holdInvoicePaymentHash: paymentHash,
);

class TestKeys extends Fake implements KeyService {
  @override
  String get publicKeyHex => 'taker';
}

class TestApi extends Fake implements ApiServiceNostr {
  final connected = StreamController<bool>.broadcast();
  final listening = Completer<void>();
  final snapshots = <String, Offer?>{};
  Object? error;
  int reads = 0;
  final List<CoordinatorRecord> coordinators = [];
  Future<Offer?> Function(String)? recover;
  final recoveryCalls = <String>[];
  final completedInitiations = <String>[];

  @override
  List<CoordinatorRecord> get allConfiguredCoordinators => coordinators;

  @override
  Future<Offer?> getMyActiveOffer(String pubkey) async {
    recoveryCalls.add(pubkey);
    return await recover?.call(pubkey);
  }

  @override
  Stream<bool> get relayConnectionState {
    if (!listening.isCompleted) listening.complete();
    return connected.stream;
  }

  @override
  Future<void> completeOfferInitiation(String paymentHash) async {
    completedInitiations.add(paymentHash);
  }

  @override
  Future<Map<String, dynamic>?> getOfferDetails(
    Offer offer,
    String coordinatorPubkey, {
    bool strict = false,
  }) async {
    reads++;
    if (error != null) throw error!;
    return snapshots[offer.id]?.toJson();
  }
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  final db = OfferDbService();
  late Directory directory;
  late ProviderContainer container;
  late TestApi api;
  late ActiveOfferNotifier notifier;

  ProviderContainer createContainer({bool rejectLifecycleRead = false}) =>
      ProviderContainer(
        overrides: [
          keyServiceProvider.overrideWithValue(TestKeys()),
          publicKeyProvider.overrideWith((ref) async => 'taker'),
          apiServiceProvider.overrideWithValue(api),
          initializedApiServiceProvider.overrideWith((ref) async => api),
          selectedPaymentSystemProvider.overrideWith(
            (ref) => SelectedPaymentSystemNotifier(kBlik),
          ),
          activeOfferNotificationsProvider.overrideWith(
            (ref) => ActiveOfferNotificationsNotifier(load: false),
          ),
          appLifecycleProvider.overrideWith((ref) {
            if (rejectLifecycleRead) {
              throw StateError('active offer synchronously entered lifecycle');
            }
            return AppLifecycleNotifier(ref);
          }),
        ],
      );

  setUpAll(() async {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
    directory = await Directory.systemTemp.createTemp('offer-reconciliation-');
    await databaseFactory.setDatabasesPath(directory.path);
  });
  tearDownAll(() async {
    await (await db.database).close();
    await directory.delete(recursive: true);
  });
  setUp(() async {
    await db.clearAll();
    await db.upsertOffer(trade());
    api = TestApi();
    container = createContainer();
    notifier = container.read(activeOfferProvider.notifier);
    await api.listening.future;
  });
  tearDown(() async {
    container.dispose();
    await api.connected.close();
  });

  test(
    'empty storage installs listener before bounded network recovery',
    () async {
      container.dispose();
      await api.connected.close();
      await db.clearAll();
      api = TestApi();
      const info = CoordinatorInfo(
        name: 'test',
        reservationSeconds: 60,
        makerFee: 1,
        takerFee: 1,
        minAmountSats: 1,
        maxAmountSats: 100000,
        currencies: ['PLN'],
        paymentSystem: 'blik',
        nostrNpub: null,
      );
      api.coordinators.addAll(
        List.generate(
          4,
          (i) => CoordinatorRecord(
            pubkeyHex: 'coordinator-$i',
            info: info,
            enabled: true,
          ),
        ),
      );
      final gate = Completer<Offer?>();
      api.recover = (_) => gate.future;
      container = createContainer();
      notifier = container.read(activeOfferProvider.notifier);
      await api.listening.future.timeout(const Duration(seconds: 1));
      expect(api.recoveryCalls, isEmpty);
      api.connected.add(true);
      await Future<void>.delayed(const Duration(milliseconds: 30));
      expect(api.recoveryCalls.length, 2);
      // A trade opened while recovery is in flight must not be replaced.
      final current = trade(id: 'new-trade');
      await notifier.setActiveOffer(current);
      gate.complete(trade(id: 'recovered'));
      await Future<void>.delayed(const Duration(milliseconds: 50));
      expect(container.read(activeOfferProvider)?.id, 'new-trade');
      expect(api.recoveryCalls.length, 2);
    },
  );

  test(
    'identical snapshots do not emit active state, changed details do',
    () async {
      api.snapshots['trade'] = trade();
      var emissions = 0;
      final subscription = container.listen(
        activeOfferProvider,
        (_, _) => emissions++,
      );
      for (var i = 0; i < 3; i++) {
        await notifier.refreshOfferDetails(trade());
      }
      expect(emissions, 0);
      api.snapshots['trade'] = trade().copyWith(
        disputeAt: DateTime.utc(2026, 9, 25),
      );
      await notifier.refreshOfferDetails(trade());
      expect(emissions, 1);
      subscription.close();
    },
  );

  test(
    'relay flaps do not repeat empty recovery, resume explicitly retries',
    () async {
      await db.clearAll();
      await notifier.setActiveOffer(null);
      api.coordinators.add(
        CoordinatorRecord(pubkeyHex: 'coordinator', enabled: true),
      );
      api.connected.add(true);
      await Future<void>.delayed(const Duration(milliseconds: 40));
      expect(api.recoveryCalls, ['coordinator']);
      for (var i = 0; i < 10; i++) {
        api.connected.add(true);
      }
      await Future<void>.delayed(const Duration(milliseconds: 40));
      expect(api.recoveryCalls, ['coordinator']);
      await notifier.reconcileAfterResume();
      expect(api.recoveryCalls, ['coordinator', 'coordinator']);
    },
  );

  test('no-trade recovery stays idle in background', () async {
    await db.clearAll();
    await notifier.setActiveOffer(null);
    api.coordinators.add(
      CoordinatorRecord(pubkeyHex: 'coordinator', enabled: true),
    );
    container.read(appForegroundProvider.notifier).state = false;
    api.connected.add(true);
    await Future<void>.delayed(const Duration(milliseconds: 40));
    expect(api.recoveryCalls, isEmpty);
    container.read(appForegroundProvider.notifier).state = true;
    await notifier.reconcileAfterResume();
    expect(api.recoveryCalls, ['coordinator']);
  });

  test('setting active offer does not synchronously enter lifecycle', () async {
    container.dispose();
    await api.connected.close();
    api = TestApi();
    container = createContainer(rejectLifecycleRead: true);
    notifier = container.read(activeOfferProvider.notifier);
    await api.listening.future;

    await notifier.setActiveOffer(trade(id: 'cycle-regression'));

    expect(container.read(activeOfferProvider)?.id, 'cycle-regression');
  });

  test('cancelling created offer acknowledges its initiation', () async {
    final created = trade(
      id: 'created-offer',
      status: OfferStatus.created,
      paymentHash: 'payment-hash',
    );
    await notifier.setActiveOffer(created);

    await notifier.cancelActiveOffer();

    expect(api.completedInitiations, ['payment-hash']);
    expect(container.read(activeOfferProvider), isNull);
    expect(
      (await db.getOfferById('created-offer'))?.status,
      OfferStatus.cancelled,
    );
  });

  test('lost reply after accepted report reconciles and confirms', () async {
    final result = await reportTakerCharged(
      send: () async {
        api.snapshots['trade'] = trade(status: OfferStatus.takerCharged);
        throw TimeoutException('reply lost');
      },
      refresh: () => notifier.refreshOfferDetails(trade()),
    );
    expect(result, ChargeReportResult.confirmed);
    expect(
      container.read(activeOfferProvider)?.status,
      OfferStatus.takerCharged,
    );
    expect((await db.getOfferById('trade'))?.status, OfferStatus.takerCharged);
  });

  test(
    'undelivered report stays pending and can retry after status check',
    () async {
      api.snapshots['trade'] = trade();
      var sends = 0;
      Future<void> send() async {
        sends++;
        if (sends == 1) throw TimeoutException('broadcast timed out');
        api.snapshots['trade'] = trade(status: OfferStatus.takerCharged);
      }

      Future<Offer?> refresh() => notifier.refreshOfferDetails(trade());
      expect(
        await reportTakerCharged(send: send, refresh: refresh),
        ChargeReportResult.pending,
      );
      expect(
        (await db.getOfferById('trade'))?.status,
        OfferStatus.expiredSentBlik,
      );
      expect(
        await reportTakerCharged(
          send: send,
          refresh: refresh,
          checkBeforeSending: true,
        ),
        ChargeReportResult.confirmed,
      );
      expect(sends, 2);
      expect(
        container.read(activeOfferProvider)?.status,
        OfferStatus.takerCharged,
      );
    },
  );

  test(
    'unavailable confirmation preserves trade and does not blindly retry',
    () async {
      var sends = 0;
      api.error = TimeoutException('status unavailable');
      Future<void> send() async {
        sends++;
        throw TimeoutException('unknown delivery');
      }

      Future<Offer?> refresh() => notifier.refreshOfferDetails(trade());
      expect(
        await reportTakerCharged(send: send, refresh: refresh),
        ChargeReportResult.pending,
      );
      expect(
        await reportTakerCharged(
          send: send,
          refresh: refresh,
          checkBeforeSending: true,
        ),
        ChargeReportResult.pending,
      );
      expect(sends, 1);
      expect(await db.getOfferById('trade'), isNotNull);
    },
  );

  test(
    'pending recovery observes accepted report without sending again',
    () async {
      api.snapshots['trade'] = trade(status: OfferStatus.takerCharged);
      expect(
        await reportTakerCharged(
          send: () async => fail('report already accepted'),
          refresh: () => notifier.refreshOfferDetails(trade()),
          checkBeforeSending: true,
        ),
        ChargeReportResult.confirmed,
      );
    },
  );

  test('successful RPC remains confirmed if status lookup fails', () async {
    api.error = TimeoutException('status unavailable');
    expect(
      await reportTakerCharged(
        send: () async {},
        refresh: () => notifier.refreshOfferDetails(trade()),
      ),
      ChargeReportResult.confirmed,
    );
  });

  test('explicit report rejection propagates', () async {
    expect(
      reportTakerCharged(
        send: () async => throw StateError('rejected'),
        refresh: () async => null,
      ),
      throwsStateError,
    );
  });

  test(
    'active reconciliation retains claim on null and relisted snapshots',
    () async {
      await notifier.reconcileActiveOfferNow();
      expect(
        container.read(activeOfferProvider)?.status,
        OfferStatus.expiredSentBlik,
      );
      api.snapshots['trade'] = trade(status: OfferStatus.funded, taker: null);
      await notifier.reconcileActiveOfferNow();
      expect(
        container.read(activeOfferProvider)?.status,
        OfferStatus.expiredSentBlik,
      );
      expect(
        (await db.getOfferById('trade'))?.status,
        OfferStatus.expiredSentBlik,
      );
    },
  );

  test('reconnect preserves active and inactive claims', () async {
    await db.upsertOffer(
      trade(id: 'history', status: OfferStatus.takerCharged),
    );
    api.snapshots['trade'] = trade(status: OfferStatus.funded, taker: null);
    api.snapshots['history'] = trade(
      id: 'history',
      status: OfferStatus.funded,
      taker: null,
    );
    api.connected.add(true);
    for (var attempts = 0; attempts < 100 && api.reads < 2; attempts++) {
      await Future<void>.delayed(const Duration(milliseconds: 10));
    }
    expect(api.reads, 2);
    // Drain the database write completing the reconnect pass.
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(
      (await db.getOfferById('trade'))?.status,
      OfferStatus.expiredSentBlik,
    );
    expect(
      (await db.getOfferById('history'))?.status,
      OfferStatus.takerCharged,
    );
  });

  for (final response in ['null', 'timeout', 'relisted']) {
    test(
      'funded status push preserves claim with $response response',
      () async {
        if (response == 'timeout') api.error = TimeoutException('no reply');
        if (response == 'relisted') {
          api.snapshots['trade'] = trade(
            status: OfferStatus.funded,
            taker: null,
          );
        }
        await notifier.applyStatusUpdate(
          OfferStatusUpdate(
            offerId: 'trade',
            paymentHash: '',
            status: 'funded',
            coordinatorPubkey: 'coordinator',
            timestamp: DateTime.now(),
          ),
        );
        expect(
          (await db.getOfferById('trade'))?.status,
          OfferStatus.expiredSentBlik,
        );
        expect(
          container.read(activeOfferProvider)?.status,
          OfferStatus.expiredSentBlik,
        );
      },
    );
  }

  test(
    'history refresh retains unavailable and relisted completed trade',
    () async {
      final history = trade(id: 'history', status: OfferStatus.takerPaid);
      await db.upsertOffer(history);
      expect(await notifier.refreshOfferDetails(history), isNull);
      api.snapshots['history'] = trade(
        id: 'history',
        status: OfferStatus.funded,
        taker: null,
      );
      expect(await notifier.refreshOfferDetails(history), isNull);
      expect((await db.getOfferById('history'))?.status, OfferStatus.takerPaid);
      expect(container.read(activeOfferProvider)?.id, 'trade');
    },
  );

  test('definitive pre-code relist may remove unused reservation', () async {
    final unused = trade(status: OfferStatus.expiredBlik);
    await notifier.setActiveOffer(unused);
    api.snapshots['trade'] = trade(status: OfferStatus.funded, taker: null);
    await notifier.reconcileActiveOfferNow();
    expect(await db.getOfferById('trade'), isNull);
    expect(container.read(activeOfferProvider), isNull);
  });

  test(
    'expired-code refresh with no details retains unused reservation',
    () async {
      final unused = trade(status: OfferStatus.expiredBlik);
      await notifier.setActiveOffer(unused);
      await notifier.refreshOfferDetails(unused);
      expect((await db.getOfferById('trade'))?.status, OfferStatus.expiredBlik);
    },
  );

  test(
    'status push during fetch cannot be overwritten by old snapshot',
    () async {
      final before = trade();
      await notifier.applyStatusUpdate(
        OfferStatusUpdate(
          offerId: 'trade',
          paymentHash: '',
          status: 'takerCharged',
          coordinatorPubkey: 'coordinator',
          timestamp: DateTime.now(),
        ),
      );
      await db.reconcileRemoteOffer(before, trade(), 'taker');
      expect(
        (await db.getOfferById('trade'))?.status,
        OfferStatus.takerCharged,
      );
    },
  );

  test('redacted participant snapshot keeps local code and invoice', () async {
    final local = trade().copyWith(
      blikCode: '123456',
      takerInvoice: 'test-invoice',
      paymentWalletId: 'wallet',
    );
    await notifier.setActiveOffer(local);
    final remote = Offer.fromJson(
      trade(status: OfferStatus.takerCharged).toRpcJson(forTaker: true),
    );
    api.snapshots['trade'] = remote;
    final refreshed = await notifier.refreshOfferDetails(local);
    expect(refreshed?.status, OfferStatus.takerCharged);
    final stored = await db.getOfferById('trade');
    expect(stored?.blikCode, '123456');
    expect(stored?.takerInvoice, 'test-invoice');
    expect(stored?.paymentWalletId, 'wallet');
  });

  test(
    'pending recovery never resends after a different authoritative state',
    () async {
      api.snapshots['trade'] = trade(status: OfferStatus.makerConfirmed);
      expect(
        await reportTakerCharged(
          send: () async => fail('no longer reportable'),
          refresh: () => notifier.refreshOfferDetails(trade()),
          checkBeforeSending: true,
        ),
        ChargeReportResult.statusUpdated,
      );
      expect(
        container.read(activeOfferProvider)?.status,
        OfferStatus.makerConfirmed,
      );
    },
  );

  test(
    'history refresh publishes updated inactive row without changing active trade',
    () async {
      final local = trade(id: 'history');
      await db.upsertOffer(local);
      final subscription = container.listen(myOffersProvider, (_, _) {});
      addTearDown(subscription.close);
      await container.read(myOffersProvider.future);
      api.snapshots['history'] = trade(
        id: 'history',
        status: OfferStatus.takerCharged,
      );
      await notifier.refreshOfferDetails(local);
      final history = await container.read(myOffersProvider.future);
      expect(
        history.singleWhere((offer) => offer.id == 'history').status,
        OfferStatus.takerCharged,
      );
      expect(container.read(activeOfferProvider)?.id, 'trade');
    },
  );

  test('refresh preserves dispute timestamp omitted by older coordinators', () {
    final started = DateTime.utc(2026, 9, 14);
    final local = trade(
      status: OfferStatus.dispute,
    ).copyWith(disputeAt: started);
    final remote = trade(status: OfferStatus.dispute);
    expect(reconcileOfferSnapshot(local, remote, 'taker')?.disputeAt, started);
    final corrected = started.add(const Duration(minutes: 1));
    expect(
      reconcileOfferSnapshot(
        local,
        remote.copyWith(disputeAt: corrected),
        'taker',
      )?.disputeAt,
      corrected,
    );
  });

  test(
    'redacted refresh preserves BOLT12 payout without mixing invoice types',
    () {
      final local = trade().copyWith(takerOffer: 'lno-local');
      final redacted = trade(status: OfferStatus.takerCharged);
      final preserved = reconcileOfferSnapshot(local, redacted, 'taker');
      expect(preserved?.takerOffer, 'lno-local');
      expect(preserved?.takerInvoice, isNull);
      final switched = reconcileOfferSnapshot(
        local,
        redacted.copyWith(takerInvoice: 'lnbc-remote'),
        'taker',
      );
      expect(switched?.takerInvoice, 'lnbc-remote');
      expect(switched?.takerOffer, isNull);
      final offer = reconcileOfferSnapshot(
        trade().copyWith(takerInvoice: 'lnbc-local'),
        redacted.copyWith(takerOffer: 'lno-remote'),
        'taker',
      );
      expect(offer?.takerOffer, 'lno-remote');
      expect(offer?.takerInvoice, isNull);
    },
  );

  test('foreign snapshot cannot replace local trade', () {
    final local = trade();
    expect(
      reconcileOfferSnapshot(local, trade(id: 'other'), 'taker'),
      same(local),
    );
  });
}
