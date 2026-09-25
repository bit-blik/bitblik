import 'dart:async';
import 'dart:io';

import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/flow/flow_provider.dart';
import 'package:bitblik/src/flow/flow_screen.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/screens/maker_flow/maker_confirm_payment_screen.dart';
import 'package:bitblik/src/services/api_service_nostr.dart';
import 'package:bitblik/src/services/key_service.dart';
import 'package:bitblik/src/settings/app_preferences.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';

class _Active extends StateNotifier<Offer?> implements ActiveOfferNotifier {
  _Active(super.state);
  void change(Offer offer) => state = offer;
  @override
  Future<void> reconcileActiveOfferNow() async {}
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Key extends KeyService {
  @override
  String? get publicKeyHex => 'maker';
}

class _Display extends StateNotifier<BitcoinDisplayUnit>
    implements BitcoinDisplayUnitNotifier {
  _Display() : super(BitcoinDisplayUnit.sats);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Api implements ApiServiceNostr {
  final Future<String?> Function(int) reply;
  final List<String> calls = [];
  _Api(this.reply);
  @override
  Future<String?> getBlikCodeForMaker(
    String id,
    String maker,
    String coordinator,
  ) {
    calls.add(id);
    return reply(calls.length);
  }

  @override
  CoordinatorInfo? getCoordinatorInfoByPubkey(String pubkey) =>
      const CoordinatorInfo(
        name: 'test',
        reservationSeconds: 61,
        makerFee: 0,
        takerFee: 0,
        minAmountSats: 1,
        maxAmountSats: 100000,
        currencies: ['PLN'],
        paymentSystem: 'blik',
        nostrNpub: null,
      );
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected API access: ${invocation.memberName}');
}

void main() {
  late FlowEngine engine;
  late Offer original;
  setUpAll(() async {
    engine = await FlowEngine.fromYamlWithImports(
      File('../core/lib/flows/blik.yml').readAsStringSync(),
      (name) => File('../core/lib/flows/$name').readAsString(),
    );
  });
  setUp(() {
    final now = DateTime.now();
    original = Offer(
      id: 'offer',
      amountSats: 10000,
      makerFees: 0,
      fiatAmount: 20,
      fiatCurrency: 'PLN',
      paymentSystemId: 'blik',
      status: OfferStatus.blikReceived,
      createdAt: now,
      updatedAt: now,
      reservedAt: now,
      blikReceivedAt: now,
      makerPubkey: 'maker',
      takerPubkey: 'taker',
      coordinatorPubkey: 'coordinator',
    );
  });

  Future<void> mount(
    WidgetTester tester,
    _Active active,
    _Api api, {
    Future<String?>? key,
  }) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    addTearDown(() {
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    });
    final router = GoRouter(
      initialLocation: '/flow',
      routes: [
        GoRoute(path: '/flow', builder: (context, state) => const FlowScreen()),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeOfferProvider.overrideWith((ref) => active),
          apiServiceProvider.overrideWithValue(api),
          keyServiceProvider.overrideWithValue(_Key()),
          coordinatorTakerChargedAutoConfirmDurationProvider('coordinator')
              .overrideWithValue(const Duration(minutes: 1)),
          publicKeyProvider.overrideWith((ref) => key ?? Future.value('maker')),
          flowEngineProvider.overrideWith((ref) async => engine),
          bitcoinDisplayUnitProvider.overrideWith((ref) => _Display()),
          selectedPaymentSystemProvider.overrideWith(
            (ref) => SelectedPaymentSystemNotifier(kBlik),
          ),
          // Never reuse an unscoped code from a previous trade.
          receivedBlikCodeProvider.overrideWith((ref) => '999999'),
        ],
        child: TranslationProvider(
          child: MaterialApp.router(routerConfig: router),
        ),
      ),
    );
    for (var i = 0; i < 5; i++) {
      await tester.pump();
    }
  }

