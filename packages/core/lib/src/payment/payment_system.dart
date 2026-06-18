import 'package:meta/meta.dart';
import 'package:ndk/ndk.dart' show Nip19;

import '../constants/relays.dart';
import '../models/offer.dart' show OfferCategory;

/// A country/payment-system specification. Single source of truth for the
/// per-market parameters that used to be hardcoded to Poland's BLIK (6-digit
/// codes, PLN, ~2 min validity).
///
/// Shared by the app (input validation, timers, currency labels) and the
/// coordinator (per-method confirmation timeout). On the wire the payment code
/// is still carried under the historical `blik_code` field regardless of method.
@immutable
class PaymentSystem {
  /// Stable identifier used on the wire (`CoordinatorInfo.paymentSystem`) and in
  /// app preferences. Never rename existing ids.
  final String id;

  /// User-facing brand name, e.g. `BLIK`, `MB WAY`. Brand names — not translated.
  final String label;

  /// App/product brand name for this market, e.g. `Bitblik`, `Bitway`. Used in
  /// UI copy that refers to the application itself (FAQ, tips, notifications)
  /// rather than the payment method. Follows the selected payment system, so it
  /// updates live when the user switches markets in settings.
  final String brandName;

  /// Name of the payment code as shown in UI text (e.g. `BLIK`, `MB WAY`).
  /// Null falls back to a neutral word via [codeLabel].
  final String? codeName;

  /// ISO 3166-1 alpha-2 country code this method serves, e.g. `PL`, `PT`.
  /// Used as the i18n key for the localized country name.
  final String country;

  /// Country flag emoji, e.g. 🇵🇱, 🇵🇹.
  final String flag;

  /// Optional app asset path for the system's logo (e.g. `assets/bitway.png`).
  /// Shown instead of [flag] where available.
  final String? logoAsset;

  /// ISO currency code the method settles in, e.g. `PLN`, `EUR`. Used for
  /// rate lookups, offer tagging, and validation.
  final String currency;

  /// Display symbol for [currency], e.g. `zł`, `€`. Shown when the user enters
  /// or picks an amount.
  final String currencySymbol;

  /// Number of digits in the payment code (BLIK 6, MB WAY 10).
  final int codeLength;

  /// How long the code stays valid, i.e. how long the maker has to use it.
  /// Drives the confirmation countdown on both client and coordinator.
  final int codeValidityMinutes;

  /// Whether the taker has to actively approve/confirm the payment code in
  /// their banking app (BLIK push confirmation). False for pull-style flows
  /// like MB WAY ATM cash-out, where the maker simply enters the code at the
  /// ATM and there is nothing for the taker to confirm — in that case all
  /// "confirm in your banking app" prompts are suppressed.
  final bool requiresCodeConfirmation;

  /// Offer categories this method supports. MB WAY ATM payouts only make sense
  /// for cash-out, so it is restricted to [OfferCategory.atm].
  final List<OfferCategory> supportedCategories;

  /// Quick-pick fiat amounts offered for ATM cash-out (in [currency] units),
  /// matching common note/withdrawal denominations. The maker can still switch
  /// to a custom amount.
  final List<int> atmPresetAmounts;

  /// Banknote nominals the local ATM network dispenses (in [currency] units).
  /// An ATM cash-out amount is only valid if it can be composed from these
  /// notes — see [canDispenseAtmAmount].
  final List<int> atmBanknoteDenominations;

  /// The project's Nostr identity (hex pubkey) whose profile NIP-65 defines the
  /// **discovery relays** for this market, and against which coordinator
  /// advertisements are resolved. Each market can advertise its own discovery
  /// set + coordinator list under a separate key (e.g. Bitblik for BLIK,
  /// Bitway for MB WAY). Stored as hex — the form Nostr filters need.
  final String discoveryPubkeyHex;

  const PaymentSystem({
    required this.id,
    required this.label,
    required this.brandName,
    this.codeName,
    required this.country,
    required this.flag,
    this.logoAsset,
    required this.currency,
    required this.currencySymbol,
    required this.codeLength,
    required this.codeValidityMinutes,
    this.requiresCodeConfirmation = true,
    required this.supportedCategories,
    required this.atmPresetAmounts,
    required this.atmBanknoteDenominations,
    this.discoveryPubkeyHex = kBitblikPubkeyHex,
  });

  /// The discovery identity as an `npub`, derived from [discoveryPubkeyHex].
  /// Only needed for display (e.g. an external profile link).
  String get discoveryNpub => Nip19.encodePubKey(discoveryPubkeyHex);

  /// Value carried on the wire under the NIP-69 `y` (platform) tag and used by
  /// clients as the `#y` subscription filter, so a market only receives offers
  /// and status updates belonging to its own payment system. Currently equals
  /// [brandName] (`Bitblik`, `Bitway`) — historical offers were published with
  /// `y=Bitblik`, so BLIK must keep that value. Wire-stable: never change an
  /// existing system's tag or older peers become invisible to this filter.
  String get platformTag => brandName;

