import 'package:bitblik/src/services/coordinator_console_account_store.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

Ndk _createNdk() => Ndk(
  NdkConfig(
    cache: MemCacheManager(),
    eventVerifier: Bip340EventVerifier(),
    bootstrapRelays: const [],
  ),
);

Future<void> _disposeNdk(Ndk ndk) async {
  for (final account in ndk.accounts.accounts.values.toList()) {
    await account.dispose();
  }
  await ndk.destroy();
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('coordinator accounts use a separate persistence namespace', () async {
    FlutterSecureStorage.setMockInitialValues({accountsKey: 'trader-state'});
    const storage = FlutterSecureStorage();
    const store = CoordinatorConsoleAccountStore(storage: storage);
    final source = _createNdk();
    final restored = _createNdk();
    final firstKeys = Bip340.generatePrivateKey();
    final secondKeys = Bip340.generatePrivateKey();

    try {
      source.accounts.loginExternalSigner(
        signer: Nip55EventSigner(
          publicKey: firstKeys.publicKey,
          nip55Signer: const Nip55Signer(package: 'com.example.first'),
        ),
      );
      source.accounts.loginExternalSigner(
        signer: Nip55EventSigner(
          publicKey: secondKeys.publicKey,
          nip55Signer: const Nip55Signer(package: 'com.example.second'),
        ),
      );
      await store.save(source);

      expect(await storage.read(key: accountsKey), 'trader-state');
      expect(
        await storage.read(key: CoordinatorConsoleAccountStore.storageKey),
        isNotNull,
      );

      await store.restore(restored);
      final account = restored.accounts.getLoggedAccount();
      expect(restored.accounts.accounts, hasLength(2));
      expect(account?.pubkey, secondKeys.publicKey);
      expect(account?.signer, isA<Nip55EventSigner>());
      expect(
        (account!.signer as Nip55EventSigner).nip55Signer.package,
        'com.example.second',
      );
      expect(
        source.relays.globalState,
        isNot(same(restored.relays.globalState)),
      );
    } finally {
      await _disposeNdk(source);
      await _disposeNdk(restored);
    }
  });

  test(
    'coordinator nsec account is restored only in coordinator NDK',
    () async {
      FlutterSecureStorage.setMockInitialValues({accountsKey: 'trader-state'});
      const storage = FlutterSecureStorage();
      const store = CoordinatorConsoleAccountStore(storage: storage);
      final source = _createNdk();
      final restored = _createNdk();
      final keys = Bip340.generatePrivateKey();

      try {
        source.accounts.loginPrivateKey(
          pubkey: keys.publicKey,
          privkey: keys.privateKey!,
        );
        await store.save(source);

        expect(await storage.read(key: accountsKey), 'trader-state');
        await store.restore(restored);

        final account = restored.accounts.getLoggedAccount();
        expect(account?.pubkey, keys.publicKey);
        expect(account?.type, AccountType.privateKey);
        expect(account?.signer, isA<Bip340EventSigner>());
        expect(
          (account!.signer as Bip340EventSigner).privateKey,
          keys.privateKey,
        );
        expect(
          source.relays.globalState,
          isNot(same(restored.relays.globalState)),
        );
      } finally {
        await _disposeNdk(source);
        await _disposeNdk(restored);
      }
    },
  );
}
