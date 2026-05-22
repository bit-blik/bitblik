import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../services/offer_db_service.dart';

final _localOfferProvider =
    FutureProvider.family<Offer?, String>((ref, id) async {
  return OfferDbService().getOfferById(id);
});

class LocalOfferDetailsScreen extends ConsumerWidget {
  const LocalOfferDetailsScreen({required this.offerId, super.key});

  static const routeName = '/my-offers/:id';

  final String offerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final offerAsync = ref.watch(_localOfferProvider(offerId));

    return Scaffold(
      appBar: AppBar(title: Text(t.myOffers.details.title)),
      body: offerAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('${t.coordinator.management.error}: $err')),
        data: (offer) {
          if (offer == null) {
            return Center(child: Text(t.myOffers.details.notFound));
          }
          return _OfferDetailsBody(offer: offer);
        },
      ),
    );
  }
}

class _OfferDetailsBody extends ConsumerWidget {
  const _OfferDetailsBody({required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final apiService = ref.watch(apiServiceProvider);
    final coordinatorInfo =
        apiService.getCoordinatorInfoByPubkey(offer.coordinatorPubkey);
    final coordinatorName =
        coordinatorInfo?.name ?? t.myOffers.unknownCoordinator;

    final fiatFmt = NumberFormat.decimalPattern();
    final satsFmt = NumberFormat.decimalPattern();
    final dateFmt = DateFormat('dd-MM-yyyy HH:mm');

    Color statusColor = _statusColor(offer.status);

    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        // Status chip
        Row(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: statusColor.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(_statusIcon(offer.status), color: statusColor, size: 16),
                  const SizedBox(width: 6),
                  Text(
                    _statusLabel(t, offer.status),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Main amounts card
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _Row(
                  label: t.myOffers.details.amount,
                  value:
                      '${fiatFmt.format(offer.fiatAmount)} ${offer.fiatCurrency}',
                  bold: true,
                ),
                const Divider(height: 16),
                _Row(
                  label: t.myOffers.details.sats,
                  value: '${satsFmt.format(offer.amountSats)} sats',
                ),
                const Divider(height: 16),
                _Row(
                  label: t.myOffers.details.makerFee,
                  value: '${offer.makerFees} sats',
                ),
                if (offer.takerFees != null) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.takerFee,
                    value: '${offer.takerFees} sats',
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Info card
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _Row(
                  label: t.myOffers.details.coordinator,
                  value: coordinatorName,
                ),
                const Divider(height: 16),
                _Row(
                  label: t.myOffers.details.createdAt,
                  value: dateFmt.format(offer.createdAt.toLocal()),
                ),
                if (offer.reservedAt != null) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.reservedAt,
                    value: dateFmt.format(offer.reservedAt!.toLocal()),
                  ),
                ],
                if (offer.blikReceivedAt != null) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.blikReceivedAt,
                    value: dateFmt.format(offer.blikReceivedAt!.toLocal()),
                  ),
                ],
                if (offer.makerConfirmedAt != null) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.makerConfirmedAt,
                    value: dateFmt.format(offer.makerConfirmedAt!.toLocal()),
                  ),
                ],
                if (offer.settledAt != null) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.settledAt,
                    value: dateFmt.format(offer.settledAt!.toLocal()),
                  ),
                ],
                if (offer.takerPaidAt != null) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.takerPaidAt,
                    value: dateFmt.format(offer.takerPaidAt!.toLocal()),
                  ),
                ],
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),

        // Technical details card
        Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CopyableField(
                  label: t.myOffers.details.id,
                  value: offer.id,
                ),
                if (offer.holdInvoicePaymentHash != null) ...[
                  const Divider(height: 16),
                  _CopyableField(
                    label: t.myOffers.details.paymentHash,
                    value: offer.holdInvoicePaymentHash!,
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
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

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.bold = false});

  final String label;
  final String value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 130,
          child: Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}

class _CopyableField extends StatelessWidget {
  const _CopyableField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final displayValue = value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 13)),
        const SizedBox(height: 4),
        Row(
          children: [
            Expanded(
              child: Text(
                displayValue,
                style: const TextStyle(fontSize: 13, fontFamily: 'monospace'),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              icon: const Icon(Icons.copy, size: 18),
              tooltip: t.common.clipboard.copyToClipboard,
              onPressed: () {
                Clipboard.setData(ClipboardData(text: value));
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(t.common.clipboard.copied),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
