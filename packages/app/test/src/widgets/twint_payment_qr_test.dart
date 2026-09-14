import 'dart:async';
import 'dart:typed_data';

import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/utils/save_payment_qr.dart';
import 'package:bitblik/src/utils/twint_qr_image.dart';
import 'package:bitblik/src/widgets/twint_payment_qr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as image;

const payload = 'Q4SIXZB8VXJ5000000000710CHF00025837';

void main() {
  test('export is a lossless black/white PNG with an opaque quiet zone', () {
    final png = renderTwintQrPng(payload);
    final decoded = image.decodePng(png)!;
    expect(decoded.width, decoded.height);
    expect(decoded.width, greaterThanOrEqualTo(400));
    for (final pixel in decoded) {
      expect(pixel.a, 255);
      expect(pixel.r == 0 || pixel.r == 255, isTrue);
      expect(pixel.g, pixel.r);
      expect(pixel.b, pixel.r);
      if (pixel.x < 64 ||
          pixel.y < 64 ||
          pixel.x >= decoded.width - 64 ||
          pixel.y >= decoded.height - 64) {
        expect(pixel.r, 255);
      }
    }
  });

  Future<void> showQr(
    WidgetTester tester, {
    String value = payload,
    DateTime? expiresAt,
    Future<PaymentQrSaveResult> Function(Uint8List)? save,
  }) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: SingleChildScrollView(
              child: TwintPaymentQr(
                payload: value,
                expiresAt:
                    expiresAt ?? DateTime.now().add(const Duration(minutes: 5)),
                saveImage: save ?? (_) async => PaymentQrSaveResult.cancelled,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pump();
  }

  testWidgets('save receives exact preview bytes; duplicate taps disabled', (
    tester,
  ) async {
    final pending = Completer<PaymentQrSaveResult>();
    Uint8List? saved;
    var calls = 0;
    await showQr(
      tester,
      save: (png) {
        saved = png;
        calls++;
        return pending.future;
      },
    );
    expect(find.byType(Image), findsNothing);
    await tester.tap(find.byIcon(Icons.qr_code_2));
    await tester.pumpAndSettle();
    final preview =
        tester.widget<Image>(find.byType(Image)).image as MemoryImage;
    await tester.tap(find.text(t.common.buttons.close));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsNothing);
    await tester.tap(find.byType(FilledButton));
    await tester.pump();
    expect(saved, orderedEquals(preview.bytes));
    expect(
      tester.widget<FilledButton>(find.byType(FilledButton)).onPressed,
      isNull,
    );
    expect(calls, 1);
    pending.complete(PaymentQrSaveResult.saved);
    await tester.pumpAndSettle();
    expect(find.text(t.twint.shop.saved), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets(
    'save failure stays visible and permits retry; cancellation is quiet',
    (tester) async {
      var calls = 0;
      await showQr(
        tester,
        save: (_) async {
          if (calls++ == 0) throw StateError('disk full');
          return PaymentQrSaveResult.cancelled;
        },
      );
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(find.text(t.twint.shop.saveFailed), findsOneWidget);
      await tester.tap(find.byType(FilledButton));
      await tester.pumpAndSettle();
      expect(find.text(t.twint.shop.saveFailed), findsNothing);
      expect(find.byType(SnackBar), findsNothing);
      expect(calls, 2);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('expiry removes QR and save action without waiting for server', (
    tester,
  ) async {
    await showQr(
      tester,
      expiresAt: DateTime.now().add(const Duration(seconds: 2)),
    );
    await tester.tap(find.byIcon(Icons.qr_code_2));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();
    expect(find.byType(Image), findsNothing);
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(FilledButton), findsNothing);
    expect(find.text(t.twint.shop.expired), findsOneWidget);
  });

  testWidgets(
    'replacement renders new bytes, and stale export cannot report success',
    (tester) async {
      final pending = Completer<PaymentQrSaveResult>();
      await showQr(tester, save: (_) => pending.future);
      await tester.tap(find.byType(FilledButton));
      await tester.pump();
      await tester.tap(find.byIcon(Icons.qr_code_2));
      await tester.pump();
      const replacement = 'Q4SIXZB8VXJ5000000000710CHF00025838';
      await showQr(tester, value: replacement);
      await tester.pump();
      expect(find.byType(AlertDialog), findsNothing);
      expect(find.byType(Image), findsNothing);
      await tester.tap(find.byIcon(Icons.qr_code_2));
      await tester.pump();
      final preview =
          tester.widget<Image>(find.byType(Image)).image as MemoryImage;
      expect(preview.bytes, orderedEquals(renderTwintQrPng(replacement)));
      pending.complete(PaymentQrSaveResult.saved);
      await tester.pumpAndSettle();
      expect(find.byType(SnackBar), findsNothing);
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('removing payment surface dismisses its open QR dialog', (
    tester,
  ) async {
    var visible = true;
    late StateSetter update;
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: StatefulBuilder(
            builder: (context, setState) {
              update = setState;
              return Scaffold(
                body: visible
                    ? TwintPaymentQr(
                        payload: payload,
                        expiresAt: DateTime.now().add(
                          const Duration(minutes: 5),
                        ),
                      )
                    : const SizedBox.shrink(),
              );
            },
          ),
        ),
      ),
    );
    await tester.tap(find.byIcon(Icons.qr_code_2));
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsOneWidget);
    update(() => visible = false);
    await tester.pumpAndSettle();
    expect(find.byType(AlertDialog), findsNothing);
    expect(find.byType(Image), findsNothing);
  });
}
