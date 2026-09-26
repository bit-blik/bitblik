import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:bip340/bip340.dart' as bip340;
import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/broadcast_state.dart';
import 'package:ndk/domain_layer/entities/relay_connectivity.dart';
import 'package:ndk/domain_layer/entities/connection_source.dart';
import 'package:test/test.dart';
import 'package:fake_async/fake_async.dart';

void main() {
  const firstPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000001';
  const secondPrivateKey =
      '0000000000000000000000000000000000000000000000000000000000000002';

  test('passive pause stays idle through ten minutes of route/network updates',
      () async {
    final clock = FakeAsync();
    final ndk = _TestNdk();
    late BitblikRpcClient client;
    var idleCalls = 0;
    clock.run((_) {
      ndk.requests.closeImmediately = true;
      client = BitblikRpcClient(
        ndk: ndk,
        signer: Bip340EventSigner(
            privateKey: firstPrivateKey,
            publicKey: bip340.getPublicKey(firstPrivateKey)),
        relays: const ['wss://enabled.example'],
        onIdle: () async {
          expect(ndk.requests.active, isEmpty);
          idleCalls++;
        },
      );
      unawaited(client.start());
    });
    await _advance(clock, Duration.zero);
    final attempts = ndk.requests._nextId;
    clock.run((_) => unawaited(client.setPassiveListeningEnabled(false)));
    await _advance(clock, Duration.zero);
    for (var i = 0; i < 600; i++) {
      clock.run((_) {
        client.setNetworkAvailable(i.isEven);
        unawaited(client.updateResponseRelays({'wss://changed.example'}));
      });
      await _advance(clock, const Duration(seconds: 1));
    }
    expect(ndk.requests.active, isEmpty);
    expect(ndk.requests._nextId, attempts);
    expect(idleCalls, 1);
    expect(clock.nonPeriodicTimerCount, 0);
    ndk.requests.closeImmediately = false;
    clock.run((_) {
      client.setNetworkAvailable(true);
      unawaited(client.setPassiveListeningEnabled(true));
    });
    await _advance(clock, Duration.zero);
    expect(ndk.requests.active.values.single.$1, {'wss://changed.example'});
    clock.run((_) => unawaited(client.stop()));
    await _advance(clock, Duration.zero);
    await ndk.destroy();
  });

  test('offline pause closes live listener before cleanup callback', () async {
    final ndk = _TestNdk();
    var idleCalls = 0;
    final client = BitblikRpcClient(
      ndk: ndk,
      signer: Bip340EventSigner(
          privateKey: firstPrivateKey,
          publicKey: bip340.getPublicKey(firstPrivateKey)),
      relays: const ['wss://enabled.example'],
      onIdle: () async {
        expect(ndk.requests.active, isEmpty);
        idleCalls++;
        throw StateError('cleanup failed');
      },
    );
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
    });
    await client.start();
    client.setNetworkAvailable(false);
    await client.setPassiveListeningEnabled(false);
    expect(ndk.requests.active, isEmpty);
    expect(idleCalls, 1);
    client.setNetworkAvailable(true);
    await client.updateResponseRelays({'wss://changed.example'});
    expect(ndk.requests.active, isEmpty);
    expect(idleCalls, 1);
  });

  test('paused explicit request waits for listener and closes it after reply',
      () async {
    final ndk = _TestNdk();
    ndk.requests.readiness = Completer<void>();
    var idleCalls = 0;
    final signer = Bip340EventSigner(
        privateKey: firstPrivateKey,
        publicKey: bip340.getPublicKey(firstPrivateKey));
    final client = BitblikRpcClient(
      ndk: ndk,
      signer: signer,
      relays: const ['wss://enabled.example'],
      onIdle: () async {
        expect(ndk.requests.active, isEmpty);
        idleCalls++;
      },
    );
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
    });
    await client.setPassiveListeningEnabled(false);
    await client.start();
    expect(ndk.requests._nextId, 0);
    final result = client.send(
      const NostrRequest(method: 'get_info', params: {}, id: 'paused-send'),
      bip340.getPublicKey(secondPrivateKey),
      relays: const ['wss://request.example'],
    );
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(ndk.broadcast.firstRequest.isCompleted, isFalse);
    expect(ndk.requests.active.values.single.$1, {'wss://request.example'});
    ndk.requests.readiness!.complete();
    await ndk.broadcast.firstRequest.future;
    ndk.requests.deliver(
      'wss://request.example',
      await ProtocolCodec.encryptResponse(
        response: const NostrResponse(id: 'paused-send', result: {}),
        senderPrivateKeyHex: secondPrivateKey,
        senderPubkeyHex: bip340.getPublicKey(secondPrivateKey),
        recipientPubkey: signer.getPublicKey(),
      ),
    );
    expect((await result).isSuccess, isTrue);
    await client.setPassiveListeningEnabled(false);
    expect(ndk.requests.active, isEmpty);
    expect(idleCalls, 2);
  });

  test('pause preserves pending concurrent requests on separate routes',
      () async {
    final ndk = _TestNdk();
    final signer = Bip340EventSigner(
        privateKey: firstPrivateKey,
        publicKey: bip340.getPublicKey(firstPrivateKey));
    final client = BitblikRpcClient(
      ndk: ndk,
      signer: signer,
      relays: const ['wss://enabled.example'],
    );
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
    });
    await client.start();
    final first = client.send(
      const NostrRequest(method: 'get_info', params: {}, id: 'first-paused'),
      bip340.getPublicKey(secondPrivateKey),
      relays: const ['wss://first.example'],
    );
    final second = client.send(
      const NostrRequest(method: 'get_info', params: {}, id: 'second-paused'),
      bip340.getPublicKey(secondPrivateKey),
      relays: const ['wss://second.example'],
    );
    await ndk.broadcast.twoRequests.future;
    await client.setPassiveListeningEnabled(false);
    await client.updateResponseRelays({'wss://unneeded.example'});
    for (final (id, route, result) in [
      ('first-paused', 'wss://first.example', first),
      ('second-paused', 'wss://second.example', second),
    ]) {
      ndk.requests.deliver(
        route,
        await ProtocolCodec.encryptResponse(
          response: NostrResponse(id: id, result: const {}),
          senderPrivateKeyHex: secondPrivateKey,
          senderPubkeyHex: bip340.getPublicKey(secondPrivateKey),
          recipientPubkey: signer.getPublicKey(),
        ),
      );
      expect((await result).isSuccess, isTrue);
      await client.setPassiveListeningEnabled(false);
    }
    expect(ndk.requests.active, isEmpty);
    await client.setPassiveListeningEnabled(true);
    expect(ndk.requests.active.values.single.$1, {'wss://unneeded.example'});
  });

  test('paused request timeout removes temporary listener without retry',
      () async {
    final ndk = _TestNdk();
    final client = BitblikRpcClient(
      ndk: ndk,
      signer: Bip340EventSigner(
          privateKey: firstPrivateKey,
          publicKey: bip340.getPublicKey(firstPrivateKey)),
      relays: const ['wss://enabled.example'],
      timeout: const Duration(milliseconds: 20),
    );
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
    });
    await client.setPassiveListeningEnabled(false);
    await client.start();
    await expectLater(
      client.send(
        const NostrRequest(
            method: 'get_info', params: {}, id: 'paused-timeout'),
        bip340.getPublicKey(secondPrivateKey),
      ),
      throwsA(isA<RpcTimeoutException>()),
    );
    await client.setPassiveListeningEnabled(false);
    expect(ndk.requests.active, isEmpty);
    final attempts = ndk.requests._nextId;
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    expect(ndk.requests._nextId, attempts);
  });

  test('passive pause survives stop/start and signer rebind', () async {
    final ndk = _TestNdk();
    final client = BitblikRpcClient(
      ndk: ndk,
      signer: Bip340EventSigner(
          privateKey: firstPrivateKey,
          publicKey: bip340.getPublicKey(firstPrivateKey)),
      relays: const ['wss://enabled.example'],
    );
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
    });
    await client.start();
    await client.setPassiveListeningEnabled(false);
    await client.stop();
    await client.start();
    await client.rebindSigner(Bip340EventSigner(
        privateKey: secondPrivateKey,
        publicKey: bip340.getPublicKey(secondPrivateKey)));
    expect(client.signer.getPublicKey(), bip340.getPublicKey(secondPrivateKey));
    expect(ndk.requests.active, isEmpty);
    expect(ndk.requests._nextId, 1);
    await client.setPassiveListeningEnabled(true);
    expect(ndk.requests.active.length, 1);
  });

  test('cold start waits for reply subscription before publishing', () async {
    final ndk = _TestNdk();
    ndk.requests.readiness = Completer<void>();
    final signer = Bip340EventSigner(
      privateKey: firstPrivateKey,
      publicKey: bip340.getPublicKey(firstPrivateKey),
    );
    final client = BitblikRpcClient(
        ndk: ndk, signer: signer, relays: const ['wss://enabled.example']);
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
    });
    await client.start();
    final result = client.send(
      const NostrRequest(method: 'get_info', params: {}, id: 'cold'),
      bip340.getPublicKey(secondPrivateKey),
    );
    await Future<void>.delayed(const Duration(milliseconds: 30));
    expect(ndk.broadcast.firstRequest.isCompleted, isFalse);
    ndk.requests.readiness!.complete();
    await ndk.broadcast.firstRequest.future;
    expect(ndk.broadcast.retryDelivery, isFalse,
        reason: 'RPCs must never enter durable retry queues');
    ndk.requests.deliver(
        'wss://enabled.example',
        await ProtocolCodec.encryptResponse(
          response: const NostrResponse(id: 'cold', result: {}),
          senderPrivateKeyHex: secondPrivateKey,
          senderPubkeyHex: bip340.getPublicKey(secondPrivateKey),
          recipientPubkey: signer.getPublicKey(),
        ));
    expect((await result).isSuccess, isTrue);
  });

  test('ended reply stream reopens without refreshing app', () async {
    final ndk = _TestNdk();
    final client = BitblikRpcClient(
        ndk: ndk,
        signer: Bip340EventSigner(
            privateKey: firstPrivateKey,
            publicKey: bip340.getPublicKey(firstPrivateKey)),
        relays: const ['wss://enabled.example']);
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
    });
    await client.start();
    final oldId = ndk.requests.active.keys.single;
    await ndk.requests.active[oldId]!.$2.close();
    await Future<void>.delayed(const Duration(milliseconds: 1100));
    expect(ndk.requests.active.length, 1);
    expect(ndk.requests.active.keys.single, isNot(oldId));
  });

  test('rejected reply streams back off even during repeated relay updates',
      () async {
    final clock = FakeAsync();
    final ndk = _TestNdk();
    late BitblikRpcClient client;
    clock.run((_) {
      ndk.requests.closeImmediately = true;
      client = BitblikRpcClient(
          ndk: ndk,
          signer: Bip340EventSigner(
              privateKey: firstPrivateKey,
              publicKey: bip340.getPublicKey(firstPrivateKey)),
          relays: const ['wss://enabled.example']);
      unawaited(client.start());
    });
    for (var i = 0; i < 600; i++) {
      clock.run((_) =>
          unawaited(client.updateResponseRelays({'wss://enabled.example'})));
      await _advance(clock, const Duration(seconds: 1));
    }
    // Persistent rejection must not reopen once per second. Jitter allows
    // at most one attempt per 30 seconds after reaching the 60-second cap.
    expect(ndk.requests._nextId, inInclusiveRange(8, 28));
    final attempts = ndk.requests._nextId;
    ndk.requests.closeImmediately = false;
    clock.run((_) =>
        unawaited(client.updateResponseRelays({'wss://replacement.example'})));
    await _advance(clock, Duration.zero);
    expect(ndk.requests._nextId, attempts + 1);
    expect(ndk.requests.active.values.single.$1, {'wss://replacement.example'});
    clock.run((_) => unawaited(client.stop()));
    await _advance(clock, const Duration(minutes: 2));
    expect(ndk.requests._nextId, attempts + 1);
    expect(ndk.requests.active, isEmpty);
    await ndk.destroy();
  });

  test('OS offline hint suspends retries until network returns', () async {
    final clock = FakeAsync();
    final ndk = _TestNdk();
    late BitblikRpcClient client;
    clock.run((_) {
      ndk.requests.closeImmediately = true;
      client = BitblikRpcClient(
          ndk: ndk,
          signer: Bip340EventSigner(
              privateKey: firstPrivateKey,
              publicKey: bip340.getPublicKey(firstPrivateKey)),
          relays: const ['wss://enabled.example']);
      unawaited(client.start());
    });
    await _advance(clock, Duration.zero);
    clock.run((_) => client.setNetworkAvailable(false));
    final attempts = ndk.requests._nextId;
    await _advance(clock, const Duration(minutes: 10));
    expect(ndk.requests._nextId, attempts);
    ndk.requests.closeImmediately = false;
    clock.run((_) => client.setNetworkAvailable(true));
    await _advance(clock, Duration.zero);
    expect(ndk.requests._nextId, attempts + 1);
    clock.run((_) => unawaited(client.stop()));
    await _advance(clock, Duration.zero);
    await ndk.destroy();
  });

  test('reply retry backoff resets after a stable open transport', () async {
    final clock = FakeAsync();
    final ndk = _TestNdk();
    late BitblikRpcClient client;
    clock.run((_) {
      ndk.requests.closeImmediately = true;
      client = BitblikRpcClient(
          ndk: ndk,
          signer: Bip340EventSigner(
              privateKey: firstPrivateKey,
              publicKey: bip340.getPublicKey(firstPrivateKey)),
          relays: const ['wss://enabled.example']);
      unawaited(client.start());
    });
    for (var i = 0; i < 180; i++) {
      await _advance(clock, const Duration(seconds: 1));
    }
    ndk.requests.closeImmediately = false;
    for (var i = 0; i < 91; i++) {
      await _advance(clock, const Duration(seconds: 1));
    }
    final attempts = ndk.requests._nextId;
    clock.run((_) => unawaited(ndk.requests.active.values.single.$2.close()));
    await _advance(clock, Duration.zero);
    await _advance(clock, const Duration(milliseconds: 1100));
    expect(ndk.requests._nextId, attempts + 1);
    clock.run((_) => unawaited(client.stop()));
    await _advance(clock, Duration.zero);
    await ndk.destroy();
  });

  test('empty relay set stays idle and adding a relay starts listening',
      () async {
    final clock = FakeAsync();
    final ndk = _TestNdk();
    late BitblikRpcClient client;
    clock.run((_) {
      client = BitblikRpcClient(
          ndk: ndk,
          signer: Bip340EventSigner(
              privateKey: firstPrivateKey,
              publicKey: bip340.getPublicKey(firstPrivateKey)),
          relays: const []);
      unawaited(client.start());
    });
    await _advance(clock, const Duration(minutes: 2));
    expect(ndk.requests._nextId, 0);
    clock.run((_) =>
        unawaited(client.updateResponseRelays({'wss://enabled.example'})));
    await _advance(clock, Duration.zero);
    expect(ndk.requests._nextId, 1);
    clock.run((_) => unawaited(client.updateResponseRelays({})));
    await _advance(clock, const Duration(minutes: 2));
    expect(ndk.requests.active, isEmpty);
    expect(ndk.requests._nextId, 1);
    clock.run((_) => unawaited(client.stop()));
    await _advance(clock, Duration.zero);
    await ndk.destroy();
  });

  test('valid reply wins before aggregate ACKs and late broadcast errors',
      () async {
    final ndk = _TestNdk();
    final acknowledgements = Completer<List<RelayBroadcastResponse>>();
    ndk.broadcast.done = acknowledgements.future;
    final signer = Bip340EventSigner(
      privateKey: firstPrivateKey,
      publicKey: bip340.getPublicKey(firstPrivateKey),
    );
    final client = BitblikRpcClient(
      ndk: ndk,
      signer: signer,
      relays: const ['wss://enabled.example'],
    );
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
    });
    await client.start();
    final response = client.send(
      const NostrRequest(method: 'get_info', params: {}, id: 'early-reply'),
      bip340.getPublicKey(secondPrivateKey),
    );
    await ndk.broadcast.firstRequest.future;
    ndk.requests.deliver(
      'wss://enabled.example',
      await ProtocolCodec.encryptResponse(
        response: const NostrResponse(id: 'early-reply', result: {'ok': true}),
        senderPrivateKeyHex: secondPrivateKey,
        senderPubkeyHex: bip340.getPublicKey(secondPrivateKey),
        recipientPubkey: signer.getPublicKey(),
      ),
    );
    expect(
        (await response.timeout(const Duration(seconds: 1))).isSuccess, isTrue);
    expect(acknowledgements.isCompleted, isFalse);
    acknowledgements.completeError(StateError('late relay failure'));
    await Future<void>.delayed(Duration.zero);
  });

  test('ACKs alone are not a coordinator response; timeout permits ID reuse',
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
      timeout: const Duration(milliseconds: 20),
    );
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
    });
    await client.start();
    const request = NostrRequest(method: 'get_info', params: {}, id: 'retry');
    // Stream acceptance must survive even if the aggregate future is stuck
    // behind another relay or delivery persistence.
    final done = Completer<List<RelayBroadcastResponse>>();
    ndk.broadcast.done = done.future;
    await expectLater(
        client.send(request, bip340.getPublicKey(secondPrivateKey)),
        throwsA(isA<RpcTimeoutException>().having(
            (error) => error.coordinatorResponseMissing,
            'coordinator response missing',
            true)));
    done.complete([]);
    final retried = client.send(request, bip340.getPublicKey(secondPrivateKey));
    await ndk.broadcast.twoRequests.future;
    ndk.requests.deliver(
      'wss://enabled.example',
      await ProtocolCodec.encryptResponse(
        response: const NostrResponse(id: 'retry', result: {}),
        senderPrivateKeyHex: secondPrivateKey,
        senderPubkeyHex: bip340.getPublicKey(secondPrivateKey),
        recipientPubkey: signer.getPublicKey(),
      ),
    );
    expect((await retried).isSuccess, isTrue);
  });

  for (final disconnected in [false, true]) {
    test('timeout keeps relay rejection/disconnection distinct: $disconnected',
        () async {
      final ndk = _TestNdk();
      ndk.broadcast.accept = disconnected;
      final client = BitblikRpcClient(
        ndk: ndk,
        signer: Bip340EventSigner(
            privateKey: firstPrivateKey,
            publicKey: bip340.getPublicKey(firstPrivateKey)),
        relays: const ['wss://enabled.example', 'wss://cold.example'],
        timeout: const Duration(milliseconds: 20),
      );
      // Only one relay is connected when send starts; both must be published
      // to, since the other can connect while the first rejects the event.
      ndk.requests.onSent = (id, urls) {
        final relay = _ConnectedRelay(urls.first);
        relay.stats.openRequestIds.add(id);
        ndk.relays.globalState.relays[relay.key] = relay;
      };
      addTearDown(() async {
        await client.stop();
        await ndk.destroy();
      });
      await client.start();
      final result = client.send(
        const NostrRequest(method: 'get_info', params: {}),
        bip340.getPublicKey(secondPrivateKey),
      );
      final assertion = expectLater(
          result,
          throwsA(isA<RpcTimeoutException>()
              .having((error) => error.coordinatorResponseMissing,
                  'coordinator fault', false)
              .having((error) => error.relayAccepted, 'relay accepted',
                  disconnected)));
      await ndk.broadcast.firstRequest.future;
      expect(ndk.broadcast.lastRelays,
          ['wss://enabled.example', 'wss://cold.example']);
      if (disconnected) ndk.relays.globalState.relays.clear();
      await assertion;
    });
  }

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

