import 'package:fixnum/fixnum.dart';
import 'package:grpc/grpc.dart';

import '../generated/lnd/lightning.pb.dart' show Payment, Payment_PaymentStatus;
import '../generated/lnd/router.pbgrpc.dart' as lnd_router;
import '../generated/lndk/lndkrpc.pbgrpc.dart' as lndk;
import '../logging/app_logger.dart';
import '../models/bolt12_offer_info.dart';
import '../models/pay_offer_result.dart';
import '../models/payment_status.dart';
import 'bolt12_offer_parser.dart';

/// BOLT12 payouts for an LND coordinator through an LNDK sidecar.
///
/// LND forwards onion messages but has no offer flow of its own. LNDK fetches
/// the offer's invoice over onion messages and pays its blinded paths with
/// LND's SendToRouteV2, so every payment lives in LND's payment database
/// under the invoice's payment hash. That hash is the payment ID: it is handed
/// to `onPaymentId` before any funds can move, and reconciliation tracks it
/// in LND.
class LndkBolt12Backend {
  LndkBolt12Backend({
    required lndk.OffersClient offers,
    required lnd_router.RouterClient router,
    required this.network,
    DateTime Function()? now,
    this.invoiceTimeout = const Duration(seconds: 30),
    this.failureSettle = const Duration(minutes: 10),
  })  : _offers = offers,
        _router = router,
        _now = now ?? DateTime.now;

  final lndk.OffersClient _offers;
  final lnd_router.RouterClient _router;
  final DateTime Function() _now;

  /// Network name as [Bolt12OfferParser] uses it, e.g. `mainnet`.
  final String network;

  /// How long LNDK may wait for the offer's invoice over onion messages.
  final Duration invoiceTimeout;

  /// LNDK tries an invoice's blinded paths one after another with the same
  /// payment hash, and LND reports the payment FAILED between two tries. A
  /// failure found during reconciliation only counts once its last HTLC has
  /// been resolved for this long.
  final Duration failureSettle;

  Bolt12OfferInfo decodeOffer(String offer) =>
      Bolt12OfferParser(expectedNetwork: network).decode(offer);

  Future<PayOfferResult> payOffer({
    required String offer,
    required int amountSat,
    int? feeLimitSat,
    required String paymentAttemptId,
    Future<void> Function(String paymentId)? onPaymentId,
  }) async {
    if (amountSat <= 0) {
      return _failed('BOLT12 payment amount must be positive.');
    }
    late final Bolt12OfferInfo info;
    try {
      info = decodeOffer(offer);
    } catch (error) {
      return _failed(error.toString());
    }
    if (info.isExpired) return _failed('BOLT12 offer is expired.');
    final minimumMsat = (amountSat - 100) * 1000;
    final maximumMsat = (amountSat + 10) * 1000;
    final offerMsat = info.amountMsat;
    if (offerMsat != null &&
        (offerMsat < minimumMsat || offerMsat > maximumMsat)) {
      return _failed('BOLT12 offer amount $offerMsat msat does not match '
          '${amountSat * 1000} msat.');
    }

    // Fetching the invoice moves no funds, so any failure here is final.
    late final lndk.GetInvoiceResponse fetched;
    try {
      final request = lndk.GetInvoiceRequest(
        offer: info.normalized,
        payerNote: _payerNote(paymentAttemptId),
        responseInvoiceTimeout: invoiceTimeout.inSeconds,
      );
      if (info.isVariableAmount) request.amount = Int64(amountSat * 1000);
      fetched = await _offers.getInvoice(request);
    } catch (error) {
      return _failed('Could not get an invoice for the BOLT12 offer: $error');
    }
    final contents = fetched.invoiceContents;
    final invoiceMsat = contents.amountMsats.toInt();
    if (invoiceMsat < minimumMsat || invoiceMsat > maximumMsat) {
      return _failed('BOLT12 invoice amount $invoiceMsat msat does not match '
          '${amountSat * 1000} msat.');
    }
    final hash = _hex(contents.paymentHash.hash);
    if (hash.length != 64) {
      return _failed('BOLT12 invoice has no valid payment hash.');
    }

    try {
      await onPaymentId?.call(hash);
    } catch (error) {
      return _failed('Could not record the BOLT12 payment hash: $error');
    }

    final payRequest = lndk.PayInvoiceRequest(invoice: fetched.invoiceHexStr);
    if (feeLimitSat != null) {
      // LNDK applies fee_limit as a fixed limit in msat; the field is uint32.
      payRequest.feeLimit = (feeLimitSat * 1000).clamp(0, 0xffffffff);
    }
    late final String preimage;
    try {
      preimage = (await _offers.payInvoice(payRequest)).paymentPreimage;
    } catch (error) {
      // LNDK only returns after its last blinded path, so LND's verdict is
      // final here; without one the outcome stays unknown.
      final payment = await _track(hash);
      if (payment == null) {
        return PayOfferResult(
          status: PaymentStatus.UNKNOWN,
          paymentId: hash,
          paymentError: 'LNDK payment outcome unknown: $error',
        );
      }
      return _fromPayment(payment, hash, settled: true);
    }
    final payment = await _track(hash);
    return PayOfferResult(
      status: PaymentStatus.SUCCEEDED,
      paymentId: hash,
      paymentPreimage: preimage,
      feeSat: payment?.status == Payment_PaymentStatus.SUCCEEDED
          ? payment!.feeSat.toInt()
          : null,
    );
  }

