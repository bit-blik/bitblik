/// Durable, maker-scoped identity for one invoice-creation attempt.
/// Retained after pending intent cleanup so an old request cannot create again.
class OfferInitiationReceipt {
  final String fingerprint;
  final String paymentHash;
  final Map<String, dynamic> quote;
  final String? holdInvoice;

  const OfferInitiationReceipt({
    required this.fingerprint,
    required this.paymentHash,
    required this.quote,
    this.holdInvoice,
  });

  Map<String, dynamic>? get result => holdInvoice == null
      ? null
      : {...quote, 'paymentHash': paymentHash, 'holdInvoice': holdInvoice};
}

class OfferInitiationException implements Exception {
  final String code;
  final String message;
  const OfferInitiationException(this.code, this.message);

  @override
  String toString() => message;
}
