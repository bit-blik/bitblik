import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';

/// A compact chip naming the bank an offer runs on, for bank-scoped markets
/// (SK cardless ATM). Renders nothing for bank-agnostic offers (BLIK, MB WAY,
/// TWINT). Short-validity banks (≤ 10 min, e.g. VÚB) get a warning accent so
/// takers notice the tight window before reserving.
class OfferBankBadge extends StatelessWidget {
  const OfferBankBadge({super.key, required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final bank = bankForOffer(offer);
    if (bank == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final isShortValidity = bank.validity.inMinutes <= 10;
    final accent =
        isShortValidity ? Colors.amber.shade800 : theme.colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(
          color: accent.withValues(alpha: 0.12),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: accent.withValues(alpha: 0.4)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isShortValidity ? Icons.timer_outlined : Icons.account_balance,
              size: 13,
              color: accent,
            ),
            const SizedBox(width: 4),
            Text(
              isShortValidity
                  ? '${bank.label} · ${bank.validity.inMinutes} min'
                  : bank.label,
              style: theme.textTheme.labelSmall?.copyWith(
                color: accent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
