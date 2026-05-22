import 'package:bitblik_core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';

class OfferListTile extends ConsumerWidget {
  const OfferListTile({
    required this.offer,
    required this.onTap,
    this.showNeko = false,
    super.key,
  });

  final Offer offer;
  final VoidCallback onTap;
  final bool showNeko;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final apiService = ref.watch(apiServiceProvider);
    final coordinatorInfo =
        apiService.getCoordinatorInfoByPubkey(offer.coordinatorPubkey);
    final coordinatorName =
        coordinatorInfo?.name ?? t.myOffers.unknownCoordinator;

    final fiatLabel = NumberFormat.decimalPattern().format(offer.fiatAmount);
    final dateLabel =
        DateFormat('dd-MM-yyyy HH:mm').format(offer.createdAt.toLocal());

    final statusLabel = _statusLabel(t, offer.status);
    final statusColor = _statusColor(offer.status);

    return ListTile(
      onTap: onTap,
      leading: showNeko
          ? SizedBox(
            width: 40,
            height: 40,
            child: Stack(
              children: [
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        'https://robohash.org/${offer.makerPubkey}?set=set4',
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
          ),
      title: Text(
        '$fiatLabel ${offer.fiatCurrency}',
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 2),
          Row(
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 6, vertical: 1),
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
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
    );
  }

  String _statusLabel(Translations t, OfferStatus status) {
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
        return t.offers.status.blikReceived;
      case OfferStatus.blikSentToMaker:
        return t.offers.status.blikSentToMaker;
      case OfferStatus.expiredBlik:
        return t.offers.status.expiredBlik;
      case OfferStatus.expiredSentBlik:
        return t.offers.status.expiredSentBlik;
      case OfferStatus.takerCharged:
        return t.offers.status.takerCharged;
      case OfferStatus.invalidBlik:
        return t.offers.status.invalidBlik;
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

  IconData _statusIcon(OfferStatus status) {
    switch (status) {
      case OfferStatus.takerPaid:
      case OfferStatus.settled:
      case OfferStatus.makerConfirmed:
        return Icons.check_circle;
      case OfferStatus.cancelled:
      case OfferStatus.expired:
      case OfferStatus.expiredBlik:
      case OfferStatus.expiredSentBlik:
      case OfferStatus.invalidBlik:
      case OfferStatus.takerPaymentFailed:
        return Icons.cancel;
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
      case OfferStatus.expiredBlik:
      case OfferStatus.expiredSentBlik:
      case OfferStatus.invalidBlik:
      case OfferStatus.takerPaymentFailed:
        return Colors.redAccent;
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
