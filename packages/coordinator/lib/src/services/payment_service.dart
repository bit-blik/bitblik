import '../models/create_hold_invoice_result.dart';
import '../models/invoice_details.dart'; // Added import
import '../models/invoice_update.dart';
import '../models/pay_invoice_result.dart';

abstract class PaymentService {
  /// Connects to the payment backend.
  Future<void> connect();

  /// Disconnects from the payment backend.
  Future<void> disconnect();

  /// Creates a hold invoice.
  /// [amountSats]: The amount in satoshis for the invoice.
  /// [memo]: A description for the invoice.
  /// [paymentHashHex]: The hex-encoded SHA256 hash of the preimage.
  /// Returns a [CreateHoldInvoiceResult] containing the BOLT11 invoice string
  /// and the actual payment hash used by the backend (which might differ for NWC).
  Future<CreateHoldInvoiceResult> createHoldInvoice({
    required int amountSats,
    required String memo,
    required String paymentHashHex, // The client-generated payment hash
  });

  /// Settles a previously accepted hold invoice using its preimage.
  /// [preimageHex]: The hex-encoded preimage.
  Future<void> settleInvoice({required String preimageHex});

  /// Cancels a hold invoice.
  /// [paymentHashHex]: The hex-encoded payment hash of the invoice to cancel.
  Future<void> cancelInvoice({required String paymentHashHex});

  /// Pays a BOLT11 invoice.
  /// This method is for NWC which doesn't stream payment updates in the same way LND does.
  /// LND will use sendPaymentStream.
  /// [invoice]: The BOLT11 invoice string.
  /// [amountSat]: Optional, if the invoice doesn't have an amount, this specifies the amount to pay.
  /// [feeLimitSat]: Optional, the maximum fee in satoshis willing to be paid.
  Future<PayInvoiceResult> payInvoice({
    required String invoice,
    int? amountSat, // For zero-amount invoices
    int? feeLimitSat, // Max fee in satoshis
  });

  /// Subscribes to updates for a specific invoice identified by its payment hash.
  /// This is for the *maker's* hold invoice.
  /// [paymentHashHex]: The hex-encoded payment hash of the invoice.
  /// Should emit an [InvoiceUpdate] when the invoice state changes (e.g., ACCEPTED, CANCELED).
  Stream<InvoiceUpdate> subscribeToInvoiceUpdates(
      {required String paymentHashHex});

  /// Looks up an invoice by its payment hash.
  /// [paymentHashHex]: The hex-encoded payment hash of the invoice.
  /// Returns an [InvoiceDetails] object.
  Future<InvoiceDetails> lookupInvoice({required String paymentHashHex});
}
