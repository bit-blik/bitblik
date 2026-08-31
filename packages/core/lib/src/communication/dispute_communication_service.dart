import 'dart:convert';
import 'dart:typed_data';

import 'package:crypto/crypto.dart';
import 'package:image/image.dart' as image;
import 'package:ndk/ndk.dart';

import '../models/offer.dart';

/// Client-side evidence policy. Coordinators do not advertise or dictate these
/// limits; Blossom servers may independently enforce stricter upload limits.
class EvidenceImagePolicy {
  final int maxInputBytes;
  final int maxPixels;

  const EvidenceImagePolicy({
    this.maxInputBytes = 12 * 1024 * 1024,
    this.maxPixels = 20 * 1000 * 1000,
  });
}

class SanitizedEvidenceImage {
  final Uint8List bytes;
  final String mimeType;
  final int width;
  final int height;

  const SanitizedEvidenceImage({
    required this.bytes,
    required this.mimeType,
    required this.width,
    required this.height,
  });
}

class EvidenceImageException implements Exception {
  final String message;
  const EvidenceImageException(this.message);

  @override
  String toString() => message;
}

/// Normalizes kind-10063 `server` tags for NDK's Blossom client, which appends
/// endpoint paths with string interpolation. Several Nostr clients publish
/// conventional base URLs ending in `/`; without removing it NDK requests
/// `//upload`, which strict Blossom servers reject with 404.
List<String> normalizeBlossomServerUrls(Iterable<String> values) {
  final normalized = <String>[];
  for (final value in values) {
    final trimmed = value.trim().replaceFirst(RegExp(r'/+$'), '');
    final uri = Uri.tryParse(trimmed);
    if (uri == null ||
        !const {'http', 'https'}.contains(uri.scheme) ||
        uri.host.isEmpty) {
      continue;
    }
    if (!normalized.contains(trimmed)) normalized.add(trimmed);
  }
  return List.unmodifiable(normalized);
}

typedef BlossomBlobDownloader = Future<Uint8List> Function(
    String serverUrl, Uri blobUrl);

/// Recovers from Blossom servers that store an upload successfully but return
/// a non-standard descriptor response. The content-addressed URL is accepted
/// only after downloading it and verifying the exact encrypted SHA-256.
Future<Uri?> findVerifiedBlossomBlob({
  required Iterable<String> serverUrls,
  required String sha256Hex,
  required BlossomBlobDownloader download,
}) async {
  final normalizedHash = sha256Hex.toLowerCase();
  if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(normalizedHash)) return null;

  for (final serverUrl in normalizeBlossomServerUrls(serverUrls)) {
    final blobUrl = Uri.parse('$serverUrl/$normalizedHash');
    try {
      final bytes = await download(serverUrl, blobUrl);
      if (sha256.convert(bytes).toString() == normalizedHash) return blobUrl;
    } catch (_) {
      // Continue to the next configured server. Upload diagnostics are
      // retained and reported by the caller if no stored blob can be proven.
    }
  }
  return null;
}

/// Validates decoded image structure and re-encodes pixels, removing EXIF,
/// location, comments, profiles, and other source-file metadata.
class EvidenceImageSanitizer {
  final EvidenceImagePolicy policy;

  const EvidenceImageSanitizer({this.policy = const EvidenceImagePolicy()});

  SanitizedEvidenceImage sanitize(Uint8List input) {
    if (input.isEmpty || input.length > policy.maxInputBytes) {
      throw const EvidenceImageException(
        'Evidence image exceeds the size limit.',
      );
    }

    final format = _formatForBytes(input);
    final decoder = switch (format) {
      _EvidenceImageFormat.jpeg => image.JpegDecoder(),
      _EvidenceImageFormat.png => image.PngDecoder(),
    };
    final info = decoder.startDecode(input);
    if (info == null || info.width <= 0 || info.height <= 0) {
      throw const EvidenceImageException(
        'Evidence image could not be decoded.',
      );
    }
    if (info.numFrames != 1 || info.width * info.height > policy.maxPixels) {
      throw const EvidenceImageException(
        'Animated or oversized evidence images are not accepted.',
      );
    }

    final decoded = decoder.decodeFrame(0);
    if (decoded == null) {
      throw const EvidenceImageException(
        'Evidence image could not be decoded.',
      );
    }
    final pixels = image.bakeOrientation(decoded);
    pixels
      ..exif = image.ExifData()
      ..iccProfile = null
      ..textData = null;
    final encoded = switch (format) {
      _EvidenceImageFormat.jpeg => image.encodeJpg(pixels, quality: 90),
      _EvidenceImageFormat.png => image.encodePng(pixels, level: 6),
    };
    if (encoded.length > policy.maxInputBytes) {
      throw const EvidenceImageException(
        'Sanitized evidence image exceeds the size limit.',
      );
    }
    return SanitizedEvidenceImage(
      bytes: Uint8List.fromList(encoded),
      mimeType: format.mimeType,
      width: pixels.width,
      height: pixels.height,
    );
  }

