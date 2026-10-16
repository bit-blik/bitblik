import 'package:bitblik/src/settings/app_preferences.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Future<double> roundTrip(double premium) async {
    SharedPreferences.setMockInitialValues({});
    final defaults = await AppPreferencesStore.loadOfferCreation();
    await AppPreferencesStore.saveOfferCreation(
      defaults.copyWith(premiumEnabled: true, defaultPremiumPercent: premium),
    );
    return (await AppPreferencesStore.loadOfferCreation())
        .defaultPremiumPercent;
  }

  test('default premium preference stays 0 (off)', () async {
    SharedPreferences.setMockInitialValues({});
    final defaults = await AppPreferencesStore.loadOfferCreation();
    expect(defaults.defaultPremiumPercent, 0);
    expect(defaults.premiumEnabled, isFalse);
  });

  test('a default discount is kept, snapped to 0.5% steps', () async {
    expect(await roundTrip(-3), -3);
    expect(await roundTrip(-1.3), -1.5);
    expect(await roundTrip(2.5), 2.5);
  });

  test('impossible discounts fall back to 0', () async {
    expect(await roundTrip(-100), 0);
    expect(await roundTrip(double.nan), 0);
  });
}
