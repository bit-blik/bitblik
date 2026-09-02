part of '../../coordinator_service.dart';

/// Backward-compatible action name for existing dispute-resolution flows.
/// Validation supports both the legacy maker invoice and a typed BOLT12 offer.
class RequireMakerRefundInvoiceAction extends RequireMakerRefundPayoutAction {
  @override
  String get name => 'require_maker_refund_invoice';
}
