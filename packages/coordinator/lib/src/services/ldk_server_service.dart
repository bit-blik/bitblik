import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:clock/clock.dart';
import 'package:crypto/crypto.dart';
import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';
import 'package:protobuf/protobuf.dart';

import '../generated/ldk_server/api.pb.dart' as ldk_api;
import '../generated/ldk_server/api.pbgrpc.dart' as ldk_grpc;
import '../generated/ldk_server/events.pb.dart' as ldk_events;
import '../generated/ldk_server/types.pb.dart' as ldk_types;
import '../logging/app_logger.dart';
import '../models/cancel_invoice_result.dart';
import '../models/bolt12_offer_info.dart';
import '../models/create_hold_invoice_result.dart';
import '../models/invoice_details.dart';
import '../models/invoice_status.dart';
import '../models/invoice_update.dart';
import '../models/pay_invoice_result.dart';
import '../models/pay_offer_result.dart';
import '../models/payment_status.dart' as domain;
import 'bolt12_offer_parser.dart';
import 'payment_service.dart';

typedef LdkServerDelay = Future<void> Function(Duration duration);

class LdkServerEventSubscription {
  final Stream<ldk_events.EventEnvelope> events;
  final Future<void> ready;

  const LdkServerEventSubscription({
    required this.events,
    required this.ready,
  });
}

abstract interface class LdkServerClientAdapter {
  Future<ldk_api.GetNodeInfoResponse> getNodeInfo();

  Future<ldk_api.Bolt11ReceiveForHashResponse> bolt11ReceiveForHash(
      ldk_api.Bolt11ReceiveForHashRequest request);

  Future<ldk_api.Bolt11ClaimForHashResponse> bolt11ClaimForHash(
      ldk_api.Bolt11ClaimForHashRequest request);

  Future<ldk_api.Bolt11FailForHashResponse> bolt11FailForHash(
      ldk_api.Bolt11FailForHashRequest request);

  Future<ldk_api.Bolt11SendResponse> bolt11Send(
      ldk_api.Bolt11SendRequest request);

  Future<ldk_api.Bolt12SendResponse> bolt12Send(
      ldk_api.Bolt12SendRequest request);

  Future<ldk_api.ListPaymentsResponse> listPayments(
      ldk_api.ListPaymentsRequest request);

  Future<ldk_api.GetPaymentDetailsResponse> getPaymentDetails(String paymentId);

  Future<ldk_api.DecodeInvoiceResponse> decodeInvoice(String invoice);

  LdkServerEventSubscription subscribeEvents();
}

class LdkServerRequestSigner {
  final String apiKey;
  final Clock clock;

  const LdkServerRequestSigner({
    required this.apiKey,
    this.clock = const Clock(),
  });

  CallOptions optionsFor(GeneratedMessage request) {
    final protobuf = request.writeToBuffer();
    final frame = BytesBuilder(copy: false)
      ..addByte(0)
      ..add(_uint32BigEndian(protobuf.length))
      ..add(protobuf);
    final timestamp = clock.now().toUtc().millisecondsSinceEpoch ~/ 1000;
    final signed = BytesBuilder(copy: false)
      ..add(_uint64BigEndian(timestamp))
      ..add(frame.takeBytes());
    final signature = Hmac(sha256, utf8.encode(apiKey))
        .convert(signed.takeBytes())
        .toString();
    return CallOptions(metadata: {
      'x-auth': 'HMAC $timestamp:$signature',
    });
  }

  static Uint8List _uint32BigEndian(int value) {
    final bytes = ByteData(4)..setUint32(0, value, Endian.big);
    return bytes.buffer.asUint8List();
  }

  static Uint8List _uint64BigEndian(int value) {
    final bytes = ByteData(8)..setUint64(0, value, Endian.big);
    return bytes.buffer.asUint8List();
  }
}

class GrpcLdkServerClientAdapter implements LdkServerClientAdapter {
  final ldk_grpc.LightningNodeClient client;
  final LdkServerRequestSigner signer;

  const GrpcLdkServerClientAdapter(this.client, this.signer);

  @override
  Future<ldk_api.GetNodeInfoResponse> getNodeInfo() {
    final request = ldk_api.GetNodeInfoRequest();
    return client.getNodeInfo(request, options: signer.optionsFor(request));
  }

  @override
  Future<ldk_api.Bolt11ReceiveForHashResponse> bolt11ReceiveForHash(
      ldk_api.Bolt11ReceiveForHashRequest request) {
    return client.bolt11ReceiveForHash(request,
        options: signer.optionsFor(request));
  }

  @override
  Future<ldk_api.Bolt11ClaimForHashResponse> bolt11ClaimForHash(
      ldk_api.Bolt11ClaimForHashRequest request) {
    return client.bolt11ClaimForHash(request,
        options: signer.optionsFor(request));
  }

  @override
  Future<ldk_api.Bolt11FailForHashResponse> bolt11FailForHash(
      ldk_api.Bolt11FailForHashRequest request) {
    return client.bolt11FailForHash(request,
        options: signer.optionsFor(request));
  }

  @override
  Future<ldk_api.Bolt11SendResponse> bolt11Send(
      ldk_api.Bolt11SendRequest request) {
    return client.bolt11Send(request, options: signer.optionsFor(request));
  }

