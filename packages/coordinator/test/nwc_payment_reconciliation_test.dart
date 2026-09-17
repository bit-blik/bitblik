import 'dart:async';

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
  String? lookedUpInvoice;

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
  }) async =>
      throw Exception(
          'error pay_invoice code: INTERNAL ldk-server reported payment failure');

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
