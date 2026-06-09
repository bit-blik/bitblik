import 'package:bitblik_core/core.dart';

import '../../i18n/gen/strings.g.dart';

/// Localized label for an [OfferStatus]. [code] is the active payment system's
/// code term (e.g. `BLIK`, `MB WAY`) injected into the code-related statuses.
String offerStatusLabel(
  Translations t,
  OfferStatus status, {
  required String code,
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
      return t.offers.status.unknownStatus;
  }
}

/// Code term for an offer, resolved from its currency, falling back to [kBlik].
String offerCodeLabel(Offer offer) =>
    (paymentSystemForCurrency(offer.fiatCurrency) ?? kBlik).codeLabel;
