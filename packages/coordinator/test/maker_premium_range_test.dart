import 'dart:async';
import 'dart:convert';

import 'package:bitblik_core/core.dart';
import 'package:bitblik_coordinator/src/models/create_hold_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/invoice_update.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:bitblik_coordinator/src/services/telegram_service.dart';
import 'package:clock/clock.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

class _SilentTelegramService extends TelegramService {
  _SilentTelegramService()
      : super(botToken: 'test-bot-token', chatIds: const ['test-chat-id']);

  @override
  Future<TelegramSendResult> sendMessageDetailed(String message,
          {List<String>? chatIds}) async =>
      const TelegramSendResult(allSucceeded: true, sentMessages: []);
}

void main() {
  group('parsePremiumRangeConfig', () {
    List<String> warnings = [];
    PremiumRange parse(String? min, String? max) {
      warnings = [];
      return parsePremiumRangeConfig(
          minPremium: min, maxPremium: max, onInvalid: warnings.add);
    }

    test('unset keeps today\'s behaviour: no premium, no discount', () {
      expect(parse(null, null), PremiumRange.none);
      expect(parse('', '  '), PremiumRange.none);
      expect(warnings, isEmpty);
    });

    test('MAX_PREMIUM alone still means a premium-only range', () {
      final range = parse(null, '5');
      expect(range.min, 0);
      expect(range.max, 5);
      expect(range.allowsDiscount, isFalse);
      expect(warnings, isEmpty);
    });

    test('a negative MIN_PREMIUM allows a discount', () {
      final range = parse('-3', '3');
      expect(range.min, -3);
      expect(range.max, 3);
      expect(range.allowsDiscount, isTrue);
      expect(range.isOffered, isTrue);
      expect(warnings, isEmpty);
    });

    test('discount-only range (MAX_PREMIUM unset)', () {
      final range = parse('-2.5', null);
      expect(range.min, -2.5);
      expect(range.max, 0);
      expect(range.isOffered, isTrue);
    });

    test('unparsable or out-of-bounds values fall back to 0 with a warning',
        () {
      expect(parse('abc', '3'), PremiumRange.sanitized(min: 0, max: 3));
      expect(warnings, hasLength(1));
      expect(parse('-100', '3'), PremiumRange.sanitized(min: 0, max: 3));
      expect(warnings, hasLength(1));
      expect(parse('NaN', 'Infinity'), PremiumRange.none);
      expect(warnings, hasLength(2));
      expect(parse('-3', '150'), PremiumRange.sanitized(min: -3, max: 0));
      expect(warnings, hasLength(1));
    });

    test('MIN_PREMIUM above MAX_PREMIUM drops the minimum to 0', () {
      expect(parse('2', '1'), PremiumRange.sanitized(min: 0, max: 1));
      expect(warnings, hasLength(1));
      // A negative max with no valid min collapses to market price.
      expect(parse(null, '-2'), PremiumRange.none);
      expect(warnings, hasLength(1));
    });
  });

  group('initiateOfferFiat clamps the premium to the configured range', () {
    const maker = 'maker_pubkey';
    late MockDatabaseService db;
    late MockPaymentService payment;
    late http.Client httpClient;
    final holdInvoiceAmounts = <int>[];

    setUp(() {
      db = MockDatabaseService();
      payment = MockPaymentService();
      holdInvoiceAmounts.clear();
      httpClient = MockClient((request) async {
        final body = {
          'https://api.coingecko.com/api/v3/simple/price?ids=bitcoin&vs_currencies=eur':
              jsonEncode({
            'bitcoin': {'eur': 54251.0}
          }),
          'https://api.yadio.io/exrates/eur': jsonEncode({'BTC': 54319.67}),
          'https://blockchain.info/ticker': jsonEncode({
            'EUR': {'last': 54218.15}
          }),
        }[request.url.toString()];
        return body == null
            ? http.Response('Not found', 404)
            : http.Response(body, 200);
      });
      when(payment.createHoldInvoice(
              amountSats: anyNamed('amountSats'),
              memo: anyNamed('memo'),
              paymentHashHex: anyNamed('paymentHashHex')))
          .thenAnswer((invocation) async {
        holdInvoiceAmounts
            .add(invocation.namedArguments[const Symbol('amountSats')] as int);
        return CreateHoldInvoiceResult(
          invoice: 'lnbc_test_invoice',
          paymentHash: invocation.namedArguments[const Symbol('paymentHashHex')]
              as String,
        );
      });
      when(payment.subscribeToInvoiceUpdates(
              paymentHashHex: anyNamed('paymentHashHex')))
          .thenAnswer((_) => const Stream<InvoiceUpdate>.empty());
    });

    Future<CoordinatorService> service(PremiumRange? range) async {
      final svc = CoordinatorService(
        db,
        paymentServiceForTest: payment,
        clock: const Clock(),
        httpClient: httpClient,
        telegramServiceForTest: _SilentTelegramService(),
        paymentSystemIdForTest: 'sk',
        premiumRangeForTest: range,
      );
      await svc.init();
      return svc;
    }

    Future<Map<String, dynamic>> initiate(
            CoordinatorService svc, double premium) =>
        svc.initiateOfferFiat(
          fiatAmount: 20,
          makerId: maker,
          category: OfferCategory.atm,
          bank: 'tatrabanka',
          premiumPercent: premium,
        );

    test('default configuration clamps a requested discount to 0', () async {
      // No override: reads MIN_PREMIUM/MAX_PREMIUM, unset in tests.
      final svc = await service(null);
      final market = await initiate(svc, 0);
      final result = await initiate(svc, -3);
      expect(result['premiumPercent'], 0);
      expect(result['amountSats'], market['amountSats']);
      final info = await svc.getCoordinatorInfo();
      expect(info.minPremiumPercent, 0);
      expect(info.toNostrTags().map((t) => t.first),
          isNot(contains('min_premium_percent')));
    });

    test('a -3..3 range lets the maker lock more sats for a discount',
        () async {
      final svc = await service(PremiumRange.sanitized(min: -3, max: 3));
      final market = await initiate(svc, 0);
      final discounted = await initiate(svc, -3);
      final premium = await initiate(svc, 3);
      final marketSats = market['amountSats'] as int;

      expect(discounted['premiumPercent'], -3);
      expect(
          discounted['amountSats'], PremiumRange.adjustedSats(marketSats, -3));
      expect(discounted['amountSats'] as int, greaterThan(marketSats));
      expect(premium['premiumPercent'], 3);
      expect(premium['amountSats'] as int, lessThan(marketSats));

      // The maker fee stays on the market value; the hold invoice carries the
      // discounted principal plus that fee.
      expect(discounted['makerFees'], market['makerFees']);
      expect(discounted['totalAmountSats'],
          (discounted['amountSats'] as int) + (market['makerFees'] as int));
      expect(holdInvoiceAmounts[1], discounted['totalAmountSats']);
    });

    test('out-of-range requests are clamped, not rejected', () async {
      final svc = await service(PremiumRange.sanitized(min: -3, max: 3));
      expect((await initiate(svc, -10))['premiumPercent'], -3);
      expect((await initiate(svc, 10))['premiumPercent'], 3);
    });

    test('coordinator info advertises the minimum next to the maximum',
        () async {
      final svc = await service(PremiumRange.sanitized(min: -3, max: 3));
      final info = await svc.getCoordinatorInfo();
      expect(info.minPremiumPercent, -3);
      expect(info.maxPremiumPercent, 3);
      expect(info.toNostrTags(),
          anyElement(equals(['min_premium_percent', '-3.0'])));
      expect(info.toJson()['min_premium_percent'], -3);
    });
  });
}
