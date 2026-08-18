import 'dart:async';

import '../../../i18n/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';

import 'package:bitblik_core/core.dart';
import '../../flow/flow_provider.dart' show flowRoute;
import '../../providers/providers.dart';
import '../../services/nostr_service.dart' show reservedOfferFromResult;
import '../../services/offer_db_service.dart';
import '../../utils/offer_status_label.dart';
import '../../widgets/critical_code_safety.dart';
import '../../widgets/progress_indicators.dart';

class TakerWaitConfirmationScreen extends ConsumerStatefulWidget {
  final Offer offer;

  const TakerWaitConfirmationScreen({required this.offer, super.key});

  @override
  ConsumerState<TakerWaitConfirmationScreen> createState() =>
      _TakerWaitConfirmationScreenState();
}

class _TakerWaitConfirmationScreenState
    extends ConsumerState<TakerWaitConfirmationScreen> {
  /// Payment method for this offer, resolved from its payment-system id
  /// (unambiguous across the EUR markets). Drives the confirmation window,
  /// validity text, and whether banking-app confirmation prompts are shown.
  PaymentSystem get _method => paymentSystemForOffer(widget.offer);

  /// Confirmation window for this offer — resolved per bank for bank-scoped
  /// markets (SK: Tatra 20 / SLSP 15 / VÚB 10 min), else the method default
  /// (BLIK 2 min, MB WAY 30 min).
  Duration get _confirmationDuration => validityForOffer(widget.offer);
  Timer? _confirmationTimer;
  Timer? _expiredBlikTimer;
  late int _confirmationCountdownSeconds = _confirmationDuration.inSeconds;
  bool _timersInitialized = false;
  bool _timerExpired = false;
  bool _expiredBlikWindowExpired = false;

  @override
  void initState() {
    super.initState();
    _validateInitialState();
  }

  void _validateInitialState() {
    final validStatuses = [
      OfferStatus.blikReceived,
      OfferStatus.blikSentToMaker,
      OfferStatus.makerConfirmed,
      OfferStatus.expiredBlik,
      OfferStatus.expiredSentBlik,
      OfferStatus.takerCharged,
    ];

    if (!validStatuses.contains(widget.offer.statusEnum)) {
      Logger.log.d(
        () =>
            "[TakerWaitConfirmation initState] Error: Received invalid offer state: ${widget.offer.status}. Resetting.",
      );
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _resetToOfferList(
            Translations.of(
              context,
            ).taker.waitConfirmation.errors.invalidOfferStateReceived,
          );
        }
      });
    }
  }

  @override
  void dispose() {
    _confirmationTimer?.cancel();
    _expiredBlikTimer?.cancel();
    super.dispose();
  }

  void _syncExpiredBlikTimer(Offer offer) {
    if (offer.statusEnum != OfferStatus.expiredBlik) {
      _expiredBlikTimer?.cancel();
      if (_expiredBlikWindowExpired) {
        setState(() {
          _expiredBlikWindowExpired = false;
        });
      }
      return;
    }

    final relistStart = offer.updatedAt ?? DateTime.now();
    final expiresAt = relistStart.add(const Duration(seconds: 60));
    final remaining = expiresAt.difference(DateTime.now());

    _expiredBlikTimer?.cancel();

    if (remaining <= Duration.zero) {
      if (!_expiredBlikWindowExpired) {
        setState(() {
          _expiredBlikWindowExpired = true;
        });
      }
      unawaited(_handleExpiredBlikWindowElapsed(offer));
      return;
    }

    if (_expiredBlikWindowExpired) {
      setState(() {
        _expiredBlikWindowExpired = false;
      });
    }

    _expiredBlikTimer = Timer(remaining, () {
      if (!mounted) return;
      setState(() {
        _expiredBlikWindowExpired = true;
      });
      unawaited(_handleExpiredBlikWindowElapsed(offer));
    });
  }

  Future<void> _handleExpiredBlikWindowElapsed(Offer offer) async {
    try {
      final apiService = await ref.read(initializedApiServiceProvider.future);
      final remote = await apiService.getOfferDetails(
        offer,
        offer.coordinatorPubkey,
      );

      if (remote == null) {
        await OfferDbService().deleteOfferById(offer.id);
        if (offer.holdInvoicePaymentHash != null &&
            offer.holdInvoicePaymentHash!.isNotEmpty &&
            offer.holdInvoicePaymentHash != offer.id) {
          await OfferDbService().deleteOfferById(offer.holdInvoicePaymentHash!);
        }
        await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
        if (mounted) {
          context.go('/offers');
        }
        return;
      }

      final refreshed = Offer.fromJson(remote);
      await ref.read(activeOfferProvider.notifier).setActiveOffer(refreshed);
      if (!mounted) return;

      if (refreshed.statusEnum == OfferStatus.funded) {
        await OfferDbService().deleteOfferById(refreshed.id);
        await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
        if (mounted) {
          context.go('/offers');
        }
        return;
      }

      _navigateToOfferDetails(refreshed.id);
    } catch (e) {
      Logger.log.w(
        () =>
            '[TakerWaitConfirmation] Failed reconciling expiredBlik relist expiry for ${offer.id}: $e',
      );
      await OfferDbService().deleteOfferById(offer.id);
      await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
      if (mounted) {
        context.go('/offers');
      }
    }
  }

  void _navigateToOfferDetails(String offerId) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.go('/offers/$offerId');
      }
    });
  }

  void _initializeOrUpdateCountdownTimer(Offer offer) {
    Logger.log.d(
      () => "[TakerWaitConfirmation] Initializing/Updating countdown timer...",
    );
    _startConfirmationTimer(offer);
    _timersInitialized = true;
  }

  void _startConfirmationTimer(Offer offer) {
    _confirmationTimer?.cancel();
    if (!mounted) return;

    final startTime = _confirmationStartTime(offer);
    final expiresAt = startTime.add(_confirmationDuration);
    final now = DateTime.now();
    final initialRemaining = expiresAt.difference(now);

    Logger.log.d(
      () =>
          "[TakerWaitConfirmation] Starting confirmation timer. Expires ~ $expiresAt",
    );

    if (initialRemaining.isNegative) {
      _handleConfirmationTimeout();
    } else {
      setState(() {
        _confirmationCountdownSeconds = initialRemaining.inSeconds.clamp(
          0,
          _confirmationDuration.inSeconds,
        );
      });
      _confirmationTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
        if (!mounted) {
          timer.cancel();
          return;
        }
        setState(() {
          if (_confirmationCountdownSeconds > 0) {
            _confirmationCountdownSeconds--;
          } else {
            timer.cancel();
            _handleConfirmationTimeout();
          }
        });
      });
    }
  }

  void _handleConfirmationTimeout() {
    _confirmationTimer?.cancel();
    if (mounted) {
      Logger.log.d(() => "[TakerWaitConfirmation] Confirmation timer expired.");
      setState(() {
        _timerExpired = true;
      });
    }
  }

  DateTime _confirmationStartTime(Offer offer) {
    return offer.blikReceivedAt ??
        offer.updatedAt ??
        offer.reservedAt ??
        offer.createdAt;
  }

  Future<void> _resetToOfferList(
    String message, {
    bool returnHome = false,
  }) async {
    _confirmationTimer?.cancel();
    ref.read(errorProvider.notifier).state = null;
    _timersInitialized = false;

    final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
    final navigator = Navigator.maybeOf(context);
    if (WidgetsBinding.instance.schedulerPhase != SchedulerPhase.idle) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          if (scaffoldMessenger != null) {
            scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
          }
          if (returnHome) {
            context.go('/');
          } else if (navigator != null && navigator.canPop()) {
            navigator.popUntil((route) => route.isFirst);
          }
        }
      });
    } else if (mounted) {
      if (scaffoldMessenger != null) {
        scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
      }
      context.go(returnHome ? '/' : '/offers');
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final offer = ref.watch(activeOfferProvider);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;

      if (offer == null) {
        Logger.log.d(
          () => "[TakerWaitConfirmation] Active offer is null. Resetting.",
        );
        _resetToOfferList(t.offers.status.cancelled);
        return;
      }

      _handleStatusTransitions(offer, t);
      _syncExpiredBlikTimer(offer);
    });

    if (offer == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_timersInitialized && _shouldInitializeTimer(offer)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _initializeOrUpdateCountdownTimer(offer);
      });
    }

    final isLoading = ref.watch(isLoadingProvider);
    final showChargedAction = offer.statusEnum == OfferStatus.expiredSentBlik;
    return Scaffold(
      body: _buildContentForStatus(context, offer),
      bottomNavigationBar:
          showChargedAction
              ? CriticalChargedActionBar(
                actionKey: const ValueKey('expired_sent_blik_charged_action'),
                label: t.taker.waitConfirmation.expiredActions.reportConflict(
                  code: offerCodeLabel(offer),
                ),
                onPressed: isLoading ? null : () => _reportCharged(offer),
                isLoading: isLoading,
              )
              : null,
    );
  }

  bool _shouldInitializeTimer(Offer offer) {
    return offer.statusEnum == OfferStatus.blikReceived ||
        offer.statusEnum == OfferStatus.blikSentToMaker;
  }

  void _handleStatusTransitions(Offer offer, Translations t) {
    final currentStatusEnum = offer.statusEnum;

    if (currentStatusEnum == OfferStatus.makerConfirmed ||
        currentStatusEnum == OfferStatus.settled ||
        currentStatusEnum == OfferStatus.payingTaker ||
        currentStatusEnum == OfferStatus.takerPaid) {
      Logger.log.d(
        () =>
            "[TakerWaitConfirmation] Status is $currentStatusEnum. Navigating to process screen.",
      );
      _confirmationTimer?.cancel();
      context.go(flowRoute);
    } else if (currentStatusEnum == OfferStatus.funded) {
      _confirmationTimer?.cancel();
      _expiredBlikTimer?.cancel();
      unawaited(_handleExpiredBlikWindowElapsed(offer));
    } else if (currentStatusEnum == OfferStatus.expiredBlik &&
        _expiredBlikWindowExpired) {
      _confirmationTimer?.cancel();
      unawaited(_handleExpiredBlikWindowElapsed(offer));
    } else if (currentStatusEnum == OfferStatus.invalidBlik) {
      _confirmationTimer?.cancel();
      _expiredBlikTimer?.cancel();
      context.go(flowRoute, extra: offer);
    } else if (currentStatusEnum == OfferStatus.conflict) {
      _confirmationTimer?.cancel();
      _expiredBlikTimer?.cancel();
      context.go(flowRoute, extra: offer.id);
    } else if (currentStatusEnum == OfferStatus.takerPaymentFailed) {
      _confirmationTimer?.cancel();
      _expiredBlikTimer?.cancel();
      context.go(flowRoute);
    } else if (!_isValidStatusForThisScreen(currentStatusEnum)) {
      _resetToOfferList(
        t.offers.errors.unexpectedStateWithStatus(
          status: currentStatusEnum.name,
        ),
      );
    }
  }

  bool _isValidStatusForThisScreen(OfferStatus status) {
    return status == OfferStatus.blikReceived ||
        status == OfferStatus.blikSentToMaker ||
        status == OfferStatus.expiredBlik ||
        status == OfferStatus.expiredSentBlik ||
        status == OfferStatus.takerCharged;
  }

  Widget _buildContentForStatus(BuildContext context, Offer offer) {
    final reminder = _categoryReminder(context, offer.category);
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const TakerProgressIndicator(activeStep: 2),
          const SizedBox(height: 10),
          if (reminder != null) ...[reminder, const SizedBox(height: 14)],
          _buildStatusWidget(context, offer),
        ],
      ),
    );
  }

  Widget? _categoryReminder(BuildContext context, OfferCategory? category) {
    final t = Translations.of(context);
    switch (category) {
      case OfferCategory.atm:
        return _buildCategoryReminderCard(
          text: t.taker.waitConfirmation.categoryReminder.atm,
          icon: Icons.local_atm_outlined,
          accent: Colors.orange,
        );
      case OfferCategory.online:
        return _buildCategoryReminderCard(
          text: t.taker.waitConfirmation.categoryReminder.ecommerce,
          icon: Icons.shopping_cart_checkout_outlined,
          accent: Colors.amber.shade800,
        );
      case OfferCategory.shop:
      case null:
        return null;
    }
  }

  Widget _buildCategoryReminderCard({
    required String text,
    required IconData icon,
    required Color accent,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: accent.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: accent.withValues(alpha: 0.25)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: accent),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 13, height: 1.35),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusWidget(BuildContext context, Offer offer) {
    switch (offer.statusEnum) {
      case OfferStatus.blikReceived:
        return _BlikReceivedWidget(
          offer: offer,
          confirmationStartTime: _confirmationStartTime(offer),
          maxConfirmationTime: _confirmationDuration,
          timerExpired: _timerExpired,
        );
      case OfferStatus.blikSentToMaker:
        return _BlikSentToMakerWidget(
          offer: offer,
          confirmationStartTime: _confirmationStartTime(offer),
          maxConfirmationTime: _confirmationDuration,
          timerExpired: _timerExpired,
          requiresConfirmation: _method.requiresCodeConfirmation,
          validityMinutes: _confirmationDuration.inMinutes,
        );
      case OfferStatus.expiredBlik:
        return _ExpiredBlikWidget(
          offer: offer,
          onResendBlik: _resendBlik,
          onCancelReservation: _cancelReservation,
          relistExpired: _expiredBlikWindowExpired,
        );
      case OfferStatus.expiredSentBlik:
        return _ExpiredSentBlikWidget(offer: offer, onResendBlik: _resendBlik);
      case OfferStatus.takerCharged:
        return _TakerChargedWidget(offer: offer);
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _resendBlik(Offer offer) async {
    if (!await showCriticalCodeDecisionDialog(
          context,
          code: offerCodeLabel(offer),
        ) ||
        !mounted) {
      return;
    }
    Logger.log.d(
      () => "[TakerWaitConfirmation] Retry selected for offer ${offer.id}",
    );

    final userPublicKey = await ref.read(publicKeyProvider.future);
    final takerId = userPublicKey;
    final apiService = ref.read(apiServiceProvider);
    final reservation = await apiService.reserveOffer(
      offer.id,
      takerId!,
      offer.coordinatorPubkey,
    );

    if (reservation.reservedAt != null || reservation.offer != null) {
      final Offer updatedOffer = reservedOfferFromResult(
        offer,
        takerId,
        reservation,
      );

      await ref.read(activeOfferProvider.notifier).setActiveOffer(updatedOffer);
      if (mounted) {
        context.go(flowRoute, extra: updatedOffer);
      }
    } else {
      if (mounted) {
        final t = Translations.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.taker.invalidBlik.errors.reservationFailed),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }

  Future<void> _reportCharged(Offer offer) async {
    ref.read(isLoadingProvider.notifier).state = true;
    ref.read(errorProvider.notifier).state = null;

    try {
      final apiService = ref.read(apiServiceProvider);
      Logger.log.i(
        () =>
            "[TakerWaitConfirmation] Reporting taker charged for offer ${offer.id}",
      );
      await apiService.markBlikCharged(offer.id, offer.coordinatorPubkey);

      // if (mounted) {
      //   final t = Translations.of(context);
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(
      //       content: Text(t.taker.waitConfirmation.feedback.conflictReported),
      //       backgroundColor: Colors.green,
      //     ),
      //   );
      //   context.go('/taker-conflict', extra: offer.id);
      // }
    } catch (e) {
      Logger.log.e(
        () => "[TakerWaitConfirmation] Error reporting conflict: $e",
      );
      if (mounted) {
        final t = Translations.of(context);
        ref.read(errorProvider.notifier).state = t.taker.waitConfirmation.errors
            .reportingConflict(details: e.toString());
      }
    } finally {
      if (mounted) {
        ref.read(isLoadingProvider.notifier).state = false;
      }
    }
  }

  Future<void> _cancelReservation(Offer offer) async {
    if (!await showCriticalCodeDecisionDialog(
          context,
          code: offerCodeLabel(offer),
        ) ||
        !mounted) {
      return;
    }
    final takerId = ref.read(publicKeyProvider).value;
    if (takerId == null) return;

    ref.read(isLoadingProvider.notifier).state = true;
    ref.read(errorProvider.notifier).state = null;

    try {
      final apiService = ref.read(apiServiceProvider);
      await apiService.cancelReservation(
        offer.id,
        takerId,
        offer.coordinatorPubkey,
      );
      if (mounted) {
        final t = Translations.of(context);
        _resetToOfferList(t.reservations.feedback.cancelled, returnHome: true);
      }
    } catch (e) {
      if (mounted) {
        final t = Translations.of(context);
        ref.read(errorProvider.notifier).state = t.reservations.errors
            .cancelling(error: e.toString());
      }
    } finally {
      if (mounted) {
        ref.read(isLoadingProvider.notifier).state = false;
      }
    }
  }
}

// ============================================================================
// Widget Components for Each Status
// ============================================================================

class _BlikReceivedWidget extends StatelessWidget {
  final Offer offer;
  final DateTime confirmationStartTime;
  final Duration maxConfirmationTime;
  final bool timerExpired;

  const _BlikReceivedWidget({
    required this.offer,
    required this.confirmationStartTime,
    required this.maxConfirmationTime,
    required this.timerExpired,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final code = offerCodeLabel(offer);

    return Column(
      children: [
        if (!timerExpired) ...[
          _buildStatusMessage(
            context,
            t.taker.waitConfirmation.waitingForMakerToReceive(code: code),
            isLoading: true,
          ),
          const SizedBox(height: 20),
        ],
        if (!timerExpired)
          CircularCountdownTimer(
            size: 200,
            key: ValueKey('confirmation_timer_${offer.id}'),
            startTime: confirmationStartTime,
            maxDuration: maxConfirmationTime,
            strokeWidth: 16,
            progressColor: Colors.blue,
            backgroundColor: Colors.white,
            fontSize: 8,
          )
        else if (timerExpired)
          const Icon(Icons.timer_off, size: 100, color: Colors.red),
        const SizedBox(height: 20),
      ],
    );
  }
}

class _BlikSentToMakerWidget extends StatelessWidget {
  final Offer offer;
  final DateTime confirmationStartTime;
  final Duration maxConfirmationTime;
  final bool timerExpired;

  /// Whether the taker has to approve the code in their banking app. When
  /// false (e.g. MB WAY ATM), banking-app prompts are suppressed.
  final bool requiresConfirmation;

  /// Code validity window in minutes, shown in the instruction/expiry text.
  final int validityMinutes;

  const _BlikSentToMakerWidget({
    required this.offer,
    required this.confirmationStartTime,
    required this.maxConfirmationTime,
    required this.timerExpired,
    required this.requiresConfirmation,
    required this.validityMinutes,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final code = offerCodeLabel(offer);

    return Column(
      children: [
        if (!timerExpired) ...[
          _buildInfoBox(
            context,
            t.taker.waitConfirmation.makerReceivedBlik(code: code),
            Icons.info_outline,
            Colors.blue,
          ),
          const SizedBox(height: 20),
          _buildStatusMessage(
            context,
            requiresConfirmation
                ? t.taker.waitConfirmation.instructions(
                  code: code,
                  minutes: validityMinutes,
                )
                : t.taker.waitConfirmation.instructionsNoConfirm(
                  code: code,
                  minutes: validityMinutes,
                ),
            isLoading: true,
          ),
          const SizedBox(height: 30),
        ],
        if (!timerExpired)
          CircularCountdownTimer(
            size: 200,
            key: ValueKey('confirmation_timer_${offer.id}'),
            startTime: confirmationStartTime,
            maxDuration: maxConfirmationTime,
            strokeWidth: 16,
            progressColor: Colors.blue,
            backgroundColor: Colors.white,
            fontSize: 8,
          )
        else if (timerExpired)
          const Icon(Icons.timer_off, size: 100, color: Colors.red),
        const SizedBox(height: 20),
        if (!timerExpired && requiresConfirmation)
          _buildWarningBox(
            context,
            t.taker.waitConfirmation.importantBlikAmountConfirmation(
              amount: formatDouble(offer.fiatAmount),
              currency: offer.fiatCurrency,
              code: code,
            ),
          ),
        if (timerExpired)
          _buildWarningBox(
            context,
            t.taker.waitConfirmation.timerExpiredMessage(
              code: code,
              minutes: validityMinutes,
            ),
          ),
      ],
    );
  }
}

class _ExpiredBlikWidget extends ConsumerWidget {
  final Offer offer;
  final Future<void> Function(Offer) onResendBlik;
  final Future<void> Function(Offer) onCancelReservation;
  final bool relistExpired;

  const _ExpiredBlikWidget({
    required this.offer,
    required this.onResendBlik,
    required this.onCancelReservation,
    required this.relistExpired,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final isLoading = ref.watch(isLoadingProvider);
    final errorMessage = ref.watch(errorProvider);
    final relistStart = offer.updatedAt ?? DateTime.now();
    final canCancel = !isLoading && !relistExpired;
    final code = offerCodeLabel(offer);

    return Column(
      children: [
        _buildExpiredIcon(),
        const SizedBox(height: 12),
        _buildExpiredTitle(t.taker.waitConfirmation.expiredTitle(code: code)),
        const SizedBox(height: 10),
        _buildWarningBox(
          context,
          t.taker.waitConfirmation.expiredWarning(code: code),
        ),
        const SizedBox(height: 10),
        Text(
          t['taker.waitConfirmation.expiredRelistCountdownLabel'],
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        CircularCountdownTimer(
          size: 92,
          key: ValueKey('expired_blik_relist_${offer.id}'),
          startTime: relistStart,
          maxDuration: const Duration(seconds: 60),
          strokeWidth: 8,
          progressColor: Colors.orange,
          backgroundColor: Colors.white,
          fontSize: 6,
        ),
        const SizedBox(height: 10),
        _buildInstructions(context, [
          t.taker.waitConfirmation.expiredInstruction1(code: code),
          t.taker.waitConfirmation.expiredInstruction2,
        ]),
        const SizedBox(height: 14),
        if (errorMessage != null) ...[
          _buildErrorMessage(context, errorMessage),
          const SizedBox(height: 10),
        ],
        _buildPrimaryButton(
          context,
          t.taker.waitConfirmation.expiredActions.renewReservation(code: code),
          Icons.refresh,
          Colors.green,
          isLoading ? null : () => onResendBlik(offer),
          isLoading: isLoading,
        ),
        const SizedBox(height: 8),
        _buildOutlinedButton(
          context,
          t.taker.waitConfirmation.expiredActions.cancelReservation,
          Icons.close,
          Colors.red,
          canCancel ? () => onCancelReservation(offer) : null,
        ),
      ],
    );
  }
}

class _ExpiredSentBlikWidget extends ConsumerWidget {
  final Offer offer;
  final Future<void> Function(Offer) onResendBlik;

  const _ExpiredSentBlikWidget({
    required this.offer,
    required this.onResendBlik,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final isLoading = ref.watch(isLoadingProvider);
    final errorMessage = ref.watch(errorProvider);
    final code = offerCodeLabel(offer);

    return Column(
      children: [
        _buildExpiredIcon(),
        const SizedBox(height: 20),
        _buildExpiredTitle(t.taker.waitConfirmation.expiredTitle(code: code)),
        const SizedBox(height: 16),
        _buildWarningBox(context, t.taker.waitConfirmation.expiredSentWarning),
        const SizedBox(height: 20),
        _buildInstructions(context, [
          t.taker.waitConfirmation.expiredInstruction1(code: code),
          t.taker.waitConfirmation.expiredInstruction3(code: code),
        ]),
        const SizedBox(height: 24),
        if (errorMessage != null) ...[
          _buildErrorMessage(context, errorMessage),
          const SizedBox(height: 16),
        ],
        _buildPrimaryButton(
          context,
          t.taker.waitConfirmation.expiredActions.renewReservation(code: code),
          Icons.refresh,
          Colors.green,
          isLoading ? null : () => onResendBlik(offer),
          isLoading: isLoading,
        ),
        const SizedBox(height: 12),
      ],
    );
  }
}

class _TakerChargedWidget extends ConsumerWidget {
  final Offer offer;

  const _TakerChargedWidget({required this.offer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    // Auto-confirm window advertised by the coordinator. Mirrors the
    // coordinator's timer which fires at offer.createdAt + this duration.
    final autoConfirmDuration = ref.watch(
      coordinatorTakerChargedAutoConfirmDurationProvider(
        offer.coordinatorPubkey,
      ),
    );
    final code = offerCodeLabel(offer);

    return Column(
      children: [
        _buildInfoBox(
          context,
          t.taker.waitConfirmation.takerCharged.title(code: code),
          Icons.check_circle_outline,
          Colors.green,
        ),
        const SizedBox(height: 20),
        // Countdown until the coordinator auto-confirms. Anchored to
        // offer.createdAt so it reflects real elapsed time across restarts.
        if (autoConfirmDuration != null)
          CircularCountdownTimer(
            size: 200,
            key: ValueKey('taker_charged_timer_${offer.id}'),
            startTime: offer.createdAt,
            maxDuration: autoConfirmDuration,
            strokeWidth: 16,
            progressColor: Colors.green,
            backgroundColor: Colors.white,
            fontSize: 4,
          ),
        const SizedBox(height: 20),
        _buildInfoBox(
          context,
          t.taker.waitConfirmation.takerCharged.message(
            minutes:
                (autoConfirmDuration ?? const Duration(minutes: 60)).inMinutes,
          ),
          Icons.info_outline,
          Colors.blue,
        ),
      ],
    );
  }
}

// ============================================================================
// Shared UI Helper Widgets
// ============================================================================

Widget _buildStatusMessage(
  BuildContext context,
  String message, {
  bool isLoading = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (isLoading)
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: SizedBox(
              width: 14,
              height: 14,
              child: CircularProgressIndicator(
                strokeWidth: 1,
                color: Colors.blue,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
              ),
            ),
          ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}

Widget _buildInfoBox(
  BuildContext context,
  String message,
  IconData icon,
  Color color,
) {
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(horizontal: 20),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: color.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: TextStyle(fontSize: 13, color: color),
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}

Widget _buildWarningBox(BuildContext context, String message) {
  return Container(
    padding: const EdgeInsets.all(12),
    margin: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.orange.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.orange.withValues(alpha: 0.3)),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 2),
          child: Icon(
            Icons.warning_amber_rounded,
            color: Colors.orange,
            size: 20,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            message,
            style: const TextStyle(fontSize: 13, color: Colors.orange),
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}

Widget _buildExpiredIcon() {
  return Container(
    width: 78,
    height: 78,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.orange.shade100,
    ),
    child: Icon(
      Icons.timer_off_outlined,
      size: 38,
      color: Colors.orange.shade700,
    ),
  );
}

Widget _buildExpiredTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _buildInstructions(BuildContext context, List<String> instructions) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          instructions.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(top: entry.key > 0 ? 8 : 0),
              child: _buildInstructionItem('-', entry.value),
            );
          }).toList(),
    ),
  );
}

Widget _buildInstructionItem(String bullet, String text) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.orange.shade100,
        ),
        child: Center(
          child: Text(
            bullet,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.orange.shade700,
            ),
          ),
        ),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Text(
          text,
          style: const TextStyle(fontSize: 14, color: Colors.black87),
        ),
      ),
    ],
  );
}

