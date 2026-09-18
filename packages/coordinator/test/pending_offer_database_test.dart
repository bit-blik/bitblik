import 'dart:io';

import 'package:bitblik_coordinator/src/models/pending_offer_intent.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

void main() {
  final port = int.tryParse(Platform.environment['BITBLIK_TEST_PG_PORT'] ?? '');
  test('pending intent additive migration, immutable save and restart read',
      () async {
    final connection = PostgreSQLConnection('127.0.0.1', port!, 'postgres',
        username: 'bitblik_test');
    await connection.open();
    addTearDown(connection.close);
    // Dedicated schema inside an explicitly disposable test server. Repeating
    // the migration must preserve existing rows, including secret material.
    final schema = 'pending_recovery_${DateTime.now().microsecondsSinceEpoch}';
    await connection.execute('CREATE SCHEMA $schema');
    await connection.execute('SET search_path TO $schema');
    final database = DatabaseService(connection: connection);
    await database.ensurePendingOfferIntentsTable();
    final expires = DateTime.utc(2026, 9, 20);
    final intent = PendingOfferIntent(
        paymentHash: '01',
        paymentSystem: 'blik',
        expiresAt: expires,
        data: {
          'offerId': 'stable-id',
          'preimageHex': 'test-only-secret',
          'makerId': 'maker',
          'amountSats': 1234,
          'fiatAmount': 20.0
        });
    await database.savePendingOfferIntent(intent);
    await database.savePendingOfferIntent(PendingOfferIntent(
        paymentHash: '02',
        paymentSystem: 'blik',
        data: intent.data,
        expiresAt: expires));
    await database.savePendingOfferIntent(PendingOfferIntent(
        paymentHash: '03',
        paymentSystem: 'mbway',
        data: intent.data,
        expiresAt: expires));
    await database.ensurePendingOfferIntentsTable();
    await expectLater(
        database.savePendingOfferIntent(PendingOfferIntent(
            paymentHash: '01',
            paymentSystem: 'blik',
            data: {'preimageHex': 'wrong'},
            expiresAt: expires)),
        throwsA(isA<PostgreSQLException>()));
    final restored = await DatabaseService(connection: connection)
        .getPendingOfferIntents('blik', limit: 1);
    expect(restored.single.paymentHash, '01');
    expect(restored.single.data, intent.data);
    expect(restored.single.expiresAt, expires);
    expect(
        (await database.getPendingOfferIntents('blik', afterHash: '01'))
            .single
            .paymentHash,
        '02');
    expect((await database.getPendingOfferIntents('mbway')).single.paymentHash,
        '03');
    await database.deletePendingOfferIntent('01');
    await database.deletePendingOfferIntent('01'); // cleanup may be retried
    expect((await database.getPendingOfferIntents('blik')).single.paymentHash,
        '02');
  },
      skip: port == null
          ? 'Set BITBLIK_TEST_PG_PORT for a disposable PostgreSQL instance'
          : false);
}
