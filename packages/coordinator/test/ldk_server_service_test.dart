import 'dart:async';

import 'package:bitblik_coordinator/src/generated/ldk_server/api.pb.dart'
    as ldk_api;
import 'package:bitblik_coordinator/src/generated/ldk_server/events.pb.dart'
    as ldk_events;
import 'package:bitblik_coordinator/src/generated/ldk_server/types.pb.dart'
    as ldk_types;
import 'package:bitblik_coordinator/src/models/invoice_status.dart';
import 'package:bitblik_coordinator/src/models/payment_status.dart' as domain;
import 'package:bitblik_coordinator/src/services/ldk_server_service.dart';
import 'package:clock/clock.dart';
import 'package:fixnum/fixnum.dart';
import 'package:test/test.dart';

const apiKey =
    '0000000000000000000000000000000000000000000000000000000000000000';
const hash = '66687aadf862bd776c8fc18b8e9f8e20089714856ee233b3902a591d0d5f2925';
const preimage =
    '0000000000000000000000000000000000000000000000000000000000000000';

void main() {
  test('signs empty streaming request with textual API key bytes', () {
    final signer = LdkServerRequestSigner(
      apiKey: apiKey,
      clock: Clock.fixed(DateTime.fromMillisecondsSinceEpoch(
        1700000000 * 1000,
        isUtc: true,
      )),
    );

    final options = signer.optionsFor(ldk_api.SubscribeEventsRequest());

    expect(
      options.metadata['x-auth'],
      'HMAC 1700000000:'
      '8f9063ee8c07f1ce754aef1f915111c6a3e914f591b3bf6a9531f00700010c4e',
    );
  });

  test('live claimable event changes pending lookup from OPEN to ACCEPTED',
      () async {
    final fake = FakeLdkServerClient();
    fake.payment = buildPayment(ldk_types.PaymentStatus.PENDING,
        direction: ldk_types.PaymentDirection.INBOUND);
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    expect((await service.lookupInvoice(paymentHashHex: hash)).status,
        InvoiceStatus.OPEN);

    fake.events.add(ldk_events.EventEnvelope(
      paymentClaimable: ldk_events.PaymentClaimable(payment: fake.payment),
    ));
    await pumpEventQueue();

    expect((await service.lookupInvoice(paymentHashHex: hash)).status,
        InvoiceStatus.ACCEPTED);
  });

  test('hold invoice request uses msat, memo, expiry, and lowercase hash',
      () async {
    final fake = FakeLdkServerClient();
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    final created = await service.createHoldInvoice(
      amountSats: 123,
      memo: 'memo',
      paymentHashHex: hash.toUpperCase(),
    );

    expect(created.paymentHash, hash);
    expect(fake.received!.amountMsat.toInt(), 123000);
    expect(fake.received!.description.direct, 'memo');
    expect(fake.received!.expirySecs, 86400);
    expect(fake.received!.paymentHash, hash);
  });

  test('settlement sends lowercase proof and waits for SUCCEEDED', () async {
    final fake = FakeLdkServerClient()
      ..payment = buildPayment(ldk_types.PaymentStatus.PENDING,
          direction: ldk_types.PaymentDirection.INBOUND);
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    await service.settleInvoice(preimageHex: preimage.toUpperCase());

    expect(fake.claimed!.paymentHash, hash);
    expect(fake.claimed!.preimage, preimage);
    expect(fake.claimed!.hasClaimableAmountMsat(), isFalse);
  });

  test('pending outgoing timeout remains explicit PENDING with payment ID',
      () async {
    var now = DateTime.utc(2026);
    final fake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(
        paymentHash: hash,
        amountMsat: Int64(100000),
      )
      ..payment = buildPayment(ldk_types.PaymentStatus.PENDING,
          direction: ldk_types.PaymentDirection.OUTBOUND);
    final service = LdkServerService(
      host: 'ldk-server',
      certificatePath: '',
      apiKey: apiKey,
      adapter: fake,
      clock: Clock(() => now),
      operationTimeout: const Duration(seconds: 1),
      delay: (duration) async => now = now.add(duration),
    );
    await service.connect();
    addTearDown(service.disconnect);

    final result = await service.payInvoice(
      invoice: 'lnbc1test',
      amountSat: 100,
      feeLimitSat: 0,
    );

    expect(result.status, domain.PaymentStatus.PENDING);
    expect(result.paymentId, hash);
    expect(fake.sent!.routeParameters.maxTotalRoutingFeeMsat.toInt(), 0);
  });

  test('event stream reconnect keeps invoice listener alive', () async {
    final fake = ReconnectingLdkServerClient();
    fake.payment = buildPayment(ldk_types.PaymentStatus.PENDING,
        direction: ldk_types.PaymentDirection.INBOUND);
    final service = LdkServerService(
      host: 'ldk-server',
      certificatePath: '',
      apiKey: apiKey,
      adapter: fake,
      initialReconnectDelay: const Duration(milliseconds: 1),
      maxReconnectDelay: const Duration(milliseconds: 2),
    );
    await service.connect();
    addTearDown(service.disconnect);
    final update = service
        .subscribeToInvoiceUpdates(paymentHashHex: hash)
        .firstWhere((event) => event.status == InvoiceStatus.ACCEPTED);

    await fake.controllers.first.close();
    await Future<void>.delayed(const Duration(milliseconds: 10));
    fake.controllers[1].add(ldk_events.EventEnvelope(
      paymentClaimable: ldk_events.PaymentClaimable(payment: fake.payment),
    ));

    expect((await update).status, InvoiceStatus.ACCEPTED);
    expect(fake.subscribeCalls, 2);
  });

  test('settled invoice cancellation never calls fail RPC', () async {
    final fake = FakeLdkServerClient();
    fake.payment = buildPayment(ldk_types.PaymentStatus.SUCCEEDED,
        direction: ldk_types.PaymentDirection.INBOUND);
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    await expectLater(
      service.cancelInvoice(paymentHashHex: hash),
      throwsA(isA<StateError>()),
    );
    expect(fake.failCalls, 0);
  });

  test('outgoing payment validates proof and supplies complete route defaults',
      () async {
    final fake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(
        paymentHash: hash,
        amountMsat: Int64(100000),
      )
      ..payment = buildPayment(
        ldk_types.PaymentStatus.SUCCEEDED,
        direction: ldk_types.PaymentDirection.OUTBOUND,
        paymentPreimage: preimage,
        feeMsat: 1500,
      );
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    final result = await service.payInvoice(
      invoice: 'lnbc1test',
      amountSat: 100,
      feeLimitSat: 2,
    );

    expect(result.status, domain.PaymentStatus.SUCCEEDED);
    expect(result.paymentPreimage, preimage);
    expect(result.feeSat, 2);
    expect(fake.sent!.routeParameters.maxTotalRoutingFeeMsat.toInt(), 2000);
    expect(fake.sent!.routeParameters.maxTotalCltvExpiryDelta, 1008);
    expect(fake.sent!.routeParameters.maxPathCount, 10);
    expect(fake.sent!.routeParameters.maxChannelSaturationPowerOfHalf, 2);
  });

  test('reconciliation returns authoritative FAILED result', () async {
    final fake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(paymentHash: hash)
      ..payment = buildPayment(ldk_types.PaymentStatus.FAILED,
          direction: ldk_types.PaymentDirection.OUTBOUND);
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    final result = await service.reconcileOutgoingPayment(invoice: 'lnbc1test');

    expect(result, isNotNull);
    expect(result!.status, domain.PaymentStatus.FAILED);
    expect(result.paymentId, hash);
  });

  test('inbound success cannot satisfy outgoing reconciliation', () async {
    final fake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(paymentHash: hash)
      ..payment = buildPayment(
        ldk_types.PaymentStatus.SUCCEEDED,
        direction: ldk_types.PaymentDirection.INBOUND,
        paymentPreimage: preimage,
      );
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    final result = await service.reconcileOutgoingPayment(invoice: 'lnbc1test');
    expect(result, isNotNull);
    expect(result!.status, domain.PaymentStatus.UNKNOWN);
  });
}

