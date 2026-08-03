import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/widgets/critical_code_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('charged action stays visible on a short mobile viewport', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 480);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    const actionKey = ValueKey('charged_action');
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: SingleChildScrollView(child: SizedBox(height: 900)),
          bottomNavigationBar: CriticalChargedActionBar(
            actionKey: actionKey,
            prompt: 'Wenn dir der Betrag belastet wurde:',
            label: 'Der Betrag wurde von meinem Bankkonto belastet',
            onPressed: null,
          ),
        ),
      ),
    );

    final actionRect = tester.getRect(find.byKey(actionKey));
    expect(actionRect.top, greaterThanOrEqualTo(0));
    expect(actionRect.bottom, lessThanOrEqualTo(480));
    expect(tester.takeException(), isNull);
  });

  testWidgets('critical dialog contains a prominent loss warning', (
    tester,
  ) async {
    await LocaleSettings.setLocale(AppLocale.en);
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Builder(
            builder:
                (context) => Scaffold(
                  body: TextButton(
                    onPressed:
                        () => showCriticalCodeDecisionDialog(
                          context,
                          code: 'BLIK',
                        ),
                    child: const Text('continue'),
                  ),
                ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('continue'));
    await tester.pumpAndSettle();

    expect(find.text('YOU MAY LOSE YOUR FUNDS'), findsOneWidget);
    expect(find.byIcon(Icons.warning_rounded), findsOneWidget);
    expect(find.textContaining('DO NOT continue'), findsOneWidget);
  });
}
