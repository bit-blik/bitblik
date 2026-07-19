import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'package:bitblik_core/core.dart';

import '../config/build_flavor.dart';

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

  /// Active payment method (country/system). Uses the saved choice if present,
  /// otherwise the build's default ([buildDefaultPaymentSystemId], resolved at
  /// startup from the appId/flavor or `--dart-define=PAYMENT_SYSTEM`).
  /// Resolve the market for this launch and report whether one is now selected.
  ///
  /// Returns `true` (→ skip the first-launch market picker) when:
  /// - the user already chose a market before, or
  /// - this is a branded/forced build (it pins its own market), or
  /// - IP geolocation resolves a **country served by a supported payment
  ///   system**, which is then auto-selected.
  ///
  /// Returns `false` (→ show the market-onboarding picker) only when we cannot
  /// determine the device country (no IP / lookup failed) OR the country is not
  /// served by any supported payment system. Detection is retried on each cold
  /// start until a market is selected, so a first launch without network can
  /// still auto-resolve on a later launch instead of being stuck on onboarding.
  static Future<bool> ensureMarketSelectedOrDetect() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_selectedPaymentSystemKey);
    if (saved != null && saved.isNotEmpty) return true;
    if (isBuildPaymentSystemForced) return true;

    final detected = await _detectPaymentSystemFromIp();
    if (detected != null) {
      await prefs.setString(_selectedPaymentSystemKey, detected.id);
      // ignore: avoid_print
      print(
        'BITFLAVOR autoDetected country=${detected.country} method=${detected.id}',
      );
      return true;
    }
    // No supported market for the detected/undetermined country → onboarding.
    return false;
  }

  static Future<PaymentSystem> loadSelectedPaymentSystem() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getString(_selectedPaymentSystemKey);
    // ignore: avoid_print
    print(
      'BITFLAVOR loadSelected saved=$saved default=$buildDefaultPaymentSystemId',
    );
    final resolved = paymentSystemById(saved ?? buildDefaultPaymentSystemId);
    // Migrate a stored legacy per-bank SK id (`tatrabanka`/`slsp`/`vub`) to the
    // collapsed `sk` market id, so the persisted value is canonical and the old
    // bank choice becomes the maker's per-offer bank instead of the market.
    if (saved != null && saved.isNotEmpty && saved != resolved.id) {
      await prefs.setString(_selectedPaymentSystemKey, resolved.id);
    }
    return resolved;
  }

  static Future<void> saveSelectedPaymentSystem(PaymentSystem method) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_selectedPaymentSystemKey, method.id);
  }

  static String _lastBankKey(String marketId) =>
      'offer_creation_last_bank_$marketId';

  static String _defaultBankKey(String marketId) =>
      'offer_creation_default_bank_$marketId';

  /// The bank the maker last used for [marketId] (bank-scoped markets), so the
  /// bank picker can default to it. Null if never chosen.
  static Future<String?> loadLastBank(String marketId) async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_lastBankKey(marketId));
    return (v == null || v.isEmpty) ? null : v;
  }

  static Future<void> saveLastBank(String marketId, String bankId) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_lastBankKey(marketId), bankId);
  }

  /// An explicit default bank for [marketId] set in offer-creation settings.
  /// When set it takes precedence over the last-used bank for the new-offer
  /// picker. Null when the user hasn't pinned one.
  static Future<String?> loadDefaultBank(String marketId) async {
    final prefs = await SharedPreferences.getInstance();
    final v = prefs.getString(_defaultBankKey(marketId));
    return (v == null || v.isEmpty) ? null : v;
  }

  static Future<void> saveDefaultBank(String marketId, String? bankId) async {
    final prefs = await SharedPreferences.getInstance();
    if (bankId == null || bankId.isEmpty) {
      await prefs.remove(_defaultBankKey(marketId));
    } else {
      await prefs.setString(_defaultBankKey(marketId), bankId);
    }
  }

  /// Whether the user has ever explicitly chosen a market/country. False on a
  /// fresh install, which triggers the first-launch market-selection onboarding
  /// (instead of silently defaulting to the build's [buildDefaultPaymentSystemId]).
  static Future<bool> hasSelectedPaymentSystem() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_selectedPaymentSystemKey) != null;
  }

  static double _normalizePremium(double value) {
    if (value.isNaN || value.isInfinite) return 0;
    if (value < 0) return 0;
    return (value * 2).round() / 2;
  }

  static Future<PaymentSystem?> _detectPaymentSystemFromIp() async {
    try {
      final countryCode = await getCountryFromIP();
      if (countryCode == null || countryCode.isEmpty) return null;
      final normalized = countryCode.toUpperCase();
      for (final system in kPaymentSystems) {
        if (system.country.toUpperCase() == normalized) {
          return system;
        }
      }
    } catch (_) {
      // Keep the startup fallback deterministic when geo lookup fails.
    }
    return null;
  }
}

/// Test/debug override for the detected country, e.g.
/// `flutter run --dart-define=GEO_COUNTRY=SK`. When set to a 2-letter code it
/// short-circuits the IP lookup so you can simulate any market on first launch.
const String _geoCountryOverride =
    String.fromEnvironment('GEO_COUNTRY', defaultValue: '');

/// ISO 3166-1 alpha-2 country code from the device IP, or null.
///
/// Tries several free, no-key, HTTPS + CORS-friendly geolocation providers in
/// order and returns the first valid 2-letter code, so one provider being
/// rate-limited (e.g. ipapi.co's free tier) doesn't break detection. Each is
/// given a short timeout; any failure falls through to the next.
Future<String?> getCountryFromIP() async {
  // Test override wins — no network call.
  if (_geoCountryOverride.length == 2 &&
      RegExp(r'^[A-Za-z]{2}$').hasMatch(_geoCountryOverride)) {
    // ignore: avoid_print
    print('BITFLAVOR geoCountryOverride=$_geoCountryOverride');
    return _geoCountryOverride.toUpperCase();
  }
  // (url, field extractor). Ordered by reliability of the free tier.
  final providers = <(String, String? Function(Map))>[
    ('https://api.country.is/', (j) => j['country'] as String?),
    ('https://ipwho.is/', (j) => j['country_code'] as String?),
    ('https://ipapi.co/json/', (j) => j['country_code'] as String?),
  ];
  for (final (url, pick) in providers) {
    try {
      final response = await http
          .get(Uri.parse(url))
          .timeout(const Duration(seconds: 5));
      if (response.statusCode != 200) continue;
      final data = jsonDecode(response.body);
      if (data is! Map) continue;
      final code = pick(data);
      // A valid result is exactly two letters; error responses (rate-limit
      // messages, {"success":false}, ...) don't match and fall through.
      if (code != null &&
          code.length == 2 &&
          RegExp(r'^[A-Za-z]{2}$').hasMatch(code)) {
        return code.toUpperCase();
      }
    } catch (_) {
      // Network/CORS/timeout/parse failure → try the next provider.
    }
  }
  return null;
}
