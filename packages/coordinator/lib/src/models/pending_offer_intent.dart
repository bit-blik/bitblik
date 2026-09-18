/// Recovery material written before asking a wallet to create a hold invoice.
/// Contains the settlement preimage: never expose or log [data].
class PendingOfferIntent {
  final String paymentHash;
  final String paymentSystem;
  final Map<String, dynamic> data;
  final DateTime expiresAt;

  const PendingOfferIntent(
      {required this.paymentHash,
      required this.paymentSystem,
      required this.data,
      required this.expiresAt});
}