  void validateDownloaded(Uint8List bytes, String expectedMimeType) {
    final format = _formatForBytes(bytes);
    if (format.mimeType != expectedMimeType) {
      throw const EvidenceImageException('Evidence image type does not match.');
    }
    final decoder = switch (format) {
      _EvidenceImageFormat.jpeg => image.JpegDecoder(),
      _EvidenceImageFormat.png => image.PngDecoder(),
    };
    final info = decoder.startDecode(bytes);
    if (info == null ||
        info.width <= 0 ||
        info.height <= 0 ||
        info.numFrames != 1 ||
        info.width * info.height > policy.maxPixels ||
        decoder.decodeFrame(0) == null) {
      throw const EvidenceImageException(
        'Evidence image could not be decoded.',
      );
    }
  }

  _EvidenceImageFormat _formatForBytes(Uint8List bytes) {
    if (bytes.length >= 3 &&
        bytes[0] == 0xff &&
        bytes[1] == 0xd8 &&
        bytes[2] == 0xff) {
      return _EvidenceImageFormat.jpeg;
    }
    const pngHeader = [0x89, 0x50, 0x4e, 0x47, 0x0d, 0x0a, 0x1a, 0x0a];
    if (bytes.length >= pngHeader.length) {
      var matches = true;
      for (var i = 0; i < pngHeader.length; i++) {
        if (bytes[i] != pngHeader[i]) matches = false;
      }
      if (matches) return _EvidenceImageFormat.png;
    }
    throw const EvidenceImageException(
      'Only decoded JPEG and PNG evidence images are accepted.',
    );
  }
}

enum _EvidenceImageFormat {
  jpeg('image/jpeg'),
  png('image/png');

  final String mimeType;
  const _EvidenceImageFormat(this.mimeType);
}

/// BitBlik-specific binding around NDK's generic NIP-17 and Blossom use cases.
/// It creates exactly one participant/coordinator peer lane at a time and
/// filters decrypted messages by the offer coordinate and deterministic case
/// id before returning them to UI code.
class DisputeCommunicationService {
  static const _caseDomain = 'bitblik-dispute-v1';
  static const _missingRecipientDmRelays =
      'Recipient has no NIP-17 DM relays (kind 10050).';

  final Ndk ndk;
  final EvidenceImageSanitizer imageSanitizer;

  const DisputeCommunicationService({
    required this.ndk,
    this.imageSanitizer = const EvidenceImageSanitizer(),
  });

  static String offerCoordinate(Offer offer) {
    final coordinator = offer.coordinatorPubkey.trim().toLowerCase();
    final offerId = offer.id.trim();
    if (coordinator.isEmpty || offerId.isEmpty) {
      throw StateError('A dispute DM requires a complete offer coordinate.');
    }
    return '38383:$coordinator:$offerId';
  }

  static String caseIdFor(Offer offer) {
    final coordinator = offer.coordinatorPubkey.trim().toLowerCase();
    final offerId = offer.id.trim();
    if (coordinator.isEmpty || offerId.isEmpty) {
      throw StateError('A dispute DM requires a complete offer coordinate.');
    }
    return sha256
        .convert(utf8.encode('$_caseDomain:$coordinator:$offerId'))
        .toString();
  }

