// For hex encoding
import 'dart:async'; // Required for Stream
import 'dart:io';
import 'dart:typed_data'; // Required for Uint8List
import 'package:grpc/grpc.dart';
// Add path dependency if not already there
import 'package:fixnum/fixnum.dart'; // Import fixnum for Int64
import 'package:dotenv/dotenv.dart';
import 'package:bolt11_decoder/bolt11_decoder.dart';

import 'payment_service.dart'; // Import the interface
import '../models/cancel_invoice_result.dart';
import '../models/invoice_status.dart';
import '../models/invoice_update.dart';
import '../models/create_hold_invoice_result.dart';
import '../models/invoice_details.dart'; // Added import
import '../models/pay_invoice_result.dart';
import '../models/pay_offer_result.dart';
import '../models/bolt12_offer_info.dart';
import '../models/payment_status.dart' as domain;
import '../logging/app_logger.dart';
import 'lndk_bolt12_backend.dart';

// Import generated LND gRPC files (adjust paths/names if necessary)
import '../generated/lnd/lightning.pbgrpc.dart';
import '../generated/lnd/invoices.pbgrpc.dart';
import '../generated/lnd/router.pbgrpc.dart'
    as lnd_router; // Alias for LND router client and types
import '../generated/lndk/lndkrpc.pbgrpc.dart' as lndk;
// Removed unnecessary import: ../generated/lnd/router.pb.dart

// Top-level helper to convert hex string to Uint8List
Uint8List _hexToBytes(String hex) {
  hex = hex.replaceAll(RegExp(r'\s+'), ''); // Remove any whitespace
  if (hex.length % 2 != 0) {
    hex = '0$hex'; // Pad with a leading zero if odd length
  }
  final bytes = <int>[];
  for (int i = 0; i < hex.length; i += 2) {
    final hexPair = hex.substring(i, i + 2);
    bytes.add(int.parse(hexPair, radix: 16));
  }
  return Uint8List.fromList(bytes);
}

String _bytesToHex(List<int> bytes) =>
    bytes.map((byte) => byte.toRadixString(16).padLeft(2, '0')).join();

class LndService implements PaymentService, Bolt12PaymentService {
  ClientChannel? _channel;
  LightningClient? _lightningClient;
  InvoicesClient? _invoicesClient;
  lnd_router.RouterClient? _routerClient; // Use aliased type
  // BOLT12 payouts through an LNDK sidecar; null unless LNDK_HOST is set.
  ClientChannel? _lndkChannel;
  LndkBolt12Backend? _bolt12;
  late DotEnv _env;

  LndService(
      {LightningClient? lightningClient,
      lnd_router.RouterClient? routerClient,
      LndkBolt12Backend? bolt12})
      : _lightningClient = lightningClient,
        _routerClient = routerClient,
        _bolt12 = bolt12 {
    _env = DotEnv(includePlatformEnvironment: true)..load();
  }

  // backendType getter removed as it's not in the interface

  @override
  Future<void> connect() async {
    if (_channel != null) return; // Already connected

    final lndHost = _env['LND_HOST'] ?? 'localhost';
    final lndPort = int.parse(_env['LND_PORT'] ?? '10009');
    final tlsCertPath = _env['LND_CERT_PATH'] ?? 'tls.cert';
    final macaroonPath = _env['LND_MACAROON_PATH'] ?? 'admin.macaroon';

    // Load TLS certificate
    final List<int> trustedRoots;
    try {
      trustedRoots = await File(tlsCertPath).readAsBytes();
    } catch (e) {
      AppLogger.info('Error reading LND TLS certificate at $tlsCertPath: $e');
      rethrow;
    }
    final channelCredentials = ChannelCredentials.secure(
      certificates: trustedRoots,
      authority: lndHost, // Specify the hostname/IP to verify against the cert
    );

    // Load Macaroon
    final List<int> macaroonBytes;
    try {
      macaroonBytes = await File(macaroonPath).readAsBytes();
    } catch (e) {
      AppLogger.info('Error reading LND macaroon at $macaroonPath: $e');
      rethrow;
    }
    // Convert macaroon bytes to hex string for metadata
    final macaroonHex = macaroonBytes
        .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
        .join('');
    // final macaroonCredentials = CallCredentials.macaroon(macaroonHex); // Incorrect approach

    // Create channel with TLS credentials
    _channel = ClientChannel(
      lndHost,
      port: lndPort,
      options: ChannelOptions(
          credentials: channelCredentials), // Base TLS credentials
    );

    // Create client stubs with macaroon metadata added to call options
    final callOptions = CallOptions(metadata: {'macaroon': macaroonHex});
    _lightningClient = LightningClient(_channel!, options: callOptions);
    _invoicesClient = InvoicesClient(_channel!, options: callOptions);
    _routerClient = lnd_router.RouterClient(_channel!,
        options: callOptions); // Use aliased type

    // Optional: Test connection with a simple call like GetInfo
    try {
      final info = await _lightningClient!.getInfo(GetInfoRequest());
      AppLogger.info(
          'Connected to LND node: ${info.identityPubkey} (alias: ${info.alias})');
      await _connectLndk(info, macaroonHex);
    } catch (e) {
      AppLogger.info('Error connecting to LND: $e');
      await disconnect(); // Clean up channel if connection test fails
      rethrow;
    }
  }

