import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ndk_flutter/l10n/app_localizations.dart' as ndk_l10n;

void main() {
  for (final locale in AppLocale.values) {
    test('${locale.languageCode} defines wallet-detail headings', () async {
      final labels = (await locale.build()).wallet.details;
      expect(labels.title, isNotEmpty);
      expect(labels.pendingTitle, isNotEmpty);
      expect(labels.finishedTitle, isNotEmpty);
      if (locale != AppLocale.en) {
        final english = (await AppLocale.en.build()).wallet.details;
        expect(labels.title, isNot(english.title));
        expect(labels.pendingTitle, isNot(english.pendingTitle));
        expect(labels.finishedTitle, isNot(english.finishedTitle));

        // Check the pinned NDK dependency too: app translations alone cannot
        // fix the wallet card, send menu, or transfer dialog.
        final ndkLabels = await ndk_l10n.AppLocalizations.delegate.load(
          locale.flutterLocale,
        );
        expect(
          ndkLabels.bolt12PrivateOfferSubtitle,
          isNot('Reusable private offer'),
        );
        expect(ndkLabels.anyAmount, isNot('Any amount'));
        expect(ndkLabels.blindedRoute, isNot('Blinded'));
        expect(ndkLabels.sendToWallet, isNot('Send to Wallet'));
        expect(
          ndkLabels.sendToWalletDescription,
          isNot('Transfer to another compatible wallet'),
        );
        expect(ndkLabels.destinationWallet, isNot('Destination wallet'));
      }
    });
  }

  testWidgets('wallet headings follow locale changes to Polish', (
    tester,
  ) async {
    addTearDown(() => LocaleSettings.setLocale(AppLocale.en));
    await tester.runAsync(() => LocaleSettings.setLocale(AppLocale.en));
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Builder(
            builder: (context) {
              final labels = Translations.of(context).wallet.details;
              return Scaffold(
                body: Column(
                  children: [
                    Text(labels.title),
                    Text(labels.pendingTitle),
                    Text(labels.finishedTitle),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
    expect(find.text('Wallet details'), findsOneWidget);
    await tester.runAsync(() => LocaleSettings.setLocale(AppLocale.pl));
    await tester.pumpAndSettle();
    expect(find.text('Szczegóły portfela'), findsOneWidget);
    expect(find.text('Oczekujące transakcje'), findsOneWidget);
    expect(find.text('Zakończone transakcje'), findsOneWidget);
    expect(find.text('Wallet details'), findsNothing);
    expect(find.text('Finished transactions'), findsNothing);
  });
}