  /// Prefix required on every legacy NIP-04 message in this case lane.
  ///
  /// Kind-4 events cannot carry private case tags, so this remains inside the
  /// encrypted text and lets an operator identify an external-client reply.
  static String legacyCaseReference(Offer offer) =>
      '[BitBlik dispute ${offer.id}]';

  String _legacyOutgoingContent({
    required Offer offer,
    required String myPubkey,
    required String text,
  }) =>
      myPubkey.toLowerCase() == offer.coordinatorPubkey.toLowerCase()
          ? text
          : '${legacyCaseReference(offer)}\n$text';

  List<List<String>> _caseTags(Offer offer) => [
        ['a', offerCoordinate(offer)],
        ['case', caseIdFor(offer)],
      ];

  /// Whether a decrypted NIP-17 message belongs to this exact dispute lane.
  ///
  /// Live inbox consumers use this before appending the message directly,
  /// avoiding a second cache query between decryption and rendering.
  bool isMessageForCase({
    required Offer offer,
    required String myPubkey,
    required Nip17Message message,
    String? participantPubkey,
    bool includeUnbound = false,
  }) {
    final peer = _peerFor(
      offer,
      myPubkey,
      participantPubkey: participantPubkey,
    );
    if (message.peerPubKey.toLowerCase() != peer.toLowerCase()) return false;
    final coordinate = _singleTag(message.rumor, 'a');
    final caseId = _singleTag(message.rumor, 'case');
    if (coordinate == offerCoordinate(offer) && caseId == caseIdFor(offer)) {
      return true;
    }
    // Ordinary Nostr clients do not know BitBlik's encrypted case tags. The
    // coordinator may display an otherwise unbound DM in the exact peer lane,
    // but a partial or different explicit case binding is never accepted.
    if (coordinate != null || caseId != null) return false;
    return includeUnbound;
  }

  String _peerFor(Offer offer, String myPubkey, {String? participantPubkey}) {
    final me = myPubkey.toLowerCase();
    if (me == offer.coordinatorPubkey.toLowerCase()) {
      final participant = participantPubkey?.toLowerCase();
      if (participant == null ||
          (participant != offer.makerPubkey.toLowerCase() &&
              participant != offer.takerPubkey?.toLowerCase())) {
        throw StateError(
          'Coordinator lane participant is not part of the offer.',
        );
      }
      return participant;
    }
    if (me != offer.makerPubkey.toLowerCase() &&
        me != offer.takerPubkey?.toLowerCase()) {
      throw StateError('Authenticated user is not part of this offer.');
    }
    return offer.coordinatorPubkey;
  }

  void _requireWritableDispute(Offer offer) {
    if (offer.statusRaw != OfferStatus.dispute.name) {
      throw StateError('Resolved dispute history is read-only.');
    }
  }

  Future<DisputeTextTransport> sendText({
    required Offer offer,
    required String myPubkey,
    required String content,
    String? participantPubkey,
    required Iterable<String> recipientDmRelayDiscoveryRelays,
    required Iterable<String> legacyRendezvousRelays,
  }) async {
    _requireWritableDispute(offer);
    final text = content.trim();
    if (text.isEmpty) throw ArgumentError.value(content, 'content');
    final peer = _peerFor(
      offer,
      myPubkey,
      participantPubkey: participantPubkey,
    );
    try {
      await ndk.dms.sendMessage(
        recipientPubKey: peer,
        content: text,
        additionalTags: _caseTags(offer),
        recipientDmRelayDiscoveryRelays: recipientDmRelayDiscoveryRelays,
      );
      return DisputeTextTransport.nip17;
    } catch (error) {
      // NDK currently exposes this specific condition as an Exception message.
      // Do not downgrade privacy for a sender-list failure or any transport,
      // signing, or general send error.
      if (!_isMissingRecipientDmRelays(error)) rethrow;
    }

    final relays = _requireLegacyRendezvousRelays(legacyRendezvousRelays);
    await ndk.dms.sendLegacyNip04Message(
      recipientPubKey: peer,
      content: _legacyOutgoingContent(
        offer: offer,
        myPubkey: myPubkey,
        text: text,
      ),
      rendezvousRelays: relays,
    );
    return DisputeTextTransport.legacyNip04;
  }

