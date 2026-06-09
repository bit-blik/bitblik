import 'dart:async'; // Import async for Timer

import 'package:flutter/foundation.dart';

import '../../i18n/gen/strings.g.dart'; // Import Slang
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../config/group_links.dart';
import 'package:bitblik_core/core.dart';
import '../utils/category_icons.dart';
import '../utils/bitcoin_display.dart';
import '../providers/providers.dart';
import '../widgets/lightning_address_widget.dart';
import '../widgets/premium_info.dart';
import '../widgets/progress_indicators.dart'; // Import the progress indicators
import 'taker_flow/taker_submit_blik_screen.dart'; // Import new screen
import 'taker_flow/taker_wait_confirmation_screen.dart'; // Import new screen

// --- OfferListScreen ---

class OfferListScreen extends ConsumerStatefulWidget {
  const OfferListScreen({super.key});

  @override
  ConsumerState<OfferListScreen> createState() => _OfferListScreenState();
}

class _OfferListScreenState extends ConsumerState<OfferListScreen> {
  CoordinatorInfo? _coordinatorInfo;
  Duration? _reservationDuration;
  bool _isLoadingCoordinatorConfig = true;
  String? _coordinatorConfigError;
  String? _selectedFinishedCoordinatorPubkey;
  String? _selectedStatsCoordinatorPubkey;

  @override
  void initState() {
    super.initState();
    // _loadCoordinatorConfig();
  }

  Future<bool> _checkTermsAcceptance(
    String coordinatorPubkey,
    String? termsOfUsageNaddr,
  ) async {
    if (termsOfUsageNaddr == null) {
      return true; // No terms, so accepted by default
    }

    final prefs = await SharedPreferences.getInstance();
    final key = 'terms_accepted_$coordinatorPubkey';
    return prefs.getBool(key) ?? false;
  }

