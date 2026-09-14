import 'dart:convert';

import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/models/create_hold_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/invoice_update.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

const payload = 'Q4SIXZB8VXJ5000000000710CHF00025837';

void main() {
  late MockDatabaseService db;
  late MockPaymentService pay;
  late CoordinatorService service;
  final received = DateTime.utc(2026, 9, 14);

  Offer offer({OfferCategory? category = OfferCategory.shop}) => Offer(
        id: 'shop',
        amountSats: 10000,
        makerFees: 50,
        status: OfferStatus.unknown,
        statusRaw: 'invalidTwint',
        fiatAmount: 7.10,
        fiatCurrency: 'CHF',
        category: category,
        paymentSystemId: 'twint',
        createdAt: received,
        updatedAt: received,
        blikReceivedAt: received,
        makerPubkey: 'maker',
        coordinatorPubkey: 'coordinator',
        blikCode: category == OfferCategory.shop ? payload : '01234',
      );

  setUp(() async {
    db = MockDatabaseService();
    pay = MockPaymentService();
    service = CoordinatorService(
      db,
      paymentServiceForTest: pay,
      paymentSystemIdForTest: 'twint',
    );
    await service.init();
  });

  test('invalid shop creation never reaches payment or database work',
      () async {
    for (final fixture in [
      (payload, 7.11),
      (payload, 7.101),
      (payload, double.nan),
      ('$payload\n', 7.10),
      ('01234', 7.10),
      (payload.replaceFirst('CHF', 'EUR'), 7.10),
    ]) {
      await expectLater(
        service.initiateOfferFiat(
          makerId: 'maker',
          category: OfferCategory.shop,
          fiatAmount: fixture.$2,
          fiatCurrency: 'CHF',
          blikCode: fixture.$1,
        ),
        throwsA(isA<FormatException>()),
      );
    }
    verifyZeroInteractions(db);
    verifyZeroInteractions(pay);
  });

  test('valid shop QR can create a funding invoice', () async {
    final creator = CoordinatorService(
      db,
      paymentServiceForTest: pay,
      paymentSystemIdForTest: 'twint',
      httpClient: MockClient((_) async => http.Response(
          jsonEncode({
            'bitcoin': {'chf': 50000},
            'BTC': 50000,
            'CHF': {'last': 50000},
          }),
          200)),
    );
    await creator.init();
    addTearDown(creator.shutdown);
    when(pay.createHoldInvoice(
      amountSats: anyNamed('amountSats'),
      memo: anyNamed('memo'),
      paymentHashHex: anyNamed('paymentHashHex'),
    )).thenAnswer((call) async => CreateHoldInvoiceResult(
          invoice: 'local-test-invoice',
          paymentHash: call.namedArguments[#paymentHashHex] as String,
        ));
    when(pay.subscribeToInvoiceUpdates(
            paymentHashHex: anyNamed('paymentHashHex')))
        .thenAnswer((_) => const Stream<InvoiceUpdate>.empty());
    final result = await creator.initiateOfferFiat(
      makerId: 'maker',
      category: OfferCategory.shop,
      fiatAmount: 7.10,
      fiatCurrency: 'CHF',
      blikCode: payload,
    );
    expect(result['holdInvoice'], 'local-test-invoice');
    expect(result['fiatAmount'], 7.10);
    expect(result['fiatCurrency'], 'CHF');
    verify(pay.createHoldInvoice(
      amountSats: anyNamed('amountSats'),
      memo: anyNamed('memo'),
      paymentHashHex: anyNamed('paymentHashHex'),
    )).called(1);
    // No funding event was simulated; no external payment or offer broadcast.
    verifyZeroInteractions(db);
  });

  test('rejected replacement does not write payload, clock or state', () async {
    final original = offer();
    when(db.getOfferById('shop')).thenAnswer((_) async => original);
    for (final replacement in [
      payload.replaceFirst('000000000710', '000000000711'),
      ' $payload',
      payload.replaceFirst('CHF', 'EUR'),
    ]) {
      await expectLater(
        service.flow.handleRpc(
          'enter_new_twint',
          {'offer_id': 'shop', 'blik_code': replacement},
          'maker',
        ),
        throwsA(isA<Exception>()),
      );
    }
    verify(db.getOfferById('shop')).called(3);
    verifyNoMoreInteractions(db);
    verifyZeroInteractions(pay);
    expect(original.blikCode, payload);
    expect(original.blikReceivedAt, received);
    expect(original.updatedAt, received);
    expect(original.statusRaw, 'invalidTwint');
  });

  test('replacement action preserves same-amount shop payload exactly',
      () async {
    // A synthetic identifier change checks transport, not terminal validity.
    final replacement = payload.replaceFirst('00025837', '00025838');
    final write = OfferWriteSpec();
    await SetNewCodeAction().run(
      service.flow,
      FlowEffectContext(
        offer: offer(),
        transition: null,
        params: {'blik_code': replacement},
        userPubkey: 'maker',
        isNewTaker: false,
        write: write,
        now: received,
      ),
    );
    expect(write.code, replacement);
  });

  test('legacy taker reservation fails before state mutation', () async {
    when(db.getOfferById('shop'))
        .thenAnswer((_) async => offer().copyWith(statusRaw: 'funded'));
    await expectLater(
      service.flow.handleRpc('reserve_offer', {'offer_id': 'shop'}, 'taker'),
      throwsA(isA<Exception>().having(
          (error) => error.toString(), 'message', contains('Update your app'))),
    );
    verify(db.getOfferById('shop')).called(1);
    verifyNoMoreInteractions(db);
    verifyZeroInteractions(pay);
    expect((await service.getCoordinatorInfo()).supportsTwintShopQr, isTrue);
  });

  test('shop details require an existing participant', () async {
    final stored = offer().copyWith(takerPubkey: 'taker');
    when(db.getOfferById('shop')).thenAnswer((_) async => stored);
    expect(
        await service.getOfferDetailsForParticipant('outsider',
            offerId: 'shop'),
        isNull);
    expect(
        (await service.getOfferDetailsForParticipant('taker', offerId: 'shop'))
            ?.blikCode,
        payload);
  });

  test('online and legacy replacements retain numeric code handling', () async {
    for (final category in [OfferCategory.online, null]) {
      final write = OfferWriteSpec();
      await SetNewCodeAction().run(
        service.flow,
        FlowEffectContext(
          offer: offer(category: category),
          transition: null,
          params: {'blik_code': ' 02345 '},
          userPubkey: 'maker',
          isNewTaker: false,
          write: write,
          now: received,
        ),
      );
      expect(write.code, '02345');
    }
  });
}