Future<LdkServerService> connectedService(FakeLdkServerClient fake) async {
  final service = LdkServerService(
    host: 'ldk-server',
    certificatePath: '',
    apiKey: apiKey,
    adapter: fake,
  );
  await service.connect();
  return service;
}

ldk_types.Payment buildPayment(
  ldk_types.PaymentStatus status, {
  required ldk_types.PaymentDirection direction,
  String? paymentPreimage,
  int? feeMsat,
}) {
  return ldk_types.Payment(
    id: hash,
    kind: ldk_types.PaymentKind(
      bolt11: ldk_types.Bolt11(
        hash: hash,
        preimage: paymentPreimage,
      ),
    ),
    amountMsat: Int64(100000),
    feePaidMsat: feeMsat == null ? null : Int64(feeMsat),
    direction: direction,
    status: status,
  );
}

class FakeLdkServerClient implements LdkServerClientAdapter {
  final events = StreamController<ldk_events.EventEnvelope>.broadcast();
  ldk_types.Payment? payment;
  ldk_api.DecodeInvoiceResponse decoded = ldk_api.DecodeInvoiceResponse();
  ldk_api.Bolt11ReceiveForHashRequest? received;
  ldk_api.Bolt11ClaimForHashRequest? claimed;
  ldk_api.Bolt11SendRequest? sent;
  int failCalls = 0;

