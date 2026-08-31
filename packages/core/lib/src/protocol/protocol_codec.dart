import 'dart:convert';

import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip44/nip44.dart';

import '../constants/kinds.dart';
import 'rpc_envelope.dart';

/// NIP-44 encryption + Nostr event envelope helpers for the Bitblik protocol.
///
/// Single source of truth for how requests, responses, and offer status
/// updates are wrapped. Used by `app`, `coordinator`, and `cli` to avoid
/// drift in encryption, tagging, or JSON framing.
///
/// All `encrypt*` methods return an **unsigned** [Nip01Event]: the caller is
/// responsible for signing (either via `signer.sign(event)` then broadcasting
/// plain, or via `broadcast(... customSigner: ...)`). Keeping signing out
/// here avoids leaking a specific signer abstraction into core.
class ProtocolCodec {
  ProtocolCodec._();

  /// Build a kind [kKindCoordinatorRequest] event carrying [request] encrypted
  /// for [coordinatorPubkey] via NIP-44.
  static Future<Nip01Event> encryptRequest({
    required NostrRequest request,
    required String senderPrivateKeyHex,
    required String senderPubkeyHex,
    required String coordinatorPubkey,
  }) async {
    // ignore: experimental_member_use
    final encrypted = await Nip44.encryptMessage(
      jsonEncode(request.toJson()),
      senderPrivateKeyHex,
      coordinatorPubkey,
    );
    return Nip01Event(
      kind: kKindCoordinatorRequest,
      pubKey: senderPubkeyHex,
      content: encrypted,
      tags: [
        ['p', coordinatorPubkey],
      ],
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }

  /// Signer-backed variant used by NIP-46/55/07 and local-key accounts alike.
  /// The signer performs NIP-44 without exposing private key material to the
  /// caller or coordinator service.
  static Future<Nip01Event> encryptRequestWithSigner({
    required NostrRequest request,
    required EventSigner signer,
    required String coordinatorPubkey,
  }) async {
    final encrypted = await signer.encryptNip44(
      plaintext: jsonEncode(request.toJson()),
      recipientPubKey: coordinatorPubkey,
    );
    if (encrypted == null) {
      throw StateError('Signer did not encrypt the coordinator request.');
    }
    return Nip01Event(
      kind: kKindCoordinatorRequest,
      pubKey: signer.getPublicKey(),
      content: encrypted,
      tags: [
        ['p', coordinatorPubkey],
      ],
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }

  /// Build a kind [kKindCoordinatorResponse] event carrying [response]
  /// encrypted for [recipientPubkey].
  static Future<Nip01Event> encryptResponse({
    required NostrResponse response,
    required String senderPrivateKeyHex,
    required String senderPubkeyHex,
    required String recipientPubkey,
  }) async {
    // ignore: experimental_member_use
    final encrypted = await Nip44.encryptMessage(
      jsonEncode(response.toJson()),
      senderPrivateKeyHex,
      recipientPubkey,
    );
    return Nip01Event(
      kind: kKindCoordinatorResponse,
      pubKey: senderPubkeyHex,
      content: encrypted,
      tags: [
        ['p', recipientPubkey],
      ],
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }

  /// Build a kind [kKindOfferStatusUpdate] event carrying an opaque JSON
  /// [payload] encrypted for [recipientPubkey] and tagged with [offerId].
  static Future<Nip01Event> encryptStatusUpdate({
    required Map<String, dynamic> payload,
    required String offerId,
    required String senderPrivateKeyHex,
    required String senderPubkeyHex,
    required String recipientPubkey,
  }) async {
    // ignore: experimental_member_use
    final encrypted = await Nip44.encryptMessage(
      jsonEncode(payload),
      senderPrivateKeyHex,
      recipientPubkey,
    );
    return Nip01Event(
      kind: kKindOfferStatusUpdate,
      pubKey: senderPubkeyHex,
      content: encrypted,
      tags: [
        ['p', recipientPubkey],
        ['offer_id', offerId],
      ],
      createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
    );
  }

  /// Decrypt + parse an incoming kind [kKindCoordinatorRequest] event.
  static Future<NostrRequest> decryptRequest(
    Nip01Event event,
    String recipientPrivateKeyHex,
  ) async {
    final plaintext = await _decrypt(event, recipientPrivateKeyHex);
    return NostrRequest.fromJson(
      jsonDecode(plaintext) as Map<String, dynamic>,
    );
  }

  /// Decrypt + parse an incoming kind [kKindCoordinatorResponse] event.
  static Future<NostrResponse> decryptResponse(
    Nip01Event event,
    String recipientPrivateKeyHex,
  ) async {
    final plaintext = await _decrypt(event, recipientPrivateKeyHex);
    return NostrResponse.fromJson(
      jsonDecode(plaintext) as Map<String, dynamic>,
    );
  }

  static Future<NostrResponse> decryptResponseWithSigner(
    Nip01Event event,
    EventSigner signer,
  ) async {
    final plaintext = await signer.decryptNip44(
      ciphertext: event.content,
      senderPubKey: event.pubKey,
    );
    if (plaintext == null) {
      throw StateError('Signer did not decrypt the coordinator response.');
    }
    return NostrResponse.fromJson(
      jsonDecode(plaintext) as Map<String, dynamic>,
    );
  }

  /// Decrypt + parse an incoming kind [kKindOfferStatusUpdate] event payload.
  static Future<Map<String, dynamic>> decryptStatusUpdate(
    Nip01Event event,
    String recipientPrivateKeyHex,
  ) async {
    final plaintext = await _decrypt(event, recipientPrivateKeyHex);
    return jsonDecode(plaintext) as Map<String, dynamic>;
  }

  static Future<String> _decrypt(
    Nip01Event event,
    String recipientPrivateKeyHex,
  ) async {
    // ignore: experimental_member_use
    return Nip44.decryptMessage(
      event.content,
      recipientPrivateKeyHex,
      event.pubKey,
    );
  }
}
