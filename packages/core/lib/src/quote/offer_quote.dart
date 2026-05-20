/// Pure fee math for Bitblik offers.
///
/// Single source of truth for how maker/taker fees are computed from a
/// coordinator's advertised percentages. Used by `coordinator` (authoritative
/// computation when creating offers and paying out), by `app` (UI estimates),
/// and by `cli` (parity with the app's flow).
///
/// All percentages are interpreted as `0..100`, not `0..1`. Fee amounts are
/// rounded up (`ceil`) — the coordinator must never under-collect fees, and
/// clients must show the same rounded number so the displayed net matches
/// what is actually paid out.
class OfferQuote {
  OfferQuote._();

  /// Coordinator fee charged to the maker, in sats:
  /// `ceil(amountSats * makerFeePercent / 100)`.
  static int makerFeeSats(int amountSats, double makerFeePercent) {
    return (amountSats * makerFeePercent / 100).ceil();
  }

  /// Coordinator fee charged to the taker, in sats:
  /// `ceil(amountSats * takerFeePercent / 100)`.
  static int takerFeeSats(int amountSats, double takerFeePercent) {
    return (amountSats * takerFeePercent / 100).ceil();
  }

  /// Net sats delivered to the taker after fee deduction.
  static int takerNetSats(int amountSats, double takerFeePercent) {
    return amountSats - takerFeeSats(amountSats, takerFeePercent);
  }
}