  /// Sets up BOLT12 payouts when LNDK_HOST names an LNDK daemon. No RPC is
  /// made here: an LNDK outage must not stop LND from serving BOLT11, it only
  /// fails BOLT12 payouts until LNDK is back.
  Future<void> _connectLndk(GetInfoResponse info, String lndMacaroonHex) async {
    final host = (_env['LNDK_HOST'] ?? '').trim();
    if (host.isEmpty) return;
    final network = info.chains.isEmpty ? '' : info.chains.first.network;
    if (network.isEmpty) {
      AppLogger.warning('LNDK_HOST is set but LND reported no network; '
          'BOLT12 payouts stay off.');
      return;
    }
    final port = int.parse(_env['LNDK_PORT'] ?? '7000');
    final certPath = _env['LNDK_CERT_PATH'] ?? 'lndk-tls-cert.pem';
    final macaroonPath = _env['LNDK_MACAROON_PATH'];
    // LNDK calls LND with the macaroon its client sends, so by default the
    // coordinator reuses its own LND macaroon.
    final macaroonHex = macaroonPath == null || macaroonPath.isEmpty
        ? lndMacaroonHex
        : _bytesToHex(await File(macaroonPath).readAsBytes());
    _lndkChannel = ClientChannel(
      host,
      port: port,
      options: ChannelOptions(
        credentials: ChannelCredentials.secure(
          certificates: await File(certPath).readAsBytes(),
          authority: host,
        ),
      ),
    );
    _bolt12 = LndkBolt12Backend(
      offers: lndk.OffersClient(_lndkChannel!,
          options: CallOptions(
            metadata: {'macaroon': macaroonHex},
            timeout: const Duration(minutes: 3),
          )),
      router: _routerClient!,
      network: network,
    );
    AppLogger.info('BOLT12 payouts enabled through LNDK at $host:$port.');
  }

  @override
  Future<void> disconnect() async {
    await _lndkChannel?.shutdown();
    _lndkChannel = null;
    _bolt12 = null;
    await _channel?.shutdown();
    _channel = null;
    _lightningClient = null;
    _invoicesClient = null;
    _routerClient = null;
    AppLogger.info('Disconnected from LND.');
  }

  @override
  Future<CreateHoldInvoiceResult> createHoldInvoice({
    required int amountSats,
    required String memo,
    required String paymentHashHex,
  }) async {
    if (_invoicesClient == null) throw StateError('LND not connected.');
    final paymentHashBytes =
        _hexToBytes(paymentHashHex); // Use top-level helper
    final request = AddHoldInvoiceRequest()
      ..memo = memo
      ..cltvExpiry = Int64(80)
      ..hash = paymentHashBytes
      ..value = Int64(amountSats)
      ..private = true
      ..expiry = Int64(86400); // 24 hours expiration
    AppLogger.info('LND: Creating hold invoice for hash: $paymentHashHex');
    final response = await _invoicesClient!.addHoldInvoice(request);
    return CreateHoldInvoiceResult(
      invoice: response.paymentRequest,
      paymentHash: paymentHashHex, // LND uses the hash we provide
    );
  }

