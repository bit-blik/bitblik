import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bip340/bip340.dart' as bip340;
import 'package:bitblik_coordinator/src/services/relay_delivery.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk/domain_layer/entities/broadcast_state.dart';
import 'package:test/test.dart';

void main() {
  late StreamController<List<RelayBroadcastResponse>> updates;
  late Completer<List<RelayBroadcastResponse>> settled;
  late NdkBroadcastResponse broadcast;
  late List<Object> errors;
  late int cleanups;
  final positive = RelayBroadcastResponse(
      relayUrl: 'wss://accept.example',
      okReceived: true,
      broadcastSuccessful: true);
  final negative = RelayBroadcastResponse(
      relayUrl: 'wss://reject.example',
      okReceived: true,
      broadcastSuccessful: false,
      msg: 'rate limited');

  setUp(() {
    updates = StreamController.broadcast();
    settled = Completer();
    errors = [];
    cleanups = 0;
    broadcast = NdkBroadcastResponse(
      publishEvent:
          Nip01Event(pubKey: 'coordinator', kind: 25196, tags: [], content: ''),
      broadcastDoneStream: updates.stream,
      broadcastDoneFuture: settled.future,
    );
  });
  tearDown(() => updates.close());

  Future<void> send({Duration timeout = const Duration(seconds: 1)}) =>
      awaitRelayAcceptance(broadcast, timeout: timeout,
          onAcceptedSettled: () async {
        cleanups++;
      }, onBackgroundError: errors.add);

  test('first positive ACK releases caller before slow relay or persistence',
      () async {
    final result = send();
    updates.add([positive]);
    await result;
    expect(settled.isCompleted, isFalse);
    expect(cleanups, 0);
    settled.complete([positive, negative]);
    await Future<void>.delayed(Duration.zero);
    expect(cleanups, 1);
    expect(errors, isEmpty);
  });

  test('early rejection does not win over later acceptance', () async {
    var completed = false;
    final result = send().then((_) => completed = true);
    updates.add([negative]);
    await Future<void>.delayed(Duration.zero);
    expect(completed, isFalse);
    updates.add([negative, positive]);
    await result;
    settled.complete([negative, positive]);
  });

  test('all rejections fail and retain pending delivery', () async {
    final result = expectLater(send(), throwsStateError);
    settled.complete([negative]);
    await result;
    expect(cleanups, 0);
  });

  test('hung ACKs bounded; late acceptance still cleans persisted delivery',
      () async {
    await expectLater(send(timeout: const Duration(milliseconds: 20)),
        throwsA(isA<TimeoutException>()));
    settled.complete([positive]);
    await Future<void>.delayed(Duration.zero);
    expect(cleanups, 1);
  });

  test('late bookkeeping failure cannot invalidate accepted delivery',
      () async {
    final result = send();
    updates.add([positive]);
    await result;
    settled.completeError(StateError('persistence failed'));
    await Future<void>.delayed(Duration.zero);
    expect(errors.single, isA<StateError>());
    expect(cleanups, 0);
  });

  test('completion without stream update still proves acceptance', () async {
    final result = send();
    settled.complete([positive]);
    await result;
    expect(cleanups, 1);
  });

  test('single-subscription adapters fall back to their completion future',
      () async {
    broadcast = NdkBroadcastResponse(
        publishEvent: broadcast.publishEvent,
        broadcastDoneStream: Stream.value([positive]));
    await send();
    expect(cleanups, 1);
  });

  test('pinned NDK exposes early positive ACK before aggregate completion',
      () async {
    final servers = <HttpServer>[];
    final sockets = <WebSocket>[];
    final releaseSlowRelay = Completer<void>();
    final ndk = Ndk(NdkConfig(
        cache: MemCacheManager(),
        eventVerifier: Bip340EventVerifier(),
        bootstrapRelays: []));
    addTearDown(() async {
      if (!releaseSlowRelay.isCompleted) releaseSlowRelay.complete();
      await ndk.destroy();
      for (final socket in sockets) {
        await socket.close();
      }
      for (final server in servers) {
        await server.close(force: true);
      }
    });
    for (final slow in [false, true]) {
      final server = await HttpServer.bind('127.0.0.1', 0);
      servers.add(server);
      server.listen((request) async {
        final socket = await WebSocketTransformer.upgrade(request);
        sockets.add(socket);
        socket.listen((raw) async {
          final message = jsonDecode(raw as String) as List;
          if (message[0] != 'EVENT') return;
          if (slow) await releaseSlowRelay.future;
          if (socket.readyState == WebSocket.open) {
            socket.add(jsonEncode(['OK', message[1]['id'], true, '']));
          }
        });
      });
    }
    const key =
        '0000000000000000000000000000000000000000000000000000000000000001';
    final signer =
        Bip340EventSigner(privateKey: key, publicKey: bip340.getPublicKey(key));
    final realBroadcast = ndk.broadcast.broadcast(
        nostrEvent: Nip01Event(
            pubKey: signer.getPublicKey(),
            kind: 25196,
            tags: [],
            content: 'test',
            createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000),
        customSigner: signer,
        specificRelays:
            servers.map((server) => 'ws://127.0.0.1:${server.port}').toList(),
        saveToCache: false);
    var fullySettled = false;
    final cleanup = Completer<void>();
    final completion =
        realBroadcast.broadcastDoneFuture.then((_) => fullySettled = true);
    await awaitRelayAcceptance(realBroadcast,
        timeout: const Duration(seconds: 2), onAcceptedSettled: () async {
      cleanup.complete();
    }, onBackgroundError: errors.add);
    expect(fullySettled, isFalse);
    expect(cleanup.isCompleted, isFalse);
    releaseSlowRelay.complete();
    await completion.timeout(const Duration(seconds: 2));
    await cleanup.future.timeout(const Duration(seconds: 2));
    expect(errors, isEmpty);
  });
}
