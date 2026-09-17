import 'dart:async';

import 'package:bitblik_coordinator/src/generated/lnd/lightning.pbgrpc.dart';
import 'package:bitblik_coordinator/src/generated/lnd/router.pbgrpc.dart'
    as router;
import 'package:bitblik_coordinator/src/models/payment_status.dart' as domain;
import 'package:bitblik_coordinator/src/services/lnd_service.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

const invoice =
    'lnbc15u1p3xnhl2pp5jptserfk3zk4qy42tlucycrfwxhydvlemu9pqr93tuzlv9cc7g3sdqsvfhkcap3xyhx7un8cqzpgxqzjcsp5f8c52y2stc300gl6s4xswtjpc37hrnnr3c9wvtgjfuvqmpm35evq9qyyssqy4lgd8tj637qcjp05rdpxxykjenthxftej7a2zzmwrmrl70fyj9hvj0rewhzj7jfyuwkwcg9g2jpwtk3wkjtwnkdks84hsnu8xps5vsq4gj5hs';

class _Response<T> extends Fake implements ResponseStream<T> {
  _Response(this.stream);
  final Stream<T> stream;
  @override
  StreamSubscription<T> listen(void Function(T)? onData,
          {Function? onError, void Function()? onDone, bool? cancelOnError}) =>
      stream.listen(onData,
          onError: onError, onDone: onDone, cancelOnError: cancelOnError);
}

class _Unary<T> extends Fake implements ResponseFuture<T> {
  _Unary(this.value);
  final T value;
  @override
  Future<R> then<R>(FutureOr<R> Function(T) onValue, {Function? onError}) =>
      Future.value(value).then(onValue, onError: onError);
}

class _Lightning extends Fake implements LightningClient {
  @override
  ResponseFuture<PayReq> decodePayReq(PayReqString request,
          {CallOptions? options}) =>
      _Unary(PayReq(paymentHash: '11' * 32, numSatoshis: Int64(1500)));
}

class _Router extends Fake implements router.RouterClient {
  Stream<Payment> send =
      Stream.error(const GrpcError.unavailable('response lost'));
  Stream<Payment> track = const Stream.empty();
  int submissions = 0;
  int lookups = 0;
  @override
  ResponseStream<Payment> sendPaymentV2(router.SendPaymentRequest request,
      {CallOptions? options}) {
    submissions++;
    return _Response(send);
  }

  @override
  ResponseStream<Payment> trackPaymentV2(router.TrackPaymentRequest request,
      {CallOptions? options}) {
    lookups++;
    return _Response(track);
  }
}

void main() {
  test('response loss and unavailable lookup remain unknown', () async {
    final rpc = _Router()
      ..track = Stream.error(const GrpcError.notFound('not yet visible'));
    final service =
        LndService(lightningClient: _Lightning(), routerClient: rpc);
    final result = await service.payInvoice(invoice: invoice, amountSat: 1500);
    expect(result.status, domain.PaymentStatus.UNKNOWN);
    expect(rpc.submissions, 1);
    expect(rpc.lookups, 1);
  });

  test('stream ending without a terminal status remains unknown', () async {
    final rpc = _Router()..send = const Stream.empty();
    final service =
        LndService(lightningClient: _Lightning(), routerClient: rpc);
    expect((await service.payInvoice(invoice: invoice)).status,
        domain.PaymentStatus.UNKNOWN);
  });

  for (final status in [
    Payment_PaymentStatus.IN_FLIGHT,
    Payment_PaymentStatus.SUCCEEDED,
    Payment_PaymentStatus.FAILED
  ]) {
    test('restart reconciles $status without sending', () async {
      final rpc = _Router()
        ..track =
            Stream.value(Payment(status: status, paymentPreimage: 'proof'));
      final service = LndService(routerClient: rpc);
      final result = await service.reconcileOutgoingPayment(invoice: invoice);
      expect(
          result?.status,
          {
            Payment_PaymentStatus.IN_FLIGHT: domain.PaymentStatus.PENDING,
            Payment_PaymentStatus.SUCCEEDED: domain.PaymentStatus.SUCCEEDED,
            Payment_PaymentStatus.FAILED: domain.PaymentStatus.FAILED,
          }[status]);
      expect(rpc.submissions, 0);
    });
  }

  test('response loss followed by authoritative success returns success',
      () async {
    final rpc = _Router()
      ..track = Stream.value(Payment(
          status: Payment_PaymentStatus.SUCCEEDED, paymentPreimage: 'proof'));
    final service =
        LndService(lightningClient: _Lightning(), routerClient: rpc);
    expect((await service.payInvoice(invoice: invoice)).status,
        domain.PaymentStatus.SUCCEEDED);
    expect(rpc.submissions, 1);
  });
}
