import 'dart:async';
import 'dart:convert';

import 'package:bitblik_coordinator/src/models/create_hold_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/invoice_update.dart';
import 'package:bitblik_coordinator/src/services/coordinator_service.dart';
import 'package:clock/clock.dart';
import 'package:fake_async/fake_async.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'test_mocks.mocks.dart';

http.Response _rateResponse(Uri url) {
  if (url.host == 'api.coingecko.com') {
    return http.Response(
      jsonEncode({
        'bitcoin': {'eur': 50000.0},
      }),
      200,
    );
  }
  if (url.host == 'api.yadio.io') {
    return http.Response(jsonEncode({'BTC': 50100.0}), 200);
  }
  return http.Response(
    jsonEncode({
      'EUR': {'last': 49900.0},
    }),
    200,
  );
}

void _stubPayment(MockPaymentService payment) {
  when(payment.createHoldInvoice(
    amountSats: anyNamed('amountSats'),
    memo: anyNamed('memo'),
    paymentHashHex: anyNamed('paymentHashHex'),
  )).thenAnswer((invocation) async {
    final hash =
        invocation.namedArguments[const Symbol('paymentHashHex')] as String;
    return CreateHoldInvoiceResult(invoice: 'lnbc_test', paymentHash: hash);
  });
  when(payment.subscribeToInvoiceUpdates(
    paymentHashHex: anyNamed('paymentHashHex'),
  )).thenAnswer((_) => const Stream<InvoiceUpdate>.empty());
  when(payment.disconnect()).thenAnswer((_) async {});
}

Future<Map<String, dynamic>> _createOffer(CoordinatorService service) {
  return service.initiateOfferFiat(
    fiatAmount: 20,
    makerId: 'maker',
    fiatCurrency: 'EUR',
  );
}

void main() {
  test('uses a stale five-minute rate when a bounded refresh fails', () async {
    var now = DateTime.utc(2026, 8, 22, 12);
    var requests = 0;
    var failRequests = false;
    final httpClient = MockClient((request) async {
      requests++;
      return failRequests
          ? http.Response('temporarily unavailable', 503)
          : _rateResponse(request.url);
    });
    final payment = MockPaymentService();
    _stubPayment(payment);
    final service = CoordinatorService(
      MockDatabaseService(),
      paymentServiceForTest: payment,
      clock: Clock(() => now),
      httpClient: httpClient,
      paymentSystemIdForTest: 'mbway',
    );
    await service.init();

    await _createOffer(service);
    expect(requests, 3);

    now = now.add(const Duration(minutes: 6));
    failRequests = true;
    await _createOffer(service);

    expect(requests, 6);
    verify(payment.createHoldInvoice(
      amountSats: anyNamed('amountSats'),
      memo: anyNamed('memo'),
      paymentHashHex: anyNamed('paymentHashHex'),
    )).called(2);
    await service.shutdown();
  });

  test('refreshes a nearly-expired rate without blocking offer creation',
      () async {
    var now = DateTime.utc(2026, 8, 22, 12);
    var requests = 0;
    var delayRequests = false;
    final pending = <({Uri url, Completer<http.Response> completer})>[];
    final httpClient = MockClient((request) {
      requests++;
      if (!delayRequests) {
        return Future.value(_rateResponse(request.url));
      }
      final completer = Completer<http.Response>();
      pending.add((url: request.url, completer: completer));
      return completer.future;
    });
    final payment = MockPaymentService();
    _stubPayment(payment);
    final service = CoordinatorService(
      MockDatabaseService(),
      paymentServiceForTest: payment,
      clock: Clock(() => now),
      httpClient: httpClient,
      paymentSystemIdForTest: 'mbway',
    );
    await service.init();
    await _createOffer(service);

    now = now.add(const Duration(minutes: 4, seconds: 1));
    delayRequests = true;
    await _createOffer(service).timeout(const Duration(seconds: 1));
    await Future<void>.delayed(Duration.zero);

    expect(requests, 6);
    expect(pending, hasLength(3));
    for (final request in pending) {
      request.completer.complete(_rateResponse(request.url));
    }
    await Future<void>.delayed(Duration.zero);
    await service.shutdown();
  });

  test('initiate_offer has a twenty-second coordinator deadline', () async {
    final payment = MockPaymentService();
    final invoiceCompleter = Completer<CreateHoldInvoiceResult>();
    when(payment.createHoldInvoice(
      amountSats: anyNamed('amountSats'),
      memo: anyNamed('memo'),
      paymentHashHex: anyNamed('paymentHashHex'),
    )).thenAnswer((_) => invoiceCompleter.future);
    when(payment.disconnect()).thenAnswer((_) async {});
    final service = CoordinatorService(
      MockDatabaseService(),
      paymentServiceForTest: payment,
      httpClient: MockClient((request) async => _rateResponse(request.url)),
      paymentSystemIdForTest: 'mbway',
    );
    await service.init();

    fakeAsync((async) {
      Object? error;
      _createOffer(service).catchError((Object caught) {
        error = caught;
        return <String, dynamic>{};
      });
      async.flushMicrotasks();

      async.elapse(const Duration(seconds: 19));
      async.flushMicrotasks();
      expect(error, isNull);

      async.elapse(const Duration(seconds: 1));
      async.flushMicrotasks();
      expect(error, isA<TimeoutException>());
    });

    await service.shutdown();
  });
}
