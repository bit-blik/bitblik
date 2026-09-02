part of '../../coordinator_service.dart';

/// Backward-compatible action name for existing payout-retry flows. The
/// underlying implementation supports both BOLT11 and BOLT12 replacements.
class UpdateTakerInvoiceAction extends UpdateTakerPayoutAction {
  @override
  String get name => 'update_taker_invoice';
}
