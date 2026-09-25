import 'dart:async';
import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/flow/flow_provider.dart';
import 'package:bitblik/src/flow/flow_screen.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/services/key_service.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _Active extends StateNotifier<Offer?> implements ActiveOfferNotifier {
  _Active(super.state);
  int reads = 0;
  Future<void>? pending;
  @override
  Future<void> reconcileActiveOfferNow() async {
    reads++;
    await pending;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Keys extends Fake implements KeyService {
  @override
  String get publicKeyHex => 'maker';
}

void main() {
  final engine = FlowEngine.fromYaml('''id: test-deadline
states:
  waiting:
    initial: true
    transitions:
      - on: timeout
        after: 1
        to: done
  done:
    terminal: true
''');
  Offer offer() => Offer(
    id: 'test',
    amountSats: 1000,
    makerFees: 0,
    fiatAmount: 10,
    fiatCurrency: 'PLN',
    status: OfferStatus.reserved,
    statusRaw: 'waiting',
    createdAt: DateTime.utc(2020),
    makerPubkey: 'maker',
    coordinatorPubkey: 'coordinator',
  );

  Future<void> mount(WidgetTester tester, _Active active) async {
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          activeOfferProvider.overrideWith((ref) => active),
          keyServiceProvider.overrideWithValue(_Keys()),
          flowEngineProvider.overrideWith((ref) async => engine),
        ],
        child: TranslationProvider(
          child: const MaterialApp(home: FlowScreen()),
        ),
      ),
    );
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(milliseconds: 1));
  }

  testWidgets('expired flow stops background retries and resumes once', (
    tester,
  ) async {
    final active = _Active(offer());
    await mount(tester, active);
    expect(active.reads, 1);
    await tester.pump(const Duration(seconds: 11));
    expect(active.reads, 2);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
    await tester.pump(const Duration(minutes: 2));
    expect(active.reads, 2);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(milliseconds: 1));
    expect(active.reads, 3);
    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 20));
    expect(active.reads, 3);
  });

  testWidgets('resume during fetch never overlaps or loses retry', (
    tester,
  ) async {
    final pending = Completer<void>();
    final active = _Active(offer())..pending = pending.future;
    await mount(tester, active);
    expect(active.reads, 1);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump(const Duration(milliseconds: 1));
    expect(active.reads, 1);
    pending.complete();
    active.pending = null;
    await tester.pump(const Duration(milliseconds: 1));
    await tester.pump(const Duration(milliseconds: 1));
    expect(active.reads, 2);
    await tester.pump(const Duration(seconds: 11));
    expect(active.reads, 3);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
