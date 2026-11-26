import 'dart:async';

import 'package:bitblik_coordinator/src/generated/lnd/lightning.pb.dart'
    show HTLCAttempt, Payment, Payment_PaymentStatus;
import 'package:bitblik_coordinator/src/generated/lnd/router.pbgrpc.dart'
    as router;
import 'package:bitblik_coordinator/src/generated/lndk/lndkrpc.pbgrpc.dart';
import 'package:bitblik_coordinator/src/models/pay_offer_result.dart';
import 'package:bitblik_coordinator/src/models/payment_status.dart';
import 'package:bitblik_coordinator/src/services/lnd_service.dart';
import 'package:bitblik_coordinator/src/services/lndk_bolt12_backend.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

// Amountless and 10-sat mainnet offers (see bolt12_offer_parser_test.dart).
const amountless =
    'lno1zcss9mk8y3wkklfvevcrszlmu23kfrxh49px20665dqwmn4p72pksese';
const tenSats =
    'lno1pqpzwyq2p32x2um5ypmx2cm5dae8x93pqthvwfzadd7jejes8q9lhc4rvjxd022zv5l44g6qah82ru5rdpnpj';
const testnet =
    'lno1qgsyxjtl6luzd9t3pr62xr7eemp6awnejusgf6gw45q75vcfqqqqqqq2p32x2um5ypmx2cm5dae8x93pqthvwfzadd7jejes8q9lhc4rvjxd022zv5l44g6qah82ru5rdpnpj';

final hashBytes = List<int>.generate(32, (i) => i);
final hashHex =
    hashBytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();

class _Unary<T> extends Fake implements ResponseFuture<T> {
  _Unary(this.future);
  _Unary.value(T value) : future = Future.value(value);
  _Unary.error(Object error) : future = Future.error(error);
  final Future<T> future;
  @override
  Future<R> then<R>(FutureOr<R> Function(T) onValue, {Function? onError}) =>
      future.then(onValue, onError: onError);
  @override
  Future<T> catchError(Function onError, {bool Function(Object)? test}) =>
      future.catchError(onError, test: test);
}

