enum CancelInvoiceDisposition {
  cancelled,
  alreadyMissing,
}

class CancelInvoiceResult {
  final CancelInvoiceDisposition disposition;

  const CancelInvoiceResult._(this.disposition);

  const CancelInvoiceResult.cancelled()
      : this._(CancelInvoiceDisposition.cancelled);

  const CancelInvoiceResult.alreadyMissing()
      : this._(CancelInvoiceDisposition.alreadyMissing);

  bool get isCancelled => disposition == CancelInvoiceDisposition.cancelled;

  bool get isAlreadyMissing =>
      disposition == CancelInvoiceDisposition.alreadyMissing;
}