  /// Reconciles from LND only. Without a recorded hash, or when LND does not
  /// know the hash, there is no authoritative record: nothing proves that no
  /// payment is under way, so this returns `null` rather than a failure.
  Future<PayOfferResult?> reconcile({
    required String offer,
    String? paymentId,
  }) async {
    if (paymentId == null) return null;
    final hash = paymentId.toLowerCase();
    if (!RegExp(r'^[0-9a-f]{64}$').hasMatch(hash)) return null;
    final payment = await _track(hash);
    if (payment == null) return null;
    return _fromPayment(payment, hash, settled: _failureSettled(payment));
  }

  Future<Payment?> _track(String hash) async {
    final request = lnd_router.TrackPaymentRequest(
      paymentHash: List<int>.generate(
          32, (i) => int.parse(hash.substring(i * 2, i * 2 + 2), radix: 16)),
    );
    try {
      await for (final payment in _router.trackPaymentV2(request,
          options: CallOptions(timeout: const Duration(seconds: 10)))) {
        return payment;
      }
    } catch (error) {
      AppLogger.warning('LND payment lookup for BOLT12 hash $hash failed.',
          error: error);
    }
    return null;
  }

  bool _failureSettled(Payment payment) {
    final resolvedNs = payment.htlcs
        .map((htlc) => htlc.resolveTimeNs.toInt())
        .fold<int>(0, (latest, ns) => ns > latest ? ns : latest);
    if (resolvedNs == 0) return false;
    final resolved =
        DateTime.fromMicrosecondsSinceEpoch(resolvedNs ~/ 1000, isUtc: true);
    return _now().toUtc().difference(resolved) >= failureSettle;
  }

  PayOfferResult _fromPayment(Payment payment, String hash,
      {required bool settled}) {
    switch (payment.status) {
      case Payment_PaymentStatus.SUCCEEDED:
        return PayOfferResult(
          status: PaymentStatus.SUCCEEDED,
          paymentId: hash,
          paymentPreimage: payment.paymentPreimage,
          feeSat: payment.feeSat.toInt(),
        );
      case Payment_PaymentStatus.FAILED:
        return PayOfferResult(
          status: settled ? PaymentStatus.FAILED : PaymentStatus.UNKNOWN,
          paymentId: hash,
          paymentError: payment.failureReason.toString(),
        );
      case Payment_PaymentStatus.IN_FLIGHT:
      case Payment_PaymentStatus.INITIATED:
        return PayOfferResult(status: PaymentStatus.PENDING, paymentId: hash);
      default:
        return PayOfferResult(status: PaymentStatus.UNKNOWN, paymentId: hash);
    }
  }

  static PayOfferResult _failed(String error) =>
      PayOfferResult(status: PaymentStatus.FAILED, paymentError: error);

  static String _payerNote(String paymentAttemptId) {
    final token = paymentAttemptId.replaceAll('-', '');
    final shortToken = token.length <= 12 ? token : token.substring(0, 12);
    return 'BitBlik payout $shortToken';
  }

  static String _hex(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
}
