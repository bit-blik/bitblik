import 'package:bitblik_core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../i18n/gen/strings.g.dart';
import '../utils/offer_status_label.dart';
import '../providers/providers.dart';
import '../utils/category_icons.dart';
import '../utils/locale_format.dart';
import 'premium_info.dart';

class OfferListTile extends ConsumerWidget {
  const OfferListTile({
    required this.offer,
    required this.onTap,
    this.showNeko = false,
    this.showPremium = false,
    super.key,
  });

  final Offer offer;
  final VoidCallback onTap;
  final bool showNeko;

  /// When true, show a `+X%` premium badge next to the amount. Opt-in so the
  /// public offers list stays unchanged; used by the user's own offers list.
  final bool showPremium;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final apiService = ref.watch(apiServiceProvider);
    final myPubkey = ref.watch(keyServiceProvider).publicKeyHex;
    final coordinatorInfo = apiService.getCoordinatorInfoByPubkey(
      offer.coordinatorPubkey,
    );
    final coordinatorName =
        coordinatorInfo?.name ?? t.myOffers.unknownCoordinator;
    final localeTag = effectiveFormatLocale(context);

    final fiatLabel = NumberFormat.decimalPattern(
      localeTag,
    ).format(offer.fiatAmount);
    final dateLabel = formatLocalizedDateTime(context, offer.createdAt);

    final statusLabel = offerStatusLabel(
      t,
      offer.status,
      code: offerCodeLabel(offer),
      statusRaw: offer.statusRaw,
    );
    final statusColor = _statusColor(offer.status);

    final isMaker = myPubkey != null && offer.makerPubkey == myPubkey;
    final isTaker = myPubkey != null && offer.takerPubkey == myPubkey;
    final premiumViewerRole =
        isTaker ? PremiumViewerRole.taker : PremiumViewerRole.maker;
    final roleLabel = isMaker
        ? t.myOffers.details.maker
        : isTaker
        ? t.myOffers.details.taker
        : null;
    // Use the user's own pubkey as the neko seed when their role is known.
    final nekoPubkey = isMaker
        ? offer.makerPubkey
        : isTaker
        ? offer.takerPubkey!
        : offer.makerPubkey;
    final showNekoAvatar = isMaker || isTaker || showNeko;

    final Widget statusLeading =
        showNekoAvatar
            ? SizedBox(
              width: 40,
              height: 40,
              child: Stack(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://robohash.org/$nekoPubkey?set=set4',
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                      placeholder:
                          (_, __) => CircleAvatar(
                            backgroundColor: statusColor.withValues(alpha: 0.15),
                            child: Icon(
                              _statusIcon(offer.status),
                              color: statusColor,
                              size: 20,
                            ),
                          ),
                      errorWidget:
                          (_, __, ___) => CircleAvatar(
                            backgroundColor: statusColor.withValues(alpha: 0.15),
                            child: Icon(
                              _statusIcon(offer.status),
                              color: statusColor,
                              size: 20,
                            ),
                          ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 16,
                      height: 16,
                      decoration: BoxDecoration(
                        color: statusColor,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1.5),
                      ),
                      child: Icon(
                        _statusIcon(offer.status),
                        color: Colors.white,
                        size: 9,
                      ),
                    ),
                  ),
                ],
              ),
            )
            : CircleAvatar(
              backgroundColor: statusColor.withValues(alpha: 0.15),
              child: Icon(_statusIcon(offer.status), color: statusColor, size: 20),
            );

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (offer.category != null) ...[
              categoryIconWidget(offer.category, 28),
              const SizedBox(width: 12),
            ],
            statusLeading,
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        '$fiatLabel ${offer.fiatCurrency}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                      if (showPremium && offer.premiumPercent > 0) ...[
                        const SizedBox(width: 6),
                        PremiumChip(
                          premiumPercent: offer.premiumPercent,
                          viewerRole: premiumViewerRole,
                        ),
                      ],
                      if (roleLabel != null) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 5,
                            vertical: 1,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade400,
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            roleLabel,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 1,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          statusLabel,
                          style: TextStyle(
                            color: statusColor,
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          coordinatorName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(
                    dateLabel,
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  IconData _statusIcon(OfferStatus status) {
    switch (status) {
      case OfferStatus.takerPaid:
      case OfferStatus.settled:
      case OfferStatus.makerConfirmed:
        return Icons.check_circle;
      case OfferStatus.cancelled:
      case OfferStatus.expired:
      case OfferStatus.invalidBlik:
      case OfferStatus.takerPaymentFailed:
        return Icons.cancel;
      case OfferStatus.expiredBlik:
      case OfferStatus.expiredSentBlik:
      case OfferStatus.conflict:
      case OfferStatus.dispute:
        return Icons.warning_amber;
      case OfferStatus.funded:
      case OfferStatus.reserved:
      case OfferStatus.blikReceived:
      case OfferStatus.blikSentToMaker:
      case OfferStatus.takerCharged:
      case OfferStatus.payingTaker:
        return Icons.timelapse;
      case OfferStatus.created:
        return Icons.hourglass_empty;
      case OfferStatus.unknown:
        return Icons.help_outline;
    }
  }

  Color _statusColor(OfferStatus status) {
    switch (status) {
      case OfferStatus.takerPaid:
      case OfferStatus.settled:
      case OfferStatus.makerConfirmed:
        return Colors.green;
      case OfferStatus.cancelled:
      case OfferStatus.expired:
      case OfferStatus.invalidBlik:
      case OfferStatus.takerPaymentFailed:
        return Colors.redAccent;
      case OfferStatus.expiredBlik:
      case OfferStatus.expiredSentBlik:
      case OfferStatus.conflict:
      case OfferStatus.dispute:
        return Colors.orange;
      case OfferStatus.funded:
      case OfferStatus.reserved:
      case OfferStatus.blikReceived:
      case OfferStatus.blikSentToMaker:
      case OfferStatus.takerCharged:
      case OfferStatus.payingTaker:
        return Colors.blue;
      case OfferStatus.created:
      case OfferStatus.unknown:
        return Colors.grey;
    }
  }
}
