import 'package:bitblik_telegram_bot/bitblik_telegram_bot.dart';
import 'package:test/test.dart';

void main() {
  test('parses market, deduplicated chats, and rate-limit settings', () {
    final config = TelegramBotConfig.fromEnvironment({
      'TELEGRAM_BOT_TOKEN': 'token',
      'TELEGRAM_CHAT_IDS': '-1001, -1002, -1001',
      'PAYMENT_SYSTEM': 'twint',
      'COORDINATOR_MIN_OFFER_INTERVAL_SECONDS': '5',
      'COORDINATOR_RATE_LIMIT_SECONDS': '90',
    });

    expect(config.paymentSystem.id, 'twint');
    expect(config.chatIds, ['-1001', '-1002']);
    expect(config.coordinatorMinInterval, const Duration(seconds: 5));
    expect(config.coordinatorCooldown, const Duration(seconds: 90));
    expect(config.discoveryRefreshInterval, const Duration(minutes: 5));
    expect(config.subscriptionRotationInterval, const Duration(minutes: 15));
    expect(config.offerStateRetention, const Duration(hours: 48));
    expect(config.maxTrackedOffers, 2000);
  });

  test('parses memory-bound settings', () {
    final config = TelegramBotConfig.fromEnvironment({
      'TELEGRAM_BOT_TOKEN': 'token',
      'TELEGRAM_CHAT_IDS': '-1001',
      'DISCOVERY_REFRESH_SECONDS': '600',
      'SUBSCRIPTION_ROTATION_SECONDS': '1200',
      'OFFER_STATE_RETENTION_SECONDS': '3600',
      'MAX_TRACKED_OFFERS': '250',
    });

    expect(config.discoveryRefreshInterval, const Duration(minutes: 10));
    expect(config.subscriptionRotationInterval, const Duration(minutes: 20));
    expect(config.offerStateRetention, const Duration(hours: 1));
    expect(config.maxTrackedOffers, 250);
  });

  test('rejects unknown markets and missing Telegram configuration', () {
    expect(
      () => TelegramBotConfig.fromEnvironment({
        'TELEGRAM_BOT_TOKEN': 'token',
        'TELEGRAM_CHAT_IDS': '-1001',
        'PAYMENT_SYSTEM': 'unknown',
      }),
      throwsFormatException,
    );
    expect(
      () => TelegramBotConfig.fromEnvironment({
        'TELEGRAM_BOT_TOKEN': 'token',
      }),
      throwsFormatException,
    );
  });
}