  @override
  Stream<InvoiceUpdate> subscribeToInvoiceUpdates(
      {required String paymentHashHex}) {
    if (_invoicesClient == null) throw StateError('LND not connected.');
    final paymentHashBytes = _hexToBytes(paymentHashHex);
    final request = SubscribeSingleInvoiceRequest()..rHash = paymentHashBytes;
    AppLogger.info(
        'LND: Subscribing to invoice updates for hash: $paymentHashHex');

    return _invoicesClient!.subscribeSingleInvoice(request).map((lndInvoice) {
      InvoiceStatus status;
      switch (lndInvoice.state) {
        case Invoice_InvoiceState.ACCEPTED:
          AppLogger.info(
              "LND: lndInvoice ACCEPTED cltvExpiry=${lndInvoice.cltvExpiry} paidSats:${lndInvoice.amtPaidSat}");
          status = InvoiceStatus.ACCEPTED;
          break;
        case Invoice_InvoiceState.SETTLED:
          status = InvoiceStatus.SETTLED;
          break;
        case Invoice_InvoiceState.CANCELED:
          status = InvoiceStatus.CANCELED;
          break;
        case Invoice_InvoiceState.OPEN:
          status = InvoiceStatus.OPEN;
          break;
        default:
          status = InvoiceStatus.UNKNOWN;
      }
      return InvoiceUpdate(
        paymentHash: paymentHashHex, // The original hash we subscribed to
        status: status,
        amountPaidSat: lndInvoice.state == Invoice_InvoiceState.SETTLED
            ? lndInvoice.amtPaidSat.toInt()
            : null,
      );
    }).handleError((error) {
      AppLogger.info(
          'LND: Error in invoice subscription stream for $paymentHashHex: $error');
      // Emit an error state or rethrow if appropriate for the application
      // For now, emitting an UNKNOWN status update
      return InvoiceUpdate(
          paymentHash: paymentHashHex, status: InvoiceStatus.UNKNOWN);
    });
  }

  @override
  Future<void> settleInvoice({required String preimageHex}) async {
    if (_invoicesClient == null) throw StateError('LND not connected.');
    final preimageBytes = _hexToBytes(preimageHex);
    final request = SettleInvoiceMsg()..preimage = preimageBytes;
    AppLogger.info('LND: Settling invoice with preimage...');
    await _invoicesClient!.settleInvoice(request);
  }

  @override
  Future<CancelInvoiceResult> cancelInvoice(
      {required String paymentHashHex}) async {
    if (_invoicesClient == null) throw StateError('LND not connected.');
    final paymentHashBytes = _hexToBytes(paymentHashHex);
    final request = CancelInvoiceMsg()..paymentHash = paymentHashBytes;
    AppLogger.info('LND: Cancelling invoice for hash: $paymentHashHex');
    await _invoicesClient!.cancelInvoice(request);
    return const CancelInvoiceResult.cancelled();
  }

