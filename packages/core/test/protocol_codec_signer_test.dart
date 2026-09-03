import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';
import 'package:test/test.dart';

void main() {
  const userPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000001';
  const coordinatorPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000002';
  final userPubkey = Bip340.getPublicKey(userPrivateKey);
  final coordinatorPubkey = Bip340.getPublicKey(coordinatorPrivateKey);

  test('signer-backed request interoperates with coordinator codec', () async {
    final signer = Bip340EventSigner(
      privateKey: userPrivateKey,
      publicKey: userPubkey,
    );
    final request = NostrRequest(
      method: kRpcGetOfferDetails,
      params: const {'offer_id': 'offer-1'},
    );

    final event = await ProtocolCodec.encryptRequestWithSigner(
      request: request,
      signer: signer,
      coordinatorPubkey: coordinatorPubkey,
    );
    final decoded = await ProtocolCodec.decryptRequest(
      event,
      coordinatorPrivateKey,
    );

    expect(event.pubKey, userPubkey);
    expect(event.tags, [
      ['p', coordinatorPubkey],
    ]);
    expect(decoded.method, request.method);
    expect(decoded.params, request.params);
    await signer.dispose();
  });

  test('signer-backed response decryption interoperates with coordinator',
      () async {
    final signer = Bip340EventSigner(
      privateKey: userPrivateKey,
      publicKey: userPubkey,
    );
    final response = NostrResponse(
      id: 'request-1',
      result: const {'status': 'dispute'},
    );
    final event = await ProtocolCodec.encryptResponse(
      response: response,
      senderPrivateKeyHex: coordinatorPrivateKey,
      senderPubkeyHex: coordinatorPubkey,
      recipientPubkey: userPubkey,
    );

    final decoded = await ProtocolCodec.decryptResponseWithSigner(
      event,
      signer,
    );

    expect(decoded.id, response.id);
    expect(decoded.result, response.result);
    await signer.dispose();
  });
}
