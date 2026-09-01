import 'dart:async';
import 'dart:io';

import 'package:bitblik_telegram_bot/bitblik_telegram_bot.dart';
import 'package:bitblik_telegram_bot/src/nostr_monitor.dart';

Future<void> main() async {
  await runZonedGuarded(() async {
    final config = TelegramBotConfig.fromEnvironment(
      loadTelegramBotEnvironment(),
    );
    final telegram = TelegramHttpClient(
      botToken: config.botToken,
      chatIds: config.chatIds,
    );
    final controller = OfferNotificationController(
      telegram: telegram,
      store: JsonNotificationStateStore(config.stateFile),
      paymentSystem: config.paymentSystem,
      frontendDomain: config.frontendDomain,
      coordinatorMinInterval: config.coordinatorMinInterval,
      coordinatorCooldown: config.coordinatorCooldown,
      offerStateRetention: config.offerStateRetention,
      maxTrackedOffers: config.maxTrackedOffers,
    );
    await controller.init();
    final monitor = NostrOfferMonitor(config: config, controller: controller);
    await monitor.start();

    print(
      'Telegram offer bot started for ${config.paymentSystem.label}; '
      'chat(s): ${config.chatIds.join(', ')}',
    );

    Future<void> shutdown(ProcessSignal signal) async {
      print('Received $signal; shutting down');
      await monitor.stop();
      telegram.close();
      exit(0);
    }

    ProcessSignal.sigint
        .watch()
        .listen((signal) => unawaited(shutdown(signal)));
    ProcessSignal.sigterm
        .watch()
        .listen((signal) => unawaited(shutdown(signal)));
    await Completer<void>().future;
  }, (error, stackTrace) {
    stderr.writeln('Uncaught Telegram bot error: $error\n$stackTrace');
  });
}
