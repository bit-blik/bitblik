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

  /// Validate the loaded flow definition at startup (beyond the structural
  /// parse): unknown effects, timeout transitions without a duration, payout
  /// auto-wiring, nip69 values, etc. Throws on any inconsistency. No-op for
  /// flows that don't use a yaml definition.
  void validateDefinition() {}

  /// Arm timer(s) for an offer that has just entered the funded state.
  void onOfferFunded(Offer offer);

  /// Re-arm timers / run expiry sweeps for live offers on coordinator startup.
  Future<void> recoverTimers();

  /// Lightweight counts of long-lived flow-owned structures for memory
  /// diagnostics.
  Map<String, int> debugCounters();
}
