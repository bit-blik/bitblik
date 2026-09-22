import 'dart:async';

import 'package:bitblik_coordinator/src/models/invoice_status.dart';
import 'package:bitblik_coordinator/src/models/payment_status.dart';
import 'package:bitblik_coordinator/src/services/nwc_service.dart';
import 'package:mockito/mockito.dart';
import 'package:ndk/domain_layer/usecases/nwc/nwc_notification.dart';
import 'package:ndk/ndk.dart';
import 'package:test/test.dart';

const _invoice = 'lnbc1test';
const _paymentHash =
    '1f68b05c0c5d7cd1bb356de77f38a18a4ceff4a48c51c30460e71bb9be1ed2a7';

LookupInvoiceResponse _lookup({
  String type = 'outgoing',
  String? state,
  int? settledAt,
  int? settleDeadline,
  String preimage = '',
  int feesPaid = 0,
}) =>
    LookupInvoiceResponse.deserialize({
      'result_type': 'lookup_invoice',
      'result': {
        'type': type,
        'invoice': _invoice,
        'state': state,
        'description': '',
        'description_hash': '',
        'preimage': preimage,
        'payment_hash': _paymentHash,
        'amount': 61073000,
        'fees_paid': feesPaid,
        'created_at': 1789652559,
        'expires_at': 1792244559,
        'settled_at': settledAt,
        'settle_deadline': settleDeadline,
      },
    });

class _StubConnection extends Fake implements NwcConnection {
  @override
  Set<String> get permissions => {
        'make_hold_invoice',
        'settle_hold_invoice',
        'cancel_hold_invoice',
        'pay_invoice',
        'lookup_invoice',
      };

  @override
  GetInfoResponse? get info => null;

  @override
  NostrWalletConnectUri get uri => NostrWalletConnectUri.parseConnectionUri(
      'nostr+walletconnect://$_paymentHash?relay=wss://example.com&secret=$_paymentHash');

  @override
  Stream<NwcNotification> get holdInvoiceStateStream => const Stream.empty();
}

class _StubNwc extends Fake implements Nwc {
  LookupInvoiceResponse response = _lookup();
  Object? lookupError;
  PayInvoiceResponse? paymentResponse;
  String? lookedUpInvoice;
  int? holdInvoiceExpiry;

  @override
  Future<NwcConnection> connect(
    String uri, {
    bool doGetInfoMethod = false,
    bool requireGetInfoResponse = false,
    bool useETagForEachRequest = false,
    bool ignoreCapabilitiesCheck = false,
    Function(String?)? onError,
    Duration? timeout,
  }) async =>
      _StubConnection();

  @override
  Future<PayInvoiceResponse> payInvoice(
    NwcConnection connection, {
    required String invoice,
    int? maxFeeMsat,
    Duration? timeout,
  }) async {
    if (paymentResponse != null) return paymentResponse!;
    throw Exception(
        'error pay_invoice code: INTERNAL ldk-server reported payment failure');
  }

  @override
  Future<MakeInvoiceResponse> makeHoldInvoice(
    NwcConnection connection, {
    required int amountSats,
    String? description,
    String? descriptionHash,
    int? expiry,
    required String paymentHash,
    Duration? timeout,
  }) async {
    holdInvoiceExpiry = expiry;
    return MakeInvoiceResponse(
      type: 'incoming',
      invoice: _invoice,
      description: description ?? '',
      descriptionHash: '',
      preimage: '',
      paymentHash: paymentHash,
      amountMsat: amountSats * 1000,
      feesPaid: 0,
      createdAt: 0,
      resultType: 'make_hold_invoice',
    );
  }

  @override
  Future<LookupInvoiceResponse> lookupInvoice(
    NwcConnection connection, {
    String? paymentHash,
    String? invoice,
  }) async {
    lookedUpInvoice = invoice;
    if (lookupError != null) throw lookupError!;
    return response;
  }

  @override
  Future<void> disconnect(NwcConnection connection) async {}
}

class _StubNdk extends Fake implements Ndk {
  _StubNdk(this.nwc);

  @override
  final Nwc nwc;
}

void main() {
  late _StubNwc nwc;
  late NwcService service;

  setUp(() async {
    nwc = _StubNwc();
    service = NwcService(nwcUri: 'test', ndk: _StubNdk(nwc));
    await service.connect();
  });

  tearDown(() async => service.disconnect());

  test('new hold invoices expire after one hour', () async {
    await service.createHoldInvoice(
        amountSats: 1000, memo: 'test', paymentHashHex: _paymentHash);
    expect(nwc.holdInvoiceExpiry, 3600);
  });

  test('does not treat an unpaid pending incoming invoice as accepted',
      () async {
    nwc.response = _lookup(type: 'incoming', state: 'pending');

    final result = await service.lookupInvoice(paymentHashHex: _paymentHash);

    expect(result.status, InvoiceStatus.OPEN);
  });

  test('recovers an accepted hold invoice from its settlement deadline',
      () async {
    nwc.response = _lookup(
      type: 'incoming',
      state: 'pending',
      settleDeadline: 1789652619,
    );

    final result = await service.lookupInvoice(paymentHashHex: _paymentHash);

    expect(result.status, InvoiceStatus.ACCEPTED);
  });

  for (final code in ['INTERNAL', 'OTHER', 'NOT_FOUND', 'PAYMENT_FAILED']) {
    test('returned $code error cannot authorize replacement', () async {
      nwc.paymentResponse =
          PayInvoiceResponse(resultType: 'pay_invoice', feesPaid: 0)
            ..errorCode = code
            ..errorMessage = 'Wallet response lost';
      final result = await service.payInvoice(invoice: _invoice);
      expect(result.status, PaymentStatus.UNKNOWN);
      expect(result.paymentError, contains(code));
    });
  }

  test('reconciles an ambiguous NWC error as a confirmed outgoing failure',
      () async {
    final submitted = await service.payInvoice(invoice: _invoice);
    expect(submitted.status, PaymentStatus.UNKNOWN);

    nwc.response = _lookup(state: 'failed');
    final result = await service.reconcileOutgoingPayment(invoice: _invoice);

    expect(nwc.lookedUpInvoice, _invoice);
    expect(result?.status, PaymentStatus.FAILED);
    expect(result?.paymentId, _paymentHash);
    expect(result?.paymentError, contains('failed'));
  });

  for (final state in [null, 'pending', 'expired', 'unknown']) {
    test('does not infer failure from unsettled outgoing state $state',
        () async {
      nwc.response = _lookup(state: state);
      expect(await service.reconcileOutgoingPayment(invoice: _invoice), isNull);
    });
  }

  test('does not treat an incoming failed invoice as an outgoing failure',
      () async {
    nwc.response = _lookup(type: 'incoming', state: 'failed');
    expect(await service.reconcileOutgoingPayment(invoice: _invoice), isNull);
  });

  test('settlement evidence takes precedence and preserves fees and proof',
      () async {
    nwc.response = _lookup(
      state: 'failed',
      settledAt: 1789652606,
      preimage: 'proof',
      feesPaid: 18125,
    );
    final result = await service.reconcileOutgoingPayment(invoice: _invoice);
    expect(result?.status, PaymentStatus.SUCCEEDED);
    expect(result?.paymentPreimage, 'proof');
    expect(result?.feeSat, 18);
  });

  test('lookup errors remain ambiguous', () async {
    nwc.lookupError = TimeoutException('lookup timed out');
    expect(await service.reconcileOutgoingPayment(invoice: _invoice), isNull);
  });
}