// Stream cancellation can return a shared completed future created outside
// the fake zone. Drain those real microtasks between virtual time advances.
Future<void> _advance(FakeAsync clock, Duration duration) async {
  clock.elapse(duration);
  await pumpEventQueue(times: 2);
  clock.flushMicrotasks();
  clock.elapse(Duration.zero);
  await pumpEventQueue(times: 2);
  clock.flushMicrotasks();
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
        )) {
    requests.onSent = (id, urls) {
      for (final url in urls) {
        final key = RelayConnectionKey.anonymous(url);
        final relay = relays.globalState.relays
            .putIfAbsent(key, () => _ConnectedRelay(url));
        relay.stats.openRequestIds.add(id);
      }
    };
  }
}

class _ConnectedRelay extends RelayConnectivity {
  _ConnectedRelay(String url)
      : super(
            key: RelayConnectionKey.anonymous(url),
            relay:
                Relay(url: url, connectionSource: ConnectionSource.explicit));
  @override
  bool get isConnected => true;
}

class _TestRequests implements Requests {
  final active = <String, (Set<String>, StreamController<Nip01Event>)>{};
  Completer<void>? readiness;
  late void Function(String, Iterable<String>) onSent;
  int _nextId = 0;
  bool closeImmediately = false;

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
      if (closeImmediately) Timer.run(() => unawaited(controller.close()));
      unawaited(Future<void>(() async {
        await readiness?.future;
        if (active.containsKey(id)) onSent(id, relays);
      }));
      return NdkResponse(id, controller.stream);
    }
    return super.noSuchMethod(invocation);
  }
}

class _TestBroadcast implements Broadcast {
  Future<List<RelayBroadcastResponse>>? done;
  bool accept = true;
  bool? retryDelivery;
  List<String> lastRelays = [];
  final firstRequest = Completer<void>();
  final twoRequests = Completer<void>();
  int _count = 0;

  @override
  dynamic noSuchMethod(Invocation invocation) {
    if (invocation.memberName == #broadcast) {
      final event = invocation.namedArguments[#nostrEvent] as Nip01Event;
      final relays =
          invocation.namedArguments[#specificRelays] as Iterable<String>;
      lastRelays = relays.toList();
      retryDelivery = invocation.namedArguments[#retryDelivery] as bool?;
      if (++_count == 1) firstRequest.complete();
      if (_count == 2) twoRequests.complete();
      return NdkBroadcastResponse(
        publishEvent: event,
        broadcastDoneFuture: done,
        broadcastDoneStream: Stream.value([
          for (final relay in relays)
            RelayBroadcastResponse(
              relayUrl: relay,
              okReceived: true,
              broadcastSuccessful: accept,
            ),
        ]).asBroadcastStream(),
      );
    }
    return super.noSuchMethod(invocation);
  }
}