  @override
  Future<ldk_api.Bolt12SendResponse> bolt12Send(
      ldk_api.Bolt12SendRequest request) {
    return client.bolt12Send(request, options: signer.optionsFor(request));
  }

  @override
  Future<ldk_api.ListPaymentsResponse> listPayments(
      ldk_api.ListPaymentsRequest request) {
    return client.listPayments(request, options: signer.optionsFor(request));
  }

  @override
  Future<ldk_api.GetPaymentDetailsResponse> getPaymentDetails(
      String paymentId) {
    final request = ldk_api.GetPaymentDetailsRequest(paymentId: paymentId);
    return client.getPaymentDetails(request,
        options: signer.optionsFor(request));
  }

  @override
  Future<ldk_api.DecodeInvoiceResponse> decodeInvoice(String invoice) {
    final request = ldk_api.DecodeInvoiceRequest(invoice: invoice);
    return client.decodeInvoice(request, options: signer.optionsFor(request));
  }

  @override
  LdkServerEventSubscription subscribeEvents() {
    final request = ldk_api.SubscribeEventsRequest();
    final response =
        client.subscribeEvents(request, options: signer.optionsFor(request));
    return LdkServerEventSubscription(
      events: response,
      ready: response.headers.then((_) {}),
    );
  }
}

class LdkServerService implements PaymentService, Bolt12PaymentService {
  static const _startupTimeout = Duration(seconds: 10);
  static const _operationTimeout = Duration(seconds: 60);
  static const _initialReconnectDelay = Duration(seconds: 1);
  static const _maxReconnectDelay = Duration(seconds: 30);

  final String host;
  final int port;
  final String certificatePath;
  final String apiKey;
  final Clock clock;
  final Duration startupTimeout;
  final Duration operationTimeout;
  final Duration initialReconnectDelay;
  final Duration maxReconnectDelay;
  final LdkServerDelay delay;
  final LdkServerClientAdapter? _injectedAdapter;

  ClientChannel? _channel;
  LdkServerClientAdapter? _adapter;
  StreamSubscription<ldk_events.EventEnvelope>? _eventSubscription;
  StreamController<InvoiceUpdate> _updates =
      StreamController<InvoiceUpdate>.broadcast();
  final Set<String> _claimableHashes = {};
  final Map<String, Future<void>> _hashLocks = {};
  late Duration _reconnectDelay;
  bool _stopping = false;
  bool _reconnectPending = false;
  int _reconnectGeneration = 0;
  bool _eventStreamConnected = false;
  int _eventStreamDisconnects = 0;
  int _eventStreamReconnects = 0;
  DateTime? _lastEventAt;
  String? _network;

  LdkServerService({
    required this.host,
    this.port = 3536,
    required this.certificatePath,
    required this.apiKey,
    this.clock = const Clock(),
    this.startupTimeout = _startupTimeout,
    this.operationTimeout = _operationTimeout,
    this.initialReconnectDelay = _initialReconnectDelay,
    this.maxReconnectDelay = _maxReconnectDelay,
    LdkServerDelay? delay,
    LdkServerClientAdapter? adapter,
  })  : delay = delay ?? Future<void>.delayed,
        _injectedAdapter = adapter {
    _reconnectDelay = initialReconnectDelay;
  }

  @override
  Future<void> connect() async {
    if (_adapter != null) return;
    _validateConfiguration();
    _stopping = false;
    if (_updates.isClosed) {
      _updates = StreamController<InvoiceUpdate>.broadcast();
    }

    try {
      if (_injectedAdapter != null) {
        _adapter = _injectedAdapter;
      } else {
        final certificate = await File(certificatePath).readAsBytes();
        _channel = ClientChannel(
          host,
          port: port,
          options: ChannelOptions(
            credentials: ChannelCredentials.secure(
              certificates: certificate,
              authority: host,
            ),
          ),
        );
        final client = ldk_grpc.LightningNodeClient(_channel!);
        _adapter = GrpcLdkServerClientAdapter(
          client,
          LdkServerRequestSigner(apiKey: apiKey, clock: clock),
        );
      }

      final info = await _adapter!.getNodeInfo().timeout(startupTimeout);
      _network = _networkName(info.network);
      await _startEventStream(initial: true);
      AppLogger.info(
          'Connected to ldk-server at $host:$port (node ${_prefix(info.nodeId)}).');
    } catch (error) {
      await disconnect();
      throw _operationError('connect', error);
    }
  }