class _Stream<T> extends Fake implements ResponseStream<T> {
  _Stream(this.stream);
  final Stream<T> stream;
  @override
  StreamSubscription<T> listen(void Function(T)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      stream.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

class _Offers extends Fake implements OffersClient {
  _Offers(this.log);
  final List<String> log;
  int invoiceMsat = 10000;
  Object? getInvoiceError;
  Object? payInvoiceError;
  GetInvoiceRequest? lastGetInvoice;
  PayInvoiceRequest? lastPayInvoice;

  @override
  ResponseFuture<GetInvoiceResponse> getInvoice(GetInvoiceRequest request,
      {CallOptions? options}) {
    log.add('getInvoice');
    lastGetInvoice = request;
    if (getInvoiceError != null) return _Unary.error(getInvoiceError!);
    return _Unary.value(GetInvoiceResponse(
      invoiceHexStr: 'beef',
      invoiceContents: Bolt12InvoiceContents(
        amountMsats: Int64(invoiceMsat),
        paymentHash: PaymentHash(hash: hashBytes),
      ),
    ));
  }

  @override
  ResponseFuture<PayInvoiceResponse> payInvoice(PayInvoiceRequest request,
      {CallOptions? options}) {
    log.add('payInvoice');
    lastPayInvoice = request;
    if (payInvoiceError != null) return _Unary.error(payInvoiceError!);
    return _Unary.value(PayInvoiceResponse(paymentPreimage: 'preimage'));
  }
}

class _Router extends Fake implements router.RouterClient {
  _Router(this.log);
  final List<String> log;
  Stream<Payment> track = const Stream.empty();
  @override
  ResponseStream<Payment> trackPaymentV2(router.TrackPaymentRequest request,
      {CallOptions? options}) {
    log.add('track');
    return _Stream(track);
  }
}

Payment _payment(Payment_PaymentStatus status, {DateTime? resolvedAt}) =>
    Payment(
      status: status,
      paymentPreimage: status == Payment_PaymentStatus.SUCCEEDED ? 'aa' : '',
      feeSat: Int64(3),
      htlcs: [
        if (resolvedAt != null)
          HTLCAttempt(
              resolveTimeNs:
                  Int64(resolvedAt.microsecondsSinceEpoch * 1000)),
      ],
    );

void main() {
  final now = DateTime.utc(2026, 10, 16, 12);
  late List<String> log;
  late _Offers offers;
  late _Router rpc;
  late LndkBolt12Backend backend;

  setUp(() {
    log = [];
    offers = _Offers(log);
    rpc = _Router(log);
    backend = LndkBolt12Backend(
      offers: offers,
      router: rpc,
      network: 'mainnet',
      now: () => now,
    );
  });

  Future<PayOfferResult> pay(String offer,
          {int amountSat = 10, int? feeLimitSat}) =>
      backend.payOffer(
        offer: offer,
        amountSat: amountSat,
        feeLimitSat: feeLimitSat,
        paymentAttemptId: 'attempt-1',
        onPaymentId: (id) async => log.add('recorded $id'),
      );

  test('records the invoice hash before any funds move', () async {
    rpc.track = Stream.value(_payment(Payment_PaymentStatus.SUCCEEDED));
    final result = await pay(tenSats);
    expect(log, ['getInvoice', 'recorded $hashHex', 'payInvoice', 'track']);
    expect(result.status, PaymentStatus.SUCCEEDED);
    expect(result.paymentId, hashHex);
    expect(result.paymentPreimage, 'preimage');
    expect(result.feeSat, 3);
  });

  test('an invoice for another amount is refused before recording', () async {
    offers.invoiceMsat = 25000; // the payout allows at most 10 sats over

    final result = await pay(tenSats);
    expect(result.status, PaymentStatus.FAILED);
    expect(log, ['getInvoice']);
  });

  test('a variable-amount offer is asked for exactly the payout', () async {
    offers.invoiceMsat = 1500000;
    rpc.track = Stream.value(_payment(Payment_PaymentStatus.SUCCEEDED));
    await pay(amountless, amountSat: 1500, feeLimitSat: 12);
    expect(offers.lastGetInvoice!.amount, Int64(1500000));
    expect(offers.lastGetInvoice!.payerNote, 'BitBlik payout attempt1');
    // LNDK reads PayInvoiceRequest.fee_limit as a fixed msat limit.
    expect(offers.lastPayInvoice!.feeLimit, 12000);
    expect(offers.lastPayInvoice!.invoice, 'beef');
  });

  test('a fixed-amount offer leaves the amount to the offer', () async {
    rpc.track = Stream.value(_payment(Payment_PaymentStatus.SUCCEEDED));
    await pay(tenSats);
    expect(offers.lastGetInvoice!.hasAmount(), isFalse);
  });

  test('wrong network and expired requests never reach LNDK', () async {
    expect((await pay(testnet)).status, PaymentStatus.FAILED);
    expect((await pay(tenSats, amountSat: 0)).status, PaymentStatus.FAILED);
    expect(log, isEmpty);
  });

  test('no invoice means nothing was paid', () async {
    offers.getInvoiceError = const GrpcError.deadlineExceeded('no reply');
    final result = await pay(tenSats);
    expect(result.status, PaymentStatus.FAILED);
    expect(log, ['getInvoice']);
  });

  test('a failed hash record stops the payment', () async {
    final result = await backend.payOffer(
      offer: tenSats,
      amountSat: 10,
      paymentAttemptId: 'attempt-1',
      onPaymentId: (_) async => throw StateError('db down'),
    );
    expect(result.status, PaymentStatus.FAILED);
    expect(log, ['getInvoice']);
  });

  group('a PayInvoice error is resolved from LND', () {
    setUp(() => offers.payInvoiceError = const GrpcError.unavailable('lost'));

    test('success', () async {
      rpc.track = Stream.value(_payment(Payment_PaymentStatus.SUCCEEDED));
      final result = await pay(tenSats);
      expect(result.status, PaymentStatus.SUCCEEDED);
      expect(result.paymentPreimage, 'aa');
    });

    test('definitive failure: LNDK returned after its last path', () async {
      rpc.track = Stream.value(
          _payment(Payment_PaymentStatus.FAILED, resolvedAt: now));
      expect((await pay(tenSats)).status, PaymentStatus.FAILED);
    });

    test('no answer from LND stays unknown', () async {
      rpc.track = Stream.error(const GrpcError.unavailable('down'));
      final result = await pay(tenSats);
      expect(result.status, PaymentStatus.UNKNOWN);
      expect(result.paymentId, hashHex);
    });
  });

  group('reconcile', () {
    Future<PayOfferResult?> reconcile(String? paymentId) =>
        backend.reconcile(offer: tenSats, paymentId: paymentId);

    test('without a recorded hash there is no record to trust', () async {
      expect(await reconcile(null), isNull);
      expect(log, isEmpty);
    });

    test('in flight and success come from LND', () async {
      rpc.track = Stream.value(_payment(Payment_PaymentStatus.IN_FLIGHT));
      expect((await reconcile(hashHex))!.status, PaymentStatus.PENDING);
      rpc.track = Stream.value(_payment(Payment_PaymentStatus.SUCCEEDED));
      expect((await reconcile(hashHex))!.status, PaymentStatus.SUCCEEDED);
    });

    test('a recent failure may still be retried by LNDK', () async {
      rpc.track = Stream.value(_payment(Payment_PaymentStatus.FAILED,
          resolvedAt: now.subtract(const Duration(minutes: 2))));
      expect((await reconcile(hashHex))!.status, PaymentStatus.UNKNOWN);
    });

    test('an old failure is final', () async {
      rpc.track = Stream.value(_payment(Payment_PaymentStatus.FAILED,
          resolvedAt: now.subtract(const Duration(minutes: 11))));
      expect((await reconcile(hashHex))!.status, PaymentStatus.FAILED);
    });

    test('a hash LND never saw is not proof of failure', () async {
      rpc.track = Stream.error(const GrpcError.notFound('not initiated'));
      expect(await reconcile(hashHex), isNull);
    });
  });

  group('LndService', () {
    test('without LNDK, BOLT12 stays off and nothing is paid', () async {
      final service = LndService(routerClient: rpc);
      expect(service.isBolt12Available, isFalse);
      final result = await service.payOffer(
          offer: tenSats, amountSat: 10, paymentAttemptId: 'attempt-1');
      expect(result.status, PaymentStatus.FAILED);
      expect(await service.reconcileOutgoingOffer(
              offer: tenSats, paymentAttemptId: 'attempt-1', paymentId: hashHex),
          isNull);
      expect(log, isEmpty);
    });

    test('with LNDK, payouts go through it', () async {
      rpc.track = Stream.value(_payment(Payment_PaymentStatus.SUCCEEDED));
      final service = LndService(routerClient: rpc, bolt12: backend);
      expect(service.isBolt12Available, isTrue);
      expect((await service.decodeOffer(offer: tenSats)).amountMsat, 10000);
      final result = await service.payOffer(
          offer: tenSats, amountSat: 10, paymentAttemptId: 'attempt-1');
      expect(result.status, PaymentStatus.SUCCEEDED);
      expect(log, ['getInvoice', 'payInvoice', 'track']);
    });
  });
}
