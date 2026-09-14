/// A provisionally supported Worldline-style shop QR payload.
///
/// This layout was inferred from a user-confirmed CHF 7.10 sample, not from a
/// published specification. Recognition is deliberately limited to this exact
/// 35-character structure. Real terminal/TWINT verification is a release gate.
class TwintShopQr {
  final String payload;
  final int amountCentimes;

  const TwintShopQr._(this.payload, this.amountCentimes);

  String get currency => 'CHF';
  String get amountText =>
      '${amountCentimes ~/ 100}.${(amountCentimes % 100).toString().padLeft(2, '0')}';

  static final _pattern = RegExp(r'^Q4SIX[A-Z0-9]{7}([0-9]{12})CHF[0-9]{8}$');

  /// Preserves every character; whitespace, case folding and URL extraction
  /// would change the payment artifact and are intentionally not performed.
  static TwintShopQr? tryParse(String payload) {
    if (payload.length != 35) return null;
    final match = _pattern.firstMatch(payload);
    if (match == null) return null;
    final centimes = int.parse(match.group(1)!);
    if (centimes <= 0) return null;
    return TwintShopQr._(payload, centimes);
  }

  bool matchesAmount(num amount) => chfCentimes(amount) == amountCentimes;
}

bool isValidTwintShopQr(String payload) =>
    TwintShopQr.tryParse(payload) != null;

/// Converts an exact decimal CHF amount to centimes without rounding. Values
/// with fractional centimes, non-finite values, and nonpositive amounts fail.
/// The upper bound matches the provisional payload's 12-digit amount field.
int? chfCentimes(num amount) {
  if (!amount.isFinite || amount <= 0) return null;
  final match =
      RegExp(r'^([0-9]+)(?:\.([0-9]{1,2}))?$').firstMatch(amount.toString());
  if (match == null) return null;
  final whole = int.tryParse(match.group(1)!);
  if (whole == null || whole > 9999999999) return null;
  final fraction = (match.group(2) ?? '').padRight(2, '0');
  final result = whole * 100 + int.parse(fraction);
  return result > 0 && result <= 999999999999 ? result : null;
}
