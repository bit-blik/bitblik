part of '../../coordinator_service.dart';

/// Backward-compatible action name for flows created before typed payout
/// instructions were introduced. It now accepts either BOLT11 or BOLT12.
class AcceptTakerInvoiceAction extends AcceptTakerPayoutAction {
  @override
  String get name => 'accept_taker_invoice';
}
