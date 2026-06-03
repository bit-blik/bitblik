import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';

/// Accent color used for the maker premium throughout the app.
const Color kPremiumColor = Color(0xFFFF007F);

enum PremiumViewerRole { maker, taker }

/// Trim trailing ".0" so 5.0 -> "5" but 2.5 stays "2.5".
String formatPremium(double premium) {
  final s = premium.toStringAsFixed(1);
  return s.endsWith('.0') ? s.substring(0, s.length - 2) : s;
}

/// Shows the premium explanation adjusted to the current viewer's role.
void showPremiumInfoDialog(
  BuildContext context, {
  PremiumViewerRole viewerRole = PremiumViewerRole.maker,
}) {
  final t = Translations.of(context);
  final body =
      viewerRole == PremiumViewerRole.taker
          ? t.offers.tooltips.premiumInfoTaker
          : t.maker.amountForm.tooltips.premiumInfo;
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(t.maker.amountForm.labels.premium),
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

/// Compact `+X% premium` chip with an info icon, tappable to explain the value.
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
    return GestureDetector(
      onTap: () => showPremiumInfoDialog(context, viewerRole: viewerRole),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: kPremiumColor.withValues(alpha: 0.10),
          borderRadius: BorderRadius.circular(999),
          border: Border.all(color: kPremiumColor.withValues(alpha: 0.35)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              t.offers.labels.premiumBadge(percent: formatPremium(premiumPercent)),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: kPremiumColor,
              ),
            ),
            const SizedBox(width: 3),
            const Icon(Icons.info_outline, size: 13, color: kPremiumColor),
          ],
        ),
      ),
    );
  }
}