  Future<void> _openTermsOfUsage(String naddr) async {
    final url = 'https://njump.to/$naddr';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> _openNostrProfile(String npub) async {
    final url = 'https://njump.to/$npub';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  Future<void> _showTermsAcceptanceDialog(
    BuildContext context,
    Offer offer,
    CoordinatorInfo? coordInfo,
    String publicKey,
    WidgetRef ref,
  ) async {
    final t = Translations.of(context);
    final router = GoRouter.of(context);
    // Prefer the kind-0 profile picture over the kind-15125 info icon.
    final coordIcon = ref
        .read(coordinatorRecordByPubkeyProvider(offer.coordinatorPubkey))
        ?.icon;
    bool termsAccepted = false;
    bool isLoadingTerms = true;

    // Load current acceptance state
    if (coordInfo?.termsOfUsageNaddr != null) {
      final accepted = await _checkTermsAcceptance(
        offer.coordinatorPubkey,
        coordInfo!.termsOfUsageNaddr,
      );
      termsAccepted = accepted;
      isLoadingTerms = false;
    } else {
      termsAccepted = true; // No terms, so accepted by default
      isLoadingTerms = false;
    }

    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            Future<void> saveTermsAcceptance(bool accepted) async {
              if (coordInfo?.termsOfUsageNaddr == null) return;

              final prefs = await SharedPreferences.getInstance();
              final key = 'terms_accepted_${offer.coordinatorPubkey}';
              await prefs.setBool(key, accepted);

              setState(() {
                termsAccepted = accepted;
              });
            }

            return AlertDialog(
              title: Text(t.coordinator.selector.termsOfUsage),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (coordInfo != null && coordInfo.name.isNotEmpty) ...[
                    Row(
                      children: [
                        if (coordIcon != null && coordIcon.isNotEmpty)
                          (coordIcon.startsWith('http')
                              ? Image.network(
                                coordIcon,
                                width: 32,
                                height: 32,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.account_circle,
                                      size: 32,
                                    ),
                              )
                              : Image.asset(
                                coordIcon,
                                width: 32,
                                height: 32,
                                errorBuilder:
                                    (context, error, stackTrace) => const Icon(
                                      Icons.account_circle,
                                      size: 32,
                                    ),
                              ))
                        else
                          const Icon(Icons.account_circle, size: 32),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            coordInfo.name,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[700],
                              fontSize: 16,
                            ),
                          ),
                        ),
                        if (coordInfo.nostrNpub != null) ...[
                          const SizedBox(width: 16),
                          IconButton(
                            icon: Image.asset(
                              'assets/nostr.png',
                              width: 32,
                              height: 32,
                            ),
                            tooltip: t.coordinator.selector.viewNostrProfile,
                            onPressed:
                                () => _openNostrProfile(coordInfo.nostrNpub!),
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                  if (isLoadingTerms)
                    const Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    )
                  else
                    Row(
                      children: [
                        Checkbox(
                          value: termsAccepted,
                          onChanged: (bool? value) {
                            saveTermsAcceptance(value ?? false);
                          },
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Flexible(
                                child: GestureDetector(
                                  onTap: () {
                                    saveTermsAcceptance(!termsAccepted);
                                  },
                                  child: Text(
                                    t.coordinator.selector.termsAccept,
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 14,
                                    ),
                                    softWrap: true,
                                  ),
                                ),
                              ),
                              Flexible(
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: GestureDetector(
                                    onTap:
                                        () => _openTermsOfUsage(
                                          coordInfo!.termsOfUsageNaddr!,
                                        ),
                                    child: Text(
                                      t.coordinator.selector.termsOfUsage,
                                      style: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 14,
                                        decoration: TextDecoration.underline,
                                      ),
                                      softWrap: true,
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
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(t.common.buttons.cancel),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                  },
                ),
                ElevatedButton(
                  child: Text(t.offers.actions.takeOffer),
                  onPressed:
                      termsAccepted
                          ? () async {
                            // Pop the terms dialog first
                            Navigator.of(dialogContext).pop();

                            // Terms are already saved via checkbox, proceed with taking offer

                            // Proceed with taking the offer
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
                                final Offer updatedOffer = offer.copyWith(
                                  status: OfferStatus.reserved,
                                  takerPubkey: takerId,
                                  reservedAt: reservationTimestamp,
                                );

                                await ref
                                    .read(activeOfferProvider.notifier)
                                    .setActiveOffer(updatedOffer);

                                // Navigate to submit BLIK screen
                                router.go("/submit-blik", extra: updatedOffer);
                              } else {
                                ref.read(errorProvider.notifier).state =
                                    t.reservations.errors.failedNoTimestamp;
                                if (scaffoldMessenger.mounted) {
                                  scaffoldMessenger.showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        t.reservations.errors.failedNoTimestamp,
                                      ),
                                    ),
                                  );
                                }
                                ref.invalidate(availableOffersProvider);
                              }
                            } catch (e) {
                              final errorMsg =
                                  e is CannotTakeOwnOfferException
                                      ? t.offers.errors.cannotTakeOwnOffer
                                      : t.reservations.errors.failedToReserve(
                                        details: e.toString(),
                                      );
                              ref.read(errorProvider.notifier).state = errorMsg;
                              if (scaffoldMessenger.mounted) {
                                scaffoldMessenger.showSnackBar(
                                  SnackBar(content: Text(errorMsg)),
                                );
                              }
                              ref.invalidate(availableOffersProvider);
                            }
                          }
                          : null,
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _loadCoordinatorConfig() async {
    if (!mounted) return;
    setState(() {
      _isLoadingCoordinatorConfig = true;
      _coordinatorConfigError = null;
    });
    try {
      final apiService = ref.read(apiServiceProvider);
      final offer = ref.read(activeOfferProvider);
      final coordinatorPubkey = offer?.coordinatorPubkey;
      if (coordinatorPubkey == null)
        throw Exception('No coordinator pubkey for active offer');
      final coordinatorInfo = apiService.getCoordinatorInfoByPubkey(
        coordinatorPubkey,
      );
      if (coordinatorInfo == null)
        throw Exception('No coordinator info found for pubkey');
      if (!mounted) return;
      setState(() {
        _coordinatorInfo = coordinatorInfo;
        _reservationDuration = Duration(
          seconds: coordinatorInfo.reservationSeconds,
        );
        _isLoadingCoordinatorConfig = false;
      });
    } catch (e) {
      if (!mounted) return;
      Logger.log.e(
        () =>
            "[OfferListScreen] Error loading coordinator info: ${e.toString()}",
      );
      setState(() {
        _isLoadingCoordinatorConfig = false;
        _coordinatorConfigError = t.system.errors.loadingCoordinatorConfig;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final router = GoRouter.of(context);
    final hasReceivingWalletAsync = ref.watch(hasReceivingWalletProvider);
    final t = Translations.of(context);
    final bitcoinDisplayUnit = ref.watch(bitcoinDisplayUnitProvider);

    final offersAsyncValue = ref.watch(availableOffersProvider);
    final publicKeyAsyncValue = ref.watch(publicKeyProvider);
    final myActiveOffer = ref.watch(activeOfferProvider);
    final selectedSystem = ref.watch(selectedPaymentSystemProvider);
    // Only coordinators serving the payment system selected in settings.
    final sortedAllCoordinators = ref
        .watch(discoveredCoordinatorsProvider)
        .maybeWhen(data: (r) => r, orElse: () => <CoordinatorRecord>[])
        .where((r) => r.paymentSystem == selectedSystem.id)
        .toList(growable: false);

    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (hasReceivingWalletAsync.maybeWhen(
            data: (value) => !value,
            orElse: () => false,
          ))
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: LightningAddressWidget.buildMissingReceivingWalletWarning(
                context,
                ref,
                t,
              ),
            ),
          Column(
            children: [
              Text(
                t.home.notifications.title,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 24),
              Wrap(
                alignment: WrapAlignment.center,
                spacing: 20,
                runSpacing: 4,
                children: [
                  // Telegram - only show if link is configured
                  if (GroupLinks.telegram.isNotEmpty)
                    InkWell(
                      onTap: () async {
                        final Uri url = Uri.parse(GroupLinks.telegram);
                        await launchUrl(url);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/telegram.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            t.home.notifications.telegram,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  // Element - only show if link is configured
                  if (GroupLinks.element.isNotEmpty)
                    InkWell(
                      onTap: () async {
                        final Uri url = Uri.parse(GroupLinks.element);
                        await launchUrl(url);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/element.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            t.home.notifications.element,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  // SimpleX - only show if link is configured
                  if (GroupLinks.simplex.isNotEmpty)
                    InkWell(
                      onTap: () async {
                        final Uri url = Uri.parse(GroupLinks.simplex);
                        await launchUrl(url);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/simplex.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            t.home.notifications.simplex,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                  // Signal - only show if link is configured
                  if (GroupLinks.signal.isNotEmpty)
                    InkWell(
                      onTap: () async {
                        final Uri url = Uri.parse(GroupLinks.signal);
                        await launchUrl(url);
                      },
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 23,
                            height: 23,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: ClipOval(
                              child: Image.asset(
                                'assets/signal.png',
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            t.home.notifications.signal,
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: offersAsyncValue.when(
              data: (offers) {
                if (offers.isEmpty) {
                  return Column(
                    children: [
                      SizedBox(height: 30),
                      Center(child: Text(t.offers.details.noAvailable)),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFEFF6FF),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: const Color(0xFFBFDBFE)),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Icon(
                                Icons.info_outline,
                                color: Color(0xFF2563EB),
                                size: 18,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  t.offers.details.noAvailableTip,
                                  textAlign: TextAlign.left,
                                  style: const TextStyle(
                                    color: Color(0xFF1D4ED8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 30),
                      const Divider(height: 32, thickness: 1),
                      Expanded(
                        child: _buildStatsSection(
                          context,
                          ref.watch(successfulOffersStatsProvider),
                          t,
                          sortedCoordinators: sortedAllCoordinators,
                          selectedCoordinatorPubkey:
                              _selectedStatsCoordinatorPubkey,
                          onCoordinatorChanged:
                              (pk) => setState(
                                () => _selectedStatsCoordinatorPubkey = pk,
                              ),
                          currency: selectedSystem.currency,
                        ),
                      ),
                    ],
                  );
                }
                // Separate finished offers
                final finishedStatuses = [
                  OfferStatus.settled,
                  OfferStatus.takerPaid,
                  OfferStatus.expired,
                  OfferStatus.cancelled,
                ];
                final conflictStatuses = [
                  OfferStatus.conflict,
                  OfferStatus.invalidBlik,
                  OfferStatus.dispute,
                ];
                // Only finished offers for the payment system selected in
                // settings (filters the coordinator dropdown too, since it is
                // derived from these offers).
                final finishedOffers =
                    offers
                        .where(
                          (offer) =>
                              finishedStatuses.contains(offer.status) &&
                              offer.fiatCurrency == selectedSystem.currency,
                        )
                        .toList();
                final activeOffers =
                    offers
                        .where(
                          (offer) =>
                              !finishedStatuses.contains(offer.status) &&
                              !conflictStatuses.contains(offer.status),
                        )
                        .toList();

                final bool showActiveOffersList = activeOffers.isNotEmpty;

                return Column(
                  children: [
                    // Active offers
                    Expanded(
                      child: RefreshIndicator(
                        onRefresh: () async {
                          Logger.log.d(
                            () => "[OfferListScreen] Manual refresh triggered.",
                          );
                          final apiService = await ref.read(
                            initializedApiServiceProvider.future,
                          );
                          await refreshAvailableOffersCache(
                            apiService,
                            ref.read(selectedPaymentSystemProvider),
                          );
                          ref.invalidate(availableOffersProvider);
                          ref.invalidate(activeOfferProvider);
                          await ref.read(availableOffersProvider.future);
                        },
                        child:
                            (!showActiveOffersList)
                                ? Container() // TODO empty no offers placeholder
                                : ListView.builder(
                                  itemCount: activeOffers.length,
                                  itemBuilder: (innerContext, index) {
                                    final offer = activeOffers[index];
                                    final bool isFunded =
                                        offer.status == OfferStatus.funded;
                                    final bool isReserved =
                                        offer.status == OfferStatus.reserved;
                                    final bool isBlikReceived =
                                        offer.status ==
                                        OfferStatus.blikReceived;
                                    // final bool isConflict = offer.status == OfferStatus.conflict;
                                    // final bool isInvalidBlik = offer.status == OfferStatus.invalidBlik;
                                    final publicKey = publicKeyAsyncValue.value;
                                    Widget? trailingWidget;

                                    if (isFunded) {
                                      trailingWidget = ElevatedButton(
                                        onPressed: publicKeyAsyncValue.maybeWhen(
                                          data:
                                              (publicKey) => () async {
                                                if (publicKey == null) {
                                                  return;
                                                }

                                                // Cannot take your own offer
                                                if (offer.makerPubkey ==
                                                    publicKey) {
                                                  ScaffoldMessenger.of(
                                                    context,
                                                  ).showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                        t
                                                            .offers
                                                            .errors
                                                            .cannotTakeOwnOffer,
                                                      ),
                                                    ),
                                                  );
                                                  return;
                                                }

                                                // Check if there is any receiving-capable wallet
                                                final hasReceivingWallet =
                                                    await ref.read(
                                                      hasReceivingWalletProvider
                                                          .future,
                                                    );
                                                if (!hasReceivingWallet) {
                                                  LightningAddressWidget.showReceivingWalletRequiredDialog(
                                                    context,
                                                    ref,
                                                    t,
                                                  );
                                                  return;
                                                }

                                                // Check terms acceptance
                                                final coordinatorInfoAsync = ref
                                                    .read(
                                                      coordinatorInfoByPubkeyProvider(
                                                        offer.coordinatorPubkey,
                                                      ),
                                                    );
                                                final coordInfo =
                                                    coordinatorInfoAsync
                                                        .valueOrNull;

                                                if (coordInfo
                                                        ?.termsOfUsageNaddr !=
                                                    null) {
                                                  final termsAccepted =
                                                      await _checkTermsAcceptance(
                                                        offer.coordinatorPubkey,
                                                        coordInfo!
                                                            .termsOfUsageNaddr,
                                                      );

                                                  if (!termsAccepted) {
                                                    await _showTermsAcceptanceDialog(
                                                      context,
                                                      offer,
                                                      coordInfo,
                                                      publicKey,
                                                      ref,
                                                    );
                                                    return;
                                                  }
                                                }

                                                final takerId = publicKey;
                                                final apiService = ref.read(
                                                  apiServiceProvider,
                                                );
                                                final scaffoldMessenger =
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    );

                                                try {
                                                  final reservationTimestamp =
                                                      await apiService
                                                          .reserveOffer(
                                                            offer.id,
                                                            takerId,
                                                            offer
                                                                .coordinatorPubkey,
                                                          );

                                                  if (reservationTimestamp !=
                                                      null) {
                                                    final Offer
                                                    updatedOffer = offer.copyWith(
                                                      status:
                                                          OfferStatus.reserved,
                                                      takerPubkey: takerId,
                                                      reservedAt:
                                                          reservationTimestamp,
                                                    );

                                                    ref
                                                        .read(
                                                          activeOfferProvider
                                                              .notifier,
                                                        )
                                                        .setActiveOffer(
                                                          updatedOffer,
                                                        );

                                                    // Navigate to submit BLIK screen
                                                    router.go(
                                                      "/submit-blik",
                                                      extra: updatedOffer,
                                                    );
                                                  } else {
                                                    ref
                                                        .read(
                                                          errorProvider
                                                              .notifier,
                                                        )
                                                        .state = t
                                                            .reservations
                                                            .errors
                                                            .failedNoTimestamp;
                                                    if (scaffoldMessenger
                                                        .mounted) {
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
                                                    ref.invalidate(
                                                      availableOffersProvider,
                                                    );
                                                  }
                                                } catch (e) {
                                                  final errorMsg =
                                                      e
                                                              is CannotTakeOwnOfferException
                                                          ? t
                                                              .offers
                                                              .errors
                                                              .cannotTakeOwnOffer
                                                          : t
                                                              .reservations
                                                              .errors
                                                              .failedToReserve(
                                                                details:
                                                                    e.toString(),
                                                              );
                                                  ref
                                                      .read(
                                                        errorProvider.notifier,
                                                      )
                                                      .state = errorMsg;
                                                  if (scaffoldMessenger
                                                      .mounted) {
                                                    scaffoldMessenger
                                                        .showSnackBar(
                                                          SnackBar(
                                                            content: Text(
                                                              errorMsg,
                                                            ),
                                                          ),
                                                        );
                                                  }
                                                  ref.invalidate(
                                                    availableOffersProvider,
                                                  );
                                                }
                                              },
                                          orElse: () => null,
                                        ),
                                        child: Text(t.offers.actions.take),
                                      );
                                    } else if (myActiveOffer != null &&
                                        offer.takerPubkey == publicKey &&
                                        offer.id == myActiveOffer.id &&
                                        (myActiveOffer.isInvalidBlik ||
                                            myActiveOffer.isConflict ||
                                            myActiveOffer.isDispute)) {
                                      // Show button for conflict, dispute, or invalidBlik if it's the active offer
                                      trailingWidget = ElevatedButton(
                                        child: Text(t.offers.actions.view),
                                        onPressed: () {
                                          if (myActiveOffer.isInvalidBlik) {
                                            router.go(
                                              '/taker-invalid-blik',
                                              extra: myActiveOffer,
                                            );
                                          } else if (myActiveOffer.isConflict ||
                                              myActiveOffer.isDispute) {
                                            router.go(
                                              '/taker-conflict',
                                              extra: myActiveOffer.id,
                                            );
                                          }
                                        },
                                      );
                                    } else if (isReserved || isBlikReceived) {
                                      if (myActiveOffer != null &&
                                          offer.id == myActiveOffer.id &&
                                          offer.takerPubkey == publicKey &&
                                          !myActiveOffer.isDispute) {
                                        trailingWidget = ElevatedButton(
                                          child: Text(t.offers.actions.view),
                                          onPressed: () {
                                            ref
                                                .read(
                                                  activeOfferProvider.notifier,
                                                )
                                                .setActiveOffer(myActiveOffer);

                                            // Determine which screen to navigate to based on status
                                            Widget destinationScreen;
                                            if (myActiveOffer.status ==
                                                OfferStatus.reserved) {
                                              destinationScreen =
                                                  TakerSubmitBlikScreen(
                                                    initialOffer: myActiveOffer,
                                                  );
                                            } else if (myActiveOffer.status ==
                                                    OfferStatus.blikReceived ||
                                                myActiveOffer.status ==
                                                    OfferStatus
                                                        .blikSentToMaker ||
                                                myActiveOffer.status ==
                                                    OfferStatus
                                                        .makerConfirmed) {
                                              destinationScreen =
                                                  TakerWaitConfirmationScreen(
                                                    offer: myActiveOffer,
                                                  );
                                            } else {
                                              Logger.log.e(
                                                () =>
                                                    "[OfferListScreen] Error: Resuming offer in unexpected state: ${myActiveOffer.status}",
                                              );
                                              ScaffoldMessenger.of(
                                                context,
                                              ).showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    t
                                                        .offers
                                                        .errors
                                                        .unexpectedState,
                                                  ),
                                                ),
                                              );
                                              return;
                                            }

                                            Navigator.of(
                                              context,
                                              rootNavigator: true,
                                            ).push(
                                              MaterialPageRoute(
                                                builder:
                                                    (context) =>
                                                        destinationScreen,
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        trailingWidget = Text(
                                          offer.status.name.toUpperCase(),
                                          style: TextStyle(
                                            color: Colors.grey[600],
                                            fontWeight: FontWeight.bold,
                                          ),
                                        );
                                      }
                                    } else {
                                      trailingWidget = Text(
                                        offer.status.name.toUpperCase(),
                                        style: TextStyle(
                                          color: Colors.grey[600],
                                          fontWeight: FontWeight.bold,
                                        ),
                                      );
                                    }

                                    return Column(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            if (kIsWeb) {
                                              context.go('/offers/${offer.id}');
                                            } else {
                                              context.push(
                                                '/offers/${offer.id}',
                                              );
                                            }
                                          },
                                          child: Card(
                                            margin: const EdgeInsets.symmetric(
                                              vertical: 5.0,
                                            ),
                                            child: Column(
                                              children: [
                                                if (isFunded)
                                                  FundedOfferProgressIndicator(
                                                    key: ValueKey(
                                                      'progress_funded_${offer.id}',
                                                    ),
                                                    createdAt: offer.createdAt,
                                                  ),
                                                if (isReserved &&
                                                    offer.reservedAt != null &&
                                                    _reservationDuration !=
                                                        null)
                                                  ReservationProgressIndicator(
                                                    key: ValueKey(
                                                      'progress_res_${offer.id}_${_reservationDuration!.inSeconds}',
                                                    ),
                                                    reservedAt:
                                                        offer.reservedAt!,
                                                    maxDuration:
                                                        _reservationDuration!,
                                                  ),
                                                if (isBlikReceived &&
                                                    offer.blikReceivedAt !=
                                                        null)
                                                  BlikConfirmationProgressIndicator(
                                                    key: ValueKey(
                                                      'progress_blik_${offer.id}',
                                                    ),
                                                    blikReceivedAt:
                                                        offer.blikReceivedAt!,
                                                    maxConfirmationTime:
                                                        (paymentSystemForCurrency(
                                                                  offer
                                                                      .fiatCurrency,
                                                                ) ??
                                                                kBlik)
                                                            .confirmationWindow,
                                                  ),

                                                ListTile(
                                                  leading:
                                                      offer.category != null
                                                          ? SizedBox(
                                                            width: 40,
                                                            height: 40,
                                                            child: Center(
                                                              child:
                                                                  categoryIconWidget(
                                                                    offer
                                                                        .category,
                                                                    28,
                                                                  ),
                                                            ),
                                                          )
                                                          : null,
                                                  title: Text(
                                                    t.offers.details
                                                        .amountWithCurrency(
                                                          amount: formatDouble(
                                                            offer.fiatAmount,
                                                          ),
                                                          currency:
                                                              offer
                                                                  .fiatCurrency,
                                                        ),
                                                  ),
                                                  titleTextStyle:
                                                      const TextStyle(
                                                        fontWeight:
                                                            FontWeight.w300,
                                                        fontSize: 24,
                                                        color: Colors.black,
                                                      ),
                                                  subtitle: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        '${t.offers.details.takerFeeLabel}: ${formatBitcoinAmount(context, bitcoinDisplayUnit, offer.takerFees ?? 0)}',
                                                      ),
                                                      if (offer.premiumPercent >
                                                          0) ...[
                                                        const SizedBox(
                                                          height: 6,
                                                        ),
                                                        PremiumChip(
                                                          premiumPercent:
                                                              offer
                                                                  .premiumPercent,
                                                          viewerRole:
                                                              PremiumViewerRole
                                                                  .taker,
                                                        ),
                                                      ],
                                                    ],
                                                  ),
                                                  subtitleTextStyle: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[700],
                                                  ),
                                                  isThreeLine: true,
                                                  trailing: trailingWidget,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                      ),
                    ),
                    // Finished offers section
                    if (finishedOffers.isNotEmpty)
                      Builder(
                        builder: (context) {
                          // Coordinators present in finished offers, ordered by score
                          final finishedPubkeys =
                              finishedOffers
                                  .map((o) => o.coordinatorPubkey)
                                  .toSet();
                          final sortedFinishedCoordinators =
                              sortedAllCoordinators
                                  .where(
                                    (r) =>
                                        finishedPubkeys.contains(r.pubkeyHex),
                                  )
                                  .toList();
                          // Include any pubkeys not yet in registry
                          for (final pk in finishedPubkeys) {
                            if (!sortedFinishedCoordinators.any(
                              (r) => r.pubkeyHex == pk,
                            )) {
                              sortedFinishedCoordinators.add(
                                CoordinatorRecord(pubkeyHex: pk),
                              );
                            }
                          }

                          // Effective selection: keep if valid, else default to first
                          final effectivePubkey =
                              sortedFinishedCoordinators.isNotEmpty
                                  ? (sortedFinishedCoordinators.any(
                                        (r) =>
                                            r.pubkeyHex ==
                                            _selectedFinishedCoordinatorPubkey,
                                      )
                                      ? _selectedFinishedCoordinatorPubkey!
                                      : sortedFinishedCoordinators
                                          .first
                                          .pubkeyHex)
                                  : null;

                          final filteredFinishedOffers =
                              effectivePubkey != null
                                  ? finishedOffers
                                      .where(
                                        (o) =>
                                            o.coordinatorPubkey ==
                                            effectivePubkey,
                                      )
                                      .toList()
                                  : finishedOffers;

                          return Padding(
                            padding: EdgeInsets.only(
                              top: showActiveOffersList ? 16.0 : 0,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      t.offers.details.finishedOffers,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    if (sortedFinishedCoordinators.length >
                                        1) ...[
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: DropdownButton<String>(
                                          value: effectivePubkey,
                                          isExpanded: true,
                                          isDense: true,
                                          underline: const SizedBox.shrink(),
                                          items:
                                              sortedFinishedCoordinators
                                                  .map(
                                                    (c) => DropdownMenuItem<
                                                      String
                                                    >(
                                                      value: c.pubkeyHex,
                                                      child: Text(
                                                        c.name,
                                                        overflow:
                                                            TextOverflow
                                                                .ellipsis,
                                                        style: const TextStyle(
                                                          fontSize: 13,
                                                        ),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                          onChanged: (value) {
                                            if (value != null) {
                                              setState(() {
                                                _selectedFinishedCoordinatorPubkey =
                                                    value;
                                              });
                                            }
                                          },
                                        ),
                                      ),
                                    ] else if (sortedFinishedCoordinators
                                        .isNotEmpty) ...[
                                      const SizedBox(width: 8),
                                      Text(
                                        sortedFinishedCoordinators.first.name,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Colors.grey[600],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ],
                                ),
                                const SizedBox(height: 8),
                                SizedBox(
                                  height: 72,
                                  child: Scrollbar(
                                    child: ListView.builder(
                                      shrinkWrap: !showActiveOffersList,
                                      physics:
                                          !showActiveOffersList
                                              ? const NeverScrollableScrollPhysics()
                                              : null,
                                      itemCount: filteredFinishedOffers.length,
                                      itemBuilder: (context, index) {
                                        final offer =
                                            filteredFinishedOffers[index];
                                        return Card(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 5.0,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                              horizontal: 16.0,
                                              vertical: 12.0,
                                            ),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  t.offers.details
                                                      .amountWithCurrency(
                                                        amount: formatDouble(
                                                          offer.fiatAmount,
                                                        ),
                                                        currency:
                                                            offer.fiatCurrency,
                                                      ),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    fontSize: 14,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  '${t.offers.details.amountLabel}: ${formatBitcoinAmount(context, bitcoinDisplayUnit, offer.amountSats)}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  '${t.offers.details.takerFeeLabel}: ${formatBitcoinAmount(context, bitcoinDisplayUnit, offer.takerFees ?? 0)}',
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey[600],
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 1,
                                                ),
                                                if (offer.premiumPercent >
                                                    0) ...[
                                                  const SizedBox(height: 4),
                                                  PremiumChip(
                                                    premiumPercent:
                                                        offer.premiumPercent,
                                                    viewerRole:
                                                        PremiumViewerRole.taker,
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                  ],
                );
              },
              loading: () {
                return Column(
                  children: [
                    SizedBox(height: 30),
                    Center(child: Text(t.offers.details.noAvailable)),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFF6FF),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: const Color(0xFFBFDBFE)),
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Icon(
                              Icons.info_outline,
                              color: Color(0xFF2563EB),
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                t.offers.details.noAvailableTip,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: Color(0xFF1D4ED8),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30),
                    const Divider(height: 32, thickness: 1),
                    Expanded(
                      child: _buildStatsSection(
                        context,
                        ref.watch(successfulOffersStatsProvider),
                        t,
                        currency: selectedSystem.currency,
                      ),
                    ),
                  ],
                );
              },
              error:
                  (error, stackTrace) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          t.offers.errors.loading(details: error.toString()),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton(
                          onPressed:
                              () => ref.invalidate(availableOffersProvider),
                          child: Text(t.common.buttons.retry),
                        ),
                      ],
                    ),
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

String formatDouble(double value) {
  // Check if the value is effectively a whole number
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  } else {
    // Format with up to 2 decimal places, removing trailing zeros
    String asString = value.toStringAsFixed(2);
    // Remove trailing zeros after decimal point
    if (asString.contains('.')) {
      asString = asString.replaceAll(RegExp(r'0+$'), '');
      // Remove decimal point if it's the last character
      if (asString.endsWith('.')) {
        asString = asString.substring(0, asString.length - 1);
      }
    }
    return asString;
  }
}

String _formatDurationFromSeconds(int? totalSeconds) {
  if (totalSeconds == null || totalSeconds < 0) {
    return '-';
  }
  if (totalSeconds == 0) {
    return '0s';
  }
  final duration = Duration(seconds: totalSeconds);
  final minutes = duration.inMinutes;
  final seconds = totalSeconds % 60;

  String result = '';
  if (minutes > 0) {
    result += '${minutes}m ';
  }
  if (seconds > 0 || minutes == 0) {
    result += '${seconds}s';
  }
  return result.trim();
}

String _formatTimeAgo(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  if (difference.inSeconds < 60) {
    return '${difference.inSeconds}s ago';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes}m ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours}h ago';
  } else {
    return '${difference.inDays}d ago';
  }
}

Widget _buildCoordinatorIcon(CoordinatorRecord c, {double size = 20}) {
  final icon = c.icon;
  if (icon != null && icon.isNotEmpty) {
    if (icon.startsWith('http')) {
      return Image.network(
        icon,
        width: size,
        height: size,
        errorBuilder: (ctx, err, st) => Icon(Icons.account_circle, size: size),
      );
    } else {
      return Image.asset(
        icon,
        width: size,
        height: size,
        errorBuilder: (ctx, err, st) => Icon(Icons.account_circle, size: size),
      );
    }
  }
  return Icon(Icons.account_circle, size: size);
}

Widget _buildStatsSection(
  BuildContext context,
  AsyncValue<Map<String, dynamic>> statsAsyncValue,
  Translations t, {
  List<CoordinatorRecord> sortedCoordinators = const [],
  String? selectedCoordinatorPubkey,
  ValueChanged<String>? onCoordinatorChanged,
  String? currency,
}) {
  return statsAsyncValue.when(
    data: (data) {
      final statsMap = data['stats'] as Map<String, dynamic>? ?? {};
      final last7Days = statsMap['last_7_days'] as Map<String, dynamic>? ?? {};

      final recentOffersData = data['offers'] as List<dynamic>? ?? [];
      // Restrict to the selected payment system so the coordinator dropdown
      // only lists coordinators that actually have finished offers for it.
      final allRecentOffers = recentOffersData
          .cast<Offer>()
          .where((o) => currency == null || o.fiatCurrency == currency)
          .toList();

      final localeTag = Localizations.localeOf(context).toLanguageTag();
      final numberFormat = NumberFormat.decimalPattern(localeTag);

      final last7DaysBlikTime =
          last7Days['avg_time_blik_received_to_created_seconds'] as num?;
      final last7DaysPaidTime =
          last7Days['avg_time_taker_paid_to_created_seconds'] as num?;

      // Build sorted coordinator list from offers present in the data
      final offerPubkeys =
          allRecentOffers.map((o) => o.coordinatorPubkey).toSet();
      final filteredSortedCoords =
          sortedCoordinators
              .where((r) => offerPubkeys.contains(r.pubkeyHex))
              .toList();
      for (final pk in offerPubkeys) {
        if (!filteredSortedCoords.any((r) => r.pubkeyHex == pk)) {
          filteredSortedCoords.add(CoordinatorRecord(pubkeyHex: pk));
        }
      }

      // Effective selection — always non-null when offers exist
      final effectivePubkey =
          filteredSortedCoords.isNotEmpty
              ? (filteredSortedCoords.any(
                    (r) => r.pubkeyHex == selectedCoordinatorPubkey,
                  )
                  ? selectedCoordinatorPubkey!
                  : filteredSortedCoords.first.pubkeyHex)
              : null;

      final recentOffers =
          effectivePubkey != null
              ? allRecentOffers
                  .where((o) => o.coordinatorPubkey == effectivePubkey)
                  .toList()
              : allRecentOffers;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            t.home.statistics.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          const SizedBox(height: 8),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Combine last 7d and avg stats into one line
                  Text(
                    t.home.statistics.last7DaysSingleLine(
                      count: numberFormat.format(last7Days['count'] ?? 0),
                      avgBlikTime: _formatDurationFromSeconds(
                        last7DaysBlikTime?.round(),
                      ),
                      avgPaidTime: _formatDurationFromSeconds(
                        last7DaysPaidTime?.round(),
                      ),
                    ),
                    style: const TextStyle(fontSize: 13),
                  ),

                  const SizedBox(height: 8),

                  // Coordinator filter — after stats, before list
                  if (filteredSortedCoords.isNotEmpty)
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            filteredSortedCoords.map((c) {
                              final selected = c.pubkeyHex == effectivePubkey;
                              return Padding(
                                padding: const EdgeInsets.only(right: 6),
                                child: FilterChip(
                                  avatar: _buildCoordinatorIcon(c, size: 16),
                                  label: Text(
                                    c.name,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  selected: selected,
                                  showCheckmark: false,
                                  onSelected:
                                      onCoordinatorChanged != null
                                          ? (_) =>
                                              onCoordinatorChanged(c.pubkeyHex)
                                          : null,
                                ),
                              );
                            }).toList(),
                      ),
                    ),

                  const SizedBox(height: 8),
                  if (recentOffers.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(t.offers.details.noSuccessfulTrades),
                    )
                  else
                    Expanded(
                      child: Scrollbar(
                        child: ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: recentOffers.length,
                          itemBuilder: (context, index) {
                            final offer = recentOffers[index];
                            return InkWell(
                              onTap: () {
                                if (kIsWeb) {
                                  context.go('/offers/${offer.id}');
                                } else {
                                  context.push('/offers/${offer.id}');
                                }
                              },
                              child: Card(
                                margin: const EdgeInsets.symmetric(
                                  vertical: 1.0,
                                  horizontal: 0,
                                ), // less margin
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0,
                                    vertical: 8.0,
                                  ), // less padding
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      // Amount and currency
                                      Text(
                                        t.offers.details.amountWithCurrency(
                                          amount: formatDouble(
                                            offer.fiatAmount,
                                          ),
                                          currency: offer.fiatCurrency,
                                        ),
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Date (now as time ago)
                                      Text(
                                        _formatTimeAgo(
                                          offer.createdAt.toLocal(),
                                        ),
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      // Taken after and Paid after (flexible to prevent overflow)
                                      Expanded(
                                        child: Row(
                                          children: [
                                            // Taken after (if available)
                                            if (offer.timeToReserveSeconds !=
                                                null)
                                              Flexible(
                                                child: Text(
                                                  t.offers.details.takenAfter(
                                                    duration:
                                                        _formatDurationFromSeconds(
                                                          offer
                                                              .timeToReserveSeconds,
                                                        ),
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                            if (offer.timeToReserveSeconds !=
                                                null)
                                              const SizedBox(width: 8),
                                            // Paid after (if available)
                                            if (offer
                                                    .totalCompletionTimeMakerSeconds !=
                                                null)
                                              Flexible(
                                                child: Text(
                                                  t.offers.details.paidAfter(
                                                    duration:
                                                        _formatDurationFromSeconds(
                                                          offer
                                                              .totalCompletionTimeMakerSeconds,
                                                        ),
                                                  ),
                                                  style: const TextStyle(
                                                    fontSize: 12,
                                                  ),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      );
    },
    loading: () => const Center(child: CircularProgressIndicator()),
    error:
        (error, stackTrace) => Center(
          child: Text(
            t.home.statistics.errors.loading(error: error.toString()),
          ),
        ),
  );
}
