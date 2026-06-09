import 'package:shared_preferences/shared_preferences.dart';

import 'package:bitblik_core/core.dart';

enum BitcoinDisplayUnit { sats, bitcoin }

class OfferCreationPreferences {
  const OfferCreationPreferences({
    required this.defaultCategory,
    required this.premiumEnabled,
    required this.defaultPremiumPercent,
    required this.preferredCoordinatorPubkey,
  });

  /// Stored in [preferredCoordinatorPubkey] to mean "pick the available
  /// coordinator with the lowest maker fee for each offer" instead of a
  /// concrete coordinator pubkey. `null` still means automatic selection.
  static const cheapestCoordinatorSentinel = '__cheapest__';

  final OfferCategory defaultCategory;
  final bool premiumEnabled;
  final double defaultPremiumPercent;
  final String? preferredCoordinatorPubkey;

  OfferCreationPreferences copyWith({
    OfferCategory? defaultCategory,
    bool? premiumEnabled,
    double? defaultPremiumPercent,
    String? preferredCoordinatorPubkey,
    bool clearPreferredCoordinator = false,
  }) {
    return OfferCreationPreferences(
      defaultCategory: defaultCategory ?? this.defaultCategory,
      premiumEnabled: premiumEnabled ?? this.premiumEnabled,
      defaultPremiumPercent:
          defaultPremiumPercent ?? this.defaultPremiumPercent,
      preferredCoordinatorPubkey:
          clearPreferredCoordinator
              ? null
              : preferredCoordinatorPubkey ?? this.preferredCoordinatorPubkey,
    );
  }
}

class DisplayPreferences {
  const DisplayPreferences({required this.bitcoinDisplayUnit});

  final BitcoinDisplayUnit bitcoinDisplayUnit;

  DisplayPreferences copyWith({BitcoinDisplayUnit? bitcoinDisplayUnit}) {
    return DisplayPreferences(
      bitcoinDisplayUnit: bitcoinDisplayUnit ?? this.bitcoinDisplayUnit,
    );
  }
}

class AppPreferences {
  const AppPreferences({required this.offerCreation, required this.display});

  final OfferCreationPreferences offerCreation;
  final DisplayPreferences display;
}

class AppPreferencesStore {
  static const _defaultCategoryKey = 'offer_creation_default_category';
  static const _premiumEnabledKey = 'offer_creation_premium_enabled';
  static const _defaultPremiumPercentKey =
      'offer_creation_default_premium_percent';
  static const _preferredCoordinatorKey =
      'offer_creation_preferred_coordinator_pubkey';
  static const _bitcoinDisplayUnitKey = 'display_bitcoin_unit';
  static const _selectedPaymentSystemKey = 'selected_payment_system_id';

  static const _defaultOfferCreation = OfferCreationPreferences(
    defaultCategory: OfferCategory.shop,
    premiumEnabled: false,
    defaultPremiumPercent: 0,
    preferredCoordinatorPubkey: null,
  );

  static const _defaultDisplay = DisplayPreferences(
    bitcoinDisplayUnit: BitcoinDisplayUnit.sats,
  );

  static Future<AppPreferences> load() async {
    final prefs = await SharedPreferences.getInstance();
    return AppPreferences(
      offerCreation: _loadOfferCreationFromPrefs(prefs),
      display: _loadDisplayFromPrefs(prefs),
    );
  }

  static Future<OfferCreationPreferences> loadOfferCreation() async {
    final prefs = await SharedPreferences.getInstance();
    return _loadOfferCreationFromPrefs(prefs);
  }

  static Future<DisplayPreferences> loadDisplay() async {
    final prefs = await SharedPreferences.getInstance();
    return _loadDisplayFromPrefs(prefs);
  }

  static Future<void> saveOfferCreation(
    OfferCreationPreferences settings,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_defaultCategoryKey, settings.defaultCategory.name);
    await prefs.setBool(_premiumEnabledKey, settings.premiumEnabled);
    await prefs.setDouble(
      _defaultPremiumPercentKey,
      _normalizePremium(settings.defaultPremiumPercent),
    );
    final preferred = settings.preferredCoordinatorPubkey;
    if (preferred == null || preferred.isEmpty) {
      await prefs.remove(_preferredCoordinatorKey);
    } else {
      await prefs.setString(_preferredCoordinatorKey, preferred);
    }
  }

  static Future<void> saveDisplay(DisplayPreferences settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      _bitcoinDisplayUnitKey,
      settings.bitcoinDisplayUnit.name,
    );
  }

  static OfferCreationPreferences _loadOfferCreationFromPrefs(
    SharedPreferences prefs,
  ) {
    final categoryName = prefs.getString(_defaultCategoryKey);
    final defaultCategory = OfferCategory.values.where(
      (value) => value.name == categoryName,
    );
    final preferredCoordinator = prefs.getString(_preferredCoordinatorKey);
    return OfferCreationPreferences(
      defaultCategory:
          defaultCategory.isEmpty
              ? _defaultOfferCreation.defaultCategory
              : defaultCategory.first,
      premiumEnabled:
          prefs.getBool(_premiumEnabledKey) ??
          _defaultOfferCreation.premiumEnabled,
      defaultPremiumPercent: _normalizePremium(
        prefs.getDouble(_defaultPremiumPercentKey) ??
            _defaultOfferCreation.defaultPremiumPercent,
      ),
      preferredCoordinatorPubkey:
          preferredCoordinator == null || preferredCoordinator.isEmpty
              ? null
              : preferredCoordinator,
    );
  }

  static DisplayPreferences _loadDisplayFromPrefs(SharedPreferences prefs) {
    final unitName = prefs.getString(_bitcoinDisplayUnitKey);
    final unit = BitcoinDisplayUnit.values.where(
      (value) => value.name == unitName,
    );
    return DisplayPreferences(
      bitcoinDisplayUnit:
          unit.isEmpty ? _defaultDisplay.bitcoinDisplayUnit : unit.first,
    );
  }

  /// Active payment method (country/system). Defaults to BLIK so existing
  /// Polish users are unaffected.
  static Future<PaymentSystem> loadSelectedPaymentSystem() async {
    final prefs = await SharedPreferences.getInstance();
    return paymentSystemById(prefs.getString(_selectedPaymentSystemKey));
  }

  static Future<void> saveSelectedPaymentSystem(PaymentSystem method) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedPaymentSystemKey, method.id);
  }

  static double _normalizePremium(double value) {
    if (value.isNaN || value.isInfinite) return 0;
    if (value < 0) return 0;
    return (value * 2).round() / 2;
  }
}
