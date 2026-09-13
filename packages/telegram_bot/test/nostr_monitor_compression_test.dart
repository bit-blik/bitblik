import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:bitblik_telegram_bot/bitblik_telegram_bot.dart';
import 'package:bitblik_telegram_bot/src/nostr_monitor.dart';
import 'package:test/test.dart';

class _NoTelegram implements TelegramClient {
  @override
  Future<List<TelegramMessageRef>> sendMessage(String text) async => [];

  @override
  Future<bool> editMessage(TelegramMessageRef message, String text) async =>
      true;

  @override
  Future<bool> deleteMessage(TelegramMessageRef message) async => true;
}

void main() {
  test('bot disables relay compression, including after reconnect', () async {
    final server = await HttpServer.bind(InternetAddress.loopbackIPv4, 0);
    final extensionOffers = <String?>[];
    final sockets = <WebSocket>[];
    final handshakes = StreamController<void>.broadcast();
    server.listen((request) async {
      extensionOffers.add(request.headers.value('sec-websocket-extensions'));
      final socket = await WebSocketTransformer.upgrade(request);
      sockets.add(socket);
      handshakes.add(null);
      socket.listen((data) {
        final message = jsonDecode(data as String) as List<dynamic>;
        if (message.first == 'REQ') {
          socket.add(jsonEncode(['EOSE', message[1]]));
        }
      });
    });

    final config = TelegramBotConfig.fromEnvironment({
      'TELEGRAM_BOT_TOKEN': 'unused-test-token',
      'TELEGRAM_CHAT_ID': 'unused-test-chat',
      'NOSTR_RELAYS': 'ws://localhost:${server.port}',
      'DISCOVERY_REFRESH_SECONDS': '3600',
      'NOSTR_QUERY_TIMEOUT_SECONDS': '2',
    });
    final controller = OfferNotificationController(
      telegram: _NoTelegram(),
      store: MemoryNotificationStateStore(),
      paymentSystem: config.paymentSystem,
      frontendDomain: config.frontendDomain,
      coordinatorMinInterval: config.coordinatorMinInterval,
      coordinatorCooldown: config.coordinatorCooldown,
    );
    await controller.init();
    final monitor = NostrOfferMonitor(config: config, controller: controller);
    addTearDown(() async {
      await monitor.stop();
      for (final socket in sockets) {
        await socket.close();
      }
      await server.close(force: true);
      await handshakes.close();
    });

    await monitor.start();
    expect(extensionOffers, isNotEmpty);
    expect(extensionOffers, everyElement(isNull));

    final reconnected = handshakes.stream.first;
    await sockets.last.close();
    await reconnected.timeout(const Duration(seconds: 5));
    await monitor.refresh();

    expect(extensionOffers.length, greaterThanOrEqualTo(2));
    expect(extensionOffers, everyElement(isNull));
  });
}
