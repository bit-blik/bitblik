import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// Accent color used for the maker premium throughout the app.
const Color kPremiumColor = Color(0xFFFF007F);

/// Accent color used for a maker discount (negative premium). Green because a
/// discount means the taker receives more sats than at the market rate.
const Color kDiscountColor = Color(0xFF1E9E5A);

enum PremiumViewerRole { maker, taker }

/// Trim trailing ".0" so 5.0 -> "5" but 2.5 stays "2.5".
String formatPremium(double premium) {
  final s = premium.toStringAsFixed(1);
  return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
}

/// Signed premium without the `%` sign: "+2.5" for a premium, "-3" for a
/// discount, "0" for market price.
String formatSignedPremium(double premium) {
  if (premium > 0) return '+${formatPremium(premium)}';
  if (premium < 0) return '-${formatPremium(-premium)}';
  return '0';
}

/// Accent for [premiumPercent]: pink for a premium, green for a discount,
/// [neutral] for market price.
Color premiumAccentColor(double premiumPercent, {Color neutral = Colors.grey}) {
  if (premiumPercent > 0) return kPremiumColor;
  if (premiumPercent < 0) return kDiscountColor;
  return neutral;
}

/// "Premium" or, for a negative value, "Discount".
String premiumLabel(Translations t, double premiumPercent) =>
    premiumPercent < 0 ? t.offers.labels.discount : t.offers.labels.premium;

/// "+2.5% premium" or "-3% discount".
String premiumBadgeText(Translations t, double premiumPercent) =>
    premiumPercent < 0
    ? t.offers.labels.discountBadge(percent: formatPremium(-premiumPercent))
    : t.offers.labels.premiumBadge(percent: formatPremium(premiumPercent));

/// Shows the premium (or, for a negative [premiumPercent], the discount)
/// explanation adjusted to the current viewer's role.
void showPremiumInfoDialog(
  BuildContext context, {
  PremiumViewerRole viewerRole = PremiumViewerRole.maker,
  double premiumPercent = 0,
}) {
  final t = Translations.of(context);
  final discount = premiumPercent < 0;
  final taker = viewerRole == PremiumViewerRole.taker;
  final body = discount
      ? (taker
            ? t.offers.tooltips.discountInfoTaker
            : t.maker.amountForm.tooltips.discountInfo)
      : (taker
            ? t.offers.tooltips.premiumInfoTaker
            : t.maker.amountForm.tooltips.premiumInfo);
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(
        discount
            ? t.maker.amountForm.labels.discount
            : t.maker.amountForm.labels.premium,
      ),
      content: Text(body),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(t.common.buttons.close),
        ),
      ],
    ),
  );
}

/// Compact `+X% premium` / `-X% discount` chip with an info icon, tappable to
/// explain the value.
class PremiumChip extends StatelessWidget {
  const PremiumChip({
    super.key,
    required this.premiumPercent,
    this.viewerRole = PremiumViewerRole.maker,
  });

  final double premiumPercent;
  final PremiumViewerRole viewerRole;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final color = premiumAccentColor(premiumPercent, neutral: kPremiumColor);
    return GestureDetector(
      onTap: () => showPremiumInfoDialog(
        context,
        viewerRole: viewerRole,
        premiumPercent: premiumPercent,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: color.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              premiumBadgeText(t, premiumPercent),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
            const SizedBox(width: 3),
            Icon(Icons.info_outline, size: 13, color: color),
          ],
        ),
      ),
    );
  }
}

/// Premium the maker form should use after selecting a coordinator that
/// allows [range]:
/// - market price (0) when premium pricing is off or the coordinator allows
///   neither a premium nor a discount;
/// - the maker's [defaultPreference] clamped to [range] until they move the
///   slider themselves;
/// - otherwise their [current] choice, clamped to [range].
double resolvePremiumForCoordinator({
  required bool premiumEnabled,
  required PremiumRange range,
  required bool userAdjusted,
  required double current,
  required double defaultPreference,
}) {
  if (!premiumEnabled || !range.isOffered) return 0;
  return range.clamp(userAdjusted ? current : defaultPreference);
}
