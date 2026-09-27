import 'dart:async';

import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/screens/offer_details_screen.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class _ActiveOffer extends StateNotifier<Offer?>
    implements ActiveOfferNotifier {
  _ActiveOffer() : super(null);

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('direct offer link recovers from empty query via live offer', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final offers = StreamController<List<Offer>>.broadcast();
    addTearDown(offers.close);
    final offer = Offer(
      id: 'funded',
      amountSats: 1000,
      makerFees: 0,
      status: OfferStatus.funded,
      fiatAmount: 92,
      fiatCurrency: 'PLN',
      createdAt: DateTime.utc(2026, 9, 27),
      makerPubkey: 'maker',
      coordinatorPubkey: 'coordinator',
    );
    final router = GoRouter(
      initialLocation: '/offers/funded',
      routes: [
        GoRoute(
          path: '/offers/:id',
          builder: (_, state) =>
              OfferDetailsScreen(offerId: state.pathParameters['id']!),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            offerDetailsProvider.overrideWith((ref, id) async => null),
            availableOffersProvider.overrideWith((ref) => offers.stream),
            publicKeyProvider.overrideWith((ref) async => 'taker'),
            hasReceivingWalletProvider.overrideWith(
              (ref) => Stream.value(false),
            ),
            activeOfferProvider.overrideWith((ref) => _ActiveOffer()),
            coordinatorInfoByPubkeyProvider.overrideWith(
              (ref, pubkey) async => null,
            ),
            coordinatorRecordByPubkeyProvider.overrideWith(
              (ref, pubkey) => null,
            ),
            selectedPaymentSystemProvider.overrideWith(
              (ref) => SelectedPaymentSystemNotifier(kBlik),
            ),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      ),
    );
    await tester.pump();
    expect(find.text('Error: Offer not found.'), findsOneWidget);

    offers.add([offer]);
    await tester.pump();
    await tester.pump();
    expect(find.text('Error: Offer not found.'), findsNothing);
    expect(find.textContaining('92 PLN', findRichText: true), findsOneWidget);
  });
}
