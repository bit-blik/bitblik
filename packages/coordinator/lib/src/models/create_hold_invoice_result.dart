/// Result of creating a hold invoice.
class CreateHoldInvoiceResult {
  final String invoice; // BOLT11 invoice string
  final String
      paymentHash; // Hex-encoded payment hash (could be different from input for NWC)

  CreateHoldInvoiceResult({required this.invoice, required this.paymentHash});

  @override
  String toString() {
    return 'CreateHoldInvoiceResult(invoice: $invoice, paymentHash: $paymentHash)';
  }
}
