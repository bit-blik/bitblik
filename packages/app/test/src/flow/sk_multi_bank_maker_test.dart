import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/screens/maker_flow/maker_amount_form.dart';
import 'package:bitblik/src/services/api_service_nostr.dart';
import 'package:bitblik/src/services/funding_payment.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Records what the maker form sends to initiate_offer, then stops the flow
/// before any funding work.
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
    List<String>? banks,
    FundingEstimate? fundingEstimate,
  }) async {
    submitted = {'amount': fiatAmount, 'bank': bank, 'banks': banks};
    throw const FormatException('Test stops before funding');
  }

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw StateError('Unexpected API access: ${invocation.memberName}');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<_MakerApi> showMaker(
    WidgetTester tester, {
    required bool multiBank,
  }) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(600, 1400);
    addTearDown(tester.view.resetDevicePixelRatio);
    addTearDown(tester.view.resetPhysicalSize);
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
        maxAmountSats: 10000000,
        currencies: const ['EUR'],
        paymentSystem: 'sk',
        nostrNpub: null,
        supportsMultiBankOffers: multiBank,
      ),
    );
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            selectedPaymentSystemProvider.overrideWith(
              (ref) => SelectedPaymentSystemNotifier(kSlovakia),
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

  Future<void> tapText(WidgetTester tester, String text) async {
    await tester.ensureVisible(find.text(text).first);
    await tester.tap(find.text(text).first);
    await tester.pumpAndSettle();
  }

  // ATM offers start on quick-pick amounts ("50 €"); anything else goes
  // through the custom-amount field.
  Future<void> enterAmount(WidgetTester tester, String amount) async {
    final preset = find.text('$amount €');
    if (preset.evaluate().isNotEmpty) {
      await tapText(tester, '$amount €');
      return;
    }
    await tapText(tester, t.maker.amountForm.labels.customAmount);
    await tester.enterText(find.byType(TextField).first, amount);
    await tester.pumpAndSettle();
  }

  Future<void> submit(WidgetTester tester) async {
    await tapText(tester, t.maker.amountForm.actions.generateInvoice);
  }

  // The shopping-centre case: Tatra banka and VÚB ATMs side by side; the
  // maker ticks both and the first taker from either bank gets the offer.
  testWidgets('ticking a second bank sends both, first choice first', (
    tester,
  ) async {
    final api = await showMaker(tester, multiBank: true);
    expect(find.byType(FilterChip), findsWidgets);
    expect(find.text(t.maker.amountForm.bank.multiHint), findsOneWidget);

    await tapText(tester, 'VÚB banka');
    await enterAmount(tester, '50');
    await submit(tester);

    expect(api.submitted, isNotNull);
    expect(api.submitted!['bank'], 'tatrabanka');
    expect(api.submitted!['banks'], ['tatrabanka', 'vub']);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  testWidgets('unticking leaves at least one bank', (tester) async {
    final api = await showMaker(tester, multiBank: true);
    // Tatra banka is the only ticked bank: unticking it is refused.
    await tapText(tester, 'Tatra banka');
    await enterAmount(tester, '50');
    await submit(tester);

    expect(api.submitted!['bank'], 'tatrabanka');
    expect(api.submitted!['banks'], isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  // Every ticked bank must pay the amount out: Prima banka stops at 200 EUR.
  testWidgets('a capped bank among the ticked ones blocks a larger amount', (
    tester,
  ) async {
    final api = await showMaker(tester, multiBank: true);
    await tapText(tester, 'Prima banka');
    await enterAmount(tester, '300');
    expect(
      find.text(
        t.exchange.errors.atmOverBankLimit(
          bank: 'Prima banka',
          limit: '200',
          currency: '€',
        ),
      ),
      findsOneWidget,
    );
    await submit(tester);
    expect(api.submitted, isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });

  // An older coordinator would keep only the first bank, so the picker stays
  // single-choice and nothing but `bank` is sent.
  testWidgets('without multi_bank_v1 the picker stays single-choice', (
    tester,
  ) async {
    final api = await showMaker(tester, multiBank: false);
    expect(find.byType(FilterChip), findsNothing);
    expect(find.text(t.maker.amountForm.bank.multiHint), findsNothing);

    await tapText(tester, 'VÚB banka');
    await enterAmount(tester, '50');
    await submit(tester);

    expect(api.submitted!['bank'], 'vub');
    expect(api.submitted!['banks'], isNull);
    await tester.pumpWidget(const SizedBox.shrink());
  });
}
