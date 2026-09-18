import 'dart:io';

import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

/// Run only against an explicitly supplied disposable PostgreSQL instance.
/// All tables are connection-local TEMP tables, never production tables.
void main() {
  final port = int.tryParse(Platform.environment['BITBLIK_TEST_PG_PORT'] ?? '');
  test('cleanup query paginates terminal rows and deletes exact message only',
      () async {
    final connection = PostgreSQLConnection('127.0.0.1', port!, 'postgres',
        username: 'bitblik_test');
    await connection.open();
    addTearDown(connection.close);
    final database = DatabaseService(connection: connection);
    await connection.execute(
        'CREATE TEMP TABLE offers (id UUID PRIMARY KEY, status TEXT NOT NULL)');
    await connection.execute('''CREATE TEMP TABLE telegram_offer_messages (
      offer_id UUID NOT NULL, chat_id TEXT NOT NULL, message_id BIGINT NOT NULL,
      message_text TEXT NOT NULL, PRIMARY KEY (offer_id, chat_id))''');
    const active = '00000000-0000-0000-0000-000000000001';
    const cancelled = '00000000-0000-0000-0000-000000000002';
    const paid = '00000000-0000-0000-0000-000000000003';
    for (final entry in {
      active: 'funded',
      cancelled: 'cancelled',
      paid: 'takerPaid'
    }.entries) {
      await connection.execute('INSERT INTO offers VALUES (@id, @status)',
          substitutionValues: {'id': entry.key, 'status': entry.value});
      await database.saveTelegramOfferMessage(
          offerId: entry.key,
          chatId: 'chat',
          messageId: 1,
          messageText: 'offer');
    }
    expect(await database.getTelegramCleanupOfferIds(limit: 1), [cancelled]);
    expect(
        await database.getTelegramCleanupOfferIds(afterId: cancelled), [paid]);
    expect(await database.getTelegramCleanupOfferIds(afterId: paid), isEmpty);
    final old = (await database.getTelegramOfferMessages(cancelled)).single;
    await database.saveTelegramOfferMessage(
        offerId: cancelled,
        chatId: 'chat',
        messageId: 2,
        messageText: 'new offer');
    await database.deleteTelegramOfferMessage(old);
    expect(
        (await database.getTelegramOfferMessages(cancelled)).single.messageId,
        2);
    await database.deleteTelegramOfferMessage(
        (await database.getTelegramOfferMessages(cancelled)).single);
    expect(await database.getTelegramCleanupOfferIds(), [paid]);
    expect(await database.getTelegramOfferMessages(active), hasLength(1));
  },
      skip: port == null
          ? 'Set BITBLIK_TEST_PG_PORT for a disposable PostgreSQL instance'
          : false);
}
