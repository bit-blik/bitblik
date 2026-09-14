import 'dart:io';

import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/services/database_service.dart';
import 'package:test/test.dart';
import 'package:uuid/uuid.dart';

import '../test/test_mocks.mocks.dart';

/// Run only against a disposable local PostgreSQL container. The explicit
/// opt-in and fixed database name keep normal package tests off real data.
void main() {
  test('shop payload survives PostgreSQL and atomic replacement', () async {
    expect(Platform.environment['DB_HOST'], '127.0.0.1');
    expect(Platform.environment['DB'], 'twint_shop_test');
    for (final name in [
      'SIMPLEX_CHAT_EXEC',
      'SIGNAL_CLI_EXEC',
      'TELEGRAM_BOT_TOKEN',
      'MATRIX_USER',
    ]) {
      expect(Platform.environment[name], '',
          reason: 'Disable notifications: $name');
    }
    final db = DatabaseService();
    await db.connect();
    addTearDown(db.disconnect);
    final service = CoordinatorService(db,
        paymentServiceForTest: MockPaymentService(),
        paymentSystemIdForTest: 'twint');
    await service.init();
    addTearDown(service.shutdown);
    final id = const Uuid().v4();
    const payload = 'Q4SIXZB8VXJ5000000000710CHF00025837';
    final received =
        DateTime.now().toUtc().subtract(const Duration(minutes: 6));
    await db.createOffer(Offer(
      id: id,
      amountSats: 10000,
      makerFees: 50,
      status: OfferStatus.funded,
      fiatAmount: 7.10,
      fiatCurrency: 'CHF',
      category: OfferCategory.shop,
      createdAt: received,
      blikReceivedAt: received,
      makerPubkey: 'maker',
      coordinatorPubkey: 'coordinator',
      blikCode: payload,
      holdInvoicePaymentHash: id,
      holdInvoicePreimage: 'local-test-preimage',
    ));
    await db.updateOfferRawStatusIfCurrent(id, 'invalidTwint',
        expectedCurrentStatuses: ['funded']);
    final original = (await db.getOfferById(id))!;
    expect(original.blikCode, payload);
    expect(original.category, OfferCategory.shop);
    expect(original.fiatAmount, 7.10);

    await expectLater(
      service.flow.handleRpc(
          'enter_new_twint',
          {
            'offer_id': id,
            'blik_code': payload.replaceFirst('000000000710', '000000000711'),
          },
          'maker'),
      throwsA(isA<FormatException>()),
    );
    final rejected = (await db.getOfferById(id))!;
    expect(rejected.blikCode, original.blikCode);
    expect(rejected.statusRaw, original.statusRaw);
    expect(rejected.updatedAt, original.updatedAt);
    expect(rejected.blikReceivedAt, original.blikReceivedAt);

    // Identifier change is synthetic; only amount equality and persistence
    // are under test, not a real terminal's acceptance of this replacement.
    final replacement = payload.replaceFirst('00025837', '00025838');
    await service.flow.handleRpc(
        'enter_new_twint', {'offer_id': id, 'blik_code': replacement}, 'maker');
    final stored = (await db.getOfferById(id))!;
    expect(stored.blikCode, replacement);
    expect(stored.statusRaw, 'funded');
    expect(stored.blikReceivedAt!.isAfter(original.blikReceivedAt!), isTrue);
    expect(stored.fiatAmount, 7.10);
    expect(stored.toRpcJson(includeBlikCode: true)['blik_code'], replacement);
    expect(stored.toRpcJson().containsKey('blik_code'), isFalse);
  }, skip: Platform.environment['TWINT_QR_DB_TEST'] != '1');
}