  /// Sends explicitly on an already-selected legacy compatibility lane.
  Future<void> sendLegacyText({
    required Offer offer,
    required String myPubkey,
    required String content,
    String? participantPubkey,
    required Iterable<String> legacyRendezvousRelays,
  }) async {
    _requireWritableDispute(offer);
    final text = content.trim();
    if (text.isEmpty) throw ArgumentError.value(content, 'content');
    final peer = _peerFor(
      offer,
      myPubkey,
      participantPubkey: participantPubkey,
    );
    await ndk.dms.sendLegacyNip04Message(
      recipientPubKey: peer,
      content: _legacyOutgoingContent(
        offer: offer,
        myPubkey: myPubkey,
        text: text,
      ),
      rendezvousRelays: _requireLegacyRendezvousRelays(
        legacyRendezvousRelays,
      ),
    );
  }

  /// Returns the already-validated NIP-17 messages held in NDK's cache.
  ///
  /// Console inbox subscriptions use this after receiving a kind-1059 event,
  /// avoiding a second short-lived relay query for every live message.
  Future<List<Nip17Message>> loadMessagesSnapshot({
    required Offer offer,
    required String myPubkey,
    String? participantPubkey,
    bool includeUnbound = false,
  }) async {
    final peer = _peerFor(
      offer,
      myPubkey,
      participantPubkey: participantPubkey,
    );
    final messages = await ndk.dms.loadConversationSnapshot(peerPubKey: peer);
    return messages
        .where(
          (message) => isMessageForCase(
            offer: offer,
            myPubkey: myPubkey,
            message: message,
            participantPubkey: participantPubkey,
            includeUnbound: includeUnbound,
          ),
        )
        .toList(growable: false);
  }

  /// Parses a NIP-17 gift wrap while tolerating the interoperable seal shape
  /// emitted by clients that repeat the recipient `p` tag inside kind 13.
  /// NDK's strict parser currently rejects every non-empty seal tag list.
  Future<Nip17Message?> parseNip17Message(Nip01Event wrappedEvent) async {
    final strict =
        await ndk.dms.parseWrappedMessage(wrappedEvent: wrappedEvent);
    if (strict != null) return strict;
    final account = ndk.accounts.getLoggedAccount();
    if (account == null || !account.signer.canSign()) return null;
    final me = account.pubkey.toLowerCase();
    try {
      final result = await ndk.giftWrap.fromGiftWrapWithInfo(
        giftWrap: wrappedEvent,
      );
      final rumor = result.rumor;
      final seal = result.seal;
      final outerRecipients = wrappedEvent.tags
          .where((tag) => tag.length >= 2 && tag.first == 'p')
          .toList();
      final compatibleSealTags = seal.tags.isNotEmpty &&
          seal.tags.every(
            (tag) =>
                tag.length >= 2 &&
                ((tag.first == 'p' && tag[1].toLowerCase() == me) ||
                    (tag.first == 'client' && tag[1].trim().isNotEmpty)),
          );
      final expectedRumorId = Nip01Utils.calculateEventIdSync(
        pubKey: rumor.pubKey,
        createdAt: rumor.createdAt,
        kind: rumor.kind,
        tags: rumor.tags,
        content: rumor.content,
      );
      final now = Nip01Event.secondsSinceEpoch();
      final latestAccepted = now + const Duration(minutes: 10).inSeconds;
      final participantTags = rumor.tags
          .where((tag) => tag.isNotEmpty && tag.first == 'p')
          .toList();
      final validParticipants = participantTags.isNotEmpty &&
          participantTags.every(
            (tag) => tag.length >= 2 && _hexPubKey.hasMatch(tag[1]),
          );
      if (!result.isCryptographicallyValid ||
          outerRecipients.length != 1 ||
          outerRecipients.single[1].toLowerCase() != me ||
          seal.kind != GiftWrap.kSealEventKind ||
          !compatibleSealTags ||
          rumor.sig != null ||
          rumor.id != expectedRumorId ||
          wrappedEvent.createdAt <= 0 ||
          seal.createdAt <= 0 ||
          rumor.createdAt <= 0 ||
          wrappedEvent.createdAt > latestAccepted ||
          seal.createdAt > latestAccepted ||
          rumor.createdAt > latestAccepted ||
          !validParticipants ||
          (rumor.kind != Dms.kMessageKind &&
              rumor.kind != Dms.kFileMessageKind) ||
          (rumor.kind == Dms.kFileMessageKind &&
              Nip17FileMetadata.tryParse(rumor) == null)) {
        return null;
      }
      final rumorAuthor = rumor.pubKey.toLowerCase();
      String? peer;
      if (rumorAuthor == me) {
        for (final tag in participantTags) {
          if (tag[1].toLowerCase() != me) {
            peer = tag[1].toLowerCase();
            break;
          }
        }
      } else if (participantTags.any(
        (tag) => tag[1].toLowerCase() == me,
      )) {
        peer = rumorAuthor;
      }
      if (peer == null) return null;
      return Nip17Message(
        wrappedEvent: wrappedEvent,
        rumor: rumor,
        peerPubKey: peer,
        isOutgoing: rumorAuthor == me,
      );
    } catch (_) {
      return null;
    }
  }

