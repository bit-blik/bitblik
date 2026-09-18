import 'dart:io';

import 'package:bitblik_coordinator/src/models/pending_offer_intent.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:postgres/postgres.dart';
import 'package:test/test.dart';

void main() {
  final port = int.tryParse(Platform.environment['BITBLIK_TEST_PG_PORT'] ?? '');
  group('durable initiation receipts', () {
    late PostgreSQLConnection first;
    late PostgreSQLConnection second;
    late DatabaseService db;
    late DatabaseService competingDb;

    PendingOfferIntent intent(String hash,
            {String maker = 'maker', String market = 'blik'}) =>
        PendingOfferIntent(
            paymentHash: hash,
            paymentSystem: market,
            data: {'makerId': maker, 'preimageHex': 'test-secret'},
            expiresAt: DateTime.utc(2026, 9, 20));
    Future<bool> claim(DatabaseService database, String hash,
            {String maker = 'maker',
            String market = 'blik',
            String id = 'operation'}) =>
        database.claimOfferInitiation(
            operationId: id,
            fingerprint: 'fixed-fingerprint',
            intent: intent(hash, maker: maker, market: market),
            quote: {'amountSats': 1000});

    setUp(() async {
      first = PostgreSQLConnection('127.0.0.1', port!, 'postgres',
          username: 'bitblik_test');
      second = PostgreSQLConnection('127.0.0.1', port, 'postgres',
          username: 'bitblik_test');
      await first.open();
      await second.open();
      addTearDown(first.close);
      addTearDown(second.close);
      final schema = 'initiation_${DateTime.now().microsecondsSinceEpoch}';
      await first.execute('CREATE SCHEMA $schema');
      await first.execute('SET search_path TO $schema');
      await second.execute('SET search_path TO $schema');
      db = DatabaseService(connection: first);
      competingDb = DatabaseService(connection: second);
      await db.ensurePendingOfferIntentsTable();
      await db.ensureOfferInitiationReceiptsTable();
    });

    test('concurrent claims commit exactly one receipt and recovery intent',
        () async {
      final results = await Future.wait(
          [claim(db, 'hash-1'), claim(competingDb, 'hash-2')]);
      expect(results.where((claimed) => claimed), hasLength(1));
      final receipt = await db.getOfferInitiation(
          paymentSystem: 'blik', makerId: 'maker', operationId: 'operation');
      final pending = await db.getPendingOfferIntents('blik');
      expect(pending, hasLength(1));
      expect(pending.single.paymentHash, receipt!.paymentHash);
      expect(receipt.result, isNull);
      await db.saveOfferInitiationInvoice(
          receipt.paymentHash, 'original-invoice');
      await competingDb.saveOfferInitiationInvoice(
          receipt.paymentHash, 'replacement-must-not-win');
      await db.deletePendingOfferIntent(receipt.paymentHash);
      await db.ensureOfferInitiationReceiptsTable();
      final restored = await competingDb.getOfferInitiation(
          paymentSystem: 'blik', makerId: 'maker', operationId: 'operation');
      expect(restored!.result, {
        'amountSats': 1000,
        'paymentHash': receipt.paymentHash,
        'holdInvoice': 'original-invoice'
      });
      expect(await claim(db, 'new-hash'), isFalse);
      expect(await db.getPendingOfferIntents('blik'), isEmpty);
    });

    test('intent insertion failure rolls back receipt claim too', () async {
      await db.savePendingOfferIntent(intent('occupied-hash'));
      await expectLater(
          claim(db, 'occupied-hash'), throwsA(isA<PostgreSQLException>()));
      expect(
          await db.getOfferInitiation(
              paymentSystem: 'blik',
              makerId: 'maker',
              operationId: 'operation'),
          isNull);
      expect(
          (await db.getPendingOfferIntents('blik')).single.data['preimageHex'],
          'test-secret');
      expect(await claim(db, 'fresh-hash'), isTrue);
    });

    test('same operation ID remains isolated by maker and market', () async {
      expect(await claim(db, 'a'), isTrue);
      expect(await claim(db, 'b', maker: 'other'), isTrue);
      expect(await claim(db, 'c', market: 'mbway'), isTrue);
      expect(
          await db.getOfferInitiation(
              paymentSystem: 'blik',
              makerId: 'stranger',
              operationId: 'operation'),
          isNull);
      expect(
          (await db.getOfferInitiation(
                  paymentSystem: 'blik',
                  makerId: 'other',
                  operationId: 'operation'))!
              .paymentHash,
          'b');
      expect(
          (await db.getOfferInitiation(
                  paymentSystem: 'mbway',
                  makerId: 'maker',
                  operationId: 'operation'))!
              .paymentHash,
          'c');
    });
  },
      skip: port == null
          ? 'Set BITBLIK_TEST_PG_PORT for a disposable PostgreSQL instance'
          : false);
}
