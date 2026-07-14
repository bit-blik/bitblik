import 'package:bitblik/src/utils/code_label_ext.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:bitblik_core/core.dart';
import '../providers/providers.dart'; // Needed for ref.invalidate
import '../../i18n/gen/strings.g.dart';

// Taker Progress Indicator Widget - reusable for taker flow screens
class TakerProgressIndicator extends ConsumerWidget {
  /// Logical step: 1 = submit code, 2 = confirm/wait, 3 = get paid.
  final int activeStep;

  const TakerProgressIndicator({super.key, this.activeStep = 1});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    // Resolve the method from the active offer (its payment-system id) or fall
    // back to the app's selected payment system, so step labels match.
    final offer = ref.watch(activeOfferProvider);
    final method =
        offer != null
            ? paymentSystemForOffer(offer)
            : ref.watch(selectedPaymentSystemProvider);
    final code = method.localizedCodeLabel;

    // Pull-style methods (e.g. MB WAY ATM) have no taker "Confirm" step — drop
    // it and renumber. The incoming activeStep keeps its logical meaning, so
    // map it onto the collapsed list (the wait phase falls onto "Get Paid").
    final labels = <String>[
      t.taker.progress.step1(code: code),
      if (method.requiresCodeConfirmation) t.taker.progress.step2(code: code),
      t.taker.progress.step3,
    ];
    final int active =
        method.requiresCodeConfirmation
            ? activeStep
            : (activeStep <= 1 ? 1 : 2);

    final children = <Widget>[];
    for (var i = 0; i < labels.length; i++) {
      final number = i + 1;
      if (i > 0) {
        children.add(
          const Text(' > ', style: TextStyle(fontSize: 14, color: Colors.grey)),
        );
      }
      children.add(
        Text(
          '$number. ${labels[i]}',
          style: TextStyle(
            fontSize: 13,
            fontWeight: number <= active ? FontWeight.w500 : FontWeight.w400,
            color: number == active ? Colors.black : Colors.grey,
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 8.0,
        runSpacing: 4.0,
        children: children,
      ),
    );
  }
}

// Widget for 10min Funded Offer Progress Bar
class FundedOfferProgressIndicator extends ConsumerStatefulWidget {
  final DateTime createdAt;

  const FundedOfferProgressIndicator({super.key, required this.createdAt});

