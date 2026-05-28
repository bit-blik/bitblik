import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../i18n/gen/strings.g.dart';
import 'package:bitblik_core/core.dart';
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
  bool _atmConsentAccepted = false;
  bool _ecommerceConsentAccepted = false;

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

  void _showReceivingWalletRequired(WidgetRef ref, Translations t) {
    LightningAddressWidget.showReceivingWalletRequiredDialog(context, ref, t);
  }

  ScaffoldMessengerState _scaffoldMessenger() => ScaffoldMessenger.of(context);

  String _categoryLabel(BuildContext context, OfferCategory? category) {
    final t = Translations.of(context);
    switch (category) {
      case OfferCategory.physicalShop:
        return t.offers.details.categories.physicalShop;
      case OfferCategory.atmCashout:
        return t.offers.details.categories.atmCashout;
      case OfferCategory.onlineService:
        return t.offers.details.categories.onlineService;
      case null:
        return '-';
    }
  }

  String? _categoryTooltip(BuildContext context, OfferCategory? category) {
    final t = Translations.of(context);
    switch (category) {
      case OfferCategory.atmCashout:
        return t.offers.tooltips.atmCategory;
      case OfferCategory.onlineService:
        return t.offers.tooltips.ecommerceCategory;
      case OfferCategory.physicalShop:
      case null:
        return null;
    }
  }

  IconData? _categoryIcon(OfferCategory? category) {
    switch (category) {
      case OfferCategory.physicalShop:
        return Icons.storefront_outlined;
      case OfferCategory.atmCashout:
        return Icons.local_atm_outlined;
      case OfferCategory.onlineService:
        return Icons.shopping_bag_outlined;
      case null:
        return null;
    }
  }

  String? _categoryAsset(OfferCategory? category) {
    switch (category) {
      case OfferCategory.physicalShop:
        return 'assets/category_shop.png';
      case OfferCategory.atmCashout:
        return 'assets/category_atm.png';
      case OfferCategory.onlineService:
        return 'assets/category_online.png';
      case null:
        return null;
    }
  }

  Widget _categoryIconWidget(
    OfferCategory? category,
    double size,
    Color color,
  ) {
    final asset = _categoryAsset(category);
    if (asset != null) {
      return Image.asset(
        asset,
        width: size,
        height: size,
        color: color,
        colorBlendMode: BlendMode.srcIn,
      );
    }
    final icon = _categoryIcon(category);
    if (icon == null) return const SizedBox.shrink();
    return Icon(icon, size: size, color: color);
  }

  List<Color> _categoryGradientColors(OfferCategory? category) {
    switch (category) {
      case OfferCategory.physicalShop:
        // logo dominant: #039F94 teal
        return [const Color(0xFF016B61), const Color(0xFF039F94)];
      case OfferCategory.atmCashout:
        // logo dominant: #03A049 green
        return [const Color(0xFF025C2E), const Color(0xFF03A049)];
      case OfferCategory.onlineService:
        // logo dominant: #0453F6 blue
        return [const Color(0xFF032696), const Color(0xFF0453F6)];
      case null:
        return [Colors.grey.shade700, Colors.grey.shade500];
    }
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

          final bool isFunded = offer.status == OfferStatus.funded;
          final bool isReserved = offer.status == OfferStatus.reserved;
          final bool isBlikReceived = offer.status == OfferStatus.blikReceived;
          final requiresAtmConsent =
              offer.category == OfferCategory.atmCashout;
          final requiresEcommerceConsent =
              offer.category == OfferCategory.onlineService;

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
                        ? OfferQuote.takerFeeSats(
                          offer.amountSats,
                          coordInfo.takerFee,
                        )
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
                          final hasCategoryConsent =
                              (!requiresAtmConsent || _atmConsentAccepted) &&
                              (!requiresEcommerceConsent ||
                                  _ecommerceConsentAccepted);
                          final isButtonEnabled =
                              publicKey != null &&
                              hasReceivingWallet &&
                              isTermsAccepted &&
                              hasCategoryConsent &&
                              !_isLoadingTerms;

                          return isButtonEnabled
                              ? () async {
                                // Check if there is any receiving-capable wallet
                                final hasReceivingWalletNow = await ref.read(
                                  hasReceivingWalletProvider.future,
                                );
                                if (!mounted) return;
                                final scaffoldMessenger = _scaffoldMessenger();
                                if (!hasReceivingWalletNow) {
                                  _showReceivingWalletRequired(ref, t);
                                  return;
                                }

                                // Check if terms are accepted
                                if (coordInfo?.termsOfUsageNaddr != null &&
                                    !_termsAccepted) {
                                  // Should not happen if button is properly disabled, but check anyway
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t.coordinator.selector.termsAccept +
                                            t.coordinator.selector.termsOfUsage,
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                if (requiresAtmConsent &&
                                    !_atmConsentAccepted) {
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t.offers.errors.atmConsentRequired,
                                      ),
                                    ),
                                  );
                                  return;
                                }
                                if (requiresEcommerceConsent &&
                                    !_ecommerceConsentAccepted) {
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t
                                            .offers
                                            .errors
                                            .ecommerceConsentRequired,
                                      ),
                                    ),
                                  );
                                  return;
                                }

                                final takerId = publicKey;
                                final apiService = ref.read(apiServiceProvider);

                                try {
                                  final reservationTimestamp = await apiService
                                      .reserveOffer(
                                        offer.id,
                                        takerId,
                                        offer.coordinatorPubkey,
                                      );
                                  if (!mounted) return;

                                  if (reservationTimestamp != null) {
                                    final updatedOffer = offer.copyWith(
                                      status: OfferStatus.reserved,
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
                        error: (_, _) => null,
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
                    if (myActiveOffer.status == OfferStatus.reserved) {
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
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        // Fading gradient background from top-left into content
                        if (offer.category != null)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    _categoryGradientColors(offer.category)[0],
                                    _categoryGradientColors(
                                      offer.category,
                                    )[1],
                                    _categoryGradientColors(
                                      offer.category,
                                    )[1].withValues(alpha: 0.18),
                                    Colors.transparent,
                                  ],
                                  stops: const [0.0, 0.14, 0.30, 0.44],
                                ),
                              ),
                            ),
                          ),
                        // Ghost icon anchored top-left
                        if (offer.category != null &&
                            _categoryIcon(offer.category) != null)
                          Positioned(
                            left: -28,
                            top: -28,
                            child: _categoryIconWidget(
                              offer.category,
                              150,
                              Colors.white.withValues(alpha: 0.12),
                            ),
                          ),
                        Column(
                          children: [
                            // Single content area — gradient fades naturally into rows
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: [
                                  Text(
                                    '${(offer.fiatAmount * 100).round() % 100 == 0 ? offer.fiatAmount.toStringAsFixed(0) : offer.fiatAmount.toStringAsFixed(2)} ${offer.fiatCurrency}',
                                    style: TextStyle(
                                      fontSize: 42,
                                      fontWeight: FontWeight.w300,
                                      color: offer.category != null
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                  const SizedBox(height: 16),
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
                                  if (offer.status != OfferStatus.takerPaid)
                                    _buildInfoRow(
                                      t.offers.details.exchangeRate,
                                      '${_formatNumber(exchangeRate)} ${offer.fiatCurrency}/BTC',
                                      hasInfoIcon: true,
                                      onInfoTap:
                                          () => _showExchangeRateSourcesDialog(
                                            context,
                                          ),
                                    ),

                                  if (offer.status != OfferStatus.takerPaid)
                                    const SizedBox(height: 16),

                                  // Taker fee row (hide for takerPaid)
                                  if (offer.status != OfferStatus.takerPaid)
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

                                  if (offer.status != OfferStatus.takerPaid)
                                    const SizedBox(height: 24),

                                  // You'll receive row (highlighted) (hide for takerPaid)
                                  if (offer.status != OfferStatus.takerPaid)
                                    _buildInfoRow(
                                      t.offers.details.youllReceive,
                                      '$youllReceive sats',
                                      isHighlighted: true,
                                    ),

                                  if (offer.status != OfferStatus.takerPaid &&
                                      offer.category != null) ...[
                                    const SizedBox(height: 16),
                                    _buildInfoRow(
                                      t.offers.details.categoryLabel,
                                      _categoryLabel(context, offer.category),
                                      valuePrefix: _categoryAsset(
                                                offer.category,
                                              ) !=
                                              null
                                          ? Image.asset(
                                            _categoryAsset(offer.category)!,
                                            width: 22,
                                            height: 22,
                                          )
                                          : null,
                                      hasInfoIcon:
                                          _categoryTooltip(
                                            context,
                                            offer.category,
                                          ) !=
                                          null,
                                      onInfoTap: () {
                                        final tooltip = _categoryTooltip(
                                          context,
                                          offer.category,
                                        );
                                        if (tooltip == null) return;
                                        showDialog(
                                          context: context,
                                          builder:
                                              (context) => AlertDialog(
                                                title: Text(
                                                  t.offers.details.categoryLabel,
                                                ),
                                                content: Text(tooltip),
                                                actions: [
                                                  TextButton(
                                                    onPressed:
                                                        () => Navigator.of(
                                                          context,
                                                        ).pop(),
                                                    child: Text(
                                                      t.common.buttons.close,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                    ),
                                    if (isFunded &&
                                        offer.category ==
                                            OfferCategory.atmCashout) ...[
                                      const SizedBox(height: 14),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.orange.withValues(
                                            alpha: 0.08,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.orange.withValues(
                                              alpha: 0.25,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(
                                                  Icons.info_outline,
                                                  color: Colors.orange,
                                                ),
                                                const SizedBox(width: 10),
                                                Expanded(
                                                  child: Text(
                                                    t.offers.tooltips.atmCategory,
                                                    style: const TextStyle(
                                                      fontSize: 13,
                                                      height: 1.35,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                  value: _atmConsentAccepted,
                                                  activeColor: Colors.red,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _atmConsentAccepted =
                                                          value ?? false;
                                                    });
                                                  },
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _atmConsentAccepted =
                                                            !_atmConsentAccepted;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            top: 12,
                                                          ),
                                                      child: Text(
                                                        t
                                                            .offers
                                                            .details
                                                            .consents
                                                            .atm,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          height: 1.35,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                    if (isFunded &&
                                        offer.category ==
                                            OfferCategory.onlineService) ...[
                                      const SizedBox(height: 14),
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.all(12),
                                        decoration: BoxDecoration(
                                          color: Colors.amber.withValues(
                                            alpha: 0.12,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          border: Border.all(
                                            color: Colors.amber.withValues(
                                              alpha: 0.35,
                                            ),
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              t.offers.tooltips.ecommerceCategory,
                                              style: const TextStyle(
                                                fontSize: 13,
                                                height: 1.35,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Checkbox(
                                                  value:
                                                      _ecommerceConsentAccepted,
                                                  activeColor: Colors.red,
                                                  onChanged: (value) {
                                                    setState(() {
                                                      _ecommerceConsentAccepted =
                                                          value ?? false;
                                                    });
                                                  },
                                                ),
                                                Expanded(
                                                  child: GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        _ecommerceConsentAccepted =
                                                            !_ecommerceConsentAccepted;
                                                      });
                                                    },
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                            top: 12,
                                                          ),
                                                      child: Text(
                                                        t
                                                            .offers
                                                            .details
                                                            .consents
                                                            .ecommerce,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                          height: 1.35,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ],

                                  // Timing information for completed offers (takerPaid status)
                                  if (offer.status == OfferStatus.takerPaid &&
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
                                        (_, _) => _buildInfoRow(
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
                          child: _buildStatusRibbon(offer.status.name),
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
    IconData? leadingIcon,
    bool hasInfoIcon = false,
    bool isHighlighted = false,
    VoidCallback? onInfoTap,
    Widget? valuePrefix,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: hasInfoIcon ? onInfoTap : null,
          child: Row(
            children: [
              if (leadingIcon != null) ...[
                Icon(leadingIcon, size: 18, color: Colors.grey[700]),
                const SizedBox(width: 8),
              ],
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
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (valuePrefix != null) ...[
              valuePrefix,
              const SizedBox(width: 6),
            ],
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
                fontWeight: isHighlighted ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }

  /// Formats a number with spaces as thousand separators
  String _formatNumber(int number) {
    final localeTag = Localizations.localeOf(context).toLanguageTag();
    final formatter = NumberFormat.decimalPattern(localeTag);
    return formatter.format(number);
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
                if (coordInfo.icon != null) ...[
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
                  const SizedBox(width: 8),
                ],
                Text(
                  coordInfo.name,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
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
              color: Colors.black.withValues(alpha: 0.3),
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
    OfferStatus? status,
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