Widget _buildErrorMessage(BuildContext context, String message) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      message,
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
        fontSize: 14,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _buildPrimaryButton(
  BuildContext context,
  String label,
  IconData icon,
  Color color,
  VoidCallback? onPressed, {
  bool isLoading = false,
}) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            const SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.blue,
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
            const SizedBox(width: 8),
          ] else ...[
            Icon(icon, size: 20),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Text(
              label,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

Widget _buildOutlinedButton(
  BuildContext context,
  String label,
  IconData icon,
  Color color,
  VoidCallback? onPressed,
) {
  return Container(
    width: double.infinity,
    margin: const EdgeInsets.symmetric(horizontal: 20),
    child: OutlinedButton(
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        side: BorderSide(color: color, width: 1),
        padding: const EdgeInsets.symmetric(vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
            child: Icon(icon, size: 14, color: Colors.white),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    ),
  );
}

String formatDouble(double value) {
  if (value == value.roundToDouble()) {
    return value.toInt().toString();
  } else {
    String asString = value.toStringAsFixed(2);
    if (asString.contains('.')) {
      asString = asString.replaceAll(RegExp(r'0+$'), '');
      if (asString.endsWith('.')) {
        asString = asString.substring(0, asString.length - 1);
      }
    }
    return asString;
  }
}
