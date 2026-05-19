import 'invoice_status.dart';

/// Represents an update for a subscribed invoice.
class InvoiceUpdate {
  final String paymentHash; // Hex-encoded payment hash
  final InvoiceStatus status;
  final int? amountPaidSat; // Amount paid in satoshis, if applicable

  InvoiceUpdate({
    required this.paymentHash,
    required this.status,
    this.amountPaidSat,
  });

  @override
  String toString() {
    return 'InvoiceUpdate(paymentHash: $paymentHash, status: $status, amountPaidSat: $amountPaidSat)';
  }
}
