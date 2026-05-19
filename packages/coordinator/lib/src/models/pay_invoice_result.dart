/// Result of paying an invoice.
class PayInvoiceResult {
  final String? paymentPreimage; // Hex-encoded preimage if successful
  final String? paymentError; // Error message if payment failed
  final int? feeSat; // Fees paid in satoshis, if available

  PayInvoiceResult({this.paymentPreimage, this.paymentError, this.feeSat});

  bool get isSuccess => paymentError == null && paymentPreimage != null;

  @override
  String toString() {
    return 'PayInvoiceResult(paymentPreimage: $paymentPreimage, paymentError: $paymentError, feeSat: $feeSat)';
  }
}
