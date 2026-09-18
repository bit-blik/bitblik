import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:bitblik_coordinator/src/services/telegram_offer_cleanup.dart';
import 'package:bitblik_coordinator/src/services/telegram_service.dart';
import 'package:test/test.dart';

class MemoryDatabase extends DatabaseService {
  final statuses = <String, String>{};
  final messages = <String, TelegramOfferMessage>{};
  bool failQuery = false;
  bool staleQuery = false;
  void add(String id, {String status = 'cancelled', int messageId = 1}) {
    statuses[id] = status;
    messages[id] = TelegramOfferMessage(
        offerId: id,
        chatId: id,
        messageId: messageId,
        messageText: 'New offer');
  }

  @override
  Future<List<String>> getTelegramCleanupOfferIds(
      {String? afterId, int limit = 100}) async {
    if (failQuery) throw StateError('database unavailable');
    return (messages.keys
            .where((id) =>
                (afterId == null || id.compareTo(afterId) > 0) &&
                (staleQuery ||
                    const {'cancelled', 'expired', 'takerPaid', 'refundedMaker'}
                        .contains(statuses[id])))
            .toList()
          ..sort())
        .take(limit)
        .toList();
  }

  @override
  Future<Offer?> getOfferById(String id) async => Offer(
      id: id,
        amountSats: 1000,
        fiatAmount: 10,
        fiatCurrency: 'PLN',
      makerFees: 1,
      makerPubkey: 'maker',
      coordinatorPubkey: 'coordinator',
      holdInvoicePaymentHash: 'hash',
      holdInvoicePreimage: 'preimage',
      createdAt: DateTime.now(),
      statusRaw: statuses[id],
      status: OfferStatus.unknown);
  @override
  Future<List<TelegramOfferMessage>> getTelegramOfferMessages(
          String id) async =>
      [if (messages[id] != null) messages[id]!];
  @override
  Future<void> deleteTelegramOfferMessage(TelegramOfferMessage message) async {
    if (messages[message.offerId]?.messageId == message.messageId)
      messages.remove(message.offerId);
  }
}

class TestTelegram extends TelegramService {
  final edits = <String>[];
  final deletes = <String>[];
  bool success = true;
  Completer<void>? gate;
  int active = 0;
  int peak = 0;
  TestTelegram() : super(botToken: 'test', chatIds: ['test']);
  Future<bool> result() async {
    active++;
    if (active > peak) peak = active;
    await gate?.future;
    active--;
    return success;
  }

  @override
  Future<bool> editMessage(
      {required String chatId, required int messageId, required String text}) {
    edits.add(chatId);
    return result();
  }

  @override
  Future<bool> deleteMessage({required String chatId, required int messageId}) {
    deletes.add(chatId);
    return result();
  }
}

void main() {
  late MemoryDatabase db;
  late TestTelegram telegram;
  late TelegramOfferCleanup worker;
  late List<Object> errors;
  setUp(() {
    db = MemoryDatabase();
    telegram = TestTelegram();
    errors = [];
    worker = TelegramOfferCleanup(
        database: db, telegram: telegram, onError: errors.add);
  });
  tearDown(() => worker.close());

  test('failed cleanup retains IDs and next pass retries', () async {
    db.add('one');
    telegram.success = false;
    await worker.reconcile();
    expect(db.messages, hasLength(1));
    telegram.success = true;
    await worker.reconcile();
    expect(db.messages, isEmpty);
    expect(telegram.edits, ['one', 'one']);
  });

  test('new worker recovers persisted terminal work on startup', () async {
    db.add('one', status: 'takerPaid');
    telegram.success = false;
    await worker.reconcile();
    await worker.close();
    telegram.success = true;
    worker = TelegramOfferCleanup(
        database: db, telegram: telegram, onError: errors.add);
    worker.start();
    await Future<void>.delayed(Duration.zero);
    expect(db.messages, isEmpty);
    expect(telegram.deletes, ['one', 'one']);
  });

  test('cleanup concurrency capped at two and overlapping passes coalesce',
      () async {
    for (final id in ['one', 'two', 'three']) {
      db.add(id);
    }
    telegram.gate = Completer();
    final first = worker.reconcile();
    await Future<void>.delayed(Duration.zero);
    expect(telegram.active, 2);
    expect(identical(first, worker.reconcile()), isTrue);
    telegram.gate!.complete();
    await first;
    expect(telegram.peak, 2);
    expect(telegram.edits, hasLength(3));
    expect(db.messages, isEmpty);
  });

  test('late cleanup cannot delete a newer message reference', () async {
    db.add('one');
    telegram.gate = Completer();
    final pass = worker.reconcile();
    await Future<void>.delayed(Duration.zero);
    db.add('one', messageId: 2);
    telegram.gate!.complete();
    await pass;
    expect(db.messages['one']!.messageId, 2);
    await worker.reconcile();
    expect(db.messages, isEmpty);
  });

  test('stale scan never cleans a currently active offer', () async {
    db.add('one', status: 'funded');
    db.staleQuery = true;
    await worker.reconcile();
    expect(telegram.edits, isEmpty);
    expect(telegram.deletes, isEmpty);
    expect(db.messages, hasLength(1));
  });

  test('failed first page cannot starve later offers', () async {
    for (var index = 0; index < 101; index++) {
      db.add(index.toString().padLeft(3, '0'));
    }
    telegram.success = false;
    await worker.reconcile();
    expect(telegram.edits, hasLength(100));
    telegram.success = true;
    await worker.reconcile();
    expect(telegram.edits.last, '100');
    expect(db.messages.containsKey('100'), isFalse);
    expect(db.messages, hasLength(100));
  });

  test('database failure recoverable; close prevents further work', () async {
    db.add('one');
    db.failQuery = true;
    await worker.reconcile();
    expect(errors.single, isA<StateError>());
    db.failQuery = false;
    await worker.reconcile();
    expect(db.messages, isEmpty);
    await worker.close();
    db.add('two');
    await worker.reconcile();
    expect(db.messages, hasLength(1));
  });
}
