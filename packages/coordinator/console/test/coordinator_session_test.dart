import 'package:bitblik_coordinator_console/src/coordinator_session.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

void main() {
  const coordinatorPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000001';
  const otherPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000002';

  late Ndk ndk;
  late CoordinatorSession session;

  setUp(() {
    ndk = Ndk(
      NdkConfig(
        cache: MemCacheManager(),
        eventVerifier: Bip340EventVerifier(),
        bootstrapRelays: const [],
      ),
    );
    session = CoordinatorSession(
      ndkFlutter: NdkFlutter(ndk: ndk),
      relayLoader: (_) async => const [],
      accountStateSaver: () async {},
    );
  });

  tearDown(() async {
    await session.logout();
    for (final account in ndk.accounts.accounts.values.toList()) {
      ndk.accounts.removeAccount(pubkey: account.pubkey);
      await account.dispose();
    }
    await ndk.destroy();
  });

  Future<void> widgetLogin(String privateKey) async {
    final pubkey = Bip340.getPublicKey(privateKey);
    ndk.accounts.loginPrivateKey(pubkey: pubkey, privkey: privateKey);
    await session.activateLoggedInAccount();
  }

  test('uses the NDK login pubkey as the coordinator identity', () async {
    final coordinator = Bip340.getPublicKey(coordinatorPrivateKey);
    await widgetLogin(coordinatorPrivateKey);

    expect(session.isAuthenticated, isTrue);
    expect(session.expectedCoordinatorPubkey, coordinator);
    expect(session.signer?.getPublicKey(), coordinator);
    expect(ndk.accounts.getPublicKey(), coordinator);
    expect(session.accounts, hasLength(1));
  });

  test(
    'keeps multiple coordinator accounts and switches with Accounts',
    () async {
      final first = Bip340.getPublicKey(coordinatorPrivateKey);
      final second = Bip340.getPublicKey(otherPrivateKey);

      await widgetLogin(coordinatorPrivateKey);
      await widgetLogin(otherPrivateKey);

      expect(
        session.accounts.map((account) => account.pubkey),
        unorderedEquals([first, second]),
      );
      expect(ndk.accounts.getPublicKey(), second);

      await session.switchCoordinator(first);

      expect(session.expectedCoordinatorPubkey, first);
      expect(ndk.accounts.getPublicKey(), first);
      expect(session.signer, same(ndk.accounts.getLoggedAccount()!.signer));
      expect(session.isAuthenticated, isTrue);
      expect(session.accounts, hasLength(2));
    },
  );

  test('logout removes only the active coordinator account', () async {
    final first = Bip340.getPublicKey(coordinatorPrivateKey);
    final second = Bip340.getPublicKey(otherPrivateKey);
    await widgetLogin(coordinatorPrivateKey);
    await widgetLogin(otherPrivateKey);

    await session.logout();

    expect(ndk.accounts.hasAccount(second), isFalse);
    expect(ndk.accounts.hasAccount(first), isTrue);
    expect(session.isAuthenticated, isFalse);
  });
}
