import 'dart:async';
import 'dart:io';

import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/services/api_service_nostr.dart';
import 'package:bitblik/src/services/key_service.dart';
import 'package:bitblik/src/services/offer_db_service.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class _Keys implements KeyService {
  _Keys(this.publicKeyHex);
  @override
  final String publicKeyHex;
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('$invocation');
}

class _Lifecycle implements AppLifecycleNotifier {
  @override
  AppLifecycleState get currentState => AppLifecycleState.resumed;
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('$invocation');
}

class _Api implements ApiServiceNostr {
  Future<Map<String, dynamic>?> Function()? response;
  int requests = 0;
  @override
  Stream<bool> get relayConnectionState => const Stream.empty();
  @override
  Future<Map<String, dynamic>?> getOfferDetails(
    Offer offer,
    String coordinatorPubkey, {
    bool strict = false,
  }) async {
    requests++;
    return response?.call();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('$invocation');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late Directory temporary;
  late ProviderContainer container;
  late ActiveOfferNotifier notifier;
  late _Api api;
  final opened = DateTime.utc(2026, 9, 14, 10);
  final delivered = opened.add(const Duration(hours: 1));
  final db = OfferDbService();

  Offer offer({String status = 'dispute', DateTime? disputeAt}) => Offer(
    id: 'dispute',
    amountSats: 1000,
    makerFees: 10,
    status: OfferStatus.values.byName(status),
    statusRaw: status,
    createdAt: opened.subtract(const Duration(hours: 1)),
    updatedAt: opened,
    disputeAt: disputeAt,
    makerPubkey: 'maker',
    takerPubkey: 'taker',
    coordinatorPubkey: 'coordinator',
    fiatAmount: 7.10,
    fiatCurrency: 'CHF',
    paymentWalletId: 'local-wallet',
  );

  Future<void> start(Offer initial, {String role = 'maker'}) async {
    await db.upsertOffer(initial);
    api = _Api();
    container = ProviderContainer(
      overrides: [
        keyServiceProvider.overrideWithValue(_Keys(role)),
        publicKeyProvider.overrideWith((ref) async => role),
        initializedApiServiceProvider.overrideWith((ref) async => api),
        appLifecycleProvider.overrideWith((ref) => _Lifecycle()),
        activeOfferNotificationsProvider.overrideWith(
          (ref) => ActiveOfferNotificationsNotifier(load: false),
        ),
      ],
    );
    final loaded = Completer<void>();
    container.listen(activeOfferProvider, (_, next) {
      if (next != null && !loaded.isCompleted) loaded.complete();
    }, fireImmediately: true);
    notifier = container.read(activeOfferProvider.notifier);
    await loaded.future;
    await Future<void>.delayed(Duration.zero);
  }

  OfferStatusUpdate update({DateTime? disputeAt, String status = 'dispute'}) =>
      OfferStatusUpdate(
        offerId: 'dispute',
        paymentHash: '',
        status: status,
        coordinatorPubkey: 'coordinator',
        timestamp: delivered,
        disputeAt: disputeAt,
      );

  setUpAll(() async {
    temporary = await Directory.systemTemp.createTemp(
      'dispute-timestamp-test-',
    );
    sqfliteFfiInit();
    databaseFactory = createDatabaseFactoryFfi(noIsolate: true);
    await databaseFactory.setDatabasesPath(temporary.path);
  });
  tearDown(() async {
    container.dispose();
    await db.clearAll();
  });
  tearDownAll(() async {
    await db.resetDatabase();
    await temporary.delete(recursive: true);
  });

  for (final role in ['maker', 'taker']) {
    test(
      '$role live dispute push stores original clock without fetching',
      () async {
        await start(offer(status: 'reserved'), role: role);
        await notifier.applyStatusUpdate(update(disputeAt: opened));
        expect(container.read(activeOfferProvider)!.disputeAt?.toUtc(), opened);
        expect((await db.getOfferById('dispute'))!.disputeAt?.toUtc(), opened);
        expect(api.requests, 0);
        await notifier.applyStatusUpdate(update());
        expect(container.read(activeOfferProvider)!.disputeAt?.toUtc(), opened);
        expect(api.requests, 0);
      },
    );

    test(
      '$role same-state restore repairs clock and preserves wallet',
      () async {
        await start(offer(), role: role);
        api.response = () async =>
            offer(disputeAt: opened).toRpcJson(forTaker: role == 'taker');
        await notifier.reconcileActiveOfferNow();
        final repaired = container.read(activeOfferProvider)!;
        expect(repaired.disputeAt, opened);
        expect(repaired.paymentWalletId, 'local-wallet');
        expect((await db.getOfferById('dispute'))!.disputeAt?.toUtc(), opened);
        // An older response lacking the field cannot erase the recovered clock.
        api.response = () async => offer().toRpcJson(forTaker: role == 'taker');
        await notifier.reconcileActiveOfferNow();
        expect(container.read(activeOfferProvider)!.disputeAt?.toUtc(), opened);
      },
    );
  }

  test(
    'older push fetches missing timestamp from authorized details',
    () async {
      await start(offer(status: 'reserved'));
      api.response = () async => offer(disputeAt: opened).toRpcJson();
      await notifier.applyStatusUpdate(update());
      expect(api.requests, 1);
      expect(container.read(activeOfferProvider)!.disputeAt?.toUtc(), opened);
      expect(
        container.read(activeOfferProvider)!.updatedAt?.toUtc(),
        delivered,
      );
    },
  );

  test(
    'entering dispute repairs missing clock; failure never invents one',
    () async {
      await start(offer(status: 'reserved'));
      api.response = () async => throw StateError('offline');
      await notifier.setActiveOffer(offer());
      // FlowScreen's existing entry hook invokes this after the first frame,
      // so entering the screen does not wait for network hydration.
      await notifier.reconcileActiveOfferNow();
      expect(container.read(activeOfferProvider)!.disputeAt?.toUtc(), isNull);
      api.response = () async => offer(disputeAt: opened).toRpcJson();
      await notifier.refreshMissingDisputeTimestamp();
      expect(container.read(activeOfferProvider)!.disputeAt?.toUtc(), opened);
    },
  );

  test(
    'late timestamp response cannot revive a newer resolved state',
    () async {
      await start(offer());
      final pending = Completer<Map<String, dynamic>?>();
      api.response = () => pending.future;
      final refresh = notifier.refreshMissingDisputeTimestamp();
      await Future<void>.delayed(Duration.zero);
      await notifier.setActiveOffer(offer(status: 'makerConfirmed'));
      pending.complete(offer(disputeAt: opened).toRpcJson());
      await refresh;
      expect(container.read(activeOfferProvider)!.statusRaw, 'makerConfirmed');
      expect((await db.getOfferById('dispute'))!.statusRaw, 'makerConfirmed');
    },
  );

  test('changed-state reconciliation imports dispute timestamp', () async {
    await start(offer(status: 'reserved'));
    api.response = () async => offer(disputeAt: opened).toRpcJson();
    await notifier.reconcileActiveOfferNow();
    expect(container.read(activeOfferProvider)!.statusRaw, 'dispute');
    expect(container.read(activeOfferProvider)!.disputeAt?.toUtc(), opened);
  });
}
