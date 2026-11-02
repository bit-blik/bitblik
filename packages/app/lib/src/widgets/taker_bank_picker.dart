import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';

import '../../i18n/gen/strings.g.dart';
import '../settings/app_preferences.dart';

/// What the taker decided in [chooseTakerBank]: go ahead (with [bank] when
/// the offer needed a choice), or stop because they dismissed the chooser.
typedef TakerBankChoice = ({bool proceed, String? bank});

/// For a multi-bank SK offer, asks the taker which of the maker's accepted
/// banks they will generate the code in — the maker then withdraws at that
/// bank's ATM, with that bank's code window. One tap picks and continues; the
/// bank picked last time is marked.
///
/// Single-bank and bank-agnostic offers need no choice and return
/// `(proceed: true, bank: null)` without showing anything. Dismissing the
/// chooser returns `proceed: false`.
Future<TakerBankChoice> chooseTakerBank(
  BuildContext context,
  Offer offer,
) async {
  final banks = banksForOffer(offer);
  if (banks.length < 2) return (proceed: true, bank: null);

  final marketId = paymentSystemForOffer(offer).id;
  final last = await AppPreferencesStore.loadLastTakerBank(marketId);
  if (!context.mounted) return (proceed: false, bank: null);

  final picked = await showModalBottomSheet<String>(
    context: context,
    showDragHandle: true,
    builder: (sheetContext) => TakerBankChooser(
      banks: banks,
      lastBankId: last,
      onPicked: (id) => Navigator.of(sheetContext).pop(id),
    ),
  );
  if (picked == null) return (proceed: false, bank: null);
  await AppPreferencesStore.saveLastTakerBank(marketId, picked);
  return (proceed: true, bank: picked);
}

/// The list behind [chooseTakerBank]: one row per accepted bank, with how
/// long that bank's code stays valid. Short windows (≤ 10 min) get the same
/// amber accent as the offer badge.
class TakerBankChooser extends StatelessWidget {
  const TakerBankChooser({
    super.key,
    required this.banks,
    required this.onPicked,
    this.lastBankId,
  });

  final List<BankSpec> banks;
  final String? lastBankId;
  final ValueChanged<String> onPicked;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final theme = Theme.of(context);
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.offers.takerBank.title, style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(t.offers.takerBank.subtitle, style: theme.textTheme.bodySmall),
            const SizedBox(height: 8),
            for (final bank in banks)
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: Icon(
                  bank.validity.inMinutes <= 10
                      ? Icons.timer_outlined
                      : Icons.account_balance,
                  color: bank.validity.inMinutes <= 10
                      ? Colors.amber.shade800
                      : theme.colorScheme.primary,
                ),
                title: Text(bank.label),
                subtitle: Text(
                  t.offers.takerBank.validity(
                    minutes: bank.validity.inMinutes,
                  ),
                ),
                trailing: bank.id == lastBankId
                    ? Icon(Icons.check, color: theme.colorScheme.primary)
                    : const Icon(Icons.chevron_right),
                onTap: () => onPicked(bank.id),
              ),
          ],
        ),
      ),
    );
  }
}
