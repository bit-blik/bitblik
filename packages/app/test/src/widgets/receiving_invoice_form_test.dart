import 'dart:async';

import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/widgets/receiving_invoice_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/data_layer/repositories/wallets/mem_wallets_repo.dart';
import 'package:ndk/entities.dart' show Bolt12Wallet;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  const offer =
      'lno1pqqq5xj5wajkcan9gdshx6pq23jhxarfdenjqstyv3ex2umnzcss80xkrjkyrjk43u5dgu8f6a450fg2cnjtg7lhg76c3gtk5gdhshns';
  late Ndk ndk;
  String? submitted;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    ndk = Ndk(
      NdkConfig(
        cache: MemCacheManager(),
        walletsRepo: MemWalletsRepo(),
        eventVerifier: Bip340EventVerifier(),
        bootstrapRelays: const [],
      ),
    );
    await ndk.wallets.addWallet(
      Bolt12Wallet(
        id: 'bolt12',
        name: 'BOLT12 wallet',
        supportedUnits: const {'sat'},
        offer: offer,
        source: offer,
      ),
    );
    await ndk.wallets.getWallets();
    submitted = null;
  });

  tearDown(() => ndk.destroy());

  Future<void> pumpForm(WidgetTester tester, {required bool bolt12}) async {
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [ndkProvider.overrideWithValue(ndk)],
          child: MaterialApp(
            home: Scaffold(
              body: SingleChildScrollView(
                child: ReceivingInvoiceForm(
                  amountSats: 1500,
                  coordinatorSupportsBolt12: bolt12,
                  onSubmit: (instruction) async => submitted = instruction,
                  labels: ReceivingInvoiceFormLabels(
                    walletSectionTitle: 'Wallets',
                    defaultWalletLabel: 'Default',
                    tapToGenerate: (amount) => 'Receive $amount',
                    invoiceLabel: 'Payout',
                    invoiceHint: 'Paste instruction',
                    submitLabel: 'Submit',
                    emptyInvoiceError: 'Missing instruction',
                    generationError: (error) => error.toString(),
                    addWalletLabel: 'Add wallet',
                    noReceivingWalletMessage: 'No compatible wallet',
                    walletUnavailableError: 'Wallet unavailable',
                    missingBolt11Error: 'Missing invoice',
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('BOLT11 coordinator hides BOLT12-only receiving wallets', (
    tester,
  ) async {
    await pumpForm(tester, bolt12: false);
    expect(find.text('BOLT12 wallet'), findsNothing);
    expect(find.text('No compatible wallet'), findsOneWidget);
  });

  testWidgets('wallet choices refresh when coordinator capabilities arrive', (
    tester,
  ) async {
    await pumpForm(tester, bolt12: false);
    expect(find.text('BOLT12 wallet'), findsNothing);
    await pumpForm(tester, bolt12: true);
    expect(find.text('BOLT12 wallet'), findsOneWidget);
    await pumpForm(tester, bolt12: false);
    expect(find.text('BOLT12 wallet'), findsNothing);
  });

  testWidgets('BOLT12 coordinator generates and submits typed offer', (
    tester,
  ) async {
    await pumpForm(tester, bolt12: true);
    final controller = tester
        .widget<TextField>(find.byType(TextField))
        .controller!;
    // NDK futures originate outside the widget test's fake-async zone.
    await tester.runAsync(() async {
      final generated = Completer<void>();
      void onGenerated() {
        if (controller.text.isNotEmpty && !generated.isCompleted) {
          generated.complete();
        }
      }

      controller.addListener(onGenerated);
      try {
        await tester.tap(find.text('BOLT12 wallet'));
        await generated.future.timeout(const Duration(seconds: 5));
      } finally {
        controller.removeListener(onGenerated);
      }
    });
    await tester.pumpAndSettle();
    expect(
      tester.widget<TextField>(find.byType(TextField)).controller!.text,
      offer,
    );
    await tester.ensureVisible(find.text('Submit'));
    await tester.tap(find.text('Submit'));
    await tester.pumpAndSettle();
    expect(submitted, offer);
    expect(tester.takeException(), isNull);
  });
}
