import 'dart:io';

import 'package:bitblik_telegram_bot/bitblik_telegram_bot.dart';
import 'package:test/test.dart';

void main() {
  test('loads .env and lets process environment override it', () async {
    final directory = await Directory.systemTemp.createTemp('bitblik-env-');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/.env');
    await file.writeAsString(
      'PAYMENT_SYSTEM=blik\nFRONTEND_DOMAIN=test.bitblik.app\n',
    );

    final environment = loadTelegramBotEnvironment(
      filename: file.path,
      platformEnvironment: const {'PAYMENT_SYSTEM': 'twint'},
    );

    expect(environment['PAYMENT_SYSTEM'], 'twint');
    expect(environment['FRONTEND_DOMAIN'], 'test.bitblik.app');
  });

  test('missing .env is optional', () {
    final environment = loadTelegramBotEnvironment(
      filename: '/definitely/missing/bitblik/.env',
      platformEnvironment: const {'PAYMENT_SYSTEM': 'mbway'},
    );

    expect(environment, {'PAYMENT_SYSTEM': 'mbway'});
  });
}
