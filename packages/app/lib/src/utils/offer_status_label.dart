import 'package:bitblik_core/core.dart';

import '../../i18n/gen/strings.g.dart';

/// `takerCharged` -> `Taker Charged`, `invalidTwint` -> `Invalid Twint`, ...
String humanizeFlowState(String state) {
  final humanized = state
      .replaceAllMapped(RegExp('([A-Z])'), (m) => ' ${m[1]}')
      .replaceAll('_', ' ')
      .trim();
  return humanized.isEmpty
      ? state
      : '${humanized[0].toUpperCase()}${humanized.substring(1)}';
}

/// Localized label for an [OfferStatus]. [code] is the active payment system's
/// code term (e.g. `BLIK`, `MB WAY`) injected into the code-related statuses.
/// [statusRaw] recovers generic (yaml-driven) flow states that parse to the
/// enum's `unknown` (e.g. `invalidTwint`) — they render humanized instead of
/// "Unknown".
String offerStatusLabel(
  Translations t,
  OfferStatus status, {
  required String code,
  String? statusRaw,
}) {
  switch (status) {
    case OfferStatus.created:
      return t.offers.status.created;
    case OfferStatus.funded:
      return t.offers.status.funded;
    case OfferStatus.expired:
      return t.offers.status.expired;
    case OfferStatus.cancelled:
      return t.offers.status.cancelled;
    case OfferStatus.reserved:
      return t.offers.status.reserved;
    case OfferStatus.blikReceived:
      return t.offers.status.blikReceived(code: code);
    case OfferStatus.blikSentToMaker:
      return t.offers.status.blikSentToMaker(code: code);
    case OfferStatus.expiredBlik:
      return t.offers.status.expiredBlik(code: code);
    case OfferStatus.expiredSentBlik:
      return t.offers.status.expiredSentBlik(code: code);
    case OfferStatus.takerCharged:
      return t.offers.status.takerCharged;
    case OfferStatus.invalidBlik:
      return t.offers.status.invalidBlik(code: code);
    case OfferStatus.conflict:
      return t.offers.status.conflict;
    case OfferStatus.dispute:
      return t.offers.status.dispute;
    case OfferStatus.makerConfirmed:
      return t.offers.status.makerConfirmed;
    case OfferStatus.settled:
      return t.offers.status.settled;
    case OfferStatus.payingTaker:
      return t.offers.status.payingTaker;
    case OfferStatus.takerPaymentFailed:
      return t.offers.status.takerPaymentFailed;
    case OfferStatus.takerPaid:
      return t.offers.status.takerPaid;
    case OfferStatus.unknown:
      if (statusRaw != null &&
          statusRaw.isNotEmpty &&
          statusRaw != OfferStatus.unknown.name) {
        return humanizeFlowState(statusRaw);
      }
      return t.offers.status.unknownStatus;
  }
}

/// Code term for an offer, resolved from its currency, falling back to [kBlik].
String offerCodeLabel(Offer offer) =>
    (paymentSystemForCurrency(offer.fiatCurrency) ?? kBlik).codeLabel;
