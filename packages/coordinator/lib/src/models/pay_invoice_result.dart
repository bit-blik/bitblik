import 'payment_status.dart';

/// Result of paying an invoice.
class PayInvoiceResult {
  final PaymentStatus status;
  final String? paymentId;
  final String? paymentPreimage; // Hex-encoded preimage if successful
  final String? paymentError; // Error message if payment failed
  final int? feeSat; // Fees paid in satoshis, if available

  PayInvoiceResult({
    PaymentStatus? status,
    this.paymentId,
    this.paymentPreimage,
    this.paymentError,
    this.feeSat,
  }) : status = status ??
            (paymentError != null
                ? PaymentStatus.FAILED
                : paymentPreimage != null
                    ? PaymentStatus.SUCCEEDED
                    : PaymentStatus.UNKNOWN);

  bool get isSuccess => status == PaymentStatus.SUCCEEDED;

  @override
  String toString() {
    return 'PayInvoiceResult(status: $status, paymentId: $paymentId, paymentError: $paymentError, feeSat: $feeSat)';
  }
}