  /// Loads only bound legacy NIP-04 text after the caller has explicitly
  /// entered compatibility mode. This is human-assistance content, never case
  /// evidence or an authorization signal.
  Future<List<LegacyNip04Message>> loadLegacyMessages({
    required Offer offer,
    required String myPubkey,
    String? participantPubkey,
    required Iterable<String> legacyRendezvousRelays,
    bool forceRefresh = false,
    bool includeUnbound = false,
  }) async {
    final peer = _peerFor(
      offer,
      myPubkey,
      participantPubkey: participantPubkey,
    );
    final relays = _requireLegacyRendezvousRelays(legacyRendezvousRelays);
    final account = ndk.accounts.getLoggedAccount();
    if (account == null || !account.signer.canSign()) {
      throw Exception('NIP-04 requires a logged-in signing account.');
    }
    final responses = await Future.wait([
      ndk.requests
          .query(
            name: 'bitblik-legacy-nip04-outgoing',
            explicitRelays: relays,
            cacheRead: !forceRefresh,
            cacheWrite: true,
            timeout: const Duration(seconds: 5),
            authenticateAs: [account],
            filter: Filter(
              kinds: const [Dms.kLegacyNip04MessageKind],
              authors: [myPubkey],
              pTags: [peer],
            ),
          )
          .future,
      ndk.requests
          .query(
            name: 'bitblik-legacy-nip04-incoming',
            explicitRelays: relays,
            cacheRead: !forceRefresh,
            cacheWrite: true,
            timeout: const Duration(seconds: 5),
            authenticateAs: [account],
            filter: Filter(
              kinds: const [Dms.kLegacyNip04MessageKind],
              authors: [peer],
              pTags: [myPubkey],
            ),
          )
          .future,
    ]);
    final messagesById = <String, LegacyNip04Message>{};
    for (final event in responses.expand((events) => events)) {
      final message = await parseLegacyNip04Event(event);
      if (message != null) messagesById[message.id] = message;
    }
    final messages = messagesById.values.toList()
      ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return messages
        .where(
          (message) => isLegacyMessageForCase(
            offer: offer,
            myPubkey: myPubkey,
            participantPubkey: participantPubkey,
            message: message,
            includeUnbound: includeUnbound,
          ),
        )
        .toList(growable: false);
  }

  /// Decrypts one already-verified kind-4 event for the active account.
  /// Request subscriptions verify event ids/signatures before yielding them;
  /// this method additionally enforces the exact NIP-04 sender/recipient shape.
  Future<LegacyNip04Message?> parseLegacyNip04Event(
    Nip01Event event,
  ) async {
    if (event.kind != Dms.kLegacyNip04MessageKind) return null;
    if (!await ndk.config.eventVerifier.verify(event)) return null;
    final account = ndk.accounts.getLoggedAccount();
    if (account == null || !account.signer.canSign()) return null;
    final me = account.pubkey.toLowerCase();
    final recipient = _singleRecipientPubkey(event)?.toLowerCase();
    if (recipient == null) return null;
    final outgoing = event.pubKey.toLowerCase() == me;
    final peer = outgoing ? recipient : event.pubKey.toLowerCase();
    if (outgoing ? peer == me : recipient != me || peer == me) return null;
    try {
      // ignore: deprecated_member_use
      final plaintext = await account.signer.decrypt(event.content, peer);
      if (plaintext == null) return null;
      return LegacyNip04Message(
        event: event,
        peerPubKey: peer,
        isOutgoing: outgoing,
        content: plaintext,
      );
    } catch (_) {
      return null;
    }
  }

