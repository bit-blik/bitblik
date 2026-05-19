import 'invoice_status.dart';

class InvoiceDetails {
  final String? type; // "incoming" or "outgoing"
  final String? invoice; // BOLT11 invoice string, optional
  final String? description;
  final String? descriptionHash;
  final String? preimage; // Optional if unpaid
  final String paymentHash;
  final int? amountMsat; // Value in msats
  final int? feesPaidMsat; // Value in msats
  final int? createdAt; // Unix timestamp
  final int? expiresAt; // Unix timestamp, optional
  final int? settledAt; // Unix timestamp, optional if unpaid
  final Map<String, dynamic>? metadata;
  final InvoiceStatus? status; // Use enum instead of String
  final String? error; // To convey any lookup errors

  InvoiceDetails({
    this.type,
    this.invoice,
    this.description,
    this.descriptionHash,
    this.preimage,
    required this.paymentHash,
    this.amountMsat,
    this.feesPaidMsat,
    this.createdAt,
    this.expiresAt,
    this.settledAt,
    this.metadata,
    this.status,
    this.error,
  });

  // Consider adding a factory constructor fromMap if needed, or toJson
}
