import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:bitblik/src/widgets/progress_indicators.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  setUp(() {
    TestWidgetsFlutterBinding.ensureInitialized()
        .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
  });
  tearDown(() {
    TestWidgetsFlutterBinding.ensureInitialized()
        .handleAppLifecycleStateChanged(AppLifecycleState.resumed);
  });

  testWidgets(
    'circular timer stops hidden ticks and uses real deadline on resume',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: CircularCountdownTimer(
            startTime: DateTime.now(),
            maxDuration: const Duration(seconds: 1),
          ),
        ),
      );
      var rebuilds = 0;
      final previous = debugOnRebuildDirtyWidget;
      debugOnRebuildDirtyWidget = (element, builtOnce) {
        previous?.call(element, builtOnce);
        if (element.widget is CircularCountdownTimer) rebuilds++;
      };
      addTearDown(() => debugOnRebuildDirtyWidget = previous);
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.hidden);
      await tester.pump();
      rebuilds = 0;
      tester.binding.scheduleForcedFrame();
      await tester.pump(const Duration(milliseconds: 500));
      expect(rebuilds, 0);
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(seconds: 1)),
      );
      tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
      await tester.pump();
      expect(find.text('0s'), findsOneWidget);
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));
      expect(tester.takeException(), isNull);
    },
  );

  for (final kind in ['funded', 'reservation', 'confirmation']) {
    testWidgets(
      '$kind timer defers expired refresh until resume, exactly once',
      (tester) async {
        var loads = 0;
        final container = ProviderContainer(
          overrides: [
            availableOffersProvider.overrideWith((ref) {
              loads++;
              return Stream.value([]);
            }),
          ],
        );
        addTearDown(container.dispose);
        container.listen(availableOffersProvider, (previous, next) {});
        final now = DateTime.now();
        final Widget indicator = switch (kind) {
          'funded' => FundedOfferProgressIndicator(
            createdAt: now.subtract(const Duration(minutes: 11)),
          ),
          'reservation' => ReservationProgressIndicator(
            reservedAt: now.subtract(const Duration(seconds: 2)),
            maxDuration: const Duration(seconds: 1),
          ),
          _ => BlikConfirmationProgressIndicator(
            blikReceivedAt: now.subtract(const Duration(minutes: 3)),
          ),
        };
        tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
        await tester.pumpWidget(
          UncontrolledProviderScope(
            container: container,
            child: MaterialApp(home: indicator),
          ),
        );
        await tester.pump(const Duration(seconds: 2));
        expect(loads, 1);
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.inactive,
        );
        await tester.pump();
        expect(loads, 1);
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        );
        await tester.pump();
        expect(loads, 2);
        tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        );
        await tester.pump(const Duration(seconds: 2));
        expect(loads, 2);
        await tester.pumpWidget(const SizedBox.shrink());
        tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.paused);
        tester.binding.handleAppLifecycleStateChanged(
          AppLifecycleState.resumed,
        );
        await tester.pump();
        expect(loads, 2);
        expect(tester.takeException(), isNull);
      },
    );
  }

  testWidgets('reservation timer stops hidden ticks and resumes repainting', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        child: MaterialApp(
          home: ReservationProgressIndicator(
            reservedAt: DateTime.now(),
            maxDuration: const Duration(minutes: 1),
          ),
        ),
      ),
    );
    var rebuilds = 0;
    final previous = debugOnRebuildDirtyWidget;
    debugOnRebuildDirtyWidget = (element, builtOnce) {
      previous?.call(element, builtOnce);
      if (element.widget is ReservationProgressIndicator) rebuilds++;
    };
    addTearDown(() => debugOnRebuildDirtyWidget = previous);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.detached);
    await tester.pump();
    rebuilds = 0;
    tester.binding.scheduleForcedFrame();
    await tester.pump(const Duration(seconds: 1));
    expect(rebuilds, 0);
    tester.binding.handleAppLifecycleStateChanged(AppLifecycleState.resumed);
    await tester.pump();
    rebuilds = 0;
    await tester.pump(const Duration(milliseconds: 100));
    expect(rebuilds, greaterThan(0));
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('circular countdown uses dark theme surfaces and text', (
    tester,
  ) async {
    final theme = AppTheme.dark;

    await tester.pumpWidget(
      MaterialApp(
        theme: theme,
        home: Scaffold(
          body: CircularCountdownTimer(
            startTime: DateTime.now(),
            maxDuration: const Duration(minutes: 1),
          ),
        ),
      ),
    );

    final indicator = tester.widget<CircularProgressIndicator>(
      find.byType(CircularProgressIndicator),
    );
    final innerCircle = tester.widget<Container>(
      find
          .descendant(
            of: find.byType(CircularCountdownTimer),
            matching: find.byType(Container),
          )
          .first,
    );
    final decoration = innerCircle.decoration! as BoxDecoration;
    final countdownText = tester.widget<Text>(
      find
          .descendant(
            of: find.byType(CircularCountdownTimer),
            matching: find.byType(Text),
          )
          .first,
    );

    expect(
      (indicator.valueColor! as AlwaysStoppedAnimation<Color>).value,
      theme.colorScheme.surfaceContainerHighest,
    );
    expect(decoration.color, theme.colorScheme.surfaceContainerLow);
    expect(countdownText.style?.color, theme.colorScheme.onSurface);
  });
}