  /// Plain external-client NIP-04 DMs have no case tag. The coordinator may
  /// display them as explicitly unbound human assistance in the exact peer
  /// lane, but a reference for a different BitBlik case is never accepted.
  bool isLegacyMessageForCase({
    required Offer offer,
    required String myPubkey,
    required LegacyNip04Message message,
    String? participantPubkey,
    bool includeUnbound = false,
  }) {
    final peer = _peerFor(
      offer,
      myPubkey,
      participantPubkey: participantPubkey,
    );
    if (message.peerPubKey.toLowerCase() != peer.toLowerCase()) return false;
    final content = message.content.trimLeft();
    if (content.startsWith(legacyCaseReference(offer))) return true;
    if (content.startsWith('[BitBlik dispute ')) return false;
    return includeUnbound;
  }

  Future<Nip17FileMetadata> sendEvidence({
    required Offer offer,
    required String myPubkey,
    required Uint8List imageBytes,
    String? participantPubkey,
    Iterable<String>? recipientDmRelayDiscoveryRelays,
    Iterable<String>? coordinatorBlossomDiscoveryRelays,
  }) async {
    _requireWritableDispute(offer);
    final peer = _peerFor(
      offer,
      myPubkey,
      participantPubkey: participantPubkey,
    );
    final sanitized = imageSanitizer.sanitize(imageBytes);
    final encrypted = await Nip17FileCrypto.encrypt(sanitized.bytes);

    // Always resolve the standard kind-10063 list authored by the coordinator.
    // The uploader signs BUD authorization with their own logged-in key.
    final servers = await _loadCoordinatorBlossomServers(
      offer.coordinatorPubkey,
      discoveryRelays: coordinatorBlossomDiscoveryRelays,
    );
    if (servers.isEmpty) {
      throw StateError('Coordinator has no Blossom server list (kind 10063).');
    }
    final uploads = await ndk.blossom.uploadBlob(
      data: encrypted.ciphertext,
      serverUrls: servers,
      contentType: 'application/octet-stream',
      serverMediaOptimisation: false,
      precomputedSha256: encrypted.encryptedSha256,
    );

    Uri? ciphertextUrl;
    for (final result in uploads) {
      final descriptor = result.descriptor;
      if (result.success &&
          descriptor != null &&
          descriptor.sha256.toLowerCase() == encrypted.encryptedSha256) {
        ciphertextUrl = Uri.tryParse(descriptor.url);
        if (ciphertextUrl != null) break;
      }
    }
    ciphertextUrl ??= await findVerifiedBlossomBlob(
      serverUrls: servers,
      sha256Hex: encrypted.encryptedSha256,
      download: (serverUrl, blobUrl) async {
        final blob = await ndk.files.download(
          url: blobUrl.toString(),
          serverUrls: [serverUrl],
        );
        return blob.data;
      },
    );
    if (ciphertextUrl == null) {
      final failures = uploads
          .map(
            (result) =>
                '${result.serverUrl}: ${result.error ?? 'invalid upload descriptor'}',
          )
          .join('; ');
      throw StateError(
        'Encrypted evidence upload failed on all coordinator servers'
        '${failures.isEmpty ? '.' : ': $failures'}',
      );
    }

    final metadata = Nip17FileMetadata.fromEncryptedFile(
      url: ciphertextUrl,
      mimeType: sanitized.mimeType,
      encryptedFile: encrypted,
      dimensions: '${sanitized.width}x${sanitized.height}',
    );
    await ndk.dms.sendFileMessage(
      recipientPubKey: peer,
      metadata: metadata,
      additionalTags: _caseTags(offer),
      recipientDmRelayDiscoveryRelays: recipientDmRelayDiscoveryRelays,
    );
    return metadata;
  }

