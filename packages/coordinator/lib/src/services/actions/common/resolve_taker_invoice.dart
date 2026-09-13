part of '../../coordinator_service.dart';

/// Backward-compatible action name for existing submit flows. The underlying
/// implementation supports both BOLT11 invoices and BOLT12 offers.
class ResolveTakerInvoiceAction extends ResolveTakerPayoutAction {
  @override
  String get name => 'resolve_taker_invoice';
}
