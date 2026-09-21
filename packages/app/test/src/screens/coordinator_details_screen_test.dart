import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/screens/coordinator_details_screen.dart';
import 'package:bitblik/src/settings/app_preferences.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _Connectivity extends StateNotifier<Map<String, RelayStatus>>
    implements RelayConnectivityNotifier {
  _Connectivity() : super(const {});

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _DisplayUnit extends StateNotifier<BitcoinDisplayUnit>
    implements BitcoinDisplayUnitNotifier {
  _DisplayUnit() : super(BitcoinDisplayUnit.sats);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('shows Nostr profile button without coordinator info metadata', (
    tester,
  ) async {
    await LocaleSettings.setLocale(AppLocale.en);
    final pubkey = '01' * 32;
    final record = CoordinatorRecord(pubkeyHex: pubkey);

    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            coordinatorRecordByPubkeyProvider(pubkey).overrideWithValue(record),
            coordinatorInfoEventSourcesProvider(
              pubkey,
            ).overrideWith((ref) async => const []),
            relayConnectivityProvider.overrideWith((ref) => _Connectivity()),
            bitcoinDisplayUnitProvider.overrideWith((ref) => _DisplayUnit()),
          ],
          child: MaterialApp(home: CoordinatorDetailsScreen(pubkey: pubkey)),
        ),
      ),
    );
    await tester.pump();

    final profileButton = find.text('Open Nostr profile');
    await tester.scrollUntilVisible(profileButton, 300);
    expect(profileButton, findsOneWidget);
  });
}
