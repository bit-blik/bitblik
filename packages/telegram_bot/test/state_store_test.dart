import 'dart:io';

import 'package:bitblik_telegram_bot/bitblik_telegram_bot.dart';
import 'package:test/test.dart';

void main() {
  test('JSON state survives repeated atomic saves', () async {
    final directory = await Directory.systemTemp.createTemp('bitblik-tg-test-');
    addTearDown(() => directory.delete(recursive: true));
    final store = JsonNotificationStateStore('${directory.path}/state.json');
    final state = NotificationState(
      offers: {
        'coordinator:offer': OfferNotificationRecord(
          coordinatorPubkey: 'coordinator',
          offerId: 'offer',
          latestEventCreatedAt: 42,
          status: 'pending',
          notificationText: 'message',
          announced: true,
          messages: const [TelegramMessageRef(chatId: '-1001', messageId: 7)],
        ),
      },
      coordinatorRates: {
        'coordinator': CoordinatorRateState(
          lastAcceptedAt: DateTime.utc(2026, 8, 31),
        ),
      },
      mutedCoordinators: {'muted'},
    );

    await store.save(state);
    await store.save(state);
    final loaded = await store.load();

    expect(loaded.offers['coordinator:offer']!.messages.single.messageId, 7);
    expect(loaded.coordinatorRates['coordinator']!.lastAcceptedAt,
        DateTime.utc(2026, 8, 31));
    expect(loaded.mutedCoordinators, {'muted'});
  });
}
