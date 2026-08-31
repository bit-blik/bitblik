part of '../../coordinator_service.dart';

/// Broadcast the newly funded offer to external notification channels.
///
/// Post-commit only: the offer is already in the entered state, and failures
/// must not roll it back.
///
/// Announces an offer only on its FIRST entry into `funded`. A later
/// re-entry (a taker cancelling or timing out back to `funded`) is a re-list,
/// not a new offer: production showed 42 re-entries since 2026-08-10 firing a
/// duplicate "New offer" message, often for an offer that expired in the same
/// second the re-list fired. The kind-38383 relay event still republishes on
/// every state change, so takers keep seeing the offer without this repeat
/// chat message.
class SendOfferNotificationsAction extends FlowAction {
  @override
  String get name => 'send_offer_notifications';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final c = flow._c;
    final history = await c._dbService.getOfferStateHistory(ctx.offer.id);
    final fundedEntryCount =
        history.where((row) => row['to_state'] == 'funded').length;
    if (fundedEntryCount > 1) {
      AppLogger.info(
          'Skipping new-offer notification for ${ctx.offer.id}: re-list '
          '(funded entry #$fundedEntryCount)',
          offerId: ctx.offer.id);
      return;
    }
    await c._sendOfferNotifications(ctx.offer);
  }
}
