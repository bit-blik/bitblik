import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:clock/clock.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

/// A coordinator whose LND is locked or unreachable at startup used to keep
/// serving for the rest of its life with no payment backend at all:
/// `_initializePaymentBackend` ran once, swallowed the error, left
/// `_paymentBackend` null and every later offer died with "No payment backend
/// configured to create hold invoice". `restart: unless-stopped` never helped,
/// because the process does not exit. That cost the sk market 45 hours in
/// August 2026 after a nightly LND update came back with a locked wallet.
///
/// The connection has to be retried instead.
void main() {
  CoordinatorService serviceWith(PaymentBackendConnector connector) {
    final service = CoordinatorService(
      MockDatabaseService(),
      clock: const Clock(),
      paymentSystemIdForTest: 'blik',
      paymentBackendConnectorForTest: connector,
    );
    addTearDown(service.shutdown);
    return service;
  }

  test('startup survives a backend that cannot be reached', () async {
    final svc = serviceWith(() async => (backend: null, type: 'none'));

    await svc.init();

    expect(svc.paymentBackendType, 'none');
  });

  test('a backend that only connects later is picked up by the retry',
      () async {
    var attempts = 0;
    final backend = MockPaymentService();
    final svc = serviceWith(() async {
      attempts++;
      // First attempt: LND is up but the wallet is still locked.
      if (attempts == 1) return (backend: null, type: 'none');
      return (backend: backend, type: 'lnd');
    });

    await svc.init();
    expect(svc.paymentBackendType, 'none', reason: 'first attempt failed');

    expect(await svc.retryPaymentBackend(), isTrue);
    expect(svc.paymentBackendType, 'lnd');
    expect(attempts, 2);
  });

  test('a connected backend is never reconnected underneath a live coordinator',
      () async {
    var attempts = 0;
    final backend = MockPaymentService();
    final svc = serviceWith(() async {
      attempts++;
      return (backend: backend, type: 'lnd');
    });

    await svc.init();
    expect(attempts, 1);

    expect(await svc.retryPaymentBackend(), isTrue);
    expect(attempts, 1);
  });

  test('a throwing connector fails startup but never crashes the retry',
      () async {
    final svc = serviceWith(() async =>
        throw Exception('wallet locked, unlock it to enable full RPC access'));

    // A hard failure still propagates out of init(), as it always did.
    await expectLater(svc.init(), throwsA(isA<Exception>()));

    // On a coordinator that is already serving, the same failure must read as
    // "still down, try again later" rather than take the process with it.
    expect(await svc.retryPaymentBackend(), isFalse);
    expect(svc.paymentBackendType, 'none');
  });
}
