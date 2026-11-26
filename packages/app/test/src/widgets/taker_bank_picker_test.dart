import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/services/nostr_service.dart'
    show reservedOfferFromResult;
import 'package:bitblik/src/widgets/taker_bank_picker.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Offer skOffer({
  String bankId = 'tatrabanka',
  List<String> bankIds = const [],
}) =>
    Offer(
      id: 'o1',
      amountSats: 90000,
      makerFees: 0,
      status: OfferStatus.funded,
      fiatAmount: 50,
      fiatCurrency: 'EUR',
      category: OfferCategory.atm,
      createdAt: DateTime.utc(2026),
      makerPubkey: 'm',
      coordinatorPubkey: 'c',
      paymentSystemId: 'sk',
      bankId: bankId,
      bankIds: bankIds,
    );

void main() {
  group('TakerBankChooser', () {
    final banks = banksForOffer(skOffer(bankIds: ['tatrabanka', 'vub']));

    Future<void> pump(
      WidgetTester tester, {
      String? last,
      required ValueChanged<String> onPicked,
    }) =>
        tester.pumpWidget(
          TranslationProvider(
            child: MaterialApp(
              home: Scaffold(
                body: TakerBankChooser(
                  banks: banks,
                  lastBankId: last,
                  onPicked: onPicked,
                ),
              ),
            ),
          ),
        );

    testWidgets('lists every accepted bank with its code window',
        (tester) async {
      await pump(tester, onPicked: (_) {});
      expect(find.text('Tatra banka'), findsOneWidget);
      expect(find.text('VÚB banka'), findsOneWidget);
      expect(find.text('Code valid for 20 min'), findsOneWidget);
      expect(find.text('Code valid for 10 min'), findsOneWidget);
    });

    testWidgets('one tap picks the bank', (tester) async {
      String? picked;
      await pump(tester, onPicked: (id) => picked = id);
      await tester.tap(find.text('VÚB banka'));
      expect(picked, 'vub');
    });

    testWidgets('marks the bank picked last time', (tester) async {
      await pump(tester, last: 'vub', onPicked: (_) {});
      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(
        find.descendant(
          of: find.widgetWithText(ListTile, 'VÚB banka'),
          matching: find.byIcon(Icons.check),
        ),
        findsOneWidget,
      );
    });
  });

  testWidgets('a single-bank offer goes ahead without asking', (tester) async {
    late TakerBankChoice choice;
    await tester.pumpWidget(
      TranslationProvider(
        child: MaterialApp(
          home: Builder(
            builder: (context) => TextButton(
              onPressed: () async =>
                  choice = await chooseTakerBank(context, skOffer()),
              child: const Text('take'),
            ),
          ),
        ),
      ),
    );
    await tester.tap(find.text('take'));
    await tester.pumpAndSettle();
    expect(choice.proceed, isTrue);
    expect(choice.bank, isNull);
    expect(find.byType(TakerBankChooser), findsNothing);
  });

  group('reservedOfferFromResult on a multi-bank offer', () {
    final listed = skOffer(bankIds: ['tatrabanka', 'vub']);

    test('runs on the picked bank when the coordinator returns no offer', () {
      final reserved = reservedOfferFromResult(
        listed,
        'taker',
        (reservedAt: DateTime.utc(2026), offer: null),
        bank: 'vub',
      );
      expect(reserved.bankId, 'vub');
      expect(reserved.acceptedBankIds, ['tatrabanka', 'vub']);
    });

    test('keeps the accepted list when the returned offer lacks it', () {
      final remote = listed.copyWith(
        bankId: 'vub',
        bankIds: const [],
        takerPubkey: 'taker',
      );
      final reserved = reservedOfferFromResult(
        listed,
        'taker',
        (reservedAt: null, offer: remote),
        bank: 'vub',
      );
      expect(reserved.bankId, 'vub');
      expect(reserved.acceptedBankIds, ['tatrabanka', 'vub']);
    });
  });
}
