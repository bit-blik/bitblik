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
import 'package:grpc/grpc.dart';
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

  test('signs non-empty request with uint64 and gRPC frame byte order', () {
    final signer = LdkServerRequestSigner(
      apiKey: apiKey,
      clock: Clock.fixed(DateTime.fromMillisecondsSinceEpoch(
        1700000000 * 1000,
        isUtc: true,
      )),
    );

    final options = signer.optionsFor(
      ldk_api.Bolt11FailForHashRequest(paymentHash: hash),
    );

    expect(
      options.metadata['x-auth'],
      'HMAC 1700000000:'
      '4c27e45204b0c4717914ca0cc69339aa7264f741c212c9480bd631bcd505ec2d',
    );
  });

  test('rejects invalid host, port, and API-key configuration', () async {
    final services = [
      LdkServerService(
          host: '',
          certificatePath: '',
          apiKey: apiKey,
          adapter: FakeLdkServerClient()),
      LdkServerService(
          host: 'ldk-server',
          port: 0,
          certificatePath: '',
          apiKey: apiKey,
          adapter: FakeLdkServerClient()),
      LdkServerService(
          host: 'ldk-server',
          certificatePath: '',
          apiKey: apiKey.toUpperCase().replaceFirst('0', 'A'),
          adapter: FakeLdkServerClient()),
    ];

    for (final service in services) {
      await expectLater(service.connect(), throwsArgumentError);
    }
  });

  test('missing pinned TLS certificate fails connection', () async {
    final service = LdkServerService(
      host: 'ldk-server',
      certificatePath: '/path/that/does/not/exist/ldk-server-tls.crt',
      apiKey: apiKey,
    );

    await expectLater(
      service.connect(),
      throwsA(
          predicate((error) => error.toString().contains('connect failed'))),
    );
  });

  test('startup waits for event headers and cleans up on timeout', () async {
    final fake = FakeLdkServerClient()..eventReady = Completer<void>().future;
    final service = LdkServerService(
      host: 'ldk-server',
      certificatePath: '',
      apiKey: apiKey,
      adapter: fake,
      startupTimeout: const Duration(milliseconds: 5),
    );

    await expectLater(service.connect(), throwsA(isA<Exception>()));
    expect(service.debugSnapshot()['event_stream_connected'], isFalse);
  });

  test('startup health check has bounded timeout', () async {
    final fake = FakeLdkServerClient()
      ..nodeInfoResponse = Completer<ldk_api.GetNodeInfoResponse>().future;
    final service = LdkServerService(
      host: 'ldk-server',
      certificatePath: '',
      apiKey: apiKey,
      adapter: fake,
      startupTimeout: const Duration(milliseconds: 5),
    );

    await expectLater(service.connect(), throwsA(isA<Exception>()));
    expect(fake.subscribeCalls, 0);
  });

  test('immediate event-header error fails startup', () async {
    final ready = Completer<void>();
    final fake = FakeLdkServerClient()..eventReady = ready.future;
    final service = LdkServerService(
      host: 'ldk-server',
      certificatePath: '',
      apiKey: apiKey,
      adapter: fake,
    );

    final expectation =
        expectLater(service.connect(), throwsA(isA<Exception>()));
    ready.completeError(const GrpcError.unavailable());
    await expectation;
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

  test('one shared event stream serves multiple invoice subscriptions',
      () async {
    const otherHash =
        '1111111111111111111111111111111111111111111111111111111111111111';
    final fake = FakeLdkServerClient();
    final service = await connectedService(fake);
    addTearDown(service.disconnect);
    final first = service.subscribeToInvoiceUpdates(paymentHashHex: hash).first;
    final second =
        service.subscribeToInvoiceUpdates(paymentHashHex: otherHash).first;

    fake.events.add(ldk_events.EventEnvelope(
      paymentClaimable: ldk_events.PaymentClaimable(
        payment: buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.INBOUND,
            paymentHash: otherHash),
      ),
    ));
    fake.events.add(ldk_events.EventEnvelope(
      paymentClaimable: ldk_events.PaymentClaimable(
        payment: buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.INBOUND),
      ),
    ));

    expect((await first).paymentHash, hash);
    expect((await second).paymentHash, otherHash);
    expect(fake.subscribeCalls, 1);
  });

  test('received event emits SETTLED and clears process-local claimable state',
      () async {
    final fake = FakeLdkServerClient()
      ..payment = buildPayment(ldk_types.PaymentStatus.PENDING,
          direction: ldk_types.PaymentDirection.INBOUND);
    final service = await connectedService(fake);
    addTearDown(service.disconnect);
    final updates = service
        .subscribeToInvoiceUpdates(paymentHashHex: hash)
        .take(2)
        .toList();

    fake.events.add(ldk_events.EventEnvelope(
      paymentClaimable: ldk_events.PaymentClaimable(payment: fake.payment),
    ));
    fake.events.add(ldk_events.EventEnvelope(
      paymentReceived: ldk_events.PaymentReceived(
        payment: buildPayment(ldk_types.PaymentStatus.SUCCEEDED,
            direction: ldk_types.PaymentDirection.INBOUND),
      ),
    ));

    expect((await updates).map((update) => update.status),
        [InvoiceStatus.ACCEPTED, InvoiceStatus.SETTLED]);
    expect((await service.lookupInvoice(paymentHashHex: hash)).status,
        InvoiceStatus.OPEN);
  });

  test('malformed or unrelated event is skipped without closing listeners',
      () async {
    final fake = FakeLdkServerClient();
    final service = await connectedService(fake);
    addTearDown(service.disconnect);
    final update =
        service.subscribeToInvoiceUpdates(paymentHashHex: hash).first;

    fake.events.add(ldk_events.EventEnvelope(
      paymentClaimable: ldk_events.PaymentClaimable(
        payment: buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.OUTBOUND),
      ),
    ));
    fake.events.add(ldk_events.EventEnvelope(
      paymentClaimable: ldk_events.PaymentClaimable(
        payment: buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.INBOUND),
      ),
    ));

    expect((await update).status, InvoiceStatus.ACCEPTED);
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

  test('gRPC auth errors omit server details and include clock hint', () async {
    final fake = FakeLdkServerClient()
      ..receiveError = const GrpcError.unauthenticated('secret server detail');
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    await expectLater(
      service.createHoldInvoice(
        amountSats: 1,
        memo: 'memo',
        paymentHashHex: hash,
      ),
      throwsA(predicate((error) {
        final message = error.toString();
        return message.contains('gRPC UNAUTHENTICATED') &&
            message.contains('clock synchronization') &&
            !message.contains('secret server detail');
      })),
    );
  });

  test('rejects malformed hashes, preimages, and sat/msat overflow', () async {
    final fake = FakeLdkServerClient();
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    await expectLater(
      service.createHoldInvoice(
          amountSats: 1, memo: 'memo', paymentHashHex: 'not-hex'),
      throwsFormatException,
    );
    await expectLater(
      service.settleInvoice(preimageHex: '00'),
      throwsFormatException,
    );
    await expectLater(
      service.createHoldInvoice(
        amountSats: 0x7fffffffffffffff ~/ 1000 + 1,
        memo: 'memo',
        paymentHashHex: hash,
      ),
      throwsArgumentError,
    );
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
    expect(fake.requestedPaymentIds, everyElement(hash));
  });

  test('settlement and cancellation clear claimable observation', () async {
    Future<void> exercise({required bool settle}) async {
      final fake = FakeLdkServerClient()
        ..payment = buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.INBOUND);
      final service = await connectedService(fake);
      addTearDown(service.disconnect);
      fake.events.add(ldk_events.EventEnvelope(
        paymentClaimable: ldk_events.PaymentClaimable(payment: fake.payment),
      ));
      await pumpEventQueue();
      expect((await service.lookupInvoice(paymentHashHex: hash)).status,
          InvoiceStatus.ACCEPTED);

      if (settle) {
        await service.settleInvoice(preimageHex: preimage);
      } else {
        await service.cancelInvoice(paymentHashHex: hash);
      }
      fake.payment = buildPayment(ldk_types.PaymentStatus.PENDING,
          direction: ldk_types.PaymentDirection.INBOUND);
      expect((await service.lookupInvoice(paymentHashHex: hash)).status,
          InvoiceStatus.OPEN);
    }

    await exercise(settle: true);
    await exercise(settle: false);
  });

  test('settlement polls through pending state before reporting success',
      () async {
    final fake = FakeLdkServerClient()
      ..autoCompleteClaim = false
      ..paymentResponses.addAll([
        buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.INBOUND),
        buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.INBOUND),
        buildPayment(ldk_types.PaymentStatus.SUCCEEDED,
            direction: ldk_types.PaymentDirection.INBOUND,
            paymentPreimage: preimage),
      ]);
    final service = LdkServerService(
      host: 'ldk-server',
      certificatePath: '',
      apiKey: apiKey,
      adapter: fake,
      delay: (_) async {},
    );
    await service.connect();
    addTearDown(service.disconnect);

    await service.settleInvoice(preimageHex: preimage);

    expect(fake.paymentLookupCalls, 3);
  });

  test('settlement confirmation deadline bounds a hanging lookup', () async {
    final fake = HangingLookupAfterFirstClient()
      ..payment = buildPayment(ldk_types.PaymentStatus.PENDING,
          direction: ldk_types.PaymentDirection.INBOUND);
    final service = LdkServerService(
      host: 'ldk-server',
      certificatePath: '',
      apiKey: apiKey,
      adapter: fake,
      operationTimeout: const Duration(milliseconds: 5),
    );
    await service.connect();
    addTearDown(service.disconnect);

    await expectLater(
      service.settleInvoice(preimageHex: preimage),
      throwsA(predicate(
          (error) => error.toString().contains('lookup payment failed'))),
    );
  });

  test('settle and cancel are serialized for same payment hash', () async {
    final claimGate = Completer<void>();
    final fake = FakeLdkServerClient()
      ..payment = buildPayment(ldk_types.PaymentStatus.PENDING,
          direction: ldk_types.PaymentDirection.INBOUND)
      ..claimGate = claimGate.future;
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    final settling = service.settleInvoice(preimageHex: preimage);
    await pumpEventQueue();
    final canceling = service.cancelInvoice(paymentHashHex: hash);
    await pumpEventQueue();
    expect(fake.failCalls, 0);

    claimGate.complete();
    await settling;
    await expectLater(canceling, throwsStateError);
    expect(fake.failCalls, 0);
  });

  test('ambiguous claim timeout never falls back to cancellation', () async {
    final fake = FakeLdkServerClient()
      ..payment = buildPayment(ldk_types.PaymentStatus.PENDING,
          direction: ldk_types.PaymentDirection.INBOUND)
      ..claimGate = Completer<void>().future;
    final service = LdkServerService(
      host: 'ldk-server',
      certificatePath: '',
      apiKey: apiKey,
      adapter: fake,
      operationTimeout: const Duration(milliseconds: 5),
    );
    await service.connect();
    addTearDown(service.disconnect);

    await expectLater(
      service.settleInvoice(preimageHex: preimage),
      throwsA(predicate(
          (error) => error.toString().contains('claim invoice failed'))),
    );
    expect(fake.failCalls, 0);
  });

  test('mismatched inbound record is rejected before mutation', () async {
    const otherHash =
        '1111111111111111111111111111111111111111111111111111111111111111';
    final wrongId = buildPayment(ldk_types.PaymentStatus.PENDING,
        direction: ldk_types.PaymentDirection.INBOUND)
      ..id = otherHash;
    final wrongHash = buildPayment(ldk_types.PaymentStatus.PENDING,
        direction: ldk_types.PaymentDirection.INBOUND)
      ..kind.bolt11.hash = otherHash;
    final wrongKind = ldk_types.Payment(
      id: hash,
      kind: ldk_types.PaymentKind(onchain: ldk_types.Onchain(txid: otherHash)),
      direction: ldk_types.PaymentDirection.INBOUND,
      status: ldk_types.PaymentStatus.PENDING,
    );
    final wrongDirection = buildPayment(ldk_types.PaymentStatus.PENDING,
        direction: ldk_types.PaymentDirection.OUTBOUND);

    for (final payment in [wrongId, wrongHash, wrongKind, wrongDirection]) {
      final settleFake = FakeLdkServerClient()..payment = payment;
      final settleService = await connectedService(settleFake);
      addTearDown(settleService.disconnect);
      await expectLater(
          settleService.settleInvoice(preimageHex: preimage), throwsStateError);
      expect(settleFake.claimCalls, 0);

      final cancelFake = FakeLdkServerClient()..payment = payment;
      final cancelService = await connectedService(cancelFake);
      addTearDown(cancelService.disconnect);
      await expectLater(
          cancelService.cancelInvoice(paymentHashHex: hash), throwsStateError);
      expect(cancelFake.failCalls, 0);
    }
  });

  test('missing and already-failed cancellation are idempotent', () async {
    final missingFake = FakeLdkServerClient();
    final missingService = await connectedService(missingFake);
    addTearDown(missingService.disconnect);
    expect(
        (await missingService.cancelInvoice(paymentHashHex: hash))
            .isAlreadyMissing,
        isTrue);

    final failedFake = FakeLdkServerClient()
      ..payment = buildPayment(ldk_types.PaymentStatus.FAILED,
          direction: ldk_types.PaymentDirection.INBOUND);
    final failedService = await connectedService(failedFake);
    addTearDown(failedService.disconnect);
    expect(
        (await failedService.cancelInvoice(paymentHashHex: hash)).isCancelled,
        isTrue);
    expect(failedFake.failCalls, 0);
  });

  test('cancellation reconciles ambiguous fail RPC outcomes', () async {
    final failedFake = FakeLdkServerClient()
      ..failError = const GrpcError.unavailable()
      ..paymentResponses.addAll([
        buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.INBOUND),
        buildPayment(ldk_types.PaymentStatus.FAILED,
            direction: ldk_types.PaymentDirection.INBOUND),
        buildPayment(ldk_types.PaymentStatus.FAILED,
            direction: ldk_types.PaymentDirection.INBOUND),
      ]);
    final failedService = await connectedService(failedFake);
    addTearDown(failedService.disconnect);
    expect(
        (await failedService.cancelInvoice(paymentHashHex: hash)).isCancelled,
        isTrue);

    final missingFake = FakeLdkServerClient()
      ..failError = const GrpcError.unavailable()
      ..paymentResponses.addAll([
        buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.INBOUND),
        null,
      ]);
    final missingService = await connectedService(missingFake);
    addTearDown(missingService.disconnect);
    expect(
        (await missingService.cancelInvoice(paymentHashHex: hash))
            .isAlreadyMissing,
        isTrue);

    final settledFake = FakeLdkServerClient()
      ..failError = const GrpcError.unavailable()
      ..paymentResponses.addAll([
        buildPayment(ldk_types.PaymentStatus.PENDING,
            direction: ldk_types.PaymentDirection.INBOUND),
        buildPayment(ldk_types.PaymentStatus.SUCCEEDED,
            direction: ldk_types.PaymentDirection.INBOUND,
            paymentPreimage: preimage),
      ]);
    final settledService = await connectedService(settledFake);
    addTearDown(settledService.disconnect);
    await expectLater(
        settledService.cancelInvoice(paymentHashHex: hash), throwsStateError);
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
      delay: (_) async {},
    );
    await service.connect();
    addTearDown(service.disconnect);
    final update = service
        .subscribeToInvoiceUpdates(paymentHashHex: hash)
        .firstWhere((event) => event.status == InvoiceStatus.ACCEPTED);

    await fake.controllers.first.close();
    await pumpEventQueue();
    fake.controllers[1].add(ldk_events.EventEnvelope(
      paymentClaimable: ldk_events.PaymentClaimable(payment: fake.payment),
    ));

    expect((await update).status, InvoiceStatus.ACCEPTED);
    expect(fake.subscribeCalls, 2);
    expect(service.debugSnapshot()['event_stream_disconnects'], 1);
    expect(service.debugSnapshot()['event_stream_reconnects'], 1);
    expect(service.debugSnapshot()['last_event_timestamp'], isNotNull);
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

  test('outgoing success requires matching 32-byte preimage', () async {
    final fake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(paymentHash: hash)
      ..payment = buildPayment(
        ldk_types.PaymentStatus.SUCCEEDED,
        direction: ldk_types.PaymentDirection.OUTBOUND,
        paymentPreimage:
            '1111111111111111111111111111111111111111111111111111111111111111',
      );
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    final result = await service.reconcileOutgoingPayment(invoice: 'lnbc1test');
    expect(result!.status, domain.PaymentStatus.UNKNOWN);
    expect(result.paymentId, hash);
  });

  test('missing and unavailable outgoing records remain unconfirmed', () async {
    final missingFake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(paymentHash: hash);
    final missingService = await connectedService(missingFake);
    addTearDown(missingService.disconnect);
    expect(await missingService.reconcileOutgoingPayment(invoice: 'lnbc1test'),
        isNull);

    final unavailableFake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(paymentHash: hash)
      ..paymentLookupError = const GrpcError.unavailable();
    final unavailableService = await connectedService(unavailableFake);
    addTearDown(unavailableService.disconnect);
    expect(
        await unavailableService.reconcileOutgoingPayment(invoice: 'lnbc1test'),
        isNull);
  });

  test('lost send response returns UNKNOWN with decoded payment ID', () async {
    final fake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(
        paymentHash: hash,
        amountMsat: Int64(100000),
      )
      ..sendError = const GrpcError.unavailable();
    final service = await connectedService(fake);
    addTearDown(service.disconnect);

    final result = await service.payInvoice(
      invoice: 'lnbc1test',
      amountSat: 100,
    );
    expect(result.status, domain.PaymentStatus.UNKNOWN);
    expect(result.paymentId, hash);
  });

  test('mismatched send ID and payment record remain UNKNOWN', () async {
    const otherHash =
        '1111111111111111111111111111111111111111111111111111111111111111';
    final sendFake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(
        paymentHash: hash,
        amountMsat: Int64(100000),
      )
      ..sendPaymentId = otherHash;
    final sendService = await connectedService(sendFake);
    addTearDown(sendService.disconnect);
    final sent =
        await sendService.payInvoice(invoice: 'lnbc1test', amountSat: 100);
    expect(sent.status, domain.PaymentStatus.UNKNOWN);
    expect(sent.paymentId, hash);

    final recordFake = FakeLdkServerClient()
      ..decoded = ldk_api.DecodeInvoiceResponse(paymentHash: hash)
      ..payment = buildPayment(ldk_types.PaymentStatus.SUCCEEDED,
          direction: ldk_types.PaymentDirection.OUTBOUND,
          paymentHash: otherHash,
          paymentPreimage: preimage);
    final recordService = await connectedService(recordFake);
    addTearDown(recordService.disconnect);
    final reconciled =
        await recordService.reconcileOutgoingPayment(invoice: 'lnbc1test');
    expect(reconciled!.status, domain.PaymentStatus.UNKNOWN);
    expect(reconciled.paymentId, hash);
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
  String paymentHash = hash,
}) {
  return ldk_types.Payment(
    id: paymentHash,
    kind: ldk_types.PaymentKind(
      bolt11: ldk_types.Bolt11(
        hash: paymentHash,
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
  Future<void> eventReady = Future<void>.value();
  Future<ldk_api.GetNodeInfoResponse>? nodeInfoResponse;
  ldk_types.Payment? payment;
  final List<ldk_types.Payment?> paymentResponses = [];
  ldk_api.DecodeInvoiceResponse decoded = ldk_api.DecodeInvoiceResponse();
  ldk_api.Bolt11ReceiveForHashRequest? received;
  ldk_api.Bolt11ClaimForHashRequest? claimed;
  ldk_api.Bolt11SendRequest? sent;
  Object? paymentLookupError;
  Object? sendError;
  Object? failError;
  Object? receiveError;
  Future<void>? claimGate;
  bool autoCompleteClaim = true;
  String sendPaymentId = hash;
  int subscribeCalls = 0;
  int paymentLookupCalls = 0;
  final List<String> requestedPaymentIds = [];
  int claimCalls = 0;
  int failCalls = 0;

  @override
  Future<ldk_api.GetNodeInfoResponse> getNodeInfo() async =>
      await (nodeInfoResponse ??
          Future.value(ldk_api.GetNodeInfoResponse(nodeId: '02abcdef')));

  @override
  LdkServerEventSubscription subscribeEvents() {
    subscribeCalls++;
    return LdkServerEventSubscription(events: events.stream, ready: eventReady);
  }

  @override
  Future<ldk_api.GetPaymentDetailsResponse> getPaymentDetails(
      String paymentId) async {
    paymentLookupCalls++;
    requestedPaymentIds.add(paymentId);
    if (paymentLookupError case final error?) throw error;
    final next =
        paymentResponses.isEmpty ? payment : paymentResponses.removeAt(0);
    return ldk_api.GetPaymentDetailsResponse(payment: next);
  }

  @override
  Future<ldk_api.DecodeInvoiceResponse> decodeInvoice(String invoice) async =>
      decoded;

  @override
  Future<ldk_api.Bolt11SendResponse> bolt11Send(
      ldk_api.Bolt11SendRequest request) async {
    sent = request;
    if (sendError case final error?) throw error;
    return ldk_api.Bolt11SendResponse(paymentId: sendPaymentId);
  }

  @override
  Future<ldk_api.Bolt11FailForHashResponse> bolt11FailForHash(
      ldk_api.Bolt11FailForHashRequest request) async {
    failCalls++;
    if (failError case final error?) throw error;
    payment = paymentWithStatus(ldk_types.PaymentStatus.FAILED);
    return ldk_api.Bolt11FailForHashResponse();
  }

  ldk_types.Payment paymentWithStatus(ldk_types.PaymentStatus status) =>
      buildPayment(status, direction: ldk_types.PaymentDirection.INBOUND);

  @override
  Future<ldk_api.Bolt11ClaimForHashResponse> bolt11ClaimForHash(
      ldk_api.Bolt11ClaimForHashRequest request) async {
    claimCalls++;
    claimed = request;
    await claimGate;
    if (autoCompleteClaim) {
      payment = buildPayment(ldk_types.PaymentStatus.SUCCEEDED,
          direction: ldk_types.PaymentDirection.INBOUND,
          paymentPreimage: request.preimage);
    }
    return ldk_api.Bolt11ClaimForHashResponse();
  }

  @override
  Future<ldk_api.Bolt11ReceiveForHashResponse> bolt11ReceiveForHash(
      ldk_api.Bolt11ReceiveForHashRequest request) async {
    received = request;
    if (receiveError case final error?) throw error;
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

class HangingLookupAfterFirstClient extends FakeLdkServerClient {
  @override
  Future<ldk_api.GetPaymentDetailsResponse> getPaymentDetails(
      String paymentId) {
    if (paymentLookupCalls > 0) {
      return Completer<ldk_api.GetPaymentDetailsResponse>().future;
    }
    return super.getPaymentDetails(paymentId);
  }
}
