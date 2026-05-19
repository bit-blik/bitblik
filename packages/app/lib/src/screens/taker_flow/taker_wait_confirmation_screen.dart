import 'dart:async';

import '../../../i18n/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';

import '../../models/offer.dart';
import '../../providers/providers.dart';
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
  Timer? _confirmationTimer;
  int _confirmationCountdownSeconds = 120;
  bool _timersInitialized = false;
  bool _timerExpired = false;
  Duration? _maxConfirmationTime;

  @override
  void initState() {
    super.initState();
    _validateInitialState();
    _fetchCoordinatorInfo();
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

  Future<void> _fetchCoordinatorInfo() async {
    try {
      final apiService = ref.read(apiServiceProvider);
      final coordinatorInfo = apiService.getCoordinatorInfoByPubkey(
        widget.offer.coordinatorPubkey,
      );
      if (coordinatorInfo != null) {
        setState(() {
          _maxConfirmationTime = const Duration(seconds: 120);
        });
      } else {
        setState(() {
          _maxConfirmationTime = const Duration(seconds: 120);
        });
      }
    } catch (e) {
      Logger.log.e(
        () => "[TakerWaitConfirmation] Error fetching coordinator info: $e",
      );
      setState(() {
        _maxConfirmationTime = const Duration(seconds: 120);
      });
    }
  }

  @override
  void dispose() {
    _confirmationTimer?.cancel();
    super.dispose();
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

    final startTime = offer.blikReceivedAt ?? DateTime.now();
    final expiresAt = startTime.add(const Duration(seconds: 120));
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
          120,
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

  Future<void> _resetToOfferList(String message) async {
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
          if (navigator != null && navigator.canPop()) {
            navigator.popUntil((route) => route.isFirst);
          }
        }
      });
    } else if (mounted) {
      if (scaffoldMessenger != null) {
        scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
      }
      context.go('/offers');
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
    });

    if (offer == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (!_timersInitialized && _shouldInitializeTimer(offer)) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _initializeOrUpdateCountdownTimer(offer);
      });
    }

    return Scaffold(body: _buildContentForStatus(context, offer));
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
      context.go("/paying-taker");
    } else if (currentStatusEnum == OfferStatus.invalidBlik) {
      _confirmationTimer?.cancel();
      context.go('/taker-invalid-blik', extra: offer);
    } else if (currentStatusEnum == OfferStatus.conflict) {
      _confirmationTimer?.cancel();
      context.go('/taker-conflict', extra: offer.id);
    } else if (currentStatusEnum == OfferStatus.takerPaymentFailed) {
      _confirmationTimer?.cancel();
      context.go('/paying-taker');
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
    return SingleChildScrollView(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const TakerProgressIndicator(activeStep: 2),
          const SizedBox(height: 10),
          _buildStatusWidget(context, offer),
        ],
      ),
    );
  }

  Widget _buildStatusWidget(BuildContext context, Offer offer) {
    switch (offer.statusEnum) {
      case OfferStatus.blikReceived:
        return _BlikReceivedWidget(
          offer: offer,
          maxConfirmationTime: _maxConfirmationTime,
          timerExpired: _timerExpired,
        );
      case OfferStatus.blikSentToMaker:
        return _BlikSentToMakerWidget(
          offer: offer,
          maxConfirmationTime: _maxConfirmationTime,
          timerExpired: _timerExpired,
        );
      case OfferStatus.expiredBlik:
        return _ExpiredBlikWidget(
          offer: offer,
          onResendBlik: _resendBlik,
          onCancelReservation: _cancelReservation,
        );
      case OfferStatus.expiredSentBlik:
        return _ExpiredSentBlikWidget(
          offer: offer,
          onResendBlik: _resendBlik,
          onReportConflict: _reportCharged,
        );
      case OfferStatus.takerCharged:
        return _TakerChargedWidget(offer: offer);
      default:
        return const SizedBox.shrink();
    }
  }

  Future<void> _resendBlik(Offer offer) async {
    Logger.log.d(
      () => "[TakerWaitConfirmation] Retry selected for offer ${offer.id}",
    );

    final userPublicKey = await ref.read(publicKeyProvider.future);
    final takerId = userPublicKey;
    final apiService = ref.read(apiServiceProvider);
    final DateTime? reservationTimestamp = await apiService.reserveOffer(
      offer.id,
      takerId!,
      offer.coordinatorPubkey,
    );

    if (reservationTimestamp != null) {
      final Offer updatedOffer = Offer(
        id: offer.id,
        amountSats: offer.amountSats,
        makerFees: offer.makerFees,
        fiatCurrency: offer.fiatCurrency,
        fiatAmount: offer.fiatAmount,
        coordinatorPubkey: offer.coordinatorPubkey,
        status: OfferStatus.reserved.name,
        createdAt: offer.createdAt,
        makerPubkey: offer.makerPubkey,
        takerPubkey: takerId,
        reservedAt: reservationTimestamp,
        blikReceivedAt: offer.blikReceivedAt,
        blikCode: offer.blikCode,
        holdInvoicePaymentHash: offer.holdInvoicePaymentHash,
      );

      await ref.read(activeOfferProvider.notifier).setActiveOffer(updatedOffer);
      if (mounted) {
        context.go("/submit-blik", extra: updatedOffer);
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
        _resetToOfferList(t.reservations.feedback.cancelled);
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
  final Duration? maxConfirmationTime;
  final bool timerExpired;

  const _BlikReceivedWidget({
    required this.offer,
    required this.maxConfirmationTime,
    required this.timerExpired,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      children: [
        if (!timerExpired) ...[
          _buildStatusMessage(
            context,
            t.taker.waitConfirmation.waitingForMakerToReceive,
            isLoading: true,
          ),
          const SizedBox(height: 20),
        ],
        if (offer.blikReceivedAt != null &&
            maxConfirmationTime != null &&
            !timerExpired)
          CircularCountdownTimer(
            size: 200,
            key: ValueKey('confirmation_timer_${offer.id}'),
            startTime: offer.blikReceivedAt!,
            maxDuration: maxConfirmationTime!,
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
  final Duration? maxConfirmationTime;
  final bool timerExpired;

  const _BlikSentToMakerWidget({
    required this.offer,
    required this.maxConfirmationTime,
    required this.timerExpired,
  });

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      children: [
        if (!timerExpired) ...[
          _buildInfoBox(
            context,
            t.taker.waitConfirmation.makerReceivedBlik,
            Icons.info_outline,
            Colors.blue,
          ),
          const SizedBox(height: 20),
          _buildStatusMessage(
            context,
            t.taker.waitConfirmation.instructions,
            isLoading: true,
          ),
          const SizedBox(height: 30),
        ],
        if (offer.blikReceivedAt != null &&
            maxConfirmationTime != null &&
            !timerExpired)
          CircularCountdownTimer(
            size: 200,
            key: ValueKey('confirmation_timer_${offer.id}'),
            startTime: offer.blikReceivedAt!,
            maxDuration: maxConfirmationTime!,
            strokeWidth: 16,
            progressColor: Colors.blue,
            backgroundColor: Colors.white,
            fontSize: 8,
          )
        else if (timerExpired)
          const Icon(Icons.timer_off, size: 100, color: Colors.red),
        const SizedBox(height: 20),
        if (!timerExpired)
          _buildWarningBox(
            context,
            t.taker.waitConfirmation.importantBlikAmountConfirmation(
              amount: formatDouble(offer.fiatAmount),
              currency: offer.fiatCurrency,
            ),
          ),
        if (timerExpired)
          _buildWarningBox(
            context,
            t.taker.waitConfirmation.timerExpiredMessage,
          ),
      ],
    );
  }
}

class _ExpiredBlikWidget extends ConsumerWidget {
  final Offer offer;
  final Future<void> Function(Offer) onResendBlik;
  final Future<void> Function(Offer) onCancelReservation;

  const _ExpiredBlikWidget({
    required this.offer,
    required this.onResendBlik,
    required this.onCancelReservation,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final isLoading = ref.watch(isLoadingProvider);
    final errorMessage = ref.watch(errorProvider);

    return Column(
      children: [
        _buildExpiredIcon(),
        const SizedBox(height: 20),
        _buildExpiredTitle(t.taker.waitConfirmation.expiredTitle),
        const SizedBox(height: 16),
        _buildWarningBox(context, t.taker.waitConfirmation.expiredWarning),
        const SizedBox(height: 20),
        _buildInstructions(context, [
          t.taker.waitConfirmation.expiredInstruction1,
          t.taker.waitConfirmation.expiredInstruction2,
        ]),
        const SizedBox(height: 24),
        if (errorMessage != null) ...[
          _buildErrorMessage(context, errorMessage),
          const SizedBox(height: 16),
        ],
        _buildPrimaryButton(
          context,
          t.taker.waitConfirmation.expiredActions.renewReservation,
          Icons.refresh,
          Colors.green,
          isLoading ? null : () => onResendBlik(offer),
          isLoading: isLoading,
        ),
        const SizedBox(height: 12),
        _buildOutlinedButton(
          context,
          t.taker.waitConfirmation.expiredActions.cancelReservation,
          Icons.close,
          Colors.red,
          isLoading ? null : () => onCancelReservation(offer),
        ),
      ],
    );
  }
}

class _ExpiredSentBlikWidget extends ConsumerWidget {
  final Offer offer;
  final Future<void> Function(Offer) onResendBlik;
  final Future<void> Function(Offer) onReportConflict;

  const _ExpiredSentBlikWidget({
    required this.offer,
    required this.onResendBlik,
    required this.onReportConflict,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final isLoading = ref.watch(isLoadingProvider);
    final errorMessage = ref.watch(errorProvider);

    return Column(
      children: [
        _buildExpiredIcon(),
        const SizedBox(height: 20),
        _buildExpiredTitle(t.taker.waitConfirmation.expiredTitle),
        const SizedBox(height: 16),
        _buildWarningBox(context, t.taker.waitConfirmation.expiredSentWarning),
        const SizedBox(height: 20),
        _buildInstructions(context, [
          t.taker.waitConfirmation.expiredInstruction1,
          t.taker.waitConfirmation.expiredInstruction3,
        ]),
        const SizedBox(height: 24),
        if (errorMessage != null) ...[
          _buildErrorMessage(context, errorMessage),
          const SizedBox(height: 16),
        ],
        _buildPrimaryButton(
          context,
          t.taker.waitConfirmation.expiredActions.renewReservation,
          Icons.refresh,
          Colors.green,
          isLoading ? null : () => onResendBlik(offer),
          isLoading: isLoading,
        ),
        const SizedBox(height: 12),
        _buildPrimaryButton(
          context,
          t.taker.waitConfirmation.expiredActions.reportConflict,
          Icons.report_problem_outlined,
          Colors.red,
          isLoading ? null : () => onReportConflict(offer),
          isLoading: isLoading,
        ),
      ],
    );
  }
}

class _TakerChargedWidget extends StatelessWidget {
  final Offer offer;

  const _TakerChargedWidget({required this.offer});

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);

    return Column(
      children: [
        _buildInfoBox(
          context,
          t.taker.waitConfirmation.takerCharged.title,
          Icons.check_circle_outline,
          Colors.green,
        ),
        const SizedBox(height: 20),
        // Show 60-minute countdown timer
        if (offer.blikReceivedAt != null)
          CircularCountdownTimer(
            size: 200,
            key: ValueKey('taker_charged_timer_${offer.id}'),
            startTime: offer.blikReceivedAt!,
            maxDuration: const Duration(minutes: 5),
            strokeWidth: 16,
            progressColor: Colors.green,
            backgroundColor: Colors.white,
            fontSize: 4,
          ),
        const SizedBox(height: 20),
        _buildInfoBox(
          context,
          t.taker.waitConfirmation.takerCharged.message,
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
    padding: const EdgeInsets.all(16),
    margin: const EdgeInsets.symmetric(horizontal: 20),
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
            style: const TextStyle(fontSize: 14, color: Colors.orange),
            softWrap: true,
          ),
        ),
      ],
    ),
  );
}

Widget _buildExpiredIcon() {
  return Container(
    width: 120,
    height: 120,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Colors.orange.shade100,
    ),
    child: Icon(
      Icons.timer_off_outlined,
      size: 60,
      color: Colors.orange.shade700,
    ),
  );
}

Widget _buildExpiredTitle(String title) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Text(
      title,
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      textAlign: TextAlign.center,
    ),
  );
}

Widget _buildInstructions(BuildContext context, List<String> instructions) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
          instructions.asMap().entries.map((entry) {
            return Padding(
              padding: EdgeInsets.only(top: entry.key > 0 ? 12 : 0),
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
          style: const TextStyle(fontSize: 15, color: Colors.black87),
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