  Future<Uint8List> downloadEvidence({
    required Offer offer,
    required String myPubkey,
    required Nip17Message message,
    String? participantPubkey,
    Iterable<String>? coordinatorBlossomDiscoveryRelays,
  }) async {
    final peer = _peerFor(
      offer,
      myPubkey,
      participantPubkey: participantPubkey,
    );
    if (message.peerPubKey.toLowerCase() != peer.toLowerCase() ||
        _singleTag(message.rumor, 'a') != offerCoordinate(offer) ||
        _singleTag(message.rumor, 'case') != caseIdFor(offer)) {
      throw StateError('Evidence is not bound to this dispute lane.');
    }
    final metadata = message.fileMetadata;
    if (metadata == null) throw const FormatException('Invalid file message.');
    final servers = await _loadCoordinatorBlossomServers(
      offer.coordinatorPubkey,
      discoveryRelays: coordinatorBlossomDiscoveryRelays,
    );
    if (servers.isEmpty) {
      throw StateError('Coordinator has no Blossom server list (kind 10063).');
    }
    final blob = await ndk.files.download(
      url: metadata.url.toString(),
      serverUrls: servers,
    );
    final plaintext = await Nip17FileCrypto.decrypt(
      ciphertext: blob.data,
      metadata: metadata,
    );
    imageSanitizer.validateDownloaded(plaintext, metadata.mimeType);
    return plaintext;
  }

  Future<List<String>> _loadCoordinatorBlossomServers(
    String coordinatorPubkey, {
    Iterable<String>? discoveryRelays,
  }) async {
    final explicitRelays = discoveryRelays
        ?.map((relay) => relay.trim())
        .where((relay) => relay.isNotEmpty)
        .toSet()
        .toList(growable: false);
    if (explicitRelays != null && explicitRelays.isNotEmpty) {
      try {
        final response = ndk.requests.query(
          name: 'dispute-coordinator-blossom-servers',
          filter: Filter(
            kinds: const [Blossom.kBlossomUserServerList],
            authors: [coordinatorPubkey],
            limit: 1,
          ),
          explicitRelays: explicitRelays,
          cacheRead: false,
          cacheWrite: true,
          timeout: const Duration(seconds: 6),
        );
        final events = await response.future;
        if (events.isNotEmpty) {
          events.sort((a, b) => b.createdAt.compareTo(a.createdAt));
          return normalizeBlossomServerUrls(
            events.first.tags
                .where(
                  (tag) => tag.length >= 2 && tag.first == 'server',
                )
                .map((tag) => tag[1]),
          );
        }
      } catch (_) {
        // Fall through to NDK's cache/default lookup. This still lets an
        // already-cached list work during a transient discovery relay outage.
      }
    }

    final discovered = await ndk.blossomUserServerList.getUserServerList(
      pubkeys: [coordinatorPubkey],
    );
    return normalizeBlossomServerUrls(discovered ?? const []);
  }

  static String? _singleTag(Nip01Event event, String name) {
    final matches = event.tags
        .where((tag) => tag.length == 2 && tag.first == name)
        .toList();
    return matches.length == 1 ? matches.single[1] : null;
  }

  /// NIP-01 permits extra fields in tags, and legacy clients commonly include
  /// a relay hint as the third `p`-tag value. Require one recipient while
  /// accepting that interoperable shape.
  static String? _singleRecipientPubkey(Nip01Event event) {
    final matches =
        event.tags.where((tag) => tag.length >= 2 && tag.first == 'p').toList();
    return matches.length == 1 ? matches.single[1] : null;
  }

  static final RegExp _hexPubKey = RegExp(r'^[0-9a-f]{64}$');

  static bool _isMissingRecipientDmRelays(Object error) =>
      error.toString().contains(_missingRecipientDmRelays);

  static List<String> _requireLegacyRendezvousRelays(
    Iterable<String> relays,
  ) {
    final cleaned = relays
        .map((relay) => relay.trim())
        .where((relay) => relay.isNotEmpty)
        .toSet()
        .toList(growable: false);
    if (cleaned.isEmpty) {
      throw StateError(
        'Legacy NIP-04 compatibility is unavailable: this coordinator has no '
        'known rendezvous relays.',
      );
    }
    return cleaned;
  }
}

/// The deliberately chosen transport for a dispute text message.
enum DisputeTextTransport { nip17, legacyNip04 }
