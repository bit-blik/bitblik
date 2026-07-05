import 'package:bitblik_core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ndk/shared/nips/nip19/nip19.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../utils/offer_status_label.dart';
import 'coordinator_details_screen.dart';
import '../services/offer_db_service.dart';
import '../utils/bitcoin_display.dart';
import '../utils/category_icons.dart';
import '../utils/locale_format.dart';
import '../widgets/premium_info.dart';

class LocalOfferDetailsScreen extends ConsumerWidget {
  const LocalOfferDetailsScreen({required this.offerId, super.key});

  static const routeName = '/my-offers/:id';

  final String offerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final offersAsync = ref.watch(myOffersProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.myOffers.details.title)),
      body: RefreshIndicator(
        onRefresh: () => _refreshOfferDetails(ref),
        child: offersAsync.when(
          loading:
              () => ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(
                    height: 400,
                    child: Center(child: CircularProgressIndicator()),
                  ),
                ],
              ),
          error:
              (err, _) => ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 400,
                    child: Center(
                      child: Text('${t.coordinator.management.error}: $err'),
                    ),
                  ),
                ],
              ),
          data: (offers) {
            Offer? offer;
            for (final candidate in offers) {
              if (candidate.id == offerId) {
                offer = candidate;
                break;
              }
            }
            if (offer == null) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: [
                  SizedBox(
                    height: 400,
                    child: Center(child: Text(t.myOffers.details.notFound)),
                  ),
                ],
              );
            }
            return _OfferDetailsBody(offer: offer);
          },
        ),
      ),
    );
  }

  Future<void> _refreshOfferDetails(WidgetRef ref) async {
    final offers = await ref.read(myOffersProvider.future);
    Offer? offer;
    for (final candidate in offers) {
      if (candidate.id == offerId) {
        offer = candidate;
        break;
      }
    }
    if (offer == null) {
      return;
    }

    final apiService = await ref.read(initializedApiServiceProvider.future);
    final remote = await apiService.getOfferDetails(
      offer,
      offer.coordinatorPubkey,
    );
    if (remote == null) {
      await OfferDbService().deleteOfferById(offer.id);
      ref.invalidate(myOffersProvider);
      return;
    }

    await OfferDbService().upsertOffer(Offer.fromJson(remote));
    ref.invalidate(myOffersProvider);
  }
}