  @override
  Future<PayInvoiceResult> payInvoice({
    required String invoice,
    int? amountSat,
    int? feeLimitSat,
  }) async {
    if (_routerClient == null || _lightningClient == null) {
      throw StateError('LND not connected.');
    }

    if (!RegExp(r'^ln(?:bc|tb|bcrt|sb)[0-9]', caseSensitive: false)
        .hasMatch(invoice.trim())) {
      return PayInvoiceResult(
        status: domain.PaymentStatus.FAILED,
        paymentError: 'payInvoice accepts BOLT11 invoices only',
      );
    }

    String paymentHashHex;
    int invoiceAmountSat = 0;

    try {
      final decodeReq = PayReqString()..payReq = invoice;
      final decoded = await _lightningClient!.decodePayReq(decodeReq);
      paymentHashHex = decoded.paymentHash; // Hex string from LND
      invoiceAmountSat = decoded.numSatoshis.toInt();

      // Validate amount if provided and invoice has an amount
      if (amountSat != null &&
          invoiceAmountSat != 0 &&
          invoiceAmountSat != amountSat) {
        return PayInvoiceResult(
          paymentError:
              'Invoice amount $invoiceAmountSat does not match expected amount $amountSat sats',
        );
      }
    } catch (e) {
      AppLogger.info('LND: Error decoding payment request.');
      return PayInvoiceResult(
        paymentError: 'Failed to decode payment request: ${e.toString()}',
      );
    }

    final request = lnd_router.SendPaymentRequest()
      ..allowSelfPayment = true
      ..paymentRequest = invoice
      ..timeoutSeconds = 60; // Default timeout, consider making configurable

    if (feeLimitSat != null) {
      request.feeLimitSat = Int64(feeLimitSat);
    }

    // For zero-amount invoices, LND requires the amount to be set in the request.
    // Use amountSat for this purpose if the invoice amount is zero.
    if (invoiceAmountSat == 0 && amountSat != null && amountSat > 0) {
      request.amt = Int64(amountSat);
    } else if (invoiceAmountSat == 0 && (amountSat == null || amountSat <= 0)) {
      return PayInvoiceResult(
        paymentError: 'Amount must be provided for a zero-amount invoice.',
      );
    }

    AppLogger.info('LND: Sending BOLT11 payment.');
    try {
      // sendPaymentV2 returns a stream. We need to listen until a terminal state.
      await for (final lndPaymentUpdate
          in _routerClient!.sendPaymentV2(request)) {
        if (lndPaymentUpdate.status == Payment_PaymentStatus.SUCCEEDED) {
          AppLogger.info('LND: Payment SUCCEEDED.');
          return PayInvoiceResult(
            status: domain.PaymentStatus.SUCCEEDED,
            paymentId: paymentHashHex,
            paymentPreimage: lndPaymentUpdate.paymentPreimage,
            feeSat: lndPaymentUpdate.feeSat.toInt(),
          );
        } else if (lndPaymentUpdate.status == Payment_PaymentStatus.FAILED) {
          AppLogger.info(
              'LND: Payment FAILED. Reason: ${lndPaymentUpdate.failureReason}');
          return PayInvoiceResult(
            status: domain.PaymentStatus.FAILED,
            paymentId: paymentHashHex,
            paymentError: lndPaymentUpdate.failureReason.toString(),
          );
        } else if (lndPaymentUpdate.status == Payment_PaymentStatus.IN_FLIGHT) {
          AppLogger.info('LND: Payment IN_FLIGHT for hash: $paymentHashHex');
          // Continue listening
        }
        // Other states like UNKNOWN, INITIATED can be logged if needed
      }
      // If the stream completes without a terminal SUCCEEDED or FAILED_ERROR,
      // try to track the payment status using trackPaymentV2.
      AppLogger.info(
          'LND: Payment stream completed without definitive SUCCEEDED/FAILED status for $paymentHashHex. Attempting to track payment status...');
      try {
        final trackedResult = await _trackPaymentV2(paymentHashHex);
        if (trackedResult != null) {
          return trackedResult;
        }
      } catch (e) {
        AppLogger.info(
            'LND: Exception during trackPaymentV2 for $paymentHashHex: $e');
      }
      return PayInvoiceResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentId: paymentHashHex,
        paymentError:
            'Payment stream completed without definitive status, and tracking did not resolve it.',
      );
    } catch (e) {
      AppLogger.info(
          'LND: Exception during sendPaymentV2 for $paymentHashHex: $e');
      final tracked = await _trackPaymentV2(paymentHashHex);
      if (tracked != null) return tracked;
      return PayInvoiceResult(
        status: domain.PaymentStatus.UNKNOWN,
        paymentId: paymentHashHex,
        paymentError: e.toString(),
      );
    }
  }

  /// Helper to track payment status using LND's trackPaymentV2.
  Future<PayInvoiceResult?> _trackPaymentV2(String paymentHashHex) async {
    if (_routerClient == null) throw StateError('LND not connected.');
    final paymentHashBytes = _hexToBytes(paymentHashHex);
    final req = lnd_router.TrackPaymentRequest()
      ..paymentHash = paymentHashBytes;
    try {
      await for (final update in _routerClient!.trackPaymentV2(req,
          options: CallOptions(timeout: const Duration(seconds: 10)))) {
        AppLogger.info(
            '!!!!!!!!!!!!!!!!!!!!!!! LND: Payment status : ${update.status}');
        if (update.status == Payment_PaymentStatus.SUCCEEDED) {
          AppLogger.info('LND: trackPaymentV2: Payment SUCCEEDED.');
          return PayInvoiceResult(
            status: domain.PaymentStatus.SUCCEEDED,
            paymentId: paymentHashHex,
            paymentPreimage: update.paymentPreimage,
            feeSat: update.feeSat.toInt(),
          );
        } else if (update.status == Payment_PaymentStatus.FAILED) {
          AppLogger.info(
              'LND: trackPaymentV2: Payment FAILED. Reason: ${update.failureReason}');
          return PayInvoiceResult(
            status: domain.PaymentStatus.FAILED,
            paymentId: paymentHashHex,
            paymentError: update.failureReason.toString(),
          );
        } else if (update.status == Payment_PaymentStatus.IN_FLIGHT) {
          AppLogger.info('LND: trackPaymentV2: Payment still IN_FLIGHT...');
          return PayInvoiceResult(
              status: domain.PaymentStatus.PENDING, paymentId: paymentHashHex);
        }
      }
      AppLogger.info(
          'LND: trackPaymentV2: Stream ended without definitive status.');
      return null;
    } catch (e) {
      AppLogger.info(
          'LND: Exception in trackPaymentV2 for $paymentHashHex: $e');
      return null;
    }
  }

  /// Helper method to map LND invoice state to InvoiceStatus enum
  InvoiceStatus _mapLndInvoiceStateToStatus(Invoice_InvoiceState state) {
    switch (state) {
      case Invoice_InvoiceState.OPEN:
        return InvoiceStatus.OPEN;
      case Invoice_InvoiceState.SETTLED:
        return InvoiceStatus.SETTLED;
      case Invoice_InvoiceState.CANCELED:
        return InvoiceStatus.CANCELED;
      case Invoice_InvoiceState.ACCEPTED:
        return InvoiceStatus.ACCEPTED;
      default:
        return InvoiceStatus.UNKNOWN;
    }
  }

  @override
  Future<InvoiceDetails> lookupInvoice({required String paymentHashHex}) async {
    if (_lightningClient == null) throw StateError('LND not connected.');
    final paymentHashBytes = _hexToBytes(paymentHashHex);
    final request = PaymentHash()..rHash = paymentHashBytes;
    AppLogger.info('LND: Looking up invoice for hash: $paymentHashHex');
    try {
      final lndInvoice = await _lightningClient!.lookupInvoice(request);
      return InvoiceDetails(
        paymentHash: paymentHashHex,
        description: lndInvoice.memo,
        amountMsat: lndInvoice.value.toInt() * 1000, // Convert sats to msats
        createdAt: lndInvoice.creationDate.toInt(),
        settledAt: lndInvoice.settleDate.toInt() == 0
            ? null
            : lndInvoice.settleDate.toInt(), // LND uses 0 for not settled
        invoice: lndInvoice.paymentRequest,
        expiresAt: lndInvoice.creationDate.toInt() +
            lndInvoice.expiry.toInt(), // LND expiry is duration from creation
        status: _mapLndInvoiceStateToStatus(lndInvoice.state),
        preimage: lndInvoice.rPreimage.isNotEmpty
            ? String.fromCharCodes(lndInvoice.rPreimage)
            : null, // LND returns bytes
        feesPaidMsat:
            null, // LND lookupInvoice doesn't directly provide fees paid for this invoice
        type:
            "incoming", // LND lookupInvoice is for invoices created by the node
        // metadata: // LND htlcs could contain metadata, but not directly on Invoice object
      );
    } catch (e) {
      AppLogger.info('LND: Error looking up invoice $paymentHashHex: $e');
      return InvoiceDetails(
        paymentHash: paymentHashHex,
        error: 'LND: Error looking up invoice: ${e.toString()}',
      );
    }
  }

  @override
  Future<PayInvoiceResult?> reconcileOutgoingPayment(
      {required String invoice}) async {
    if (_routerClient == null) return null;
    try {
      final request = Bolt11PaymentRequest(invoice);
      final hash = request.tags
          .firstWhere((tag) => tag.type == 'payment_hash')
          .data as String;
      return await _trackPaymentV2(hash);
    } catch (e) {
      AppLogger.warning('LND outgoing reconciliation unavailable.', error: e);
      return null;
    }
  }

  @override
  bool get isBolt12Available => _bolt12 != null;

  @override
  Future<Bolt12OfferInfo> decodeOffer({required String offer}) async {
    final bolt12 = _bolt12;
    if (bolt12 == null) throw StateError('LNDK BOLT12 is not configured.');
    return bolt12.decodeOffer(offer);
  }

  @override
  Future<PayOfferResult> payOffer({
    required String offer,
    required int amountSat,
    int? feeLimitSat,
    required String paymentAttemptId,
    Future<void> Function(String paymentId)? onPaymentId,
  }) async {
    final bolt12 = _bolt12;
    if (bolt12 == null) {
      return const PayOfferResult(
        status: domain.PaymentStatus.FAILED,
        paymentError: 'LNDK BOLT12 is not configured.',
      );
    }
    return bolt12.payOffer(
      offer: offer,
      amountSat: amountSat,
      feeLimitSat: feeLimitSat,
      paymentAttemptId: paymentAttemptId,
      onPaymentId: onPaymentId,
    );
  }

  @override
  Future<PayOfferResult?> reconcileOutgoingOffer({
    required String offer,
    required String paymentAttemptId,
    String? paymentId,
  }) async =>
      _bolt12?.reconcile(offer: offer, paymentId: paymentId);
}
