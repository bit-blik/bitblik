import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

/// A new coordinator (bank-aware code) must stay wire-compatible with old
/// BLIK / MB WAY / TWINT clients that know nothing about banks: no bank is
/// required, none is advertised, and the RPC signature stays optional.
void main() {
  const maker = 'maker_pubkey';

  CoordinatorService serviceFor(String market) => CoordinatorService(
        MockDatabaseService(),
        paymentServiceForTest: MockPaymentService(),
        clock: const Clock(),
        paymentSystemIdForTest: market,
      );

  group('bank-agnostic markets advertise no banks', () {
    for (final market in ['blik', 'mbway', 'twint']) {
      test('$market: servedBanks empty, info.banks empty', () async {
        final svc = serviceFor(market);
        await svc.init();
        expect(svc.servedBanks, isEmpty, reason: market);
        final info = await svc.getCoordinatorInfo();
        expect(info.banks, isEmpty, reason: market);
        expect(info.bankChannelLinks, isEmpty, reason: market);
        // Nothing bank-related leaks onto the wire.
        expect(info.toNostrTags().any((t) => t[0] == 'banks'), isFalse,
            reason: market);
      });
    }
  });

  group('offer creation stays bank-optional for old markets', () {
    test('BLIK offer without a bank is not rejected for a missing bank',
        () async {
      final svc = serviceFor('blik');
      await svc.init();
      // BLIK is taker-provides + bank-agnostic: no bank needed. The call fails
      // later (no rate/backend in this unit test), but never with a
      // bank-required error — assert the failure is not about the bank.
      try {
        await svc.initiateOfferFiat(
          fiatAmount: 50,
          makerId: maker,
          fiatCurrency: 'PLN',
          category: OfferCategory.atm,
        );
      } catch (e) {
        expect(e.toString().toLowerCase(), isNot(contains('bank')));
      }
    });

    test('TWINT still validates the maker code even with a null category',
        () async {
      // An old client that omits the category must still get its maker-provided
      // code validated — the coordinator falls back to the sole online
      // instrument. An invalid code is rejected before any rate/backend work.
      final svc = serviceFor('twint');
      await svc.init();
      expect(
        () => svc.initiateOfferFiat(
          fiatAmount: 50,
          makerId: maker,
          fiatCurrency: 'CHF',
          blikCode: 'not-a-code',
        ),
        throwsA(isA<Exception>()),
      );
    });

    test('TWINT rejects the disabled shop category', () async {
      final svc = serviceFor('twint');
      await svc.init();
      expect(
        () => svc.initiateOfferFiat(
          fiatAmount: 50,
          makerId: maker,
          fiatCurrency: 'CHF',
          category: OfferCategory.shop,
          blikCode: '12345',
        ),
        throwsA(
          predicate(
            (error) => error.toString().contains(
                  'Unsupported category shop for twint',
                ),
          ),
        ),
      );
    });
  });
}
