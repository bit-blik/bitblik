import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';

/// Compact chips naming the bank(s) an offer runs on, for bank-scoped markets
/// (SK cardless ATM). Renders nothing for bank-agnostic offers (BLIK, MB WAY,
/// TWINT). Short-validity banks (≤ 10 min, e.g. VÚB) get a warning accent so
/// takers notice the tight window before reserving.
///
/// An open multi-bank offer shows one chip per accepted bank — a taker from
/// any of them can take it. Once a taker holds it, only the bank they picked
/// is shown.
class OfferBankBadge extends StatelessWidget {
  const OfferBankBadge({super.key, required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    final running = bankForOffer(offer);
    final banks = offer.isMultiBank && offer.takerPubkey == null
        ? banksForOffer(offer)
        : [?running];
    if (banks.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.only(top: 6),
      child: Wrap(
        spacing: 4,
        runSpacing: 4,
        children: [for (final bank in banks) _BankChip(bank: bank)],
      ),
    );
  }
}

class _BankChip extends StatelessWidget {
  const _BankChip({required this.bank});

  final BankSpec bank;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isShortValidity = bank.validity.inMinutes <= 10;
    final accent =
        isShortValidity ? Colors.amber.shade800 : theme.colorScheme.primary;

    return Container(
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
    );
  }
}
