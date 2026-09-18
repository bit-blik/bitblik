import 'dart:io';
import 'dart:ui' as ui;

import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/flow/twint_bodies.dart';
import 'package:bitblik/src/screens/maker_flow/maker_amount_form.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/services/api_service_nostr.dart';
import 'package:bitblik/src/widgets/twint_payment_qr.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bitblik/src/services/funding_payment.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _OfferState extends StateNotifier<Offer?> implements ActiveOfferNotifier {
  _OfferState(super.state);
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Api implements ApiServiceNostr {
  final Offer offer;
  _Api(this.offer);
  @override
  Future<Map<String, dynamic>?> getOfferDetails(
    Offer offer,
    String coordinatorPubkey, {
    bool strict = false,
  }) async => this.offer.toRpcJson(includeBlikCode: true, forTaker: true);
  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected API access: ${invocation.memberName}');
}

class _MakerApi implements ApiServiceNostr {
  Map<String, dynamic>? submitted;
  @override
  Future<double> getBtcRate(String currency) async => 50000;
  @override
  Future<Map<String, dynamic>> initiateOfferFiat({
    required double fiatAmount,
    required String fiatCurrency,
    OfferCategory? category,
    String? coordinatorPubkey,
    double premiumPercent = 0,
    String? blikCode,
    String? bank,
    FundingEstimate? fundingEstimate,
  }) async {
    submitted = {
      'amount': fiatAmount,
      'currency': fiatCurrency,
      'category': category,
      'payload': blikCode,
    };
    throw const FormatException('Test stops before funding');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected API access: ${invocation.memberName}');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late FlowEngine engine;
  setUpAll(() async {
    final fonts = Platform.environment['TWINT_QR_FONT_DIR'];
    if (fonts != null) {
      final text = FontLoader('Roboto');
      for (final file in ['Roboto-Regular.ttf', 'Roboto-Bold.ttf']) {
        text.addFont(
          File(
            '$fonts/$file',
          ).readAsBytes().then((bytes) => ByteData.sublistView(bytes)),
        );
      }
      await text.load();
      final icons = FontLoader('MaterialIcons')
        ..addFont(
          File(
            '$fonts/MaterialIcons-Regular.otf',
          ).readAsBytes().then((bytes) => ByteData.sublistView(bytes)),
        );
      await icons.load();
    }
    engine = await FlowEngine.fromYamlWithImports(
      File('../core/lib/flows/twint.yml').readAsStringSync(),
      (name) => File('../core/lib/flows/$name').readAsString(),
    );
  });
  const payload = 'Q4SIXZB8VXJ5000000000710CHF00025837';
  Offer offer(OfferCategory? category, String status) {
    final now = DateTime.now().toUtc();
    return Offer(
      id: 'shop-flow',
      amountSats: 10000,
      makerFees: 50,
      status: OfferStatus.unknown,
      statusRaw: status,
      fiatAmount: 7.10,
      fiatCurrency: 'CHF',
      paymentSystemId: 'twint',
      category: category,
      createdAt: now,
      blikReceivedAt: now,
      reservedAt: now,
      makerPubkey: 'maker',
      takerPubkey: 'taker',
      coordinatorPubkey: 'coordinator',
      blikCode: category == OfferCategory.shop ? payload : '01234',
    );
  }

  Future<void> showFlow(
    WidgetTester tester,
    Offer current,
    FlowBody body,
    FlowActor role, {
    String? capture,
    Size size = const Size(390, 844),
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = size;
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
    final boundary = GlobalKey();
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            activeOfferProvider.overrideWith((ref) => _OfferState(current)),
            selectedPaymentSystemProvider.overrideWith(
              (ref) => SelectedPaymentSystemNotifier(kTwint),
            ),
            initializedApiServiceProvider.overrideWith(
              (ref) async => _Api(current),
            ),
          ],
          child: MaterialApp(
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
            ),
            home: RepaintBoundary(
              key: boundary,
              child: Scaffold(
                body: Consumer(
                  builder: (context, ref, _) =>
                      body(context, ref, current, engine, role),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    final directory = Platform.environment['TWINT_QR_ARTIFACT_DIR'];
    if (capture != null && directory != null) {
      await tester.runAsync(() async {
        for (final element in find.byType(Image).evaluate()) {
          await precacheImage((element.widget as Image).image, element);
        }
      });
      await tester.pump();
      await tester.runAsync(() async {
        final image =
            await (boundary.currentContext!.findRenderObject()!
                    as RenderRepaintBoundary)
                .toImage();
        final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
        await File(
          '$directory/$capture.png',
        ).writeAsBytes(bytes!.buffer.asUint8List());
        image.dispose();
      });
    }
  }

  testWidgets(
    'shop taker offers compact QR controls; online and legacy show numeric code',
    (tester) async {
      for (final category in [OfferCategory.shop, OfferCategory.online, null]) {
        await showFlow(
          tester,
          offer(category, 'reserved'),
          twintTakerPayBody,
          FlowActor.taker,
          capture: 'taker-${category?.name ?? 'legacy'}',
        );
        if (category == OfferCategory.shop) {
          expect(find.byType(TwintPaymentQr), findsOneWidget);
          expect(find.text(payload), findsNothing);
          expect(find.byType(Image), findsNothing);
          expect(find.byIcon(Icons.qr_code_2).hitTestable(), findsOneWidget);
          expect(
            find.text(t.twint.flow.takerPay.cancel).hitTestable(),
            findsOneWidget,
          );
        } else {
          expect(find.byType(TwintPaymentQr), findsNothing);
          expect(find.text('01234'), findsOneWidget);
        }
        await tester.pumpWidget(const SizedBox.shrink());
      }
    },
  );

  testWidgets('taker footer stays fixed while small-phone details scroll', (
    tester,
  ) async {
    for (final category in [OfferCategory.shop, OfferCategory.online]) {
      await showFlow(
        tester,
        offer(category, 'reserved'),
        twintTakerPayBody,
        FlowActor.taker,
        size: const Size(320, 568),
        capture: 'taker-small-${category.name}',
      );
      final controls = [
        find.text(t.twint.flow.takerPay.paid),
        find.text(t.twint.flow.takerPay.cancel),
      ];
      final before = controls.map(tester.getCenter).toList();
      final qrBefore = category == OfferCategory.shop
          ? tester.getCenter(find.byIcon(Icons.qr_code_2))
          : null;
      if (category == OfferCategory.shop) {
        for (final icon in [Icons.qr_code_2, Icons.download]) {
          expect(
            find.ancestor(
              of: find.byIcon(icon),
              matching: find.byType(Scrollable),
            ),
            findsOneWidget,
          );
        }
      }
      for (final control in controls) {
        expect(control.hitTestable(), findsOneWidget);
        expect(
          find.ancestor(of: control, matching: find.byType(Scrollable)),
          findsNothing,
        );
      }
      await tester.drag(
        find.byType(SingleChildScrollView).first,
        const Offset(0, -400),
      );
      await tester.pumpAndSettle();
      expect(controls.map(tester.getCenter).toList(), before);
      if (qrBefore != null) {
        expect(
          tester.getCenter(find.byIcon(Icons.qr_code_2)).dy,
          lessThan(qrBefore.dy),
        );
      }
      expect(tester.takeException(), isNull);
      await tester.pumpWidget(const SizedBox.shrink());
    }
  });

  testWidgets('shop replacement has scan action and no manual field', (
    tester,
  ) async {
    await showFlow(
      tester,
      offer(OfferCategory.shop, 'invalidTwint'),
      twintMakerReCodeBody,
      FlowActor.maker,
      capture: 'maker-replacement',
    );
    expect(find.byType(TextField), findsNothing);
    expect(find.text(t.maker.amountForm.twintScan.manualButton), findsNothing);
    expect(find.text(t.maker.amountForm.twintScan.scanButton), findsOneWidget);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  Future<_MakerApi> showMaker(
    WidgetTester tester, {
    bool supported = true,
  }) async {
    SharedPreferences.setMockInitialValues({});
    final api = _MakerApi();
    final coordinator = CoordinatorRecord(
      pubkeyHex: 'coordinator',
      responsive: true,
      info: CoordinatorInfo(
        name: 'Test coordinator',
        reservationSeconds: 300,
        makerFee: 0,
        takerFee: 0,
        minAmountSats: 100,
        maxAmountSats: 1000000,
        currencies: const ['CHF'],
        paymentSystem: 'twint',
        nostrNpub: null,
        supportsTwintShopQr: supported,
      ),
    );
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            selectedPaymentSystemProvider.overrideWith(
              (ref) => SelectedPaymentSystemNotifier(kTwint),
            ),
            apiServiceProvider.overrideWithValue(api),
            publicKeyProvider.overrideWith((ref) async => 'maker'),
            enabledCoordinatorsProvider.overrideWithValue(
              AsyncData([coordinator]),
            ),
            coordinatorRecordByPubkeyProvider(
              'coordinator',
            ).overrideWithValue(coordinator),
          ],
          child: MaterialApp(home: Scaffold(body: MakerAmountForm())),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    return api;
  }

  Future<void> completeScan(
    WidgetTester tester,
    String label,
    String? value,
  ) async {
    await tester.ensureVisible(find.text(label));
    await tester.tap(find.text(label));
    // Supply the scanner route's result before building a physical camera in
    // this form test. Decoder/error behavior has separate scanner coverage.
    tester
        .state<NavigatorState>(find.byType(Navigator))
        .pop(value == null ? null : TwintShopQr.tryParse(value));
    await tester.pumpAndSettle();
  }

  testWidgets(
    'shop form scans read-only amount, rescans atomically and submits full QR',
    (tester) async {
      final api = await showMaker(tester);
      expect(find.byType(TextField), findsNothing);
      expect(
        find.text(t.maker.amountForm.twintScan.manualButton),
        findsNothing,
      );
      await completeScan(tester, t.maker.amountForm.twintScan.scanButton, null);
      expect(find.byType(TextField), findsNothing);
      await completeScan(
        tester,
        t.maker.amountForm.twintScan.scanButton,
        payload,
      );
      var amount = tester.widget<TextField>(find.byType(TextField));
      expect(amount.readOnly, isTrue);
      expect(amount.controller!.text, '7.10');
      final replacement = payload.replaceFirst('000000000710', '000000000711');
      await completeScan(tester, t.twint.shop.rescan, replacement);
      amount = tester.widget<TextField>(find.byType(TextField));
      expect(amount.controller!.text, '7.11');
      await tester.ensureVisible(
        find.text(t.maker.amountForm.actions.generateInvoice),
      );
      await tester.tap(find.text(t.maker.amountForm.actions.generateInvoice));
      await tester.pumpAndSettle();
      expect(api.submitted, {
        'amount': 7.11,
        'currency': 'CHF',
        'category': OfferCategory.shop,
        'payload': replacement,
      });
      await tester.pumpWidget(const SizedBox.shrink());
    },
  );

  testWidgets('category switching clears incompatible scan and manual data', (
    tester,
  ) async {
    await showMaker(tester);
    await completeScan(
      tester,
      t.maker.amountForm.twintScan.scanButton,
      payload,
    );
    final online = find.text(t.maker.amountForm.category.shortLabels.online);
    await tester.ensureVisible(online);
    await tester.tap(online);
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNothing);
    await tester.ensureVisible(
      find.text(t.maker.amountForm.twintScan.manualButton),
    );
    await tester.tap(find.text(t.maker.amountForm.twintScan.manualButton));
    await tester.pumpAndSettle();
    for (final field in tester.widgetList<TextField>(find.byType(TextField))) {
      expect(field.controller!.text, isEmpty);
    }
    final shop = find.text(t.maker.amountForm.category.shortLabels.shop);
    await tester.ensureVisible(shop);
    await tester.tap(shop);
    await tester.pumpAndSettle();
    expect(find.byType(TextField), findsNothing);
    expect(find.text(t.maker.amountForm.twintScan.manualButton), findsNothing);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('older coordinator cannot receive a shop funding request', (
    tester,
  ) async {
    final api = await showMaker(tester, supported: false);
    await completeScan(
      tester,
      t.maker.amountForm.twintScan.scanButton,
      payload,
    );
    expect(find.text(t.twint.shop.coordinatorUnsupported), findsOneWidget);
    await tester.ensureVisible(
      find.text(t.maker.amountForm.actions.generateInvoice),
    );
    await tester.tap(find.text(t.maker.amountForm.actions.generateInvoice));
    await tester.pumpAndSettle();
    expect(api.submitted, isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
