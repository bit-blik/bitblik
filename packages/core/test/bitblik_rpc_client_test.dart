import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:bip340/bip340.dart' as bip340;
import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/broadcast_state.dart';
import 'package:test/test.dart';

void main() {
  const firstPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000001';
  const secondPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000002';

  test('concurrent probes retain reply relays during registry updates',
      () async {
    final ndk = _TestNdk();
    final signer = Bip340EventSigner(
      privateKey: firstPrivateKey,
      publicKey: bip340.getPublicKey(firstPrivateKey),
    );
    final client = BitblikRpcClient(
      ndk: ndk,
      signer: signer,
      relays: const ['wss://enabled.example'],
      timeout: const Duration(seconds: 1),
    );
    addTearDown(() async {
      await client.stop();
      expect(ndk.requests.active, isEmpty);
      await ndk.destroy();
    });
    await client.start();

    const thirdPrivateKey =
        '0000000000000000000000000000000000000000000000000000000000000003';
    final replies = Future.wait([
      client.send(
        const NostrRequest(method: 'get_info', params: {}, id: 'first'),
        bip340.getPublicKey(secondPrivateKey),
        relays: const ['wss://first.example'],
      ),
      client.send(
        const NostrRequest(method: 'get_info', params: {}, id: 'second'),
        bip340.getPublicKey(thirdPrivateKey),
        relays: const ['wss://second.example'],
      ),
    ]);
    final assertion = expectLater(
      replies,
      completion(everyElement(isA<NostrResponse>().having(
        (response) => response.isSuccess,
        'isSuccess',
        isTrue,
      ))),
    );
    await ndk.broadcast.twoRequests.future;

    // Health/profile emissions reapply enabled-only relays while disabled
    // coordinators' probes are still in flight.
    await client.updateResponseRelays({'wss://enabled.example'});
    ndk.requests.deliver(
      'wss://second.example',
      await ProtocolCodec.encryptResponse(
        response: const NostrResponse(id: 'second', result: {}),
        senderPrivateKeyHex: thirdPrivateKey,
        senderPubkeyHex: bip340.getPublicKey(thirdPrivateKey),
        recipientPubkey: signer.getPublicKey(),
      ),
    );
    await client.updateResponseRelays({'wss://enabled.example'});
    ndk.requests.deliver(
      'wss://first.example',
      await ProtocolCodec.encryptResponse(
        response: const NostrResponse(id: 'first', result: {}),
        senderPrivateKeyHex: secondPrivateKey,
        senderPubkeyHex: bip340.getPublicKey(secondPrivateKey),
        recipientPubkey: signer.getPublicKey(),
      ),
    );
    await assertion;
    await client.updateResponseRelays({'wss://enabled.example'});
    expect(ndk.requests.active.length, 1);
    expect(ndk.requests.active.values.single.$1, {'wss://enabled.example'});
  });

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

class _TestNdk extends Ndk {
  @override
  final _TestRequests requests = _TestRequests();
  @override
  final _TestBroadcast broadcast = _TestBroadcast();

  _TestNdk()
      : super(NdkConfig(
          cache: MemCacheManager(),
          eventVerifier: Bip340EventVerifier(),
          bootstrapRelays: const [],
        ));
}

class _TestRequests implements Requests {
  final active = <String, (Set<String>, StreamController<Nip01Event>)>{};
  int _nextId = 0;

  void deliver(String relay, Nip01Event event) {
    for (final (relays, controller) in active.values) {
      if (relays.contains(relay)) controller.add(event);
    }
  }

  @override
  Future<void> closeSubscription(String subId, {String debugLabel = ''}) async {
    // Exercise overlapping updates across the transport's close await.
    await Future<void>.delayed(Duration.zero);
    await active.remove(subId)?.$2.close();
  }

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #subscription) {
      final id = 'subscription-${_nextId++}';
      final relays =
          invocation.namedArguments[#explicitRelays] as Iterable<String>;
      final controller = StreamController<Nip01Event>();
      active[id] = (relays.toSet(), controller);
      return NdkResponse(id, controller.stream);
    }
    return super.noSuchMethod(invocation);
  }
}

class _TestBroadcast implements Broadcast {
  final twoRequests = Completer<void>();
  int _count = 0;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #broadcast) {
      final event = invocation.namedArguments[#nostrEvent] as Nip01Event;
      final relays =
          invocation.namedArguments[#specificRelays] as Iterable<String>;
      if (++_count == 2) twoRequests.complete();
      return NdkBroadcastResponse(
        publishEvent: event,
        broadcastDoneStream: Stream.value([
          for (final relay in relays)
            RelayBroadcastResponse(
              relayUrl: relay,
              okReceived: true,
              broadcastSuccessful: true,
            ),
        ]),
      );
    }
    return super.noSuchMethod(invocation);
  }
}
