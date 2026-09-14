import 'dart:async';
import 'package:bitblik_core/core.dart';

enum ChargeReportResult { confirmed, pending, statusUpdated }

/// A transport timeout cannot distinguish an undelivered request from a lost
/// reply. Reconcile first; retry only after a fresh, still-reportable status.
Future<ChargeReportResult> reportTakerCharged({
  required Future<void> Function() send,
  required Future<Offer?> Function() refresh,
  bool checkBeforeSending = false,
}) async {
  Future<Offer?> checkStatus() async {
    try {
      return await refresh();
    } catch (_) {
      return null;
    }
  }

  if (checkBeforeSending) {
    final current = await checkStatus();
    if (current == null) return ChargeReportResult.pending;
    if (current.status == OfferStatus.takerCharged) {
      return ChargeReportResult.confirmed;
    }
    if (current.status != OfferStatus.expiredSentBlik) {
      return ChargeReportResult.statusUpdated;
    }
  }
  try {
    await send();
  } on TimeoutException {
    final current = await checkStatus();
    return current?.status == OfferStatus.takerCharged
        ? ChargeReportResult.confirmed
        : ChargeReportResult.pending;
  }
  // Successful RPC confirms receipt even if the status fetch is unavailable.
  await checkStatus();
  return ChargeReportResult.confirmed;
}