class _OfferDetailsBody extends ConsumerWidget {
  const _OfferDetailsBody({required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final apiService = ref.watch(apiServiceProvider);
    final bitcoinDisplayUnit = ref.watch(bitcoinDisplayUnitProvider);
    final currentPubKey =
        ref.watch(publicKeyProvider).value ??
        ref.watch(keyServiceProvider).publicKeyHex;
    final activeOffer = ref.watch(activeOfferProvider);
    final coordinatorInfo = apiService.getCoordinatorInfoByPubkey(
      offer.coordinatorPubkey,
    );
    final coordinatorRecord = ref.watch(
      coordinatorRecordByPubkeyProvider(offer.coordinatorPubkey),
    );
    final coordinatorName =
        coordinatorInfo?.name ?? t.myOffers.unknownCoordinator;
    final localeTag = effectiveFormatLocale(context);

    final fiatFmt = NumberFormat.decimalPattern(localeTag);
    final amountLabel =
        '${fiatFmt.format(offer.fiatAmount)} ${offer.fiatCurrency} • ${formatBitcoinAmount(context, bitcoinDisplayUnit, offer.amountSats)}';
    final ourFee =
        currentPubKey == offer.makerPubkey
            ? offer.makerFees
            : currentPubKey == offer.takerPubkey
            ? (offer.takerFees ?? 0)
            : 0;
    final takerPubkey = offer.takerPubkey;
    final takerPaidReferenceAt =
        offer.takerPaidAt ??
        (offer.status == OfferStatus.takerPaid ? offer.settledAt : null);
    final isCurrentOfferActive = activeOffer?.id == offer.id;
    final canResumeMakerWaitTaker =
        currentPubKey != null &&
        currentPubKey == offer.makerPubkey &&
        offer.status == OfferStatus.funded;
    final shouldShowCreatedAt =
        offer.reservedAt == null ||
        offer.createdAt.difference(offer.reservedAt!).abs() >
            const Duration(seconds: 1);
    final shouldShowFee = _shouldShowFee(offer.status) && ourFee > 0;
    final premiumViewerRole =
        currentPubKey != null && currentPubKey == offer.takerPubkey
            ? PremiumViewerRole.taker
            : PremiumViewerRole.maker;

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
                    offerStatusLabel(
                      t,
                      offer.status,
                      code: offerCodeLabel(offer),
                      statusRaw: offer.statusRaw,
                    ),
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            if (offer.category != null) ...[
              const SizedBox(width: 10),
              categoryIconWidget(offer.category, 20),
            ],
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
                  value: amountLabel,
                  bold: true,
                ),
                if (shouldShowFee) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.yourFee,
                    value: formatBitcoinAmount(
                      context,
                      bitcoinDisplayUnit,
                      ourFee,
                    ),
                  ),
                ],
                if (offer.premiumPercent > 0) ...[
                  const Divider(height: 16),
                  _WidgetRow(
                    label: t.offers.labels.premium,
                    child: PremiumChip(
                      premiumPercent: offer.premiumPercent,
                      viewerRole: premiumViewerRole,
                    ),
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
                _WidgetRow(
                  label: t.myOffers.details.coordinator,
                  child: InkWell(
                    onTap:
                        () => openCoordinatorDetails(
                          context,
                          offer.coordinatorPubkey,
                        ),
                    borderRadius: BorderRadius.circular(6),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _CoordinatorLogo(
                            icon: coordinatorRecord?.icon,
                            fallbackColor: statusColor,
                          ),
                          const SizedBox(width: 8),
                          Flexible(
                            child: Text(
                              coordinatorName,
                              style: const TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.grey[600],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Maker pubkey is stripped from taker-facing coordinator
                // responses (privacy) — the local record then holds a
                // non-hex sentinel; hide the row rather than crash npub
                // encoding.
                if (_isValidPubkeyHex(offer.makerPubkey)) ...[
                  const Divider(height: 16),
                  _WidgetRow(
                    label: t.myOffers.details.maker,
                    child: _CounterpartyPreview(
                      pubkey: offer.makerPubkey,
                      statusColor: statusColor,
                    ),
                  ),
                ],
                if (takerPubkey != null && _isValidPubkeyHex(takerPubkey)) ...[
                  const Divider(height: 16),
                  _WidgetRow(
                    label: t.myOffers.details.taker,
                    child: _CounterpartyPreview(
                      pubkey: takerPubkey,
                      statusColor: statusColor,
                    ),
                  ),
                ],
                if (shouldShowCreatedAt) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.createdAt,
                    value: formatLocalizedDateTime(context, offer.createdAt),
                  ),
                ],
                if (offer.reservedAt != null) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.reservedAt,
                    value: t.myOffers.details.after(
                      duration: _formatDuration(
                        offer.reservedAt!.difference(offer.createdAt),
                      ),
                    ),
                  ),
                ],
                if (takerPaidReferenceAt != null) ...[
                  const Divider(height: 16),
                  _Row(
                    label: t.myOffers.details.takerPaidAt,
                    value: t.myOffers.details.after(
                      duration: _formatDuration(
                        takerPaidReferenceAt.difference(offer.createdAt),
                      ),
                    ),
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
                _CopyableField(label: t.myOffers.details.id, value: offer.id),
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
        if (isCurrentOfferActive || canResumeMakerWaitTaker) ...[
          const SizedBox(height: 20),
          _ActiveOfferCta(
            label: t.myOffers.details.continueActiveOffer,
            statusColor: statusColor,
            onTap:
                currentPubKey == null
                    ? null
                    : () => _resumeOfferFromDetails(
                      context,
                      ref,
                      offer,
                      currentPubKey,
                      t,
                    ),
          ),
        ],
      ],
    );
  }

  Future<void> _resumeOfferFromDetails(
    BuildContext context,
    WidgetRef ref,
    Offer offer,
    String currentPubKey,
    Translations t,
  ) async {
    await ref.read(activeOfferProvider.notifier).setActiveOffer(offer);
    if (!context.mounted) return;
    _openActiveOfferFlow(context, ref, offer, currentPubKey, t);
  }

  void _openActiveOfferFlow(
    BuildContext context,
    WidgetRef ref,
    Offer activeOffer,
    String currentPubKey,
    Translations t,
  ) {
    if (activeOffer.holdInvoicePaymentHash != null) {
      ref.read(paymentHashProvider.notifier).state =
          activeOffer.holdInvoicePaymentHash!;
    }

    // Every market is flow-driven: resume into the single flow screen, which
    // renders the body for the offer's current state + role.
    if (currentPubKey == activeOffer.makerPubkey ||
        currentPubKey == activeOffer.takerPubkey) {
      ref.read(activeOfferProvider.notifier).setActiveOffer(activeOffer);
      context.go('/flow');
    }
  }

  String _formatDuration(Duration duration) {
    final seconds = duration.inSeconds;
    if (seconds < 60) return '${seconds}s';
    final minutes = duration.inMinutes;
    final remSeconds = seconds % 60;
    if (remSeconds == 0) return '${minutes}m';
    return '${minutes}m ${remSeconds}s';
  }

  bool _shouldShowFee(OfferStatus status) {
    const activeStatuses = {
      OfferStatus.created,
      OfferStatus.funded,
      OfferStatus.reserved,
      OfferStatus.blikReceived,
      OfferStatus.blikSentToMaker,
      OfferStatus.invalidBlik,
      OfferStatus.takerCharged,
      OfferStatus.makerConfirmed,
      OfferStatus.settled,
      OfferStatus.payingTaker,
      OfferStatus.takerPaymentFailed,
      OfferStatus.conflict,
      OfferStatus.dispute,
      OfferStatus.unknown,
    };

    return activeStatuses.contains(status) || status == OfferStatus.takerPaid;
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
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(label, style: TextStyle(color: Colors.grey[700])),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 5,
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: TextStyle(
              fontWeight: bold ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ),
      ],
    );
  }
}

