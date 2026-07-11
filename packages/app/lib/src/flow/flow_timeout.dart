import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';

/// Absolute UTC deadline at which [state]'s yaml timeout fires for [offer], or
/// null when the state has no timeout. The timer base honors the transition's
/// `from_field` (matching the coordinator's [_genericArmTimer]):
///   - `created_at`      -> total offer lifetime (not reset by reserve/revert)
///   - `code_received_at`-> continues from code submission
///   - (default)         -> state entry (`updated_at`)
DateTime? flowStateDeadline(FlowEngine engine, String state, Offer offer) {
  final tm = flowStateTimer(engine, state, offer);
  return tm == null ? null : tm.start.add(tm.max);
}

/// The (start, maxDuration) of [state]'s yaml timeout for [offer] — the inputs
/// the shared [CircularCountdownTimer] needs — or null when the state has no
/// timeout. Timer base honors the transition's `from_field` (see
/// [flowStateDeadline]).
({DateTime start, Duration max})? flowStateTimer(
    FlowEngine engine, String state, Offer offer) {
  final t = engine.timeoutFor(state);
  final secs = t?.durationSeconds;
  if (t == null || secs == null) return null;
  final base = switch (t.fromField) {
    'created_at' => offer.createdAt,
    'code_received_at' =>
      offer.blikReceivedAt ?? offer.updatedAt ?? offer.createdAt,
    _ => offer.updatedAt ?? offer.createdAt,
  };
  return (start: base.toUtc(), max: Duration(seconds: secs));
}

/// A live mm:ss countdown to [deadline]. Ticks once a second and calls
/// [onExpired] once when it reaches zero (e.g. to refresh the offer, since the
/// coordinator will have advanced the state). Renders nothing when [deadline]
/// is null.
class FlowCountdown extends StatefulWidget {
  final DateTime? deadline;
  final VoidCallback? onExpired;
  final TextStyle? style;

  /// Optional `{time}` template, e.g. `'Auto-cancels in {time}'`. When null only
  /// the mm:ss value is shown.
  final String Function(String time)? label;

  const FlowCountdown({
    super.key,
    required this.deadline,
    this.onExpired,
    this.style,
    this.label,
  });

  @override
  State<FlowCountdown> createState() => _FlowCountdownState();
}

class _FlowCountdownState extends State<FlowCountdown> {
  Timer? _timer;
  bool _firedExpired = false;

  @override
  void initState() {
    super.initState();
    _startTicker();
  }

  @override
  void didUpdateWidget(FlowCountdown old) {
    super.didUpdateWidget(old);
    if (old.deadline != widget.deadline) {
      _firedExpired = false;
      _startTicker();
    }
  }

  void _startTicker() {
    _timer?.cancel();
    if (widget.deadline == null) return;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {});
      if (_remaining() <= Duration.zero && !_firedExpired) {
        _firedExpired = true;
        widget.onExpired?.call();
      }
    });
  }

  Duration _remaining() {
    final d = widget.deadline;
    if (d == null) return Duration.zero;
    final r = d.difference(DateTime.now().toUtc());
    return r.isNegative ? Duration.zero : r;
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.deadline == null) return const SizedBox.shrink();
    final r = _remaining();
    final mm = r.inMinutes.toString().padLeft(2, '0');
    final ss = (r.inSeconds % 60).toString().padLeft(2, '0');
    final time = '$mm:$ss';
    final text = widget.label?.call(time) ?? time;
    return Text(text, style: widget.style);
  }
}