  @override
  Future<ldk_api.GetNodeInfoResponse> getNodeInfo() async =>
      ldk_api.GetNodeInfoResponse(nodeId: '02abcdef');

  @override
  LdkServerEventSubscription subscribeEvents() => LdkServerEventSubscription(
        events: events.stream,
        ready: Future<void>.value(),
      );

  @override
  Future<ldk_api.GetPaymentDetailsResponse> getPaymentDetails(
          String paymentId) async =>
      ldk_api.GetPaymentDetailsResponse(payment: payment);

  @override
  Future<ldk_api.DecodeInvoiceResponse> decodeInvoice(String invoice) async =>
      decoded;

  @override
  Future<ldk_api.Bolt11SendResponse> bolt11Send(
      ldk_api.Bolt11SendRequest request) async {
    sent = request;
    return ldk_api.Bolt11SendResponse(paymentId: hash);
  }

  @override
  Future<ldk_api.Bolt11FailForHashResponse> bolt11FailForHash(
      ldk_api.Bolt11FailForHashRequest request) async {
    failCalls++;
    payment = paymentWithStatus(ldk_types.PaymentStatus.FAILED);
    return ldk_api.Bolt11FailForHashResponse();
  }

  ldk_types.Payment paymentWithStatus(ldk_types.PaymentStatus status) =>
      buildPayment(status, direction: ldk_types.PaymentDirection.INBOUND);

  @override
  Future<ldk_api.Bolt11ClaimForHashResponse> bolt11ClaimForHash(
      ldk_api.Bolt11ClaimForHashRequest request) async {
    claimed = request;
    payment = buildPayment(ldk_types.PaymentStatus.SUCCEEDED,
        direction: ldk_types.PaymentDirection.INBOUND,
        paymentPreimage: request.preimage);
    return ldk_api.Bolt11ClaimForHashResponse();
  }

  @override
  Future<ldk_api.Bolt11ReceiveForHashResponse> bolt11ReceiveForHash(
      ldk_api.Bolt11ReceiveForHashRequest request) async {
    received = request;
    return ldk_api.Bolt11ReceiveForHashResponse(invoice: 'lnbc1test');
  }
}

class ReconnectingLdkServerClient extends FakeLdkServerClient {
  final controllers = [
    StreamController<ldk_events.EventEnvelope>.broadcast(),
    StreamController<ldk_events.EventEnvelope>.broadcast(),
  ];
  int subscribeCalls = 0;

  @override
  LdkServerEventSubscription subscribeEvents() {
    final index = subscribeCalls++;
    return LdkServerEventSubscription(
      events: controllers[index].stream,
      ready: Future<void>.value(),
    );
  }
}
