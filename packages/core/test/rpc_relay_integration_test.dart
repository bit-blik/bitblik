import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bip340/bip340.dart' as bip340;
import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

const coordinatorKey =
    '0000000000000000000000000000000000000000000000000000000000000002';

/// Loopback relay fixture: real NDK sockets, signing and encrypted replies.
/// No public relays, wallets or payments are touched.
class LocalRelay {
  final HttpServer server;
  final bool reply;
  final ready = Completer<void>();
  final subscribed = Completer<void>();
  final sockets = <WebSocket>[];
  var events = 0;
  var eventsBeforeSubscription = 0;
  LocalRelay(this.server, {required this.reply}) {
    server.listen((request) async {
      final socket = await WebSocketTransformer.upgrade(request);
      sockets.add(socket);
      final subscriptions = <String>{};
      socket.listen((raw) async {
        final message = jsonDecode(raw as String) as List;
        if (message[0] == 'REQ') {
          final id = message[1] as String;
          subscriptions.add(id);
          if (!subscribed.isCompleted) subscribed.complete();
          await ready.future;
          if (socket.readyState == WebSocket.open) {
            socket.add(jsonEncode(['EOSE', id]));
          }
        } else if (message[0] == 'CLOSE') {
          subscriptions.remove(message[1]);
        } else if (message[0] == 'EVENT') {
          events++;
          if (subscriptions.isEmpty) eventsBeforeSubscription++;
          if (!reply) return; // Deliberately never ACK this relay's broadcast.
          final event = Nip01EventModel.fromJson(
              Map<String, dynamic>.from(message[1] as Map));
          final request =
              await ProtocolCodec.decryptRequest(event, coordinatorKey);
          final response = await ProtocolCodec.encryptResponse(
            response: NostrResponse(id: request.id, result: {'ok': true}),
            senderPrivateKeyHex: coordinatorKey,
            senderPubkeyHex: bip340.getPublicKey(coordinatorKey),
            recipientPubkey: event.pubKey,
          );
          final signed = await Bip340EventSigner(
                  privateKey: coordinatorKey,
                  publicKey: bip340.getPublicKey(coordinatorKey))
              .sign(response);
          // Reply first. Relay ACK is not a prerequisite for processing it.
          for (final id in subscriptions) {
            socket.add(jsonEncode(
                ['EVENT', id, Nip01EventModel.fromEntity(signed).toJson()]));
          }
          socket.add(jsonEncode(['OK', event.id, true, '']));
        }
      });
    });
  }
  String get url => 'ws://127.0.0.1:${server.port}';
  Future<void> close() async {
    if (!ready.isCompleted) ready.complete();
    for (final socket in sockets) {
      await socket.close();
    }
    await server.close(force: true);
  }
}

void main() {
  test('real NDK sends REQ first without requiring live EOSE or all ACKs',
      () async {
    final primary =
        LocalRelay(await HttpServer.bind('127.0.0.1', 0), reply: true);
    final silent =
        LocalRelay(await HttpServer.bind('127.0.0.1', 0), reply: false);
    final ndk = Ndk(NdkConfig(
        cache: MemCacheManager(),
        eventVerifier: Bip340EventVerifier(),
        bootstrapRelays: []));
    const clientKey =
        '0000000000000000000000000000000000000000000000000000000000000001';
    final client = BitblikRpcClient(
        ndk: ndk,
        signer: Bip340EventSigner(
            privateKey: clientKey, publicKey: bip340.getPublicKey(clientKey)),
        relays: [primary.url, silent.url],
        timeout: const Duration(seconds: 2));
    addTearDown(() async {
      await client.stop();
      await ndk.destroy();
      await primary.close();
      await silent.close();
    });
    await client.start();
    await Future.wait([primary.subscribed.future, silent.subscribed.future])
        .timeout(const Duration(seconds: 3));
    final response = client.send(
        const NostrRequest(method: 'get_info', params: {}),
        bip340.getPublicKey(coordinatorKey));
    expect(
        (await response.timeout(const Duration(seconds: 2))).isSuccess, isTrue);
    expect(primary.events, 1);
    expect(
        primary.eventsBeforeSubscription + silent.eventsBeforeSubscription, 0);
    expect(primary.ready.isCompleted, isFalse);
  }, timeout: const Timeout(Duration(seconds: 15)));
}
