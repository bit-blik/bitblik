import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/services/api_service_nostr.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _Api extends Fake implements ApiServiceNostr {
  final backgroundModes = <bool>[];

  @override
  Future<void> setBackgrounded(
    bool backgrounded, {
    required bool keepOfferAlerts,
  }) async {
    backgroundModes.add(backgrounded);
  }

  @override
  void setNetworkAvailable(bool available) {}
}

class _Alerts extends StateNotifier<bool>
    implements NewOfferNotificationsNotifier {
  _Alerts() : super(false);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  const connectivity = MethodChannel('dev.fluttercommunity.plus/connectivity');
  const connectivityEvents = MethodChannel(
    'dev.fluttercommunity.plus/connectivity_status',
  );

  Future<void> verifyStartup(
    WidgetTester tester, {
    required bool cachedForeground,
    required AppLifecycleState startupState,
    required bool expectedForeground,
  }) async {
    final api = _Api();
    final messenger = tester.binding.defaultBinaryMessenger;
    messenger.setMockMethodCallHandler(connectivity, (_) async => ['wifi']);
    messenger.setMockMethodCallHandler(connectivityEvents, (_) async => null);
    final container = ProviderContainer(
      overrides: [
        apiServiceProvider.overrideWithValue(api),
        initializedApiServiceProvider.overrideWith((ref) async => api),
        newOfferNotificationsProvider.overrideWith((ref) => _Alerts()),
      ],
    );
    addTearDown(() {
      container.dispose();
      messenger.setMockMethodCallHandler(connectivity, null);
      messenger.setMockMethodCallHandler(connectivityEvents, null);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    });

    // Startup providers can cache foreground before API initialization finishes
    // and before the lifecycle observer is registered.
    tester.binding.handleAppLifecycleStateChanged(
      cachedForeground ? AppLifecycleState.resumed : AppLifecycleState.paused,
    );
    expect(container.read(appForegroundProvider), cachedForeground);
    tester.binding.handleAppLifecycleStateChanged(startupState);
    final lifecycle = container.read(appLifecycleProvider);
    expect(lifecycle.currentState, startupState);
    // Seeding is deferred until the provider finishes building.
    expect(container.read(appForegroundProvider), cachedForeground);
    await tester.pump();
    await tester.pump();
    expect(container.read(appForegroundProvider), expectedForeground);
    expect(api.backgroundModes, [!expectedForeground]);
  }

  testWidgets('initialization catches pause before observer registration', (
    tester,
  ) async {
    await verifyStartup(
      tester,
      cachedForeground: true,
      startupState: AppLifecycleState.paused,
      expectedForeground: false,
    );
  });

  testWidgets('initialization catches resume before observer registration', (
    tester,
  ) async {
    await verifyStartup(
      tester,
      cachedForeground: false,
      startupState: AppLifecycleState.resumed,
      expectedForeground: true,
    );
  });

  for (final foreground in [false, true]) {
    testWidgets('inactive initialization preserves foreground=$foreground', (
      tester,
    ) async {
      await verifyStartup(
        tester,
        cachedForeground: foreground,
        startupState: AppLifecycleState.inactive,
        expectedForeground: foreground,
      );
    });
  }
}
