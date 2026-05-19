import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../i18n/gen/strings.g.dart';
import '../models/coordinator_info.dart';
import '../models/offer.dart';
import '../providers/providers.dart';
import '../services/api_service_nostr.dart';
import '../widgets/lightning_address_widget.dart';
import '../widgets/progress_indicators.dart';

class OfferDetailsScreen extends ConsumerStatefulWidget {
  final String offerId;

  const OfferDetailsScreen({super.key, required this.offerId});

  @override
  ConsumerState<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends ConsumerState<OfferDetailsScreen> {
  bool _termsAccepted = false;
  bool _isLoadingTerms = true;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _loadTermsAcceptance(
    String coordinatorPubkey,
    String? termsOfUsageNaddr,
  ) async {
    if (termsOfUsageNaddr == null) {
      setState(() {
        _termsAccepted = false;
        _isLoadingTerms = false;
      });
      return;
    }

    final prefs = await SharedPreferences.getInstance();
    final key = 'terms_accepted_$coordinatorPubkey';
    final accepted = prefs.getBool(key) ?? false;

    setState(() {
      _termsAccepted = accepted;
      _isLoadingTerms = false;
    });
  }

  Future<void> _saveTermsAcceptance(
    bool accepted,
    String coordinatorPubkey,
  ) async {
    final prefs = await SharedPreferences.getInstance();
    final key = 'terms_accepted_$coordinatorPubkey';
    await prefs.setBool(key, accepted);

    setState(() {
      _termsAccepted = accepted;
    });
  }

  Future<void> _openTermsOfUsage(String naddr) async {
    final url = 'https://njump.to/$naddr';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    // Watch available offers for real-time updates
    final availableOffersAsync = ref.watch(availableOffersProvider);
    final offerAsyncValue = ref.watch(offerDetailsProvider(widget.offerId));
    final publicKeyAsyncValue = ref.watch(publicKeyProvider);
    final hasReceivingWalletAsync = ref.watch(hasReceivingWalletProvider);
    final myActiveOffer = ref.watch(activeOfferProvider);
    final t = Translations.of(context);
    final router = GoRouter.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(t.offers.details.selectedOffer)),
      body: offerAsyncValue.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
        data: (initialOffer) {
          if (initialOffer == null) {
            return Center(child: Text(t.offers.errors.notFound));
          }

          // Start with the initial offer from the detail provider
          var offer = initialOffer;

          // Check if we have a real-time update from availableOffersProvider
          availableOffersAsync.whenData((availableOffers) {
            final updatedOffer = availableOffers.firstWhere(
              (o) => o.id == widget.offerId,
              orElse: () => initialOffer,
            );
            // Use the updated offer if it's different
            if (updatedOffer.id == widget.offerId) {
              offer = updatedOffer;
            }
          });

          // Use the helper provider for reservation duration
          final reservationDuration = ref.watch(
            coordinatorReservationDurationProvider(offer.coordinatorPubkey),
          );

          final bool isFunded = offer.status == OfferStatus.funded.name;
          final bool isReserved = offer.status == OfferStatus.reserved.name;
          final bool isBlikReceived =
              offer.status == OfferStatus.blikReceived.name;

          // Get coordinator info for taker fee calculation
          final coordinatorInfoAsync = ref.watch(
            coordinatorInfoByPubkeyProvider(offer.coordinatorPubkey),
          );

          // Load terms acceptance when coordinator info is available
          coordinatorInfoAsync.whenData((coordInfo) {
            if (coordInfo != null && _isLoadingTerms) {
              _loadTermsAcceptance(
                offer.coordinatorPubkey,
                coordInfo.termsOfUsageNaddr,
              );
            }
          });

          // Calculate exchange rate and amounts (PLN per BTC)
          final exchangeRate =
              offer.amountSats > 0
                  ? ((offer.fiatAmount / offer.amountSats) * 100000000).round()
                  : 0;

          // Calculate taker fee from coordinator's percentage
          final takerFeeAmount = coordinatorInfoAsync.maybeWhen(
            data:
                (coordInfo) =>
                    coordInfo != null
                        ? (offer.amountSats * coordInfo.takerFee / 100).ceil()
                        : 0,
            orElse: () => 0,
          );

          final youllReceive = offer.amountSats - takerFeeAmount;

          Widget? actionButton;

          if (isFunded) {
            actionButton = SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                onPressed: publicKeyAsyncValue.maybeWhen(
                  data:
                      (publicKey) => coordinatorInfoAsync.maybeWhen(
                        data: (coordInfo) {
                          final hasTerms = coordInfo?.termsOfUsageNaddr != null;
                          final isTermsAccepted = !hasTerms || _termsAccepted;
                          final hasReceivingWallet = hasReceivingWalletAsync
                              .maybeWhen(
                                data: (value) => value,
                                orElse: () => false,
                              );
                          final isButtonEnabled =
                              publicKey != null &&
                              hasReceivingWallet &&
                              isTermsAccepted &&
                              !_isLoadingTerms;

                          return isButtonEnabled
                              ? () async {
                                // Check if there is any receiving-capable wallet
                                final hasReceivingWalletNow = await ref.read(
                                  hasReceivingWalletProvider.future,
                                );
                                if (!hasReceivingWalletNow) {
                                  LightningAddressWidget.showReceivingWalletRequiredDialog(
                                    context,
                                    ref,
                                    t,
                                  );
                                  return;
                                }

                                // Check if terms are accepted
                                if (coordInfo?.termsOfUsageNaddr != null &&
                                    !_termsAccepted) {
                                  // Should not happen if button is properly disabled, but check anyway
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t.coordinator.selector.termsAccept +
                                            t.coordinator.selector.termsOfUsage,
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                final takerId = publicKey;
                                final apiService = ref.read(apiServiceProvider);
                                final scaffoldMessenger = ScaffoldMessenger.of(
                                  context,
                                );

                                try {
                                  final reservationTimestamp = await apiService
                                      .reserveOffer(
                                        offer.id,
                                        takerId,
                                        offer.coordinatorPubkey,
                                      );

                                  if (reservationTimestamp != null) {
                                    final updatedOffer = offer.copyWith(
                                      status: OfferStatus.reserved.name,
                                      takerPubkey: takerId,
                                      reservedAt: reservationTimestamp,
                                    );

                                    ref
                                        .read(activeOfferProvider.notifier)
                                        .setActiveOffer(updatedOffer);

                                    // Navigate to submit BLIK screen
                                    router.go(
                                      "/submit-blik",
                                      extra: updatedOffer,
                                    );
                                  } else {
                                    ref.read(errorProvider.notifier).state =
                                        t.reservations.errors.failedNoTimestamp;
                                    if (scaffoldMessenger.mounted) {
                                      scaffoldMessenger.showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            t
                                                .reservations
                                                .errors
                                                .failedNoTimestamp,
                                          ),
                                        ),
                                      );
                                    }
                                    ref.invalidate(availableOffersProvider);
                                  }
                                } catch (e) {
                                  final errorMsg = t.reservations.errors
                                      .failedToReserve(details: e.toString());
                                  ref.read(errorProvider.notifier).state =
                                      errorMsg;
                                  if (scaffoldMessenger.mounted) {
                                    scaffoldMessenger.showSnackBar(
                                      SnackBar(content: Text(errorMsg)),
                                    );
                                  }
                                  ref.invalidate(availableOffersProvider);
                                }
                              }
                              : null;
                        },
                        loading: () => null,
                        error: (_, __) => null,
                        orElse: () => null,
                      ),
                  orElse: () => null,
                ),
                child: Text(
                  t.offers.actions.takeOffer,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          } else if (myActiveOffer != null &&
              offer.id == myActiveOffer.id &&
              offer.takerPubkey == publicKeyAsyncValue.value! &&
              (myActiveOffer.isInvalidBlik || myActiveOffer.isConflict)) {
            // Show button for conflict or invalidBlik if it's the active offer
            actionButton = SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: Text(
                  t.offers.actions.view,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                onPressed: () {
                  if (myActiveOffer.isInvalidBlik) {
                    router.go('/taker-invalid-blik', extra: myActiveOffer);
                  } else if (myActiveOffer.isConflict) {
                    router.go('/taker-conflict', extra: myActiveOffer.id);
                  }
                },
              ),
            );
          } else if (isReserved || isBlikReceived) {
            if (myActiveOffer != null &&
                offer.id == myActiveOffer.id &&
                offer.takerPubkey == publicKeyAsyncValue.value!) {
              actionButton = SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                  ),
                  child: Text(
                    t.offers.actions.view,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onPressed: () {
                    if (myActiveOffer.status == OfferStatus.reserved.name) {
                      router.go("/submit-blik", extra: myActiveOffer);
                    } else {
                      router.go("/wait-confirmation", extra: myActiveOffer);
                    }
                  },
                ),
              );
            }
          }

          return Padding(
            padding: const EdgeInsets.fromLTRB(16.0, 4.0, 16.0, 16.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Main offer card with new design
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            // Content area with padding
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  // Large amount display at the top
                                  Text(
                                    '${(offer.fiatAmount * 100).round() % 100 == 0 ? offer.fiatAmount.toStringAsFixed(0) : offer.fiatAmount.toStringAsFixed(2)} ${offer.fiatCurrency}',
                                    style: const TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),

                                  const SizedBox(height: 16),

                                  // Progress indicators below fiat amount
                                  if (isFunded)
                                    FundedOfferProgressIndicator(
                                      key: ValueKey(
                                        'progress_funded_${offer.id}',
                                      ),
                                      createdAt: offer.createdAt,
                                    ),
                                  if (isReserved &&
                                      offer.reservedAt != null &&
                                      reservationDuration != null)
                                    ReservationProgressIndicator(
                                      key: ValueKey(
                                        'progress_res_${offer.id}_${reservationDuration.inSeconds}',
                                      ),
                                      reservedAt: offer.reservedAt!,
                                      maxDuration: reservationDuration,
                                    ),
                                  if (isBlikReceived &&
                                      offer.blikReceivedAt != null)
                                    BlikConfirmationProgressIndicator(
                                      key: ValueKey(
                                        'progress_blik_${offer.id}',
                                      ),
                                      blikReceivedAt: offer.blikReceivedAt!,
                                    ),

                                  const SizedBox(height: 32),

                                  // Exchange Rate row (hide for takerPaid)
                                  if (offer.status !=
                                      OfferStatus.takerPaid.name)
                                    _buildInfoRow(
                                      t.offers.details.exchangeRate,
                                      '${_formatNumber(exchangeRate)} ${offer.fiatCurrency}/BTC',
                                      hasInfoIcon: true,
                                      onInfoTap:
                                          () => _showExchangeRateSourcesDialog(
                                            context,
                                          ),
                                    ),

                                  if (offer.status !=
                                      OfferStatus.takerPaid.name)
                                    const SizedBox(height: 16),

                                  // Taker fee row (hide for takerPaid)
                                  if (offer.status !=
                                      OfferStatus.takerPaid.name)
                                    _buildInfoRow(
                                      t.offers.details.takerFeeLabel,
                                      '$takerFeeAmount sats',
                                      hasInfoIcon: true,
                                      onInfoTap: () {
                                        coordinatorInfoAsync.whenData((
                                          coordInfo,
                                        ) {
                                          if (coordInfo != null) {
                                            showDialog(
                                              context: context,
                                              builder:
                                                  (context) => AlertDialog(
                                                    title: Text(
                                                      t
                                                          .offers
                                                          .details
                                                          .takerFeeLabel,
                                                    ),
                                                    content: Text(
                                                      t.offers.tooltips
                                                          .takerFeeInfo(
                                                            feePercent:
                                                                coordInfo
                                                                    .takerFee
                                                                    .toString(),
                                                          ),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                        onPressed:
                                                            () =>
                                                                Navigator.of(
                                                                  context,
                                                                ).pop(),
                                                        child: Text(
                                                          t
                                                              .common
                                                              .buttons
                                                              .close,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                            );
                                          }
                                        });
                                      },
                                    ),

                                  if (offer.status !=
                                      OfferStatus.takerPaid.name)
                                    const SizedBox(height: 24),

                                  // You'll receive row (highlighted) (hide for takerPaid)
                                  if (offer.status !=
                                      OfferStatus.takerPaid.name)
                                    _buildInfoRow(
                                      t.offers.details.youllReceive,
                                      '$youllReceive sats',
                                      isHighlighted: true,
                                    ),

                                  // Timing information for completed offers (takerPaid status)
                                  if (offer.status ==
                                          OfferStatus.takerPaid.name &&
                                      offer.timeToReserveSeconds != null &&
                                      offer.totalCompletionTimeMakerSeconds !=
                                          null) ...[
                                    const SizedBox(height: 24),

                                    // Taken after
                                    Text(
                                      t.offers.details.takenAfter(
                                        duration: _formatDurationFromSeconds(
                                          offer.timeToReserveSeconds,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),

                                    const SizedBox(height: 16),

                                    // Paid after (total time)
                                    Text(
                                      t.offers.details.paidAfter(
                                        duration: _formatDurationFromSeconds(
                                          offer.totalCompletionTimeMakerSeconds,
                                        ),
                                      ),
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[600],
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],

                                  const SizedBox(height: 20),

                                  // Separator line
                                  Container(height: 1, color: Colors.grey[300]),

                                  const SizedBox(height: 20),

                                  // Coordinator row
                                  coordinatorInfoAsync.when(
                                    data:
                                        (coordInfo) =>
                                            coordInfo != null
                                                ? _buildCoordinatorRow(
                                                  t.offers.details.coordinator,
                                                  coordInfo,
                                                )
                                                : _buildInfoRow(
                                                  t.offers.details.coordinator,
                                                  'Unknown',
                                                ),
                                    loading:
                                        () => _buildInfoRow(
                                          t.offers.details.coordinator,
                                          '...',
                                        ),
                                    error:
                                        (_, __) => _buildInfoRow(
                                          t.offers.details.coordinator,
                                          'Unknown',
                                        ),
                                  ),

                                  // Terms of Usage checkbox (only for funded offers with terms)
                                  if (isFunded)
                                    coordinatorInfoAsync.maybeWhen(
                                      data: (coordInfo) {
                                        if (coordInfo?.termsOfUsageNaddr !=
                                            null) {
                                          return Column(
                                            children: [
                                              const SizedBox(height: 10),
                                              if (_isLoadingTerms)
                                                const Padding(
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 8.0,
                                                  ),
                                                  child: SizedBox(
                                                    width: 20,
                                                    height: 20,
                                                    child:
                                                        CircularProgressIndicator(
                                                          strokeWidth: 2,
                                                        ),
                                                  ),
                                                )
                                              else
                                                Row(
                                                  children: [
                                                    Checkbox(
                                                      value: _termsAccepted,
                                                      onChanged: (bool? value) {
                                                        _saveTermsAcceptance(
                                                          value ?? false,
                                                          offer
                                                              .coordinatorPubkey,
                                                        );
                                                      },
                                                    ),
                                                    Expanded(
                                                      child: Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              _saveTermsAcceptance(
                                                                !_termsAccepted,
                                                                offer
                                                                    .coordinatorPubkey,
                                                              );
                                                            },
                                                            child: Text(
                                                              t
                                                                  .coordinator
                                                                  .selector
                                                                  .termsAccept,
                                                              style: const TextStyle(
                                                                color:
                                                                    Colors
                                                                        .black,
                                                                fontSize: 14,
                                                              ),
                                                            ),
                                                          ),
                                                          MouseRegion(
                                                            cursor:
                                                                SystemMouseCursors
                                                                    .click,
                                                            child: GestureDetector(
                                                              onTap:
                                                                  () => _openTermsOfUsage(
                                                                    coordInfo!
                                                                        .termsOfUsageNaddr!,
                                                                  ),
                                                              child: Text(
                                                                t
                                                                    .coordinator
                                                                    .selector
                                                                    .termsOfUsage,
                                                                style: const TextStyle(
                                                                  color:
                                                                      Colors
                                                                          .blue,
                                                                  fontSize: 14,
                                                                  decoration:
                                                                      TextDecoration
                                                                          .underline,
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                            ],
                                          );
                                        }
                                        return const SizedBox.shrink();
                                      },
                                      orElse: () => const SizedBox.shrink(),
                                    ),

                                  const SizedBox(height: 6),

                                  // Receiving wallet hint for funded offers
                                  if (isFunded &&
                                      hasReceivingWalletAsync.maybeWhen(
                                        data: (value) => !value,
                                        orElse: () => false,
                                      )) ...[
                                    const SizedBox(height: 10),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 8,
                                      ),
                                      child:
                                          LightningAddressWidget.buildMissingReceivingWalletWarning(
                                            context,
                                            ref,
                                            t,
                                          ),
                                    ),
                                  ],
                                  const SizedBox(height: 6),

                                  // Action button
                                  if (actionButton != null) actionButton,
                                ],
                              ),
                            ),
                          ],
                        ),

                        // Status ribbon in top-right corner (diagonal)
                        Positioned(
                          top: 20,
                          right: -32,
                          child: _buildStatusRibbon(offer.status),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Builds an information row with label and value, matching the design from the image
  Widget _buildInfoRow(
    String label,
    String value, {
    bool hasInfoIcon = false,
    bool isHighlighted = false,
    VoidCallback? onInfoTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: hasInfoIcon ? onInfoTap : null,
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w400,
                ),
              ),
              if (hasInfoIcon) ...[
                const SizedBox(width: 4),
                Icon(Icons.info_outline, size: 16, color: Colors.grey[500]),
              ],
            ],
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
          ),
        ),
      ],
    );
  }

  /// Formats a number with spaces as thousand separators
  String _formatNumber(int number) {
    final formatter = NumberFormat('#,###', 'en_US');
    return formatter.format(number).replaceAll(',', ' ');
  }

  /// Formats a duration from seconds in a human-readable format
  String _formatDurationFromSeconds(int? totalSeconds) {
    if (totalSeconds == null || totalSeconds < 0) {
      return '-';
    }
    if (totalSeconds == 0) {
      return '0s';
    }

    if (totalSeconds < 60) {
      return '${totalSeconds}s';
    } else if (totalSeconds < 3600) {
      final minutes = totalSeconds ~/ 60;
      final seconds = totalSeconds % 60;
      return seconds > 0 ? '${minutes}m ${seconds}s' : '${minutes}m';
    } else {
      final hours = totalSeconds ~/ 3600;
      final minutes = (totalSeconds % 3600) ~/ 60;
      return minutes > 0 ? '${hours}h ${minutes}m' : '${hours}h';
    }
  }

  /// Shows a dialog with exchange rate sources
  void _showExchangeRateSourcesDialog(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            backgroundColor: Colors.transparent,
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children:
                      ApiServiceNostr.exchangeRateSourceNames
                          .map(
                            (source) => Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 4.0,
                              ),
                              child: Text(
                                source,
                                style: const TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                ),
              ),
            ),
          ),
    );
  }

  /// Builds a coordinator row with icon and name
  Widget _buildCoordinatorRow(String label, CoordinatorInfo coordInfo) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
            fontWeight: FontWeight.w400,
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: () => _showCoordinatorDetailsDialog(coordInfo),
            child: Row(
              children: [
                Text(
                  coordInfo.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                if (coordInfo.icon != null) ...[
                  const SizedBox(width: 8),
                  Image.network(
                    coordInfo.icon!,
                    width: 20,
                    height: 20,
                    errorBuilder:
                        (context, error, stackTrace) => Icon(
                          Icons.account_balance,
                          size: 20,
                          color: Colors.grey[600],
                        ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }

  /// Shows a dialog with coordinator details
  void _showCoordinatorDetailsDialog(CoordinatorInfo coordInfo) {
    final t = Translations.of(context);

    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            child: Container(
              constraints: const BoxConstraints(maxWidth: 400),
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header with icon and name
                  Row(
                    children: [
                      if (coordInfo.icon != null)
                        Image.network(
                          coordInfo.icon!,
                          width: 40,
                          height: 40,
                          errorBuilder:
                              (context, error, stackTrace) =>
                                  const Icon(Icons.account_balance, size: 40),
                        ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coordInfo.name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            if (coordInfo.version != null)
                              Text(
                                'v${coordInfo.version}',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey[600],
                                ),
                              ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Coordinator details
                  _buildDialogInfoRow(
                    t.coordinator.dialog.makerFee,
                    '${coordInfo.makerFee}%',
                  ),
                  const SizedBox(height: 12),
                  _buildDialogInfoRow(
                    t.coordinator.dialog.takerFee,
                    '${coordInfo.takerFee}%',
                  ),
                  const SizedBox(height: 12),
                  _buildDialogInfoRow(
                    t.coordinator.dialog.amountRange,
                    '${coordInfo.minAmountSats}-${coordInfo.maxAmountSats} sats',
                  ),
                  const SizedBox(height: 12),
                  _buildDialogInfoRow(
                    t.coordinator.dialog.reservationTime,
                    '${coordInfo.reservationSeconds}s',
                  ),
                  const SizedBox(height: 12),
                  _buildDialogInfoRow(
                    t.coordinator.dialog.currencies,
                    coordInfo.currencies.join(', '),
                  ),

                  // Terms of Usage link
                  if (coordInfo.termsOfUsageNaddr != null) ...[
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap:
                          () => _openTermsOfUsage(coordInfo.termsOfUsageNaddr!),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            t.coordinator.selector.termsOfUsage,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(width: 16),
                          Flexible(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  t.coordinator.dialog.viewTerms,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.blue,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Icon(
                                  Icons.open_in_new,
                                  size: 14,
                                  color: Colors.blue,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],

                  // Nostr profile button
                  if (coordInfo.nostrNpub != null) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: Image.asset(
                          'assets/nostr.png',
                          width: 20,
                          height: 20,
                        ),
                        label: Text(t.coordinator.selector.viewNostrProfile),
                        onPressed:
                            () => _openNostrProfile(coordInfo.nostrNpub!),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
    );
  }

  /// Builds an info row for the coordinator dialog
  Widget _buildDialogInfoRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(fontSize: 14, color: Colors.grey[600])),
        const SizedBox(width: 16),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }

  /// Builds a status ribbon for the card
  Widget _buildStatusRibbon(String status) {
    final t = Translations.of(context);
    Color ribbonColor;
    String ribbonText;

    switch (status.toLowerCase()) {
      case 'created':
        ribbonColor = Colors.grey;
        ribbonText = t.offers.status.created.toUpperCase();
        break;
      case 'funded':
        ribbonColor = Colors.green;
        ribbonText = t.offers.status.funded.toUpperCase();
        break;
      case 'expired':
        ribbonColor = Colors.grey[600]!;
        ribbonText = t.offers.status.expired.toUpperCase();
        break;
      case 'cancelled':
        ribbonColor = Colors.grey[600]!;
        ribbonText = t.offers.status.cancelled.toUpperCase();
        break;
      case 'reserved':
        ribbonColor = Colors.orange;
        ribbonText = t.offers.status.reserved.toUpperCase();
        break;
      case 'blikreceived':
        ribbonColor = Colors.blue;
        ribbonText = t.offers.status.blikReceived.toUpperCase();
        break;
      case 'bliksenttomaker':
        ribbonColor = Colors.lightBlue;
        ribbonText = t.offers.status.blikSentToMaker.toUpperCase();
        break;
      case 'invalidblik':
        ribbonColor = Colors.deepOrange;
        ribbonText = t.offers.status.invalidBlik.toUpperCase();
        break;
      case 'conflict':
        ribbonColor = Colors.red[700]!;
        ribbonText = t.offers.status.conflict.toUpperCase();
        break;
      case 'dispute':
        ribbonColor = Colors.red[900]!;
        ribbonText = t.offers.status.dispute.toUpperCase();
        break;
      case 'makerconfirmed':
        ribbonColor = Colors.purple;
        ribbonText = t.offers.status.makerConfirmed.toUpperCase();
        break;
      case 'settled':
        ribbonColor = Colors.indigo;
        ribbonText = t.offers.status.settled.toUpperCase();
        break;
      case 'payingtaker':
        ribbonColor = Colors.teal;
        ribbonText = t.offers.status.payingTaker.toUpperCase();
        break;
      case 'takerpaymentfailed':
        ribbonColor = Colors.deepOrange[700]!;
        ribbonText = t.offers.status.takerPaymentFailed.toUpperCase();
        break;
      case 'takerpaid':
        ribbonColor = Colors.green[700]!;
        ribbonText = t.offers.status.takerPaid.toUpperCase();
        break;
      default:
        ribbonColor = Colors.blueGrey;
        ribbonText = status.toUpperCase();
    }

    return Transform.rotate(
      angle: 0.785398, // 45 degrees in radians
      child: Container(
        width: 140,
        height: 30,
        decoration: BoxDecoration(
          color: ribbonColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(
            ribbonText,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.8,
            ),
          ),
        ),
      ),
    );
  }

  /// Opens the Nostr profile in a browser
  void _openNostrProfile(String npub) async {
    // Use njump.to as a Nostr profile viewer (npub is already encoded in CoordinatorInfo)
    final url = 'https://njump.to/$npub';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}

extension OfferCopyWith on Offer {
  Offer copyWith({
    String? id,
    int? amountSats,
    int? takerFees,
    int? makerFees,
    String? fiatCurrency,
    double? fiatAmount,
    String? status,
    String? coordinatorPubkey,
    DateTime? createdAt,
    String? makerPubkey,
    String? takerPubkey,
    DateTime? reservedAt,
    DateTime? blikReceivedAt,
    String? blikCode,
    String? holdInvoicePaymentHash,
  }) {
    return Offer(
      id: id ?? this.id,
      amountSats: amountSats ?? this.amountSats,
      takerFees: takerFees ?? this.takerFees,
      makerFees: makerFees ?? this.makerFees,
      fiatCurrency: fiatCurrency ?? this.fiatCurrency,
      fiatAmount: fiatAmount ?? this.fiatAmount,
      status: status ?? this.status,
      coordinatorPubkey: coordinatorPubkey ?? this.coordinatorPubkey,
      createdAt: createdAt ?? this.createdAt,
      makerPubkey: makerPubkey ?? this.makerPubkey,
      takerPubkey: takerPubkey ?? this.takerPubkey,
      reservedAt: reservedAt ?? this.reservedAt,
      blikReceivedAt: blikReceivedAt ?? this.blikReceivedAt,
      blikCode: blikCode ?? this.blikCode,
      holdInvoicePaymentHash:
          holdInvoicePaymentHash ?? this.holdInvoicePaymentHash,
    );
  }
}
