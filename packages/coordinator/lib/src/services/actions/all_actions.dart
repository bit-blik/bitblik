part of '../coordinator_service.dart';

/// Every [FlowAction] implementation, one instance per action file under
/// `services/actions/`. This list is the single compile-time anchor Dart
/// needs (AOT has no reflection to discover subclasses); each action is
/// otherwise fully self-describing — it declares its own yml keyword
/// ([FlowAction.name]). The registry itself is built from this list at startup
/// with duplicate-name detection, and flow validation exits the coordinator if
/// a yml references an action not present here.
final List<FlowAction> allFlowActions = [
  AcceptTakerInvoiceAction(),
  AssertAssignedTakerAction(),
  CancelHoldInvoiceAction(),
  CancelReservationAction(),
  ClearTakerFieldsAction(),
  RefundMakerAction(),
  RequireMakerRefundInvoiceAction(),
  ResolveTakerInvoiceAction(),
  ReserveTakerAction(),
  SendOfferNotificationsAction(),
  SendPaymentAction(),
  SettleOfferFundsAction(),
  StampCodeReceivedAtAction(),
  StampMakerConfirmedAtAction(),
  StampReservedAtAction(),
  StampTakerChargedAtAction(),
  UpdateTakerInvoiceAction(),
  ValidateCodeAction(),
  NotifyMakerOfChargeAction(),
  SendTwintCodeToTakerAction(),
  SetNewCodeAction(),
];
