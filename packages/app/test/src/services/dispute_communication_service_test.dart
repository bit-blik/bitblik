import 'dart:typed_data';

import 'package:bitblik_core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image/image.dart' as image;
import 'package:ndk/ndk.dart';
import 'package:ndk/shared/nips/nip01/bip340.dart';

void main() {
  test('normalizes trailing slashes from kind-10063 Blossom servers', () {
    expect(
      normalizeBlossomServerUrls([
        ' https://blossom.primal.net/ ',
        'https://blossom.primal.net///',
        'https://nostr.download/',
        'not-a-server',
      ]),
      ['https://blossom.primal.net', 'https://nostr.download'],
    );
  });

  test(
    'recovers a stored upload from a non-standard Blossom response',
    () async {
      final ciphertext = Uint8List.fromList([1, 2, 3, 4]);
      const hash =
          '9f64a747e1b97f131fabb6b447296c9b6f0201e79fb3c5356e6c77e89b6a806a';
      final requested = <Uri>[];

      final recovered = await findVerifiedBlossomBlob(
        serverUrls: const ['https://first.example/', 'https://yaki.example/'],
        sha256Hex: hash,
        download: (server, url) async {
          requested.add(url);
          if (server == 'https://first.example') return Uint8List.fromList([9]);
          return ciphertext;
        },
      );

      expect(recovered, Uri.parse('https://yaki.example/$hash'));
      expect(requested, [
        Uri.parse('https://first.example/$hash'),
        Uri.parse('https://yaki.example/$hash'),
      ]);
    },
  );

  const sanitizer = EvidenceImageSanitizer();

  test('JPEG evidence is decoded, re-encoded, and metadata is removed', () {
    final source = image.Image(width: 8, height: 6)
      ..exif.imageIfd.imageDescription = 'sensitive location metadata';
    final input = image.encodeJpg(source);

    final result = sanitizer.sanitize(input);

    expect(result.mimeType, 'image/jpeg');
    expect(result.width, 8);
    expect(result.height, 6);
    final decoded = image.decodeJpg(result.bytes);
    expect(decoded, isNotNull);
    expect(decoded!.exif.imageIfd.imageDescription, isNull);
  });

  test('PNG evidence is decoded and remains a valid PNG', () {
    final input = image.encodePng(image.Image(width: 4, height: 3));
    final result = sanitizer.sanitize(input);

    expect(result.mimeType, 'image/png');
    expect(result.width, 4);
    expect(result.height, 3);
    expect(image.decodePng(result.bytes), isNotNull);
    expect(
      () => sanitizer.validateDownloaded(result.bytes, result.mimeType),
      returnsNormally,
    );
  });

  test('rejects unsupported signatures, byte limit, and pixel limit', () {
    expect(
      () => sanitizer.sanitize(Uint8List.fromList([1, 2, 3])),
      throwsA(isA<EvidenceImageException>()),
    );

    const tinyBytes = EvidenceImageSanitizer(
      policy: EvidenceImagePolicy(maxInputBytes: 2),
    );
    expect(
      () =>
          tinyBytes.sanitize(image.encodePng(image.Image(width: 1, height: 1))),
      throwsA(isA<EvidenceImageException>()),
    );

    const tinyPixels = EvidenceImageSanitizer(
      policy: EvidenceImagePolicy(maxPixels: 3),
    );
    expect(
      () => tinyPixels.sanitize(
        image.encodePng(image.Image(width: 2, height: 2)),
      ),
      throwsA(isA<EvidenceImageException>()),
    );
  });

  test('download validation rejects a MIME mismatch', () {
    final png = image.encodePng(image.Image(width: 1, height: 1));
    expect(
      () => sanitizer.validateDownloaded(png, 'image/jpeg'),
      throwsA(isA<EvidenceImageException>()),
    );
  });

  test('case binding is deterministic and uses the NIP-69 coordinate', () {
    final offer = Offer(
      id: 'offer-id',
      amountSats: 1000,
      makerFees: 5,
      status: OfferStatus.dispute,
      fiatAmount: 10,
      fiatCurrency: 'PLN',
      createdAt: DateTime.utc(2026),
      makerPubkey: 'maker',
      coordinatorPubkey: 'coordinator',
      takerPubkey: 'taker',
    );

    expect(
      DisputeCommunicationService.offerCoordinate(offer),
      '38383:coordinator:offer-id',
    );
    expect(
      DisputeCommunicationService.caseIdFor(offer),
      DisputeCommunicationService.caseIdFor(offer),
    );
    expect(DisputeCommunicationService.caseIdFor(offer), hasLength(64));
    expect(
      DisputeCommunicationService.legacyCaseReference(offer),
      '[BitBlik dispute offer-id]',
    );
    final nonCanonical = offer.copyWith(
      id: ' offer-id ',
      coordinatorPubkey: ' COORDINATOR ',
    );
    expect(
      DisputeCommunicationService.offerCoordinate(nonCanonical),
      '38383:coordinator:offer-id',
    );
    expect(
      DisputeCommunicationService.caseIdFor(nonCanonical),
      DisputeCommunicationService.caseIdFor(offer),
    );
    expect(
      () => DisputeCommunicationService.offerCoordinate(
        offer.copyWith(coordinatorPubkey: ' '),
      ),
      throwsStateError,
    );
  });

  test(
    'plain external NIP-04 can be shown only as unbound peer assistance',
    () async {
      const takerPrivateKey =
          '0000000000000000000000000000000000000000000000000000000000000003';
      const coordinatorPrivateKey =
          '0000000000000000000000000000000000000000000000000000000000000002';
      final taker = Bip340.getPublicKey(takerPrivateKey);
      final coordinator = Bip340.getPublicKey(coordinatorPrivateKey);
      final ndk = Ndk(
        NdkConfig(
          cache: MemCacheManager(),
          eventVerifier: Bip340EventVerifier(),
          bootstrapRelays: const [],
        ),
      );
      ndk.accounts.loginPrivateKey(
        pubkey: coordinator,
        privkey: coordinatorPrivateKey,
      );
      final offer = Offer(
        id: 'legacy-case',
        amountSats: 1000,
        makerFees: 5,
        status: OfferStatus.dispute,
        statusRaw: OfferStatus.dispute.name,
        fiatAmount: 10,
        fiatCurrency: 'PLN',
        createdAt: DateTime.utc(2026),
        makerPubkey: Bip340.getPublicKey(
          '0000000000000000000000000000000000000000000000000000000000000001',
        ),
        coordinatorPubkey: coordinator,
        takerPubkey: taker,
      );
      try {
        final event = Nip01Utils.signWithPrivateKey(
          event: Nip01Event(
            pubKey: taker,
            kind: Dms.kLegacyNip04MessageKind,
            createdAt: Nip01Event.secondsSinceEpoch(),
            content:
                (await Bip340EventSigner(
                  privateKey: takerPrivateKey,
                  publicKey: taker,
                ).encrypt('plain external client message', coordinator))!,
            tags: [
              ['p', coordinator, 'wss://relay-hint.example'],
            ],
          ),
          privateKey: takerPrivateKey,
        );
        final communication = DisputeCommunicationService(ndk: ndk);
        final message = await communication.parseLegacyNip04Event(event);
        expect(message, isNotNull);
        expect(message!.peerPubKey, taker);
        expect(
          communication.isLegacyMessageForCase(
            offer: offer,
            myPubkey: coordinator,
            participantPubkey: taker,
            message: message,
          ),
          isFalse,
        );
        expect(
          communication.isLegacyMessageForCase(
            offer: offer,
            myPubkey: coordinator,
            participantPubkey: taker,
            message: message,
            includeUnbound: true,
          ),
          isTrue,
        );
      } finally {
        await ndk.destroy();
      }
    },
  );

  test(
    'maker NIP-17 wrapper decrypts into the coordinator maker lane',
    () async {
      const makerPrivateKey =
          '0000000000000000000000000000000000000000000000000000000000000001';
      const coordinatorPrivateKey =
          '0000000000000000000000000000000000000000000000000000000000000002';
      final maker = Bip340.getPublicKey(makerPrivateKey);
      final coordinator = Bip340.getPublicKey(coordinatorPrivateKey);
      final offer = Offer(
        id: 'nip17-round-trip',
        amountSats: 1000,
        makerFees: 5,
        status: OfferStatus.dispute,
        statusRaw: OfferStatus.dispute.name,
        fiatAmount: 10,
        fiatCurrency: 'PLN',
        createdAt: DateTime.utc(2026),
        makerPubkey: maker,
        coordinatorPubkey: coordinator,
        takerPubkey: Bip340.getPublicKey(
          '0000000000000000000000000000000000000000000000000000000000000003',
        ),
      );
      final sender = Ndk(
        NdkConfig(
          cache: MemCacheManager(),
          eventVerifier: Bip340EventVerifier(),
          bootstrapRelays: const [],
        ),
      );
      final receiverCache = MemCacheManager();
      final receiver = Ndk(
        NdkConfig(
          cache: receiverCache,
          eventVerifier: Bip340EventVerifier(),
          bootstrapRelays: const [],
        ),
      );
      sender.accounts.loginPrivateKey(pubkey: maker, privkey: makerPrivateKey);
      receiver.accounts.loginPrivateKey(
        pubkey: coordinator,
        privkey: coordinatorPrivateKey,
      );

      try {
        final rumor = await sender.giftWrap.createRumor(
          content: 'maker to coordinator',
          kind: Dms.kMessageKind,
          tags: [
            ['p', coordinator],
            ['a', DisputeCommunicationService.offerCoordinate(offer)],
            ['case', DisputeCommunicationService.caseIdFor(offer)],
          ],
        );
        final wrapped = await sender.giftWrap.toGiftWrap(
          rumor: rumor,
          recipientPubkey: coordinator,
        );
        await receiverCache.saveEvent(wrapped);

        final parsed = await receiver.dms.parseWrappedMessage(
          wrappedEvent: wrapped,
        );
        expect(parsed, isNotNull);
        expect(parsed!.peerPubKey, maker);

        final communication = DisputeCommunicationService(ndk: receiver);
        expect(
          communication.isMessageForCase(
            offer: offer,
            myPubkey: coordinator,
            participantPubkey: maker,
            message: parsed,
          ),
          isTrue,
        );

        final unboundRumor = await sender.giftWrap.createRumor(
          content: 'generic client DM',
          kind: Dms.kMessageKind,
          tags: [
            ['p', coordinator],
          ],
        );
        final unboundWrapped = await sender.giftWrap.toGiftWrap(
          rumor: unboundRumor,
          recipientPubkey: coordinator,
        );
        await receiverCache.saveEvent(unboundWrapped);
        final unbound = await receiver.dms.parseWrappedMessage(
          wrappedEvent: unboundWrapped,
        );
        expect(unbound, isNotNull);
        expect(
          communication.isMessageForCase(
            offer: offer,
            myPubkey: coordinator,
            participantPubkey: maker,
            message: unbound!,
          ),
          isFalse,
        );
        expect(
          communication.isMessageForCase(
            offer: offer,
            myPubkey: coordinator,
            participantPubkey: maker,
            message: unbound,
            includeUnbound: true,
          ),
          isTrue,
        );

        final lane = await communication.loadMessagesSnapshot(
          offer: offer,
          myPubkey: coordinator,
          participantPubkey: maker,
        );
        expect(lane, hasLength(1));
        expect(lane.single.content, 'maker to coordinator');
        final unboundLane = await communication.loadMessagesSnapshot(
          offer: offer,
          myPubkey: coordinator,
          participantPubkey: maker,
          includeUnbound: true,
        );
        expect(unboundLane, hasLength(2));
        expect(
          unboundLane.map((message) => message.content),
          contains('generic client DM'),
        );
      } finally {
        await sender.destroy();
        await receiver.destroy();
      }
    },
  );
}