  void _validateConfiguration() {
    if (host.trim().isEmpty) {
      throw ArgumentError('LDK_SERVER_HOST is required.');
    }
    if (port <= 0 || port > 65535) {
      throw ArgumentError('LDK_SERVER_PORT must be between 1 and 65535.');
    }
    if (certificatePath.trim().isEmpty && _injectedAdapter == null) {
      throw ArgumentError('LDK_SERVER_CERT_PATH is required.');
    }
    if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(apiKey)) {
      throw ArgumentError(
          'LDK_SERVER_API_KEY must be 64-character lowercase hex text.');
    }
  }

  Future<void> _startEventStream({required bool initial}) async {
    final eventStream = _adapter!.subscribeEvents();
    var ended = false;
    var ready = false;
    late final StreamSubscription<ldk_events.EventEnvelope> nextSubscription;
    void disconnected([Object? error, StackTrace? stack]) {
      if (ended) return;
      ended = true;
      if (ready && !_stopping) {
        _eventStreamConnected = false;
        _eventStreamDisconnects++;
      }
      if (error != null) {
        AppLogger.warning('ldk-server event stream disconnected.',
            error: error);
      }
      if (identical(_eventSubscription, nextSubscription)) {
        _scheduleReconnect();
      }
    }

    nextSubscription = eventStream.events.listen(
      _handleEvent,
      onError: disconnected,
      onDone: disconnected,
      cancelOnError: true,
    );
    try {
      await eventStream.ready.timeout(startupTimeout);
    } catch (_) {
      await nextSubscription.cancel();
      rethrow;
    }
    final previousSubscription = _eventSubscription;
    _eventSubscription = nextSubscription;
    await previousSubscription?.cancel();
    ready = true;
    _eventStreamConnected = !ended;
    _reconnectDelay = initialReconnectDelay;
    _reconnectPending = false;
    if (!initial) _eventStreamReconnects++;
    AppLogger.info(initial
        ? 'ldk-server event stream connected.'
        : 'ldk-server event stream reconnected.');
    if (ended) _scheduleReconnect();
  }

  void _scheduleReconnect() {
    if (_stopping || _adapter == null || _reconnectPending) return;
    _reconnectPending = true;
    final wait = _reconnectDelay;
    final generation = _reconnectGeneration;
    final doubled = _reconnectDelay * 2;
    _reconnectDelay = doubled > maxReconnectDelay ? maxReconnectDelay : doubled;
    unawaited(_reconnectAfter(wait, generation));
  }

  Future<void> _reconnectAfter(Duration wait, int generation) async {
    await delay(wait);
    if (_stopping || generation != _reconnectGeneration || _adapter == null) {
      return;
    }
    try {
      await _startEventStream(initial: false);
    } catch (error) {
      _reconnectPending = false;
      AppLogger.warning('ldk-server event stream reconnect failed.',
          error: error);
      _scheduleReconnect();
    }
  }

  void _handleEvent(ldk_events.EventEnvelope envelope) {
    _lastEventAt = clock.now().toUtc();
    try {
      if (envelope.hasPaymentClaimable()) {
        final event = envelope.paymentClaimable;
        if (!event.hasPayment()) return;
        final payment = event.payment;
        final hash = _validatedPaymentHash(
          payment,
          ldk_types.PaymentDirection.INBOUND,
        );
        if (hash == null) return;
        _claimableHashes.add(hash);
        AppLogger.info(
            'ldk-server invoice ${_prefix(hash)} claimable${event.hasClaimDeadline() ? ' until block ${event.claimDeadline}' : ''}.');
        _updates.add(InvoiceUpdate(
          paymentHash: hash,
          status: InvoiceStatus.ACCEPTED,
          amountPaidSat: payment.hasAmountMsat()
              ? payment.amountMsat.toInt() ~/ 1000
              : null,
        ));
      } else if (envelope.hasPaymentReceived()) {
        final event = envelope.paymentReceived;
        if (!event.hasPayment()) return;
        final payment = event.payment;
        final hash = _validatedPaymentHash(
          payment,
          ldk_types.PaymentDirection.INBOUND,
        );
        if (hash == null) return;
        _claimableHashes.remove(hash);
        AppLogger.info('ldk-server invoice ${_prefix(hash)} settled.');
        _updates.add(InvoiceUpdate(
          paymentHash: hash,
          status: InvoiceStatus.SETTLED,
          amountPaidSat: payment.hasAmountMsat()
              ? payment.amountMsat.toInt() ~/ 1000
              : null,
        ));
      }
    } catch (error) {
      AppLogger.warning('Skipping malformed ldk-server event.', error: error);
    }
  }

  @override
  Future<void> disconnect() async {
    _stopping = true;
    _reconnectPending = false;
    _reconnectGeneration++;
    await _eventSubscription?.cancel();
    _eventSubscription = null;
    _eventStreamConnected = false;
    await _channel?.shutdown();
    _channel = null;
    _adapter = null;
    _network = null;
    _claimableHashes.clear();
    if (!_updates.isClosed) await _updates.close();
  }

  @override
  Future<CreateHoldInvoiceResult> createHoldInvoice({
    required int amountSats,
    required String memo,
    required String paymentHashHex,
  }) async {
    final adapter = _requireAdapter();
    final hash = _normalizeHash(paymentHashHex, 'payment hash');
    final amountMsat = _satsToMsat(amountSats, 'invoice amount');
    final request = ldk_api.Bolt11ReceiveForHashRequest(
      amountMsat: Int64(amountMsat),
      description: ldk_types.Bolt11InvoiceDescription(direct: memo),
      expirySecs: 86400,
      paymentHash: hash,
    );
    final response = await _rpc(
      'create hold invoice',
      adapter.bolt11ReceiveForHash(request),
    );
    if (response.invoice.trim().isEmpty) {
      throw StateError('ldk-server returned an empty BOLT11 invoice.');
    }
    return CreateHoldInvoiceResult(
        invoice: response.invoice, paymentHash: hash);
  }

  @override
  Stream<InvoiceUpdate> subscribeToInvoiceUpdates(
      {required String paymentHashHex}) {
    _requireAdapter();
    final hash = _normalizeHash(paymentHashHex, 'payment hash');
    late StreamController<InvoiceUpdate> controller;
    StreamSubscription<InvoiceUpdate>? subscription;
    controller = StreamController<InvoiceUpdate>(
      onListen: () {
        subscription = _updates.stream
            .where((update) => update.paymentHash == hash)
            .listen(controller.add, onError: controller.addError);
        if (_claimableHashes.contains(hash)) {
          controller.add(
              InvoiceUpdate(paymentHash: hash, status: InvoiceStatus.ACCEPTED));
        }
      },
      onCancel: () => subscription?.cancel(),
    );
    return controller.stream;
  }

  @override
  Future<InvoiceDetails> lookupInvoice({required String paymentHashHex}) async {
    final hash = _normalizeHash(paymentHashHex, 'payment hash');
    try {
      final payment = await _getPayment(hash);
      if (payment == null) {
        return InvoiceDetails(
          paymentHash: hash,
          status: InvoiceStatus.UNKNOWN,
          error: 'ldk-server payment not found.',
        );
      }
      _requirePayment(payment, hash, ldk_types.PaymentDirection.INBOUND);
      if (payment.status != ldk_types.PaymentStatus.PENDING) {
        _claimableHashes.remove(hash);
      }
      final status = switch (payment.status) {
        ldk_types.PaymentStatus.PENDING => _claimableHashes.contains(hash)
            ? InvoiceStatus.ACCEPTED
            : InvoiceStatus.OPEN,
        ldk_types.PaymentStatus.SUCCEEDED => InvoiceStatus.SETTLED,
        ldk_types.PaymentStatus.FAILED => InvoiceStatus.CANCELED,
        _ => InvoiceStatus.UNKNOWN,
      };
      return InvoiceDetails(
        paymentHash: hash,
        type: 'incoming',
        amountMsat: payment.hasAmountMsat() ? payment.amountMsat.toInt() : null,
        feesPaidMsat:
            payment.hasFeePaidMsat() ? payment.feePaidMsat.toInt() : null,
        preimage: payment.kind.bolt11.hasPreimage()
            ? payment.kind.bolt11.preimage
            : null,
        settledAt: status == InvoiceStatus.SETTLED
            ? payment.latestUpdateTimestamp.toInt()
            : null,
        status: status,
      );
    } catch (error) {
      return InvoiceDetails(
        paymentHash: hash,
        status: InvoiceStatus.UNKNOWN,
        error: _operationError('lookup invoice', error).toString(),
      );
    }
  }

  @override
  Future<void> settleInvoice({required String preimageHex}) async {
    final preimage = _normalizeHash(preimageHex, 'preimage');
    final hash = sha256.convert(_hexToBytes(preimage)).toString();
    await _withHashLock(hash, () async {
      final before = await _getPayment(hash);
      if (before == null) throw StateError('ldk-server payment not found.');
      _requirePayment(before, hash, ldk_types.PaymentDirection.INBOUND);
      if (before.status == ldk_types.PaymentStatus.SUCCEEDED) {
        _claimableHashes.remove(hash);
        return;
      }
      if (before.status == ldk_types.PaymentStatus.FAILED) {
        throw StateError('Cannot settle canceled ldk-server invoice.');
      }
      if (before.status != ldk_types.PaymentStatus.PENDING) {
        throw StateError('Cannot settle ldk-server invoice in unknown state.');
      }
      await _rpc(
        'claim invoice',
        _requireAdapter().bolt11ClaimForHash(
          ldk_api.Bolt11ClaimForHashRequest(
            paymentHash: hash,
            preimage: preimage,
          ),
        ),
      );
      final terminal =
          await _pollPayment(hash, ldk_types.PaymentDirection.INBOUND);
      if (terminal?.status != ldk_types.PaymentStatus.SUCCEEDED) {
        throw StateError(terminal?.status == ldk_types.PaymentStatus.FAILED
            ? 'ldk-server invoice failed while settling.'
            : 'Timed out confirming ldk-server invoice settlement.');
      }
      _requirePayment(terminal!, hash, ldk_types.PaymentDirection.INBOUND);
      _claimableHashes.remove(hash);
      AppLogger.info('ldk-server invoice ${_prefix(hash)} settled.');
    });
  }

  @override
  Future<CancelInvoiceResult> cancelInvoice(
      {required String paymentHashHex}) async {
    final hash = _normalizeHash(paymentHashHex, 'payment hash');
    return _withHashLock(hash, () async {
      final before = await _getPayment(hash);
      if (before == null) return const CancelInvoiceResult.alreadyMissing();
      _requirePayment(before, hash, ldk_types.PaymentDirection.INBOUND);
      if (before.status == ldk_types.PaymentStatus.SUCCEEDED) {
        throw StateError('Cannot cancel settled ldk-server invoice.');
      }
      if (before.status == ldk_types.PaymentStatus.FAILED) {
        _claimableHashes.remove(hash);
        _updates.add(
            InvoiceUpdate(paymentHash: hash, status: InvoiceStatus.CANCELED));
        return const CancelInvoiceResult.cancelled();
      }
      if (before.status != ldk_types.PaymentStatus.PENDING) {
        throw StateError('Cannot cancel ldk-server invoice in unknown state.');
      }

      try {
        await _rpc(
          'fail invoice',
          _requireAdapter().bolt11FailForHash(
            ldk_api.Bolt11FailForHashRequest(paymentHash: hash),
          ),
        );
      } catch (_) {
        final reconciled = await _getPayment(hash);
        if (reconciled == null) {
          return const CancelInvoiceResult.alreadyMissing();
        }
        _requirePayment(reconciled, hash, ldk_types.PaymentDirection.INBOUND);
        if (reconciled.status == ldk_types.PaymentStatus.SUCCEEDED) {
          throw StateError('Cannot cancel settled ldk-server invoice.');
        }
        if (reconciled.status != ldk_types.PaymentStatus.FAILED) rethrow;
      }

      final terminal =
          await _pollPayment(hash, ldk_types.PaymentDirection.INBOUND);
      if (terminal == null) {
        throw StateError(
            'Timed out confirming ldk-server invoice cancellation.');
      }
      _requirePayment(terminal, hash, ldk_types.PaymentDirection.INBOUND);
      if (terminal.status == ldk_types.PaymentStatus.SUCCEEDED) {
        throw StateError('Cannot cancel settled ldk-server invoice.');
      }
      if (terminal.status != ldk_types.PaymentStatus.FAILED) {
        throw StateError(
            'Timed out confirming ldk-server invoice cancellation.');
      }
      _claimableHashes.remove(hash);
      AppLogger.info('ldk-server invoice ${_prefix(hash)} canceled.');
      _updates.add(
          InvoiceUpdate(paymentHash: hash, status: InvoiceStatus.CANCELED));
      return const CancelInvoiceResult.cancelled();
    });
  }

  @override
  Future<PayInvoiceResult> payInvoice({
    required String invoice,
    int? amountSat,
    int? feeLimitSat,
  }) async {
    final adapter = _requireAdapter();
    late ldk_api.DecodeInvoiceResponse decoded;
    try {
      decoded = await _rpc('decode invoice', adapter.decodeInvoice(invoice));
    } catch (error) {
      return PayInvoiceResult(
        status: domain.PaymentStatus.FAILED,
        paymentError: _operationError('decode invoice', error).toString(),
      );
    }
    final hash = _normalizeHash(decoded.paymentHash, 'decoded payment hash');
    if (decoded.isExpired) {
      return PayInvoiceResult(
        status: domain.PaymentStatus.FAILED,
        paymentId: hash,
        paymentError: 'BOLT11 invoice has expired.',
      );
    }
    if (!decoded.hasAmountMsat() && (amountSat == null || amountSat <= 0)) {
      return PayInvoiceResult(
        status: domain.PaymentStatus.FAILED,
        paymentId: hash,
        paymentError: 'Amount must be provided for a zero-amount invoice.',
      );
    }
    if (decoded.hasAmountMsat() &&
        amountSat != null &&
        decoded.amountMsat.toInt() !=
            _satsToMsat(amountSat, 'payment amount')) {
      return PayInvoiceResult(
        status: domain.PaymentStatus.FAILED,
        paymentId: hash,
        paymentError: 'Invoice amount does not match expected amount.',
      );
    }

    final request = ldk_api.Bolt11SendRequest(invoice: invoice);
    if (!decoded.hasAmountMsat()) {
      request.amountMsat = Int64(_satsToMsat(amountSat!, 'payment amount'));
    }
    if (feeLimitSat != null) {
      request.routeParameters = _routeParameters(feeLimitSat);
    }

    try {
      final response = await _rpc('send payment', adapter.bolt11Send(request));
      final returnedId = _normalizeHash(response.paymentId, 'payment ID');
      if (returnedId != hash) {
        throw StateError('ldk-server returned mismatched payment ID.');
      }
    } catch (error) {
      return PayInvoiceResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentId: hash,
        paymentError: _operationError('send payment', error).toString(),
      );
    }

    late final ldk_types.Payment? payment;
    try {
      payment = await _pollPayment(hash, ldk_types.PaymentDirection.OUTBOUND);
    } catch (error) {
      return PayInvoiceResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentId: hash,
        paymentError: _operationError('track payment', error).toString(),
      );
    }
    if (payment == null) {
      return PayInvoiceResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentId: hash,
        paymentError: 'Could not confirm ldk-server payment state.',
      );
    }
    try {
      _requirePayment(payment, hash, ldk_types.PaymentDirection.OUTBOUND);
    } catch (error) {
      return PayInvoiceResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentId: hash,
        paymentError: error.toString(),
      );
    }
    return _outgoingResult(payment, hash);
  }

  @override
  Future<PayInvoiceResult?> reconcileOutgoingPayment(
      {required String invoice}) async {
    final adapter = _requireAdapter();
    late final String hash;
    try {
      final decoded =
          await _rpc('decode invoice', adapter.decodeInvoice(invoice));
      hash = _normalizeHash(decoded.paymentHash, 'decoded payment hash');
    } catch (error) {
      AppLogger.warning('ldk-server outgoing invoice decode unavailable.',
          error: error);
      return null;
    }
    late final ldk_types.Payment? payment;
    try {
      payment = await _getPayment(hash);
    } catch (error) {
      AppLogger.warning('ldk-server outgoing reconciliation unavailable.',
          error: error);
      return null;
    }
    if (payment == null) return null;
    try {
      _requirePayment(payment, hash, ldk_types.PaymentDirection.OUTBOUND);
      return _outgoingResult(payment, hash);
    } catch (error) {
      AppLogger.warning('ldk-server outgoing reconciliation record invalid.',
          error: error);
      return PayInvoiceResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentId: hash,
        paymentError: error.toString(),
      );
    }
  }

  @override
  bool get isBolt12Available => _adapter != null && _network != null;

  @override
  Future<Bolt12OfferInfo> decodeOffer({required String offer}) async {
    _requireAdapter();
    final network = _network;
    if (network == null) {
      throw StateError('ldk-server BOLT12 is unavailable on this network.');
    }
    return Bolt12OfferParser(expectedNetwork: network).decode(offer);
  }

  @override
  Future<PayOfferResult> payOffer({
    required String offer,
    required int amountSat,
    int? feeLimitSat,
    required String paymentAttemptId,
  }) async {
    if (amountSat <= 0) {
      return const PayOfferResult(
        status: domain.PaymentStatus.FAILED,
        paymentError: 'BOLT12 payment amount must be positive.',
      );
    }
    if (!isBolt12Available) {
      return const PayOfferResult(
        status: domain.PaymentStatus.FAILED,
        paymentError: 'ldk-server BOLT12 is unavailable.',
      );
    }

    late final Bolt12OfferInfo info;
    try {
      info = await decodeOffer(offer: offer);
    } catch (error) {
      return PayOfferResult(
        status: domain.PaymentStatus.FAILED,
        paymentError: error.toString(),
      );
    }
    if (info.isExpired) {
      return const PayOfferResult(
        status: domain.PaymentStatus.FAILED,
        paymentError: 'BOLT12 offer is expired.',
      );
    }
    final expectedAmountMsat = _satsToMsat(amountSat, 'payment amount');
    if (info.amountMsat != null &&
        (info.amountMsat! < (amountSat - 100) * 1000 ||
            info.amountMsat! > (amountSat + 10) * 1000)) {
      return PayOfferResult(
        status: domain.PaymentStatus.FAILED,
        paymentError:
            'BOLT12 offer amount ${info.amountMsat} msat does not match $expectedAmountMsat msat.',
      );
    }

    final note = _payerNote(paymentAttemptId);
    final request = ldk_api.Bolt12SendRequest(
      offer: info.normalized,
      payerNote: note,
    );
    if (info.isVariableAmount) request.amountMsat = Int64(expectedAmountMsat);
    if (feeLimitSat != null) {
      request.routeParameters = _routeParameters(feeLimitSat);
    }

    late final String paymentId;
    try {
      final response = await _rpc(
          'send BOLT12 payment', _requireAdapter().bolt12Send(request));
      paymentId = _normalizeHash(response.paymentId, 'payment ID');
    } catch (error) {
      return PayOfferResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentError: _operationError('send BOLT12 payment', error).toString(),
      );
    }

    late final ldk_types.Payment? payment;
    try {
      payment = await _pollBolt12Payment(
        paymentId,
        info.offerId,
        note,
      );
    } catch (error) {
      return PayOfferResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentId: paymentId,
        paymentError: _operationError('track BOLT12 payment', error).toString(),
      );
    }
    if (payment == null) {
      return PayOfferResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentId: paymentId,
        paymentError: 'Could not confirm ldk-server BOLT12 payment state.',
      );
    }
    return _outgoingOfferResult(payment, paymentId);
  }

  @override
  Future<PayOfferResult?> reconcileOutgoingOffer({
    required String offer,
    required String paymentAttemptId,
    String? paymentId,
  }) async {
    if (!isBolt12Available) return null;
    try {
      final info = await decodeOffer(offer: offer);
      final note = _payerNote(paymentAttemptId);
      ldk_types.Payment? payment;
      String? normalizedId;
      if (paymentId != null) {
        normalizedId = _normalizeHash(paymentId, 'payment ID');
        payment = await _getPayment(normalizedId);
        if (payment == null) return null;
        _requireBolt12Payment(payment, normalizedId, info.offerId, note);
      } else {
        payment = await _findBolt12Payment(info.offerId, note);
        if (payment == null) return null;
        normalizedId = _normalizeHash(payment.id, 'payment ID');
        _requireBolt12Payment(payment, normalizedId, info.offerId, note);
      }
      return _outgoingOfferResult(payment, normalizedId);
    } catch (error) {
      AppLogger.warning('ldk-server BOLT12 reconciliation unavailable.',
          error: error);
      return null;
    }
  }

  Future<ldk_types.Payment?> _findBolt12Payment(
      String offerId, String payerNote) async {
    final matches = <ldk_types.Payment>[];
    ldk_types.PageToken? pageToken;
    final seenTokens = <String>{};
    var reachedLastPage = false;
    for (var page = 0; page < 100; page++) {
      final request = ldk_api.ListPaymentsRequest(pageToken: pageToken);
      final response =
          await _rpc('list payments', _requireAdapter().listPayments(request));
      for (final payment in response.payments) {
        if (payment.direction == ldk_types.PaymentDirection.OUTBOUND &&
            payment.hasKind() &&
            payment.kind.hasBolt12Offer() &&
            payment.kind.bolt12Offer.offerId.toLowerCase() == offerId &&
            payment.kind.bolt12Offer.hasPayerNote() &&
            payment.kind.bolt12Offer.payerNote == payerNote) {
          matches.add(payment);
        }
      }
      if (!response.hasNextPageToken()) {
        reachedLastPage = true;
        break;
      }
      final next = response.nextPageToken;
      final key = '${next.token}:${next.index}';
      if (!seenTokens.add(key)) {
        throw StateError('ldk-server repeated a payment page token.');
      }
      pageToken = next;
    }
    if (!reachedLastPage) {
      throw StateError('ldk-server payment history exceeded page limit.');
    }
    return matches.length == 1 ? matches.single : null;
  }

  Future<ldk_types.Payment?> _pollBolt12Payment(
      String paymentId, String offerId, String payerNote) async {
    final deadline = clock.now().add(operationTimeout);
    ldk_types.Payment? last;
    while (clock.now().isBefore(deadline)) {
      final remaining = deadline.difference(clock.now());
      last = await _getPayment(paymentId, timeout: remaining);
      if (last != null) {
        _requireBolt12Payment(last, paymentId, offerId, payerNote);
      }
      if (last == null || last.status != ldk_types.PaymentStatus.PENDING) {
        return last;
      }
      final afterLookup = deadline.difference(clock.now());
      if (afterLookup <= Duration.zero) break;
      await delay(afterLookup < const Duration(milliseconds: 250)
          ? afterLookup
          : const Duration(milliseconds: 250));
    }
    return last;
  }

  void _requireBolt12Payment(ldk_types.Payment payment, String expectedId,
      String expectedOfferId, String expectedPayerNote) {
    if (_normalizeHash(payment.id, 'payment ID') != expectedId ||
        !payment.hasKind() ||
        !payment.kind.hasBolt12Offer() ||
        _normalizeHash(payment.kind.bolt12Offer.offerId, 'BOLT12 offer ID') !=
            expectedOfferId ||
        !payment.kind.bolt12Offer.hasPayerNote() ||
        payment.kind.bolt12Offer.payerNote != expectedPayerNote ||
        payment.direction != ldk_types.PaymentDirection.OUTBOUND) {
      throw StateError(
          'ldk-server returned mismatched BOLT12 payment details.');
    }
  }

  PayOfferResult _outgoingOfferResult(
      ldk_types.Payment payment, String paymentId) {
    switch (payment.status) {
      case ldk_types.PaymentStatus.PENDING:
        return PayOfferResult(
          status: domain.PaymentStatus.PENDING,
          paymentId: paymentId,
          paymentError: 'ldk-server BOLT12 payment is pending.',
        );
      case ldk_types.PaymentStatus.FAILED:
        return PayOfferResult(
          status: domain.PaymentStatus.FAILED,
          paymentId: paymentId,
          paymentError: 'ldk-server BOLT12 payment failed.',
        );
      case ldk_types.PaymentStatus.SUCCEEDED:
        final details = payment.kind.bolt12Offer;
        final hash =
            details.hasHash() ? details.hash.trim().toLowerCase() : null;
        final preimage = details.hasPreimage()
            ? details.preimage.trim().toLowerCase()
            : null;
        if (hash == null ||
            preimage == null ||
            !_isHex32(hash) ||
            !_isHex32(preimage) ||
            sha256.convert(_hexToBytes(preimage)).toString() != hash) {
          return PayOfferResult(
            status: domain.PaymentStatus.UNKNOWN,
            paymentId: paymentId,
            paymentError:
                'ldk-server BOLT12 success has no valid matching preimage.',
          );
        }
        return PayOfferResult(
          status: domain.PaymentStatus.SUCCEEDED,
          paymentId: paymentId,
          paymentPreimage: preimage,
          feeSat: payment.hasFeePaidMsat()
              ? (payment.feePaidMsat.toInt() / 1000).round()
              : 0,
        );
      default:
        return PayOfferResult(
          status: domain.PaymentStatus.UNKNOWN,
          paymentId: paymentId,
          paymentError: 'Unknown ldk-server BOLT12 payment status.',
        );
    }
  }

  PayInvoiceResult _outgoingResult(ldk_types.Payment payment, String hash) {
    switch (payment.status) {
      case ldk_types.PaymentStatus.PENDING:
        return PayInvoiceResult(
          status: domain.PaymentStatus.PENDING,
          paymentId: hash,
          paymentError: 'ldk-server payment is pending.',
        );
      case ldk_types.PaymentStatus.FAILED:
        return PayInvoiceResult(
          status: domain.PaymentStatus.FAILED,
          paymentId: hash,
          paymentError: 'ldk-server payment failed.',
        );
      case ldk_types.PaymentStatus.SUCCEEDED:
        final preimage = payment.kind.bolt11.hasPreimage()
            ? payment.kind.bolt11.preimage.toLowerCase()
            : null;
        if (preimage == null ||
            !_isHex32(preimage) ||
            sha256.convert(_hexToBytes(preimage)).toString() != hash) {
          return PayInvoiceResult(
            status: domain.PaymentStatus.UNKNOWN,
            paymentId: hash,
            paymentError: 'ldk-server success has no valid matching preimage.',
          );
        }
        return PayInvoiceResult(
          status: domain.PaymentStatus.SUCCEEDED,
          paymentId: hash,
          paymentPreimage: preimage,
          feeSat: payment.hasFeePaidMsat()
              ? (payment.feePaidMsat.toInt() / 1000).round()
              : 0,
        );
      default:
        return PayInvoiceResult(
          status: domain.PaymentStatus.UNKNOWN,
          paymentId: hash,
          paymentError: 'Unknown ldk-server payment status.',
        );
    }
  }

  Future<ldk_types.Payment?> _getPayment(String hash,
      {Duration? timeout}) async {
    final response = await _rpc(
      'lookup payment',
      _requireAdapter().getPaymentDetails(hash),
      timeout: timeout,
    );
    return response.hasPayment() ? response.payment : null;
  }

  Future<ldk_types.Payment?> _pollPayment(
      String hash, ldk_types.PaymentDirection direction) async {
    final deadline = clock.now().add(operationTimeout);
    ldk_types.Payment? last;
    while (clock.now().isBefore(deadline)) {
      final remaining = deadline.difference(clock.now());
      last = await _getPayment(hash, timeout: remaining);
      if (last != null) _requirePayment(last, hash, direction);
      if (last == null || last.status != ldk_types.PaymentStatus.PENDING) {
        return last;
      }
      final afterLookup = deadline.difference(clock.now());
      if (afterLookup <= Duration.zero) break;
      await delay(afterLookup < const Duration(milliseconds: 250)
          ? afterLookup
          : const Duration(milliseconds: 250));
    }
    return last;
  }

  Map<String, dynamic> debugSnapshot() => {
        'event_stream_connected': _eventStreamConnected,
        'event_stream_disconnects': _eventStreamDisconnects,
        'event_stream_reconnects': _eventStreamReconnects,
        'last_event_timestamp': _lastEventAt == null
            ? null
            : _lastEventAt!.millisecondsSinceEpoch ~/ 1000,
      };

  String? _validatedPaymentHash(
      ldk_types.Payment payment, ldk_types.PaymentDirection direction) {
    try {
      final hash = _normalizeHash(payment.id, 'payment ID');
      _requirePayment(payment, hash, direction);
      return hash;
    } catch (error) {
      AppLogger.warning('Skipping unrelated ldk-server payment event.',
          error: error);
      return null;
    }
  }

  void _requirePayment(ldk_types.Payment payment, String expectedHash,
      ldk_types.PaymentDirection direction) {
    if (_normalizeHash(payment.id, 'payment ID') != expectedHash ||
        !payment.hasKind() ||
        !payment.kind.hasBolt11() ||
        _normalizeHash(payment.kind.bolt11.hash, 'BOLT11 payment hash') !=
            expectedHash ||
        payment.direction != direction) {
      throw StateError('ldk-server returned mismatched payment details.');
    }
  }

  Future<T> _withHashLock<T>(String hash, Future<T> Function() action) async {
    final previous = _hashLocks[hash] ?? Future<void>.value();
    final completer = Completer<void>();
    final mine = completer.future;
    _hashLocks[hash] = mine;
    try {
      await previous.catchError((_) {});
      return await action();
    } finally {
      completer.complete();
      if (identical(_hashLocks[hash], mine)) _hashLocks.remove(hash);
    }
  }

  LdkServerClientAdapter _requireAdapter() {
    return _adapter ?? (throw StateError('ldk-server is not connected.'));
  }

  Future<T> _rpc<T>(String operation, Future<T> future,
      {Duration? timeout}) async {
    try {
      return await future.timeout(timeout ?? operationTimeout);
    } catch (error) {
      throw _operationError(operation, error);
    }
  }

  static int _satsToMsat(int sats, String name, {bool allowZero = false}) {
    if (sats < 0 ||
        (!allowZero && sats == 0) ||
        sats > 0x7fffffffffffffff ~/ 1000) {
      throw ArgumentError('$name is out of range.');
    }
    return sats * 1000;
  }

  static ldk_types.RouteParametersConfig _routeParameters(int feeLimitSat) =>
      ldk_types.RouteParametersConfig(
        maxTotalRoutingFeeMsat:
            Int64(_satsToMsat(feeLimitSat, 'fee limit', allowZero: true)),
        maxTotalCltvExpiryDelta: 1008,
        maxPathCount: 10,
        maxChannelSaturationPowerOfHalf: 2,
      );

  static String _payerNote(String paymentAttemptId) {
    final token = paymentAttemptId.replaceAll('-', '');
    final shortToken = token.length <= 12 ? token : token.substring(0, 12);
    return 'BitBlik payout $shortToken';
  }

  static String? _networkName(ldk_types.Network network) => switch (network) {
        ldk_types.Network.BITCOIN => 'mainnet',
        ldk_types.Network.TESTNET => 'testnet',
        ldk_types.Network.SIGNET => 'signet',
        ldk_types.Network.REGTEST => 'regtest',
        ldk_types.Network.TESTNET4 => null,
        _ => null,
      };

  static String _normalizeHash(String value, String name) {
    final normalized = value.trim().toLowerCase();
    if (!_isHex32(normalized)) {
      throw FormatException('$name must be a 32-byte hex string.');
    }
    return normalized;
  }

  static bool _isHex32(String value) =>
      RegExp(r'^[0-9a-f]{64}$').hasMatch(value);

  static Uint8List _hexToBytes(String value) => Uint8List.fromList([
        for (var i = 0; i < value.length; i += 2)
          int.parse(value.substring(i, i + 2), radix: 16),
      ]);

  static String _prefix(String value) =>
      value.length <= 12 ? value : value.substring(0, 12);

  static Exception _operationError(String operation, Object error) {
    if (error is GrpcError) {
      final clockHint = error.code == StatusCode.unauthenticated
          ? ' Check host clock synchronization.'
          : '';
      return Exception(
          'ldk-server $operation failed (gRPC ${error.codeName}).$clockHint');
    }
    return Exception('ldk-server $operation failed: $error');
  }
}
