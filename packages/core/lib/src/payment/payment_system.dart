import 'package:meta/meta.dart';
import 'package:ndk/ndk.dart' show Nip19;

import '../constants/relays.dart';
import '../models/offer.dart' show OfferCategory, Offer;

/// The shape of the payment artifact exchanged in a flow.
enum InstrumentKind {
  /// A fixed-length numeric code (BLIK, MB WAY, TWINT, SK cardless withdrawal).
  numericCode,

  /// An opaque QR payload (e.g. Slovak pay-by-square) scanned/pasted as a
  /// string. Interoperable across bank apps, so never bank-scoped.
  qrPayload,
}

/// Who supplies the payment artifact and when.
enum InstrumentDirection {
  /// The taker generates/submits the artifact after reserving (BLIK, MB WAY,
  /// SK ATM withdrawal).
  takerProvides,

  /// The maker supplies the artifact when creating the offer (TWINT, SK QR).
  makerProvides,
}

/// Per-bank parameters for an ATM instrument that varies by bank. Today only
/// the Slovak ATM instrument carries these — Tatra banka, Slovenská sporiteľňa
/// and VÚB differ only in code validity and ATM note set, not in flow shape.
///
/// Every field except [id]/[label]/[validity] is an optional override of the
/// owning [InstrumentSpec]'s default.
@immutable
class BankSpec {
  /// Stable identifier carried on the wire (`Offer.bankId`) and in coordinator
  /// config. Never rename existing ids. E.g. `tatrabanka`, `slsp`, `vub`.
  final String id;

  /// User-facing bank name, e.g. `Tatra banka`. Not translated (brand name).
  final String label;

  /// How long this bank's code stays valid — the maker's confirmation window.
  final Duration validity;

  /// Overrides [InstrumentSpec.codeLength] when set.
  final int? codeLength;

  /// Map/locator URL for this bank's ATM network, shown on the "use code"
  /// screen. Overrides [InstrumentSpec.atmMapUrl].
  final String? atmMapUrl;

  /// Quick-pick fiat amounts for ATM cash-out. Overrides
  /// [InstrumentSpec.atmPresetAmounts].
  final List<int>? atmPresetAmounts;

  /// Banknote nominals this bank's ATMs dispense. Overrides
  /// [InstrumentSpec.atmBanknoteDenominations].
  final List<int>? atmBanknoteDenominations;

