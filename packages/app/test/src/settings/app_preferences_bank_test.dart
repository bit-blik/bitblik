import 'package:bitblik/src/settings/app_preferences.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('selected payment-system migration (legacy SK ids → sk)', () {
    for (final legacy in ['tatrabanka', 'slsp', 'vub']) {
      test('$legacy resolves to the collapsed sk market and is rewritten',
          () async {
        SharedPreferences.setMockInitialValues({
          'selected_payment_system_id': legacy,
        });

        final resolved =
            await AppPreferencesStore.loadSelectedPaymentSystem();
        expect(resolved.id, 'sk');
        expect(resolved, kSlovakia);

        // The stored value is normalized to the canonical market id.
        final prefs = await SharedPreferences.getInstance();
        expect(prefs.getString('selected_payment_system_id'), 'sk');
      });
    }

    test('a current market id is left untouched', () async {
      SharedPreferences.setMockInitialValues({
        'selected_payment_system_id': 'blik',
      });
      final resolved = await AppPreferencesStore.loadSelectedPaymentSystem();
      expect(resolved.id, 'blik');
      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('selected_payment_system_id'), 'blik');
    });
  });

  group('deployment payment-system default', () {
    test('is selected for a new user without being persisted', () async {
      SharedPreferences.setMockInitialValues({});

      expect(
        await AppPreferencesStore.ensureMarketSelectedOrDetect(
          deploymentDefaultPaymentSystemId: 'sk',
        ),
        isTrue,
      );
      expect(
        await AppPreferencesStore.loadSelectedPaymentSystem(
          deploymentDefaultPaymentSystemId: 'sk',
        ),
        kSlovakia,
      );

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('selected_payment_system_id'), isNull);
    });

    test('does not override a saved user choice', () async {
      SharedPreferences.setMockInitialValues({
        'selected_payment_system_id': 'twint',
      });

      expect(
        await AppPreferencesStore.loadSelectedPaymentSystem(
          deploymentDefaultPaymentSystemId: 'sk',
        ),
        kTwint,
      );
    });

    test('ignores an unknown deployment value', () async {
      SharedPreferences.setMockInitialValues({});

      expect(
        await AppPreferencesStore.loadSelectedPaymentSystem(
          deploymentDefaultPaymentSystemId: 'unknown',
        ),
        kBlik,
      );
    });
  });

  group('per-market last-bank memory', () {
    test('save then load round-trips the chosen bank', () async {
      SharedPreferences.setMockInitialValues({});
      expect(await AppPreferencesStore.loadLastBank('sk'), isNull);
      await AppPreferencesStore.saveLastBank('sk', 'slsp');
      expect(await AppPreferencesStore.loadLastBank('sk'), 'slsp');
      // Scoped per market — another market has its own slot.
      expect(await AppPreferencesStore.loadLastBank('blik'), isNull);
    });
  });
}
