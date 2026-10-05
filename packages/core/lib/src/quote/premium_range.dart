/// Maker premium math and the range a coordinator allows.
///
/// A positive premium prices the offer above market: the maker locks fewer
/// sats for the same fiat amount. A negative premium is a discount: the maker
/// locks more sats for the same fiat amount, so the taker receives more sats
/// than at the market rate. `0` means market price.
///
/// All percentages are interpreted as `-100..100`, not `-1..1`.
class PremiumRange {
  /// Lowest premium (%) allowed. Negative means a discount is allowed.
  final double min;

  /// Highest premium (%) allowed.
  final double max;

  const PremiumRange._(this.min, this.max);

  /// No premium and no discount: only market price.
  static const PremiumRange none = PremiumRange._(0, 0);

  /// Builds a range from advertised or configured bounds, replacing anything
  /// unusable with market price:
  /// - a bound that is not finite or outside `(-100, 100)` becomes `0`;
  /// - when `min > max`, `min` falls back to `0` (no discount), and `max`
  ///   too if it is still below `min`.
  factory PremiumRange.sanitized({double min = 0, double max = 0}) {
    var lo = _isValidBound(min) ? min : 0.0;
    var hi = _isValidBound(max) ? max : 0.0;
    if (lo > hi) {
      lo = 0;
      if (hi < lo) hi = 0;
    }
    return PremiumRange._(lo, hi);
  }

  static bool _isValidBound(double value) =>
      value.isFinite && value > -100 && value < 100;

  /// Whether a maker can choose anything other than market price.
  bool get isOffered => min < 0 || max > 0;

  /// Whether a maker can set a discount (negative premium).
  bool get allowsDiscount => min < 0;

  /// Clamps [premiumPercent] into this range. Non-finite values become `0`
  /// before clamping.
  double clamp(double premiumPercent) {
    final value = premiumPercent.isFinite ? premiumPercent : 0.0;
    return value.clamp(min, max).toDouble();
  }

  /// Sats the maker locks for [marketSats] worth of fiat at
  /// [premiumPercent]: fewer with a premium, more with a discount.
  static int adjustedSats(int marketSats, double premiumPercent) {
    return (marketSats * (1 - premiumPercent / 100)).round();
  }

  @override
  bool operator ==(Object other) =>
      other is PremiumRange && other.min == min && other.max == max;

  @override
  int get hashCode => Object.hash(min, max);

  @override
  String toString() => 'PremiumRange($min..$max)';
}