  testWidgets(
    'resume blikReceived fetches immediately, not cached previous code',
    (tester) async {
      final api = _Api((_) async => '123456');
      await mount(tester, _Active(original), api);
      expect(api.calls, ['offer']);
      expect(find.text('123 456'), findsOneWidget);
      expect(find.text('999 999'), findsNothing);
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  for (final empty in [false, true]) {
    testWidgets(
      'retries ${empty ? 'empty reply' : 'timeout'} without a new status',
      (tester) async {
        final api = _Api((call) async {
          if (call == 1) {
            if (empty) return null;
            throw TimeoutException('test timeout');
          }
          return '123456';
        });
        final active = _Active(original);
        await mount(tester, active, api);
        expect(api.calls.length, 1);
        expect(find.text(t.common.buttons.retry), findsOneWidget);
        active.change(original.copyWith(updatedAt: DateTime.now()));
        await tester.pump(const Duration(seconds: 2));
        expect(api.calls.length, 1);
        await tester.pump(const Duration(seconds: 1));
        await tester.pump();
        expect(api.calls.length, 2);
        expect(find.text('123 456'), findsOneWidget);
        await tester.pumpWidget(const SizedBox.shrink());
      },
    );
  }

  for (final hiddenState in [
    AppLifecycleState.hidden,
    AppLifecycleState.paused,
    AppLifecycleState.detached,
  ]) {
    testWidgets('retry stops while $hiddenState and resumes once', (
      tester,
    ) async {
      final api = _Api((call) async => call == 1 ? null : '123456');
      await mount(tester, _Active(original), api);
      expect(api.calls.length, 1);
      tester.binding.handleAppLifecycleStateChanged(hiddenState);
      await tester.pump(const Duration(seconds: 10));
      expect(api.calls.length, 1);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      await tester.pump(const Duration(seconds: 3));
      expect(api.calls.length, 1);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(api.calls.length, 2);
      expect(find.text('123 456'), findsOneWidget);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.inactive);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump(const Duration(seconds: 3));
      expect(api.calls.length, 2);
      await tester.pumpWidget(const SizedBox.shrink());
    });
  }

  testWidgets(
    'background completion retains code without duplicate resume fetch',
    (tester) async {
      final pending = Completer<String?>();
      final api = _Api((_) => pending.future);
      await mount(tester, _Active(original), api);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
      pending.complete('123456');
      await tester.pump(const Duration(seconds: 5));
      expect(api.calls.length, 1);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(api.calls.length, 1);
      expect(find.text('123 456'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('resume during in-flight fetch waits for same response', (
    tester,
  ) async {
    final pending = Completer<String?>();
    final api = _Api((_) => pending.future);
    await mount(tester, _Active(original), api);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(seconds: 5));
    expect(api.calls.length, 1);
    pending.complete('123456');
    await tester.pump();
    await tester.pump();
    expect(find.text('123 456'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('auto-confirm repaint ticker pauses and restarts on resume', (
    tester,
  ) async {
    final api = _Api((_) async => '123456');
    await mount(
      tester,
      _Active(original.copyWith(status: OfferStatus.takerCharged)),
      api,
    );
    var repaints = 0;
    final previousCallback = debugOnRebuildDirtyWidget;
    debugOnRebuildDirtyWidget = (element, builtOnce) {
      previousCallback?.call(element, builtOnce);
      if (element.widget is MakerConfirmPaymentScreen) repaints++;
    };
    addTearDown(() => debugOnRebuildDirtyWidget = previousCallback);
    await tester.pump(const Duration(seconds: 1));
    expect(repaints, greaterThan(0));
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump();
    repaints = 0;
    await tester.pump(const Duration(seconds: 5));
    expect(repaints, 0);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    repaints = 0;
    await tester.pump(const Duration(seconds: 1));
    expect(repaints, greaterThan(0));
    expect(api.calls, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('status push before reply keeps one request and displays reply', (
    tester,
  ) async {
    final pending = Completer<String?>();
    final api = _Api((_) => pending.future);
    final active = _Active(original);
    await mount(tester, active, api);
    active.change(original.copyWith(status: OfferStatus.blikSentToMaker));
    await tester.pump(const Duration(seconds: 5));
    expect(api.calls.length, 1);
    pending.complete('123456');
    await tester.pump();
    expect(find.text('123 456'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('waits for public key then fetches', (tester) async {
    final key = Completer<String?>();
    final api = _Api((_) async => '123456');
    await mount(tester, _Active(original), api, key: key.future);
    expect(api.calls, isEmpty);
    key.complete('maker');
    await tester.pump();
    await tester.pump();
    expect(api.calls.length, 1);
    expect(find.text('123 456'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('normal reserved to received transition fetches only once', (
    tester,
  ) async {
    final api = _Api((_) async => '123456');
    final active = _Active(original.copyWith(status: OfferStatus.reserved));
    await mount(tester, active, api);
    expect(api.calls, isEmpty);
    active.change(original);
    for (var i = 0; i < 5; i++) {
      await tester.pump();
    }
    expect(api.calls.length, 1);
    expect(find.text('123 456'), findsOneWidget);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('manual retry cancels scheduled retry', (tester) async {
    final pending = Completer<String?>();
    final api = _Api(
      (call) => call == 1
          ? Future.error(TimeoutException('test timeout'))
          : pending.future,
    );
    final active = _Active(original);
    await mount(tester, active, api);
    await tester.tap(find.text(t.common.buttons.retry));
    await tester.pump();
    active.change(original.copyWith(updatedAt: DateTime.now()));
    await tester.pump(const Duration(seconds: 5));
    expect(api.calls.length, 2);
    pending.complete('123456');
    await tester.pump();
    await tester.pump();
    expect(find.text('123 456'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('navigation cancels retry and ignores late failure', (
    tester,
  ) async {
    final pending = Completer<String?>();
    final api = _Api((_) => pending.future);
    await mount(tester, _Active(original), api);
    await tester.pumpWidget(const SizedBox.shrink());
    pending.completeError(TimeoutException('late test failure'));
    await tester.pump(const Duration(seconds: 5));
    expect(api.calls.length, 1);
    expect(tester.takeException(), isNull);
  });

  testWidgets('does not fetch code beyond its validity window', (tester) async {
    final api = _Api((_) async => '123456');
    final stale = original.copyWith(
      blikReceivedAt: DateTime.now().subtract(const Duration(minutes: 3)),
    );
    await mount(tester, _Active(stale), api);
    await tester.pump(const Duration(seconds: 5));
    expect(api.calls, isEmpty);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('expiry ignores late reply and stops retrying', (tester) async {
    final pending = Completer<String?>();
    final api = _Api((_) => pending.future);
    final active = _Active(original);
    await mount(tester, active, api);
    active.change(original.copyWith(status: OfferStatus.expiredBlik));
    await tester.pump();
    pending.complete('123456');
    await tester.pump(const Duration(seconds: 10));
    expect(api.calls.length, 1);
    expect(find.text('123 456'), findsNothing);
    expect(tester.takeException(), isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('changed code attempt ignores old reply and fetches new code', (
    tester,
  ) async {
    final pending = Completer<String?>();
    final api = _Api(
      (call) => call == 1 ? pending.future : Future.value('654321'),
    );
    final active = _Active(original);
    await mount(tester, active, api);
    active.change(
      original.copyWith(
        reservedAt: original.reservedAt!.add(const Duration(seconds: 1)),
        blikReceivedAt: original.blikReceivedAt!.add(
          const Duration(seconds: 1),
        ),
      ),
    );
    await tester.pump();
    expect(api.calls.length, 1);
    pending.complete('123456');
    await tester.pump();
    await tester.pump(const Duration(seconds: 3));
    await tester.pump();
    expect(api.calls.length, 2);
    expect(find.text('123 456'), findsNothing);
    expect(find.text('654 321'), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
