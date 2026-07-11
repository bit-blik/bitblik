part of '../../coordinator_service.dart';

/// Broadcast the newly funded offer to external notification channels.
///
/// Post-commit only: the offer is already in the entered state, and failures
/// must not roll it back.
class SendOfferNotificationsAction extends FlowAction {
  @override
  String get name => 'send_offer_notifications';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    await flow._c._sendOfferNotifications(ctx.offer);
  }
}
