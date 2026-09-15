import 'dart:io';

import 'package:bitblik_telegram_bot/bitblik_telegram_bot.dart';
import 'package:test/test.dart';

void main() {
  test('loads .env and lets process environment override it', () async {
    final directory = await Directory.systemTemp.createTemp('bitblik-env-');
    addTearDown(() => directory.delete(recursive: true));
    final file = File('${directory.path}/.env');
    await file.writeAsString(
      'PAYMENT_SYSTEM=blik\n'
      'FRONTEND_DOMAIN=test.bitblik.app\n'
      'EXCLUDED_COORDINATOR_PUBKEYS=npub1excluded\n'
      'SUBSCRIPTION_ROTATION_SECONDS=1200\n'
      'OFFER_STATE_RETENTION_SECONDS=3600\n'
      'MAX_TRACKED_OFFERS=250\n',
    );

    final environment = loadTelegramBotEnvironment(
      filename: file.path,
      platformEnvironment: const {'PAYMENT_SYSTEM': 'twint'},
    );

    expect(environment['PAYMENT_SYSTEM'], 'twint');
    expect(environment['FRONTEND_DOMAIN'], 'test.bitblik.app');
    expect(environment['EXCLUDED_COORDINATOR_PUBKEYS'], 'npub1excluded');
    expect(environment['SUBSCRIPTION_ROTATION_SECONDS'], '1200');
    expect(environment['OFFER_STATE_RETENTION_SECONDS'], '3600');
    expect(environment['MAX_TRACKED_OFFERS'], '250');
  });

  test('missing .env is optional', () {
    final environment = loadTelegramBotEnvironment(
      filename: '/definitely/missing/bitblik/.env',
      platformEnvironment: const {'PAYMENT_SYSTEM': 'mbway'},
    );

    expect(environment, {'PAYMENT_SYSTEM': 'mbway'});
  });
}