  const BankSpec({
    required this.id,
    required this.label,
    required this.validity,
    this.codeLength,
    this.atmMapUrl,
    this.atmPresetAmounts,
    this.atmBanknoteDenominations,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is BankSpec && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

/// How the payment artifact works for one [OfferCategory] of a market.
///
/// Holds everything that used to be hardcoded per payment method: code length,
/// validity window, who provides the code, and its generic flow definition.
/// Where a market's ATM instrument varies by bank (Slovakia), the defaults
/// here are overridden by the matching [BankSpec].
@immutable
class InstrumentSpec {
  final InstrumentKind kind;
  final InstrumentDirection direction;

  /// Id of the flow definition (`packages/core/lib/flows/<flowId>.yml`) that
  /// models this instrument's coordinator state machine.
  final String flowId;

  /// Default validity window (maker confirmation countdown). Overridden per
  /// bank by [BankSpec.validity].
  final Duration validity;

  /// Default numeric-code length. Null for [InstrumentKind.qrPayload].
  /// Overridden per bank by [BankSpec.codeLength].
  final int? codeLength;

  /// Name of the payment code as shown in UI text (`BLIK`, `MB WAY`). Null
  /// falls back to a neutral word via [codeLabel].
  final String? codeName;

  /// Whether the taker actively approves the code in their banking app (BLIK
  /// push). False for pull-style ATM cash-out where there is nothing to
  /// confirm — those "confirm in your banking app" prompts are suppressed.
  final bool requiresCodeConfirmation;

  /// Default quick-pick ATM amounts (in currency units). Overridden per bank.
  final List<int> atmPresetAmounts;

  /// Default ATM banknote nominals. An ATM cash-out amount is valid only if it
  /// can be composed from these notes — see [canDispenseAtmAmount]. Overridden
  /// per bank.
  final List<int> atmBanknoteDenominations;

  /// Default ATM locator URL. Overridden per bank by [BankSpec.atmMapUrl].
  final String? atmMapUrl;

  /// Per-bank variants. Empty for bank-agnostic instruments (BLIK, MB WAY,
  /// TWINT, and any pay-by-square QR).
  final List<BankSpec> banks;

  const InstrumentSpec({
    required this.kind,
    required this.direction,
    required this.validity,
    required this.flowId,
    this.codeLength,
    this.codeName,
    this.requiresCodeConfirmation = true,
    this.atmPresetAmounts = const [],
    this.atmBanknoteDenominations = const [],
    this.atmMapUrl,
    this.banks = const [],
  });

  /// Whether this instrument distinguishes banks (only SK ATM today).
  bool get hasBanks => banks.isNotEmpty;

  /// Whether the maker supplies the code upfront at offer creation.
  bool get makerProvidesCode => direction == InstrumentDirection.makerProvides;

  /// Payment-code term for UI text; neutral `'code'` when [codeName] is unset.
  String get codeLabel =>
      (codeName == null || codeName!.isEmpty) ? 'code' : codeName!;

  /// The [BankSpec] with [id], or null (unknown/absent id, or bank-agnostic).
  BankSpec? bankById(String? id) {
    if (id == null || id.isEmpty) return null;
    for (final b in banks) {
      if (b.id == id) return b;
    }
    return null;
  }

  /// Validity window for [bank] (its override, else the instrument default).
  Duration validityFor(BankSpec? bank) => bank?.validity ?? validity;

  /// Numeric code length for [bank] (its override, else the default).
  int? codeLengthFor(BankSpec? bank) => bank?.codeLength ?? codeLength;

  /// ATM presets for [bank] (its override, else the default).
  List<int> presetsFor(BankSpec? bank) =>
      bank?.atmPresetAmounts ?? atmPresetAmounts;

  /// ATM banknote nominals for [bank] (its override, else the default).
  List<int> denominationsFor(BankSpec? bank) =>
      bank?.atmBanknoteDenominations ?? atmBanknoteDenominations;

  /// ATM locator URL for [bank] (its override, else the default).
  String? atmMapUrlFor(BankSpec? bank) => bank?.atmMapUrl ?? atmMapUrl;

  /// Whether [payload] is a syntactically valid artifact for this instrument
  /// (and optionally [bank]). Numeric codes must be exactly the expected number
  /// of digits; QR payloads only need to be non-empty (pay-by-square structure
  /// validation is deferred to the QR feature).
  bool validate(String payload, {BankSpec? bank}) {
    switch (kind) {
      case InstrumentKind.numericCode:
        final len = codeLengthFor(bank);
        return len != null &&
            payload.length == len &&
            int.tryParse(payload) != null;
      case InstrumentKind.qrPayload:
        return payload.isNotEmpty;
    }
  }

  /// Whether [amount] (whole currency units) can be dispensed at [bank]'s ATM
  /// (or this instrument's default note set), i.e. composed as a non-negative
  /// integer combination of the note denominations.
  bool canDispenseAtmAmount(num amount, {BankSpec? bank}) =>
      _canDispense(amount, denominationsFor(bank));
}

/// A country/market specification. One market = one coordinator scope, one
/// wire platform (`y`) tag, one discovery identity. Its [instruments] map holds
/// the per-category flow parameters that used to be hardcoded on the market
/// itself.
///
/// Shared by the app (input validation, timers, currency labels) and the
/// coordinator (per-flow confirmation timeout). On the wire the payment code is
/// still carried under the historical `blik_code` field regardless of method.
@immutable
class PaymentSystem {
  /// Stable identifier used on the wire (`CoordinatorInfo.paymentSystem`,
  /// `Offer.paymentSystemId`) and in app preferences. Never rename existing
  /// ids. E.g. `blik`, `mbway`, `twint`, `sk`.
  final String id;

  /// User-facing market name, e.g. `BLIK`, `MB WAY`, `Slovensko`. Brand — not
  /// translated.
  final String label;

  /// App/product brand name for this market, e.g. `Bitblik`, `Bitway`. Used in
  /// UI copy that refers to the application itself (FAQ, tips, notifications).
  final String brandName;

  /// ISO 3166-1 alpha-2 country code, e.g. `PL`, `PT`, `SK`. Used as the i18n
  /// key for the localized country name.
  final String country;

  /// Country flag emoji, e.g. 🇵🇱, 🇵🇹.
  final String flag;

  /// Optional app asset path for the market's logo (e.g. `assets/bitway.png`).
  /// Shown instead of [flag] where available.
  final String? logoAsset;

  /// ISO currency code the market settles in, e.g. `PLN`, `EUR`.
  final String currency;

  /// Display symbol for [currency], e.g. `zł`, `€`.
  final String currencySymbol;

  /// The project's Nostr identity (hex pubkey) whose NIP-65 defines this
  /// market's **discovery relays** and against which coordinator
  /// advertisements are resolved. Stored as hex.
  final String discoveryPubkeyHex;

  /// Value carried on the wire under the NIP-69 `y` (platform) tag and used by
  /// clients as the `#y` subscription filter, so a market only receives its own
  /// offers and status updates. An explicit, **wire-frozen** identifier —
  /// independent of both [id] (coordinator/currency logic) and [brandName]
  /// (display only). For the ASCII-clean legacy markets it happens to equal the
  /// brand (`Bitblik`, `Bitway`, `Bittwint`); SK's brand `Bitvýber` carries a
  /// diacritic, so its tag is the ASCII `Bitvyber`. Never change an existing
  /// market's tag or older peers become invisible to this filter.
  final String platformTag;

  /// Per-category payment instruments. The map keys are the categories this
  /// market supports.
  final Map<OfferCategory, InstrumentSpec> instruments;

  const PaymentSystem({
    required this.id,
    required this.label,
    required this.brandName,
    required this.country,
    required this.flag,
    required this.currency,
    required this.currencySymbol,
    required this.platformTag,
    required this.instruments,
    this.logoAsset,
    this.discoveryPubkeyHex = kBitblikPubkeyHex,
  });

  /// The discovery identity as an `npub`, derived from [discoveryPubkeyHex].
  String get discoveryNpub => Nip19.encodePubKey(discoveryPubkeyHex);

  /// Categories this market supports (the instrument map keys).
  List<OfferCategory> get supportedCategories => instruments.keys.toList();

  /// Whether this market offers a choice of category (vs a single forced one).
  bool get hasCategoryChoice => instruments.length > 1;

  /// The instrument for [category]; falls back to the sole instrument when the
  /// market has exactly one (so category-unaware callers keep working).
  InstrumentSpec? instrumentFor(OfferCategory? category) {
    if (category != null) {
      final direct = instruments[category];
      if (direct != null) return direct;
    }
    if (instruments.length == 1) return instruments.values.first;
    return null;
  }

  /// The market's primary (first) instrument, backing the market-level
  /// convenience accessors below.
  InstrumentSpec get _primary => instruments.values.first;

  /// The bank the code accessors resolve against — the first bank of the
  /// primary instrument, or null when bank-agnostic.
  BankSpec? get _primaryBank =>
      _primary.banks.isEmpty ? null : _primary.banks.first;

  // ─── market-level convenience accessors ─────────────────────────────────
  // These read the primary instrument and are well-defined only for attributes
  // a market's instruments/banks share (true for all current markets). For
  // anything that legitimately varies per bank — validity window, ATM presets/
  // denominations/map URL, and (in principle) code length — resolve from the
  // offer instead: instrumentForOffer / bankForOffer / validityForOffer.

  /// Code length of the primary instrument (its default; ignores per-bank
  /// overrides). `0` for QR instruments. Prefer `instrument.codeLengthFor(bank)`
  /// when an offer's bank is known.
  int get codeLength => _primary.codeLengthFor(_primaryBank) ?? 0;

  /// Payment-code brand name for UI (e.g. `BLIK`, `MB WAY`), or null.
  String? get codeName => _primary.codeName;

  /// Payment-code term for UI text; neutral `'code'` when [codeName] is unset.
  String get codeLabel => _primary.codeLabel;

  /// Whether the taker confirms the code in their banking app (instrument-level;
  /// uniform across a market's banks).
  bool get requiresCodeConfirmation => _primary.requiresCodeConfirmation;

  /// Whether the maker supplies the code upfront at offer creation (TWINT).
  bool get makerProvidesCodeAtOfferCreation => _primary.makerProvidesCode;

  /// The primary instrument's flow id — the flow this market's coordinator/
  /// client loads (current markets have one flow across their categories).
  String get flowId => _primary.flowId;

  /// Whether [code] is valid for the primary instrument (its default length).
  /// Prefer `instrument.validate(code, bank: bank)` when a bank is known.
  bool isValidCode(String code) => _primary.validate(code, bank: _primaryBank);

  @override
  bool operator ==(Object other) =>
      identical(this, other) || (other is PaymentSystem && other.id == id);

  @override
  int get hashCode => id.hashCode;
}

/// Whether [amount] (whole units) is a non-negative integer combination of
/// [denominations]. Non-integer/non-positive amounts are rejected. With no
/// denominations, any positive whole amount is accepted.
bool _canDispense(num amount, List<int> denominations) {
  if (amount <= 0) return false;
  if (amount != amount.truncateToDouble()) return false;
  final target = amount.toInt();
  final denoms = denominations.where((d) => d > 0).toList(growable: false);
  if (denoms.isEmpty) return true;

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

int _gcd(int a, int b) {
  a = a.abs();
  b = b.abs();
  while (b != 0) {
    final t = b;
    b = a % b;
    a = t;
  }
  return a == 0 ? 1 : a;
}

/// Poland — BLIK. 6-digit code, ~2 min validity (matches the legacy 120s
/// window). Bank-agnostic; supports shop, ATM and online.
const PaymentSystem kBlik = PaymentSystem(
  id: 'blik',
  label: 'BLIK',
  brandName: 'Bitblik',
  platformTag: 'Bitblik',
  country: 'PL',
  flag: '🇵🇱',
  currency: 'PLN',
  currencySymbol: 'zł',
  instruments: {
    OfferCategory.shop: _blikInstrument,
    OfferCategory.atm: _blikInstrument,
    OfferCategory.online: _blikInstrument,
  },
);

const InstrumentSpec _blikInstrument = InstrumentSpec(
  kind: InstrumentKind.numericCode,
  direction: InstrumentDirection.takerProvides,
  flowId: 'blik',
  validity: Duration(minutes: 2),
  codeLength: 6,
  codeName: 'BLIK',
  atmPresetAmounts: [50, 100, 200, 300, 500],
  atmBanknoteDenominations: [10, 20, 50, 100, 200, 500],
);

/// Portugal — MB WAY ATM payout. 10-digit code, 30 min validity. ATM only,
/// pull-style (nothing for the taker to confirm).
const PaymentSystem kMbway = PaymentSystem(
  id: 'mbway',
  label: 'MBway',
  brandName: 'Bitway',
  platformTag: 'Bitway',
  logoAsset: 'assets/bitway.png',
  country: 'PT',
  flag: '🇵🇹',
  currency: 'EUR',
  currencySymbol: '€',
  discoveryPubkeyHex: kBitwayPubkeyHex,
  instruments: {
    OfferCategory.atm: InstrumentSpec(
      kind: InstrumentKind.numericCode,
      direction: InstrumentDirection.takerProvides,
      flowId: 'mbway',
      validity: Duration(minutes: 30),
      codeLength: 10,
      codeName: 'MB WAY',
      requiresCodeConfirmation: false,
      atmPresetAmounts: [20, 50, 100, 150, 200, 250],
      atmBanknoteDenominations: [20, 50, 100, 200],
    ),
  },
);

/// Switzerland — TWINT. The maker creates a 5-digit code upfront; the taker
/// enters it in the TWINT app after taking the offer. Generic engine.
const PaymentSystem kTwint = PaymentSystem(
  id: 'twint',
  label: 'TWINT',
  brandName: 'Bittwint',
  platformTag: 'Bittwint',
  logoAsset: 'assets/bittwint.png',
  country: 'CH',
  flag: '🇨🇭',
  currency: 'CHF',
  currencySymbol: 'CHF',
  discoveryPubkeyHex: kTwintPubkeyHex,
  instruments: {
    OfferCategory.online: _twintInstrument,
  },
);

const InstrumentSpec _twintInstrument = InstrumentSpec(
  kind: InstrumentKind.numericCode,
  direction: InstrumentDirection.makerProvides,
  flowId: 'twint',
  validity: Duration(minutes: 5),
  codeLength: 5,
  codeName: 'TWINT',
);

/// Slovakia — cardless ATM withdrawal across Tatra banka, Slovenská sporiteľňa
/// and VÚB. One market, one coordinator scope, one wire tag (`Bitvyber`); the
/// bank is chosen by the maker per offer and carried in `Offer.bankId`. The
/// three banks differ only in code validity and ATM note set — one flow serves
/// all of them.
const PaymentSystem kSlovakia = PaymentSystem(
  id: 'sk',
  label: 'Slovensko',
  brandName: 'Bitvýber',
  platformTag: 'Bitvyber',
  country: 'SK',
  flag: '🇸🇰',
  currency: 'EUR',
  currencySymbol: '€',
  instruments: {
    OfferCategory.atm: InstrumentSpec(
      kind: InstrumentKind.numericCode,
      direction: InstrumentDirection.takerProvides,
      flowId: 'sk_atm',
      // Bank-scoped code validity resolves through $code_validity in sk_atm.yml;
      // this default is the fallback when an offer has no (known) bank.
      validity: Duration(minutes: 15),
      codeLength: 6,
      requiresCodeConfirmation: false,
      // Shared across all SK banks (10 EUR floor). The banks below intentionally
      // do NOT override atmBanknoteDenominations or atmPresetAmounts, so both
      // dispensability and the quick-pick chips are identical for Tatra / SLSP /
      // VÚB — starting at the 10 EUR note.
      atmBanknoteDenominations: [10, 20, 50, 100],
      atmPresetAmounts: [10, 20, 50, 100, 200],
      banks: [
        BankSpec(
          id: 'tatrabanka',
          label: 'Tatra banka',
          validity: Duration(minutes: 20),
          atmMapUrl: 'https://www.google.com/maps/search/Tatra+banka+bankomat',
        ),
        BankSpec(
          id: 'slsp',
          label: 'Slovenská sporiteľňa',
          validity: Duration(minutes: 15),
          atmMapUrl:
              'https://www.google.com/maps/search/Slovenska+sporitelna+bankomat',
        ),
        BankSpec(
          id: 'vub',
          label: 'VÚB banka',
          // VÚB Mobil Banking asks the code holder to set a "Doba platnosti"
          // anywhere from 10 to 60 minutes, so 10 is the shortest window a VÚB
          // code can have — and the only one every code is guaranteed to have,
          // since the coordinator never learns what the taker picked. Older
          // material (and this comment before it) quoted a flat 3 minutes,
          // which no longer matches the app.
          validity: Duration(minutes: 10),
          atmMapUrl: 'https://www.google.com/maps/search/VUB+banka+bankomat',
        ),
      ],
    ),
  },
);

/// All supported markets. Add a market by appending here.
///
/// Slovakia is appended **after** [kMbway] so the currency→market fallback
/// ([paymentSystemForCurrency]) keeps resolving EUR to MB WAY for legacy
/// coordinators that don't advertise a `payment_system` id.
const List<PaymentSystem> kPaymentSystems = [
  kBlik,
  kMbway,
  kTwint,
  kSlovakia,
];

/// Legacy per-bank market ids that collapsed into the single [kSlovakia]
/// market. Offers/coordinators that still send these resolve to `sk`.
const Map<String, String> _legacyMarketIdAliases = {
  'tatrabanka': 'sk',
  'slsp': 'sk',
  'vub': 'sk',
};

/// Resolve a market by [id]; maps legacy SK per-bank ids to `sk` and falls back
/// to [kBlik] for unknown/null ids so older peers keep working.
PaymentSystem paymentSystemById(String? id) {
  if (id == null) return kBlik;
  final canonical = _legacyMarketIdAliases[id] ?? id;
  for (final m in kPaymentSystems) {
    if (m.id == canonical) return m;
  }
  return kBlik;
}

/// Resolve the market that settles in [currency]. Ambiguous once several
/// markets share a currency: EUR maps to the first EUR entry ([kMbway]) because
/// Slovakia is appended after it. Prefer [paymentSystemForOffer] when an
/// [Offer] is in hand. Returns null if no market matches.
PaymentSystem? paymentSystemForCurrency(String? currency) {
  if (currency == null) return null;
  final upper = currency.toUpperCase();
  for (final m in kPaymentSystems) {
    if (m.currency == upper) return m;
  }
  return null;
}

/// Resolve the market whose wire platform tag (`y`) equals [tag], e.g.
/// `Bitvyber` → [kSlovakia]. Returns null for unknown tags.
PaymentSystem? paymentSystemForPlatformTag(String? tag) {
  if (tag == null || tag.isEmpty) return null;
  for (final m in kPaymentSystems) {
    if (m.platformTag == tag) return m;
  }
  return null;
}

/// Resolve the market for [offer]. Prefers the offer's explicit
/// [Offer.paymentSystemId] (unambiguous even when markets share a currency),
/// falling back to the currency mapping for legacy offers. Never null —
/// defaults to [kBlik] via [paymentSystemById].
PaymentSystem paymentSystemForOffer(Offer offer) {
  final id = offer.paymentSystemId;
  if (id != null && id.isNotEmpty) return paymentSystemById(id);
  return paymentSystemForCurrency(offer.fiatCurrency) ?? kBlik;
}

/// The [InstrumentSpec] driving [offer] (its market + category). Null only when
/// the market genuinely has no instrument for the offer's category.
InstrumentSpec? instrumentForOffer(Offer offer) =>
    paymentSystemForOffer(offer).instrumentFor(offer.category);

/// The [BankSpec] for [offer] (its instrument + [Offer.bankId]), or null when
/// the instrument is bank-agnostic or the id is unknown/absent.
BankSpec? bankForOffer(Offer offer) =>
    instrumentForOffer(offer)?.bankById(offer.bankId);

/// The effective validity window for [offer] — the offer's bank override, else
/// the instrument default. Falls back to [kBlik]'s window when the market has
/// no instrument for the category (should not happen for real offers).
Duration validityForOffer(Offer offer) {
  final instrument = instrumentForOffer(offer);
  if (instrument == null) return _blikInstrument.validity;
  return instrument.validityFor(instrument.bankById(offer.bankId));
}
