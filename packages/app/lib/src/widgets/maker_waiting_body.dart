import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart' show bitcoinDisplayUnitProvider;
import '../screens/maker_flow/maker_amount_form.dart'
    show MakerProgressIndicator;
import '../utils/bitcoin_display.dart';
import 'premium_info.dart';

/// Shared "maker waiting for the trade to progress" layout: progress steps,
/// spinner + message, a centered countdown, offer details and slots for an
/// error line and action buttons.
///
/// Purely presentational — the caller supplies the countdown widget and the
/// actions, so the same layout serves both the BLIK screen (client-side
/// timers and per-status navigation) and flow-driven bodies where
/// navigation/actions/timeouts are dictated by the flow yaml (TWINT today,
/// BLIK once migrated).
class MakerWaitingBody extends ConsumerWidget {
  final Offer offer;

  /// Short status line shown next to the small spinner. Null hides the row
  /// entirely (e.g. when an info section below already explains the state).
  final String? message;

  /// Centered widget under the message — typically a countdown circle while a
  /// deadline is running, or a plain spinner.
  final Widget countdown;

  /// Extra widgets between the message and the countdown (e.g. the maker's
  /// TWINT code box).
  final List<Widget> extra;

  /// Optional error line rendered above [actions].
  final Widget? error;

  /// Bottom action area (cancel button, FlowActionsBar, ...).
  final Widget? actions;

  /// Breadcrumb / progress indicator at the top. Defaults to the BLIK
  /// [MakerProgressIndicator] at step 2; TWINT passes its own indicator.
  final Widget progressIndicator;

  const MakerWaitingBody({
    super.key,
    required this.offer,
    this.message,
    required this.countdown,
    this.extra = const [],
    this.error,
    this.actions,
    this.progressIndicator = const MakerProgressIndicator(activeStep: 2),
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final bitcoinDisplayUnit = ref.watch(bitcoinDisplayUnitProvider);
    final fiat =
        (offer.fiatAmount * 100).round() % 100 == 0
            ? offer.fiatAmount.toStringAsFixed(0)
            : offer.fiatAmount.toStringAsFixed(2);

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progress indicator (default: step 2)
            progressIndicator,
            const SizedBox(height: 20),
            // Top section: Message with refresh icon
            if (message != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      message!,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                      textAlign: TextAlign.center,
                      softWrap: true,
                    ),
                  ),
                ],
              ),
            ...extra,
            const SizedBox(height: 30),

            // Center: countdown (or spinner) supplied by the caller
            Center(child: countdown),

            const SizedBox(height: 30),

            // Bottom section: offer details, error and actions
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDetailRow(
                  t.offers.details.amountLabel,
                  '$fiat ${offer.fiatCurrency}',
                ),
                const SizedBox(height: 8),
                _buildDetailRow(
                  t.maker.amountForm.labels.fee,
                  formatBitcoinAmount(
                    context,
                    bitcoinDisplayUnit,
                    offer.makerFees,
                  ),
                ),
                if (offer.premiumPercent > 0) ...[
                  const SizedBox(height: 8),
                  GestureDetector(
                    onTap: () => showPremiumInfoDialog(context),
                    child: _buildDetailRow(
                      t.offers.labels.premium,
                      '+${formatPremium(offer.premiumPercent)}%',
                    ),
                  ),
                ],
                const SizedBox(height: 30),
                if (error != null) error!,
                if (actions != null) actions!,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
