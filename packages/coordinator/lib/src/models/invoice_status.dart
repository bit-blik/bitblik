/// Represents the status of an invoice.
enum InvoiceStatus {
  OPEN, // Invoice is open and waiting for payment.
  ACCEPTED, // Hold invoice HTLC is accepted (funded but not settled).
  SETTLED, // Invoice is fully paid and settled.
  CANCELED, // Invoice has been canceled.
  UNKNOWN, // Status cannot be determined.
}
