import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/widgets/premium_info.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('resolvePremiumForCoordinator', () {
    double resolve({
      bool enabled = true,
      required PremiumRange range,
      bool userAdjusted = false,
      double current = 0,
      double defaultPreference = 0,
    }) => resolvePremiumForCoordinator(
      premiumEnabled: enabled,
      range: range,
      userAdjusted: userAdjusted,
      current: current,
      defaultPreference: defaultPreference,
    );

    final discountRange = PremiumRange.sanitized(min: -3, max: 3);

    test('market price when the coordinator offers no range', () {
      expect(resolve(range: PremiumRange.none, defaultPreference: 2), 0);
      expect(resolve(range: PremiumRange.none, defaultPreference: -2), 0);
    });

    test('market price when premium pricing is disabled', () {
      expect(
        resolve(enabled: false, range: discountRange, defaultPreference: -2),
        0,
      );
    });

    test('the default preference stays 0 unless the maker changes it', () {
      expect(resolve(range: discountRange), 0);
    });

    test('a discount default is kept when the coordinator allows it', () {
      expect(resolve(range: discountRange, defaultPreference: -2), -2);
      expect(resolve(range: discountRange, defaultPreference: -5), -3);
    });

    test('a premium-only coordinator clamps a discount to 0', () {
      final premiumOnly = PremiumRange.sanitized(max: 5);
      expect(resolve(range: premiumOnly, defaultPreference: -2), 0);
      expect(
        resolve(range: premiumOnly, userAdjusted: true, current: -2.5),
        0,
      );
    });

    test('a slider choice is clamped to the new coordinator range', () {
      expect(
        resolve(range: discountRange, userAdjusted: true, current: -2.5),
        -2.5,
      );
      expect(
        resolve(range: discountRange, userAdjusted: true, current: 4),
        3,
      );
    });

    test('a discount-only coordinator still shows the slider', () {
      final discountOnly = PremiumRange.sanitized(min: -2);
      expect(discountOnly.isOffered, isTrue);
      expect(resolve(range: discountOnly, defaultPreference: 1), 0);
    });
  });

  test('formatSignedPremium', () {
    expect(formatSignedPremium(2.5), '+2.5');
    expect(formatSignedPremium(-3), '-3');
    expect(formatSignedPremium(0), '0');
  });

  test('premiumAccentColor', () {
    expect(premiumAccentColor(1), kPremiumColor);
    expect(premiumAccentColor(-1), kDiscountColor);
    expect(premiumAccentColor(0), Colors.grey);
  });

  Future<void> pumpChip(WidgetTester tester, double premium) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Scaffold(
            body: PremiumChip(
              premiumPercent: premium,
              viewerRole: PremiumViewerRole.taker,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('chip labels a negative premium as a discount', (tester) async {
    await pumpChip(tester, -3);
    final label = tester.widget<Text>(find.text('-3% discount'));
    expect(label.style?.color, kDiscountColor);

    await tester.tap(find.byType(PremiumChip));
    await tester.pumpAndSettle();
    expect(find.text('Discount'), findsOneWidget);
    expect(find.textContaining('you receive more sats'), findsOneWidget);
  });

  testWidgets('chip keeps the premium wording for positive values', (
    tester,
  ) async {
    await pumpChip(tester, 2.5);
    final label = tester.widget<Text>(find.text('+2.5% premium'));
    expect(label.style?.color, kPremiumColor);
  });

  testWidgets('Slovak discount wording', (tester) async {
    await tester.runAsync(() => LocaleSettings.setLocale(AppLocale.sk));
    addTearDown(() => LocaleSettings.setLocale(AppLocale.en));
    await pumpChip(tester, -1.5);
    expect(find.text('-1.5% zľava'), findsOneWidget);
  });
}
