import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../settings/app_preferences.dart';
import '../utils/bitcoin_display.dart';

class DisplaySettingsScreen extends ConsumerWidget {
  const DisplaySettingsScreen({super.key});

  static const routeName = '/settings/display';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final settings = ref.watch(bitcoinDisplayUnitProvider);

    return Scaffold(
      appBar: AppBar(title: Text(t.settings.display.title)),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        t.settings.display.bitcoinUnit,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        t.settings.display.bitcoinUnitDescription,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                SegmentedButton<BitcoinDisplayUnit>(
                  segments: [
                    ButtonSegment(
                      value: BitcoinDisplayUnit.sats,
                      label: Text(
                        formatBitcoinAmount(
                          context,
                          BitcoinDisplayUnit.sats,
                          1234,
                        ),
                      ),
                    ),
                    ButtonSegment(
                      value: BitcoinDisplayUnit.bitcoin,
                      label: Text(
                        formatBitcoinAmount(
                          context,
                          BitcoinDisplayUnit.bitcoin,
                          1234,
                        ),
                      ),
                    ),
                  ],
                  selected: {settings},
                  showSelectedIcon: false,
                  onSelectionChanged:
                      (selection) => ref
                          .read(bitcoinDisplayUnitProvider.notifier)
                          .set(selection.first),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
