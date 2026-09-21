import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/screens/maker_flow/twint_shop_qr_scanner_screen.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

const payload = 'Q4SIXZB8VXJ5000000000710CHF00025837';

void main() {
  late ValueChanged<String> detect;
  late ValueChanged<Object> cameraError;
  TwintShopQr? result;
  var completed = false;

  Future<void> showScanner(WidgetTester tester, {int? amount}) async {
    completed = false;
    result = null;
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              return Scaffold(
                body: TextButton(
                  onPressed: () async {
                    result = await Navigator.of(context).push<TwintShopQr>(
                      MaterialPageRoute(
                        builder: (_) => TwintShopQrScannerScreen(
                          requiredCentimes: amount,
                          cameraBuilder: (_, onScan, onError) {
                            detect = onScan;
                            cameraError = onError;
                            return const SizedBox.expand();
                          },
                        ),
                      ),
                    );
                    completed = true;
                  },
                  child: const Text('Start'),
                ),
              );
            },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Start'));
    await tester.pumpAndSettle();
  }

  testWidgets('valid capture returns exact payload and amount once', (
    tester,
  ) async {
    await showScanner(tester);
    final callback = detect;
    callback(payload);
    callback(payload);
    await tester.pumpAndSettle();
    expect(completed, isTrue);
    expect(result?.payload, payload);
    expect(result?.amountCentimes, 710);
    expect(find.text('Start'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('invalid capture and wrong replacement amount allow retry', (
    tester,
  ) async {
    await showScanner(tester, amount: 710);
    expect(find.byType(TextField), findsNothing);
    detect(' $payload');
    await tester.pumpAndSettle();
    expect(find.text(t.twint.shop.invalidQr), findsOneWidget);
    expect(completed, isFalse);
    await tester.pump(const Duration(seconds: 5));
    expect(find.text(t.twint.shop.invalidQr), findsNothing);
    expect(completed, isFalse);
    detect(' $payload');
    await tester.pumpAndSettle();
    await tester.tap(find.text(t.common.buttons.retry));
    await tester.pumpAndSettle();
    detect(payload.replaceFirst('000000000710', '000000000711'));
    await tester.pumpAndSettle();
    expect(find.text(t.twint.shop.amountMismatch), findsOneWidget);
    await tester.tap(find.text(t.common.buttons.retry));
    await tester.pumpAndSettle();
    detect(payload);
    await tester.pumpAndSettle();
    expect(result?.amountCentimes, 710);
  });

  testWidgets('camera denial stays retryable; back cancels without data', (
    tester,
  ) async {
    await showScanner(tester);
    cameraError(Exception('denied'));
    await tester.pumpAndSettle();
    expect(find.text(t.twint.shop.cameraFailed), findsOneWidget);
    await tester.tap(find.text(t.common.buttons.retry));
    await tester.pumpAndSettle();
    expect(find.text(t.twint.shop.cameraFailed), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();
    expect(completed, isTrue);
    expect(result, isNull);
  });
}
