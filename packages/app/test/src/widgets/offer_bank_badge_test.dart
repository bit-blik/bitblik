import 'package:bitblik/src/widgets/offer_bank_badge.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Offer skOffer({String? bankId}) => Offer(
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
    );

Future<void> pump(WidgetTester tester, Offer offer) async {
  await tester.pumpWidget(
    MaterialApp(home: Scaffold(body: OfferBankBadge(offer: offer))),
  );
}

void main() {
  testWidgets('renders nothing for a bank-agnostic offer', (tester) async {
    await pump(tester, skOffer(bankId: null));
    expect(find.byType(SizedBox), findsWidgets); // the shrink sentinel
    expect(find.textContaining('banka'), findsNothing);
  });

  testWidgets('shows the bank label for a bank-scoped offer', (tester) async {
    await pump(tester, skOffer(bankId: 'tatrabanka'));
    expect(find.textContaining('Tatra banka'), findsOneWidget);
  });

  testWidgets('VÚB (3 min) shows a short-validity warning with minutes',
      (tester) async {
    await pump(tester, skOffer(bankId: 'vub'));
    // Short-validity banks surface the window inline.
    expect(find.textContaining('3 min'), findsOneWidget);
    expect(find.byIcon(Icons.timer_outlined), findsOneWidget);
  });
}
