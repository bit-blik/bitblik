import 'payment_status.dart';

/// Represents an update for a subscribed outgoing payment.
class PaymentUpdate {
  final String
      paymentHash; // Hex-encoded payment hash of the invoice being paid
  final PaymentStatus status;
  final String? preimage; // Hex-encoded preimage if payment succeeded
  final int? feeSat; // Fee paid in satoshis, if applicable
  final String? failureReason; // Reason for failure, if applicable

  PaymentUpdate({
    required this.paymentHash,
    required this.status,
    this.preimage,
    this.feeSat,
    this.failureReason,
  });

  @override
  String toString() {
    return 'PaymentUpdate(paymentHash: $paymentHash, status: $status, preimage: $preimage, feeSat: $feeSat, failureReason: $failureReason)';
  }
}