  @override
  ConsumerState<FundedOfferProgressIndicator> createState() =>
      _FundedOfferProgressIndicatorState();
}

class _FundedOfferProgressIndicatorState
    extends ConsumerState<FundedOfferProgressIndicator> {
  Timer? _timer;
  double _progress = 1.0;
  int _remainingSeconds = 600; // 10 minutes
  final Duration _maxFundedTime = const Duration(minutes: 10);

  @override
  void initState() {
    super.initState();
    _calculateProgress();
    if (_progress <= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _triggerRefresh());
    } else {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant FundedOfferProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.createdAt != oldWidget.createdAt) {
      _timer?.cancel();
      _calculateProgress();
      if (_progress > 0) {
        _startTimer();
      } else {
        _triggerRefresh();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateProgress() {
    final now = DateTime.now();
    final expiresAt = widget.createdAt.add(_maxFundedTime);
    final totalDuration = _maxFundedTime.inMilliseconds;
    final remainingDuration = expiresAt.difference(now).inMilliseconds;
    if (!mounted) return;
    setState(() {
      if (remainingDuration <= 0) {
        _progress = 0.0;
        _remainingSeconds = 0;
      } else {
        _progress = remainingDuration / totalDuration;
        _remainingSeconds = (remainingDuration / 1000).ceil().clamp(0, 600);
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    if (_progress <= 0) return;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _calculateProgress();
      if (_progress <= 0) {
        timer.cancel();
        _triggerRefresh();
      }
    });
  }

  Future<void> _triggerRefresh() async {
    if (mounted) {
      ref.invalidate(availableOffersProvider);
    }
  }

  String _formatMMSS(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    if (_progress <= 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 25,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey[500],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            t.offers.progress.waitingForTaker(
              time: _formatMMSS(_remainingSeconds),
            ),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for Reservation Progress Bar (dynamic duration)
class ReservationProgressIndicator extends ConsumerStatefulWidget {
  final DateTime reservedAt;
  final Duration maxDuration; // Added maxDuration

  const ReservationProgressIndicator({
    super.key,
    required this.reservedAt,
    required this.maxDuration, // Added maxDuration
  });

  @override
  ConsumerState<ReservationProgressIndicator> createState() =>
      _ReservationProgressIndicatorState();
}

class _ReservationProgressIndicatorState
    extends ConsumerState<ReservationProgressIndicator> {
  Timer? _timer;
  double _progress = 1.0;
  late int _remainingSeconds; // Will be initialized in initState

  @override
  void initState() {
    super.initState();
    _remainingSeconds =
        widget.maxDuration.inSeconds; // Initialize with widget.maxDuration
    _calculateProgress();
    if (_progress <= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _triggerRefresh());
    } else {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant ReservationProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Check if either reservedAt or maxDuration changed
    if (widget.reservedAt != oldWidget.reservedAt ||
        widget.maxDuration != oldWidget.maxDuration) {
      Logger.log.d(
        () =>
            "[ReservationProgress] reservedAt or maxDuration changed. Recalculating.",
      );
      _timer?.cancel();
      _remainingSeconds =
          widget.maxDuration.inSeconds; // Re-initialize with new maxDuration
      _calculateProgress();
      if (_progress > 0) {
        _startTimer();
      } else {
        // If progress is already 0 (e.g. new maxDuration is very short or in the past)
        _triggerRefresh();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateProgress() {
    final now = DateTime.now();
    // Use widget.maxDuration
    final expiresAt = widget.reservedAt.add(widget.maxDuration);
    final totalDuration = widget.maxDuration.inMilliseconds;
    final remainingDuration = expiresAt.difference(now).inMilliseconds;

    if (!mounted) return;

    setState(() {
      if (remainingDuration <= 0) {
        _progress = 0.0;
        _remainingSeconds = 0;
      } else {
        _progress = remainingDuration / totalDuration;
        // Ensure remainingSeconds doesn't exceed maxDuration.inSeconds, useful if timer fires slightly late
        _remainingSeconds = (remainingDuration / 1000).ceil().clamp(
          0,
          widget.maxDuration.inSeconds,
        );
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    if (_progress <= 0) return;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _calculateProgress();
      if (_progress <= 0) {
        timer.cancel();
        _triggerRefresh();
      }
    });
  }

  Future<void> _triggerRefresh() async {
    Logger.log.d(
      () => "[ReservationProgress] Timer expired. Refreshing providers.",
    );
    if (mounted) {
      ref.invalidate(availableOffersProvider);
    } else {
      Logger.log.d(
        () => "[ReservationProgress] Widget disposed before refresh.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_progress <= 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 20,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey[500],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            t.offers.progress.reserved(seconds: _remainingSeconds),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Widget for the BLIK/payment-code Confirmation Progress Bar. The window length
// depends on the payment method (BLIK 2 min, MB WAY 30 min).
class BlikConfirmationProgressIndicator extends ConsumerStatefulWidget {
  final DateTime blikReceivedAt;

  /// Code-confirmation window for the offer's payment method. Defaults to the
  /// legacy BLIK 120s window.
  final Duration maxConfirmationTime;

  const BlikConfirmationProgressIndicator({
    super.key,
    required this.blikReceivedAt,
    this.maxConfirmationTime = const Duration(seconds: 120),
  });

  @override
  ConsumerState<BlikConfirmationProgressIndicator> createState() =>
      _BlikConfirmationProgressIndicatorState();
}

class _BlikConfirmationProgressIndicatorState
    extends ConsumerState<BlikConfirmationProgressIndicator> {
  Timer? _timer;
  double _progress = 1.0;
  late int _remainingSeconds = _maxConfirmationTime.inSeconds;
  Duration get _maxConfirmationTime => widget.maxConfirmationTime;

  @override
  void initState() {
    super.initState();
    _calculateProgress();
    if (_progress <= 0) {
      WidgetsBinding.instance.addPostFrameCallback((_) => _triggerRefresh());
    } else {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant BlikConfirmationProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.blikReceivedAt != oldWidget.blikReceivedAt) {
      Logger.log.d(
        () => "[BlikConfirmProgress] blikReceivedAt changed. Recalculating.",
      );
      _timer?.cancel();
      _calculateProgress();
      if (_progress > 0) {
        _startTimer();
      } else {
        _triggerRefresh();
      }
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateProgress() {
    final now = DateTime.now();
    final expiresAt = widget.blikReceivedAt.add(_maxConfirmationTime);
    final totalDuration = _maxConfirmationTime.inMilliseconds;
    final remainingDuration = expiresAt.difference(now).inMilliseconds;
    if (!mounted) return;
    setState(() {
      if (remainingDuration <= 0) {
        _progress = 0.0;
        _remainingSeconds = 0;
      } else {
        _progress = remainingDuration / totalDuration;
        _remainingSeconds = (remainingDuration / 1000).ceil().clamp(
          0,
          _maxConfirmationTime.inSeconds,
        );
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    if (_progress <= 0) return;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _calculateProgress();
      if (_progress <= 0) {
        timer.cancel();
        _triggerRefresh();
      }
    });
  }

  Future<void> _triggerRefresh() async {
    Logger.log.d(
      () => "[BlikConfirmProgress] Timer expired. Refreshing providers.",
    );
    if (mounted) {
      ref.invalidate(availableOffersProvider);
    } else {
      Logger.log.d(
        () => "[BlikConfirmProgress] Widget disposed before refresh.",
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_progress <= 0) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              height: 20,
              child: LinearProgressIndicator(
                value: _progress,
                backgroundColor: Colors.grey[500],
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Text(
            t.offers.progress.confirming(seconds: _remainingSeconds),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}

// Circular Countdown Timer Widget - reusable for multiple screens
class CircularCountdownTimer extends StatefulWidget {
  final DateTime startTime;
  final Duration maxDuration;
  final double size;
  final double strokeWidth;
  final Color progressColor;
  final Color backgroundColor;
  final double fontSize;

  const CircularCountdownTimer({
    super.key,
    required this.startTime,
    required this.maxDuration,
    this.size = 120,
    this.strokeWidth = 12,
    this.progressColor = Colors.green,
    this.backgroundColor = Colors.white,
    this.fontSize = 40,
  });

  @override
  State<CircularCountdownTimer> createState() => _CircularCountdownTimerState();
}

class _CircularCountdownTimerState extends State<CircularCountdownTimer> {
  Timer? _timer;
  double _progress = 1.0;
  int _remainingSeconds = 0;

  @override
  void initState() {
    super.initState();
    _calculateProgress();
    if (_remainingSeconds > 0) {
      _startTimer();
    }
  }

  @override
  void didUpdateWidget(covariant CircularCountdownTimer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.startTime != oldWidget.startTime ||
        widget.maxDuration != oldWidget.maxDuration) {
      _timer?.cancel();
      _calculateProgress();
      if (_remainingSeconds > 0) _startTimer();
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _calculateProgress() {
    final now = DateTime.now();
    final expiresAt = widget.startTime.add(widget.maxDuration);
    final totalDuration = widget.maxDuration.inMilliseconds;
    final remainingDuration = expiresAt.difference(now).inMilliseconds;
    final elapsedDuration = now.difference(widget.startTime).inMilliseconds;

    if (!mounted) return;

    setState(() {
      if (remainingDuration <= 0) {
        _progress = 1.0; // Full circle when time is up (all time spent)
        _remainingSeconds = 0;
      } else {
        // Progress represents elapsed time (spent time)
        _progress = (elapsedDuration / totalDuration).clamp(0.0, 1.0);
        _remainingSeconds = (remainingDuration / 1000).ceil().clamp(
          0,
          widget.maxDuration.inSeconds,
        );
      }
    });
  }

  void _startTimer() {
    _timer?.cancel();
    if (_remainingSeconds <= 0) return;

    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      _calculateProgress();
      if (_remainingSeconds <= 0) {
        timer.cancel();
      }
    });
  }

  String _formatTime(int totalSeconds) {
    if (totalSeconds < 60) {
      // Less than 1 minute: show as "Xs" (e.g., "45s")
      return '${totalSeconds}s';
    } else {
      // 1 minute or more: show as "M:SS" (e.g., "5:30")
      final minutes = (totalSeconds ~/ 60).toString();
      final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
      return '$minutes:$seconds';
    }
  }

  @override
  Widget build(BuildContext context) {
    // Upper-bound font size based on widget size. The text is wrapped in a
    // FittedBox constrained to the circle's inner width, so a short value like
    // "24s" renders at this size while a longer "30:00" is scaled down to fit
    // on one line — both stay legible regardless of digit count.
    final dynamicFontSize = widget.size * 0.35;
    // Usable width inside the ring (diameter minus both strokes and a margin).
    final innerWidth = widget.size - widget.strokeWidth * 2 - 12;

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background circle (white background for text)
          Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
          // Circular progress indicator (spent time - background color/white)
          SizedBox(
            width: widget.size,
            height: widget.size,
            child: CircularProgressIndicator(
              value: _progress,
              backgroundColor: widget.progressColor,
              valueColor: AlwaysStoppedAnimation<Color>(widget.backgroundColor),
              strokeWidth: widget.strokeWidth,
            ),
          ),
          // Time display — scaled to fit the ring's inner width on one line.
          SizedBox(
            width: innerWidth,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                _formatTime(_remainingSeconds),
                maxLines: 1,
                softWrap: false,
                style: TextStyle(
                  fontSize: dynamicFontSize,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