  /// Payment-code term for UI text; neutral `'code'` when [codeName] is unset.
  String get codeLabel =>
      (codeName == null || codeName!.isEmpty) ? 'code' : codeName!;

  /// Whether this method offers a choice of category (vs a single forced one).
  bool get hasCategoryChoice => supportedCategories.length > 1;

  /// Window the maker has to confirm after the taker submits the code.
  Duration get confirmationWindow => Duration(minutes: codeValidityMinutes);

  /// Whether [code] is a syntactically valid payment code for this method.
  bool isValidCode(String code) =>
      code.length == codeLength && int.tryParse(code) != null;

  /// Whether [amount] (in whole [currency] units) can actually be paid out by
  /// an ATM, i.e. composed as a non-negative integer combination of
  /// [atmBanknoteDenominations]. Non-integer or non-positive amounts are
  /// rejected. With no configured denominations, any positive whole amount is
  /// accepted.
  bool canDispenseAtmAmount(num amount) {
    if (amount <= 0) return false;
    // ATMs only dispense whole notes, so the amount must be a whole number.
    if (amount != amount.truncateToDouble()) return false;
    final target = amount.toInt();
    final denoms =
        atmBanknoteDenominations.where((d) => d > 0).toList(growable: false);
    if (denoms.isEmpty) return true;

    // Reachability must respect the actual note set (e.g. with {20,50} the
    // amount 30 is not dispensable even though it is a multiple of 10). Use a
    // bounded DP for typical amounts; for very large targets fall back to the
    // gcd test (every sufficiently large multiple of the gcd is reachable).
    const dpCap = 200000;
    if (target > dpCap) {
      final g = denoms.reduce(_gcd);
      return target % g == 0;
    }
    final reachable = List<bool>.filled(target + 1, false);
    reachable[0] = true;
    for (var i = 1; i <= target; i++) {
      for (final d in denoms) {
        if (d <= i && reachable[i - d]) {
          reachable[i] = true;
          break;
        }
      }
    }
    return reachable[target];
  }

  static int _gcd(int a, int b) {
    a = a.abs();
    b = b.abs();
    while (b != 0) {
      final t = b;
      b = a % b;
      a = t;
    }
    return a == 0 ? 1 : a;
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is PaymentSystem && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

/// Poland — BLIK. 6-digit code, ~2 min validity (matches the legacy 120s window).
const PaymentSystem kBlik = PaymentSystem(
  id: 'blik',
  label: 'BLIK',
  brandName: 'Bitblik',
  codeName: 'BLIK',
  country: 'PL',
  flag: '🇵🇱',
  currency: 'PLN',
  currencySymbol: 'zł',
  codeLength: 6,
  codeValidityMinutes: 2,
  supportedCategories: [
    OfferCategory.shop,
    OfferCategory.atm,
    OfferCategory.online,
  ],
  atmPresetAmounts: [50, 100, 200, 300, 500],
  atmBanknoteDenominations: [10, 20, 50, 100, 200, 500],
);

/// Portugal — MB WAY ATM payout. 10-digit code, 30 min validity. ATM only.
const PaymentSystem kMbway = PaymentSystem(
  id: 'mbway',
  label: 'MBway',
  brandName: 'Bitway',
  codeName: 'MB WAY',
  country: 'PT',
  flag: '🇵🇹',
  logoAsset: 'assets/bitway.png',
  currency: 'EUR',
  currencySymbol: '€',
  codeLength: 10,
  codeValidityMinutes: 30,
  // ATM cash-out: the maker enters the code at the ATM; the taker has nothing
  // to approve in a banking app.
  requiresCodeConfirmation: false,
  supportedCategories: [OfferCategory.atm],
  atmPresetAmounts: [20, 50, 100, 150, 200, 250],
  atmBanknoteDenominations: [20, 50, 100, 200],
  // Bitway has its own Nostr identity for discovery (relays + coordinators).
  discoveryPubkeyHex: kBitwayPubkeyHex,
);

/// All supported payment methods. Add a market by appending here.
const List<PaymentSystem> kPaymentSystems = [kBlik, kMbway];

/// Resolve a method by [id]; falls back to [kBlik] for unknown/legacy ids so
/// older peers keep working.
PaymentSystem paymentSystemById(String? id) {
  for (final m in kPaymentSystems) {
    if (m.id == id) return m;
  }
  return kBlik;
}

/// Resolve the method that settles in [currency] (1:1 with currency today).
/// Returns null if no method matches.
PaymentSystem? paymentSystemForCurrency(String? currency) {
  if (currency == null) return null;
  final upper = currency.toUpperCase();
  for (final m in kPaymentSystems) {
    if (m.currency == upper) return m;
  }
  return null;
}
