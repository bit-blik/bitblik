import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/widgets/bolt12_badge.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('renders the BOLT12 capability as a gradient pill', (
    tester,
  ) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: const MaterialApp(home: Scaffold(body: Bolt12Badge())),
      ),
    );
    expect(find.text('BOLT12'), findsOneWidget);
    expect(find.byIcon(Icons.bolt_rounded), findsOneWidget);
    final decorated = tester
        .widgetList<DecoratedBox>(find.byType(DecoratedBox))
        .where(
          (box) =>
              box.decoration is BoxDecoration &&
              (box.decoration as BoxDecoration).gradient != null,
        );
    expect(decorated, isNotEmpty);
  });

  for (final compact in [false, true]) {
    testWidgets('BOLT12 badge opens localized help (compact: $compact)', (
      tester,
    ) async {
      if (compact) {
        tester.view.physicalSize = const Size(320, 640);
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.resetPhysicalSize);
        addTearDown(tester.view.resetDevicePixelRatio);
      }
      var parentTapped = false;
      String? openedUrl;
      const launcherChannel = MethodChannel('plugins.flutter.io/url_launcher');
      tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
        launcherChannel,
        (call) async {
          if (call.method == 'launch') {
            openedUrl = (call.arguments as Map)['url'] as String;
          }
          return true;
        },
      );
      addTearDown(
        () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          launcherChannel,
          null,
        ),
      );
      await tester.runAsync(() => LocaleSettings.setLocale(AppLocale.pl));
      addTearDown(() => LocaleSettings.setLocale(AppLocale.en));
      await tester.pumpWidget(
        TranslationProvider(
          child: MaterialApp(
            builder: (context, child) => MediaQuery(
              data: MediaQuery.of(
                context,
              ).copyWith(textScaler: TextScaler.linear(compact ? 2 : 1)),
              child: child!,
            ),
            locale: const Locale('pl'),
            supportedLocales: const [Locale('pl')],
            localizationsDelegates: GlobalMaterialLocalizations.delegates,
            home: Scaffold(
              body: InkWell(
                onTap: () => parentTapped = true,
                child: Center(child: Bolt12Badge(compact: compact)),
              ),
            ),
          ),
        ),
      );
      await tester.tap(find.text('BOLT12'));
      await tester.pumpAndSettle();

      expect(parentTapped, isFalse);
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Obsługa BOLT12'), findsOneWidget);
      expect(
        find.text(
          'Ten koordynator może płacić do portfeli odbierających płatności '
          'przez oferty BOLT12. Możesz używać tych portfeli do wypłat dla '
          'takera lub zwrotów dla makera.',
        ),
        findsOneWidget,
      );
      expect(
        find.textContaining('Oferta BOLT12 to wielokrotnego użytku'),
        findsOneWidget,
      );
      final learnMore = find.text('Dowiedz się więcej na bolt12.org');
      await tester.ensureVisible(learnMore);
      await tester.tap(learnMore);
      await tester.pumpAndSettle();
      expect(openedUrl, 'https://bolt12.org/');
      expect(find.byType(AlertDialog), findsOneWidget);
      final dialogContext = tester.element(find.byType(AlertDialog));
      await tester.tap(
        find.text(MaterialLocalizations.of(dialogContext).closeButtonLabel),
      );
      await tester.pumpAndSettle();
      expect(find.byType(AlertDialog), findsNothing);
    });
  }

  testWidgets('BOLT12 badge opens with keyboard', (tester) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: const MaterialApp(
          home: Scaffold(body: Center(child: Bolt12Badge())),
        ),
      ),
    );
    await tester.sendKeyEvent(LogicalKeyboardKey.tab);
    await tester.pump();
    await tester.sendKeyEvent(LogicalKeyboardKey.enter);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
