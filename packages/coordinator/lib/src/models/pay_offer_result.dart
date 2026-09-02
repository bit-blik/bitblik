import 'payment_status.dart';

class PayOfferResult {
  final PaymentStatus status;
  final String? paymentId;
  final String? paymentPreimage;
  final String? payerProof;
  final String? paymentError;
  final int? feeSat;

  const PayOfferResult({
    required this.status,
    this.paymentId,
    this.paymentPreimage,
    this.payerProof,
    this.paymentError,
    this.feeSat,
  });

  bool get isSuccess => status == PaymentStatus.SUCCEEDED;
}