class _WidgetRow extends StatelessWidget {
  const _WidgetRow({required this.label, required this.child});

  final String label;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 3,
          child: Text(label, style: TextStyle(color: Colors.grey[700])),
        ),
        const SizedBox(width: 12),
        Expanded(
          flex: 5,
          child: Align(alignment: Alignment.centerRight, child: child),
        ),
      ],
    );
  }
}

class _CoordinatorLogo extends StatelessWidget {
  const _CoordinatorLogo({required this.icon, required this.fallbackColor});

  final String? icon;
  final Color fallbackColor;

  @override
  Widget build(BuildContext context) {
    final normalized = icon?.trim();
    if (normalized != null && normalized.isNotEmpty) {
      if (normalized.startsWith('http')) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(999),
          child: CachedNetworkImage(
            imageUrl: normalized,
            width: 20,
            height: 20,
            fit: BoxFit.cover,
            errorWidget: (_, _, _) => _fallback(),
          ),
        );
      }
      return ClipRRect(
        borderRadius: BorderRadius.circular(999),
        child: Image.asset(
          normalized,
          width: 20,
          height: 20,
          fit: BoxFit.cover,
          errorBuilder: (_, _, _) => _fallback(),
        ),
      );
    }
    return _fallback();
  }

  Widget _fallback() {
    return CircleAvatar(
      radius: 10,
      backgroundColor: fallbackColor.withValues(alpha: 0.15),
      child: Icon(Icons.account_balance_wallet, size: 12, color: fallbackColor),
    );
  }
}

/// True for a 64-char hex nostr pubkey — false for empty values and
/// placeholder sentinels like `unknown_maker` (see Offer.fromJson defaults).
bool _isValidPubkeyHex(String pubkey) =>
    RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(pubkey);

class _CounterpartyPreview extends StatelessWidget {
  const _CounterpartyPreview({required this.pubkey, required this.statusColor});

  final String pubkey;
  final Color statusColor;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final npub = Nip19.encodePubKey(pubkey);

    return Row(
      children: [
        SizedBox(
          width: 28,
          height: 28,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: 'https://robohash.org/$pubkey?set=set4',
              fit: BoxFit.cover,
              errorWidget:
                  (_, _, _) => CircleAvatar(
                    backgroundColor: statusColor.withValues(alpha: 0.15),
                    child: Icon(Icons.pets, size: 14, color: statusColor),
                  ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            npub,
            textAlign: TextAlign.right,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
        IconButton(
          icon: const Icon(Icons.copy, size: 18),
          tooltip: t.common.clipboard.copyToClipboard,
          padding: const EdgeInsets.only(left: 8, top: 8, bottom: 8),
          constraints: const BoxConstraints(minHeight: 48),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: npub));
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(t.common.clipboard.copied),
                duration: const Duration(seconds: 2),
              ),
            );
          },
        ),
      ],
    );
  }
}

class _ActiveOfferCta extends StatelessWidget {
  const _ActiveOfferCta({
    required this.label,
    required this.statusColor,
    required this.onTap,
  });

  final String label;
  final Color statusColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(26),
        child: Ink(
          decoration: BoxDecoration(
            color:
                onTap == null
                    ? theme.colorScheme.surfaceContainerHighest
                    : Colors.black,
            borderRadius: BorderRadius.circular(26),
            border: Border.all(
              color: onTap == null ? theme.dividerColor : Colors.black,
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          child: Row(
            children: [
              const SizedBox(width: 26),
              Expanded(
                child: Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: onTap == null ? theme.disabledColor : Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 12),
              Icon(
                Icons.arrow_forward_ios,
                color: onTap == null ? theme.disabledColor : Colors.white,
                size: 16,
              ),
            ],
          ),
        ),
      ),
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
