class Bolt12OfferInfo {
  final String normalized;
  final String offerId;
  final String network;
  final int? amountMsat;
  final bool isExpired;
  final bool isVariableAmount;
  final int? quantityMax;

  const Bolt12OfferInfo({
    required this.normalized,
    required this.offerId,
    required this.network,
    required this.amountMsat,
    required this.isExpired,
    required this.isVariableAmount,
    this.quantityMax,
  });
}
