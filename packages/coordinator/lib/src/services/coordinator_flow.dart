part of 'coordinator_service.dart';

/// Strategy for a single offer flow.
///
/// The [CoordinatorService] owns the shared services (DB, payment backend,
/// notifications, Lightning payout tail, status broadcast). Each [OfferFlow]
/// implementation drives the offer state machine for one FLOW_MODE: the
/// yaml-driven [GenericOfferFlow] or the hardcoded [LegacyEnumOfferFlow].
///
/// To drop the legacy enum flow entirely: delete `coordinator_flow_legacy.dart`,
/// remove its `part` directive in `coordinator_service.dart`, and remove the
/// `else` branch that constructs [LegacyEnumOfferFlow] in
/// [CoordinatorService.init].
abstract class OfferFlow {
  /// True when [method] is an offer-action RPC this flow enforces directly.
  /// Shared query/info/payout RPCs (get_info, get_offer_details,
  /// update_taker_invoice, …) return false and are handled by the coordinator.
  bool handlesRpc(String method);

  /// Enforce + apply an offer-action RPC, returning the wire response payload.
  /// Throws on a disallowed transition / identity mismatch.
  Future<Map<String, dynamic>> handleRpc(
      String method, Map<String, dynamic> params, String userPubkey,
      {String? clientVersion});

  /// Arm timer(s) for an offer that has just entered the funded state.
  void onOfferFunded(Offer offer);

  /// Re-arm timers / run expiry sweeps for live offers on coordinator startup.
  Future<void> recoverTimers();
}
