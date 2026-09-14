import 'package:bitblik_core/core.dart';

/// Resolve a coordinator snapshot without erasing evidence of a taker's trade.
/// Null/foreign snapshots are inconclusive. Only a confirmed relist before the
/// maker had the code can remove a taker's local reservation.
Offer? reconcileOfferSnapshot(Offer local, Offer? remote, String? userPubkey) {
  if (remote == null || userPubkey == null || userPubkey.isEmpty) return local;
  final sameOffer =
      local.coordinatorPubkey == remote.coordinatorPubkey &&
      (local.id == remote.id ||
          (local.holdInvoicePaymentHash?.isNotEmpty == true &&
              local.holdInvoicePaymentHash == remote.holdInvoicePaymentHash));
  if (!sameOffer) return local;

  final takerOnly =
      local.takerPubkey == userPubkey && local.makerPubkey != userPubkey;
  final participates =
      remote.takerPubkey == userPubkey || remote.makerPubkey == userPubkey;
  if (takerOnly && (!participates || remote.status == OfferStatus.funded)) {
    const beforeCodeWasShared = {
      OfferStatus.reserved,
      OfferStatus.blikReceived,
      OfferStatus.expiredBlik,
    };
    if (!beforeCodeWasShared.contains(local.status)) return local;
    // Loss of ownership in another state is not proof of a harmless relist.
    return remote.status == OfferStatus.funded && !participates ? null : local;
  }
  // Participant RPCs omit the taker's code/invoice. Keep locally-held evidence
  // for the same taker, and keep the client-only wallet selection.
  return remote.copyWith(
    paymentWalletId: local.paymentWalletId,
    blikCode: takerOnly ? remote.blikCode ?? local.blikCode : remote.blikCode,
    takerInvoice: takerOnly
        ? remote.takerInvoice ?? local.takerInvoice
        : remote.takerInvoice,
  );
}
