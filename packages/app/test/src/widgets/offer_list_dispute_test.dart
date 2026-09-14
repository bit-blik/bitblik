import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/providers/providers.dart';
import 'package:bitblik/src/screens/offer_list_screen.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/ndk.dart';
import 'package:shared_preferences/shared_preferences.dart';

Offer _offer(String id, double amount, OfferStatus status) => Offer(
  id: id,
  amountSats: 1000,
  makerFees: 0,
  status: status,
  fiatAmount: amount,
  fiatCurrency: 'PLN',
  createdAt: DateTime.utc(2026, 9, 14),
  makerPubkey: 'maker',
  takerPubkey: 'taker',
  coordinatorPubkey: 'coordinator',
);

class _ActiveOffer extends StateNotifier<Offer?>
    implements ActiveOfferNotifier {
  _ActiveOffer(super.state);

  @override
  Future<void> setActiveOffer(Offer? offer) async => state = offer;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  testWidgets('hides disputed offers even when the public listing is stale', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final listed = _offer('tracked', 123, OfferStatus.reserved);
    final active = _ActiveOffer(listed);
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: OfferListScreen()),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      TranslationProvider(
        child: ProviderScope(
          overrides: [
            availableOffersProvider.overrideWith(
              (ref) => Stream.value([
                listed,
                _offer('available', 456, OfferStatus.funded),
                Offer.fromNostrEvent(
                  Nip01Event(
                    pubKey: 'coordinator',
                    kind: kKindOffer,
                    tags: const [
                      ['d', 'disputed'],
                      ['fa', '789'],
                      ['f', 'PLN'],
                      ['s', 'in-progress'],
                      ['bitblik_status', 'dispute'],
                    ],
                    content: '',
                  ),
                ),
                _offer(
                  'tracked',
                  321,
                  OfferStatus.reserved,
                ).copyWith(coordinatorPubkey: 'other-coordinator'),
              ]),
            ),
            activeOfferProvider.overrideWith((ref) => active),
            publicKeyProvider.overrideWith((ref) async => 'taker'),
            hasReceivingWalletProvider.overrideWith(
              (ref) => Stream.value(true),
            ),
            discoveredCoordinatorsProvider.overrideWith(
              (ref) => Stream.value([]),
            ),
            successfulOffersStatsProvider.overrideWith((ref) async => {}),
            selectedPaymentSystemProvider.overrideWith(
              (ref) => SelectedPaymentSystemNotifier(kBlik),
            ),
          ],
          child: MaterialApp.router(routerConfig: router),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('123 PLN'), findsOneWidget);
    expect(find.text('456 PLN'), findsOneWidget);
    expect(find.text('789 PLN'), findsNothing);

    for (final status in [
      'securingDispute',
      'dispute',
      'refundingMaker',
      'payingMaker',
    ]) {
      await active.setActiveOffer(
        listed.copyWith(
          status: OfferStatus.values.firstWhere(
            (value) => value.name == status,
            orElse: () => OfferStatus.unknown,
          ),
          statusRaw: status,
        ),
      );
      await tester.pumpAndSettle();
      expect(find.text('123 PLN'), findsNothing, reason: status);
      expect(find.text('456 PLN'), findsOneWidget, reason: status);
      expect(find.text('321 PLN'), findsOneWidget, reason: status);
    }
  });
}
