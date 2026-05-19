/// Represents the status of an outgoing payment.
enum PaymentStatus {
  PENDING, // Payment is in flight.
  SUCCEEDED, // Payment completed successfully.
  FAILED, // Payment failed.
  UNKNOWN, // Status cannot be determined.
}
