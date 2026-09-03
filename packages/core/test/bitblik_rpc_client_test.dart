import 'package:bitblik_core/core.dart';
import 'package:bip340/bip340.dart' as bip340;
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

void main() {
  const firstPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000001';
  const secondPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000002';

  test('rebindSigner keeps NDK and moves the response identity', () async {
    final ndk = Ndk(
      NdkConfig(
        cache: MemCacheManager(),
        eventVerifier: Bip340EventVerifier(),
        bootstrapRelays: const [],
      ),
    );
    final firstSigner = Bip340EventSigner(
      privateKey: firstPrivateKey,
      publicKey: bip340.getPublicKey(firstPrivateKey),
    );
    final secondSigner = Bip340EventSigner(
      privateKey: secondPrivateKey,
      publicKey: bip340.getPublicKey(secondPrivateKey),
    );
    final client = BitblikRpcClient(
      ndk: ndk,
      signer: firstSigner,
      relays: const [],
    );

    await client.start();
    await client.rebindSigner(secondSigner);

    expect(identical(client.ndk, ndk), isTrue);
    expect(client.signer.getPublicKey(), secondSigner.getPublicKey());

    await client.stop();
    await ndk.destroy();
  });
}
