import 'package:ndk/ndk.dart';
import 'package:ndk/entities.dart';

/// A typed Lightning instruction generated for an outgoing BitBlik payout.
sealed class ReceivingPayment {
  const ReceivingPayment();

  String get encoded;

  String? get bolt11 =>
      this is ReceivingInvoice ? (this as ReceivingInvoice).invoice : null;

  String? get bolt12 =>
      this is ReceivingOffer ? (this as ReceivingOffer).offer : null;

  Map<String, String> toWireParams({required String purpose}) => switch (this) {
        ReceivingInvoice(:final invoice) => {
            purpose == 'maker' ? 'maker_invoice' : 'taker_invoice': invoice,
          },
        ReceivingOffer(:final offer) => {
            purpose == 'maker' ? 'maker_offer' : 'taker_offer': offer,
          },
      };
}

class ReceivingInvoice extends ReceivingPayment {
  final String invoice;

  const ReceivingInvoice(this.invoice);

  @override
  String get encoded => invoice;
}

class ReceivingOffer extends ReceivingPayment {
  final String offer;

  const ReceivingOffer(this.offer);

  @override
  String get encoded => offer;
}

bool walletCanReceiveForCoordinator(
  Wallet wallet, {
  required bool coordinatorSupportsBolt12,
}) {
  if (!wallet.canReceive || !wallet.supportedUnits.contains('sat')) {
    return false;
  }
  if (wallet.supportsBolt11InvoiceReceive) return true;
  return coordinatorSupportsBolt12 && wallet.supportsBip321Receive;
}

bool walletCanReceiveBolt12(Wallet wallet) =>
    wallet.supportsBip321Receive &&
    wallet.receivePaymentProtocols.contains(WalletPaymentProtocol.bolt12);

bool hasOnlyBolt12ReceivingWallets(Iterable<Wallet> wallets) {
  final receivingWallets = wallets.where((wallet) => wallet.canReceive).toList();
  return receivingWallets.isNotEmpty &&
      receivingWallets.any(walletCanReceiveBolt12) &&
      !receivingWallets.any(
        (wallet) => walletCanReceiveForCoordinator(
          wallet,
          coordinatorSupportsBolt12: false,
        ),
      );
}

/// Chooses a compatible receiving wallet. An explicit [walletId] is always
/// respected. Otherwise, BOLT12-capable coordinators prefer a BOLT12 receiver,
/// while legacy coordinators only select wallets that can create BOLT11.
Wallet? selectReceivingWalletForCoordinator(
  Iterable<Wallet> wallets, {
  required bool coordinatorSupportsBolt12,
  Wallet? defaultWallet,
  String? walletId,
}) {
  final compatible = wallets
      .where(
        (wallet) => walletCanReceiveForCoordinator(
          wallet,
          coordinatorSupportsBolt12: coordinatorSupportsBolt12,
        ),
      )
      .toList();
  if (walletId != null) {
    return compatible.where((wallet) => wallet.id == walletId).firstOrNull;
  }

  if (coordinatorSupportsBolt12) {
    if (defaultWallet != null &&
        compatible.contains(defaultWallet) &&
        walletCanReceiveBolt12(defaultWallet)) {
      return defaultWallet;
    }
    final bolt12Wallet = compatible.where(walletCanReceiveBolt12).firstOrNull;
    if (bolt12Wallet != null) return bolt12Wallet;
  }
  if (defaultWallet != null && compatible.contains(defaultWallet)) {
    return defaultWallet;
  }
  return compatible.firstOrNull;
}

/// Generates the best receiving instruction supported by both the coordinator
/// and the selected wallet using NDK's protocol-aware BIP-321 wallet API.
/// Older coordinators stay on the direct BOLT11 path.
Future<ReceivingPayment> createReceivingPayment(
  Ndk ndk,
  int amountSats, {
  required bool coordinatorSupportsBolt12,
  String? walletId,
  String? description,
}) async {
  final wallet = selectReceivingWalletForCoordinator(
    ndk.wallets.getWalletsForUnit('sat'),
    coordinatorSupportsBolt12: coordinatorSupportsBolt12,
    defaultWallet: ndk.wallets.defaultWalletForReceiving,
    walletId: walletId,
  );
  if (wallet == null) {
    throw Exception('No compatible receiving wallet configured');
  }

  if (coordinatorSupportsBolt12 && wallet.supportsBip321Receive) {
    try {
      final response = await ndk.wallets.receiveBip321(
        walletId: wallet.id,
        amountMsat: amountSats * 1000,
        description: wallet is Bolt12Wallet ? null : description,
      );
      final offer = extractBolt12Offer(response.bip321);
      if (offer != null) return ReceivingOffer(offer);

      final invoice = extractBolt11Invoice(response.bip321);
      if (invoice != null) return ReceivingInvoice(invoice);
      throw const FormatException(
        'Wallet returned no supported BIP-321 payment instruction',
      );
    } catch (_) {
      if (!wallet.supportsBolt11InvoiceReceive) rethrow;
    }
  }

  if (!wallet.supportsBolt11InvoiceReceive) {
    throw UnsupportedError('Selected wallet cannot create a BOLT11 invoice');
  }
  final result =
      await ndk.wallets.receive(walletId: wallet.id, amountSats: amountSats);
  final invoice = extractBolt11Invoice(result);
  if (invoice == null) {
    throw Exception('Unable to generate invoice from receiving wallet');
  }
  return ReceivingInvoice(invoice);
}

String? extractBolt11Invoice(dynamic value) {
  for (final candidate in _paymentCandidates(value, const [
    'lightning',
    'bolt11',
    'invoice',
    'payment_request',
    'request',
    'bip321',
  ])) {
    final fromUri = _queryInstruction(candidate, 'lightning');
    if (fromUri != null && isBolt11(fromUri)) return fromUri;
    final normalized = candidate.toLowerCase().startsWith('lightning:')
        ? candidate.substring('lightning:'.length).trim()
        : candidate;
    if (isBolt11(normalized)) return normalized;
  }
  return null;
}

String? extractBolt12Offer(dynamic value) {
  for (final candidate in _paymentCandidates(value, const [
    'lno',
    'bolt12',
    'offer',
    'payment_offer',
    'request',
    'bip321',
  ])) {
    final fromUri = _queryInstruction(candidate, 'lno');
    if (fromUri != null && isBolt12Offer(fromUri)) return fromUri;
    final normalized = candidate.toLowerCase().startsWith('lightning:')
        ? candidate.substring('lightning:'.length).trim()
        : candidate;
    if (isBolt12Offer(normalized)) return normalized;
  }
  return null;
}

bool isBolt11(String value) {
  final lower = value.trim().toLowerCase();
  return RegExp(r'^ln(?:bc|tb|bcrt|sb)[0-9]').hasMatch(lower) &&
      !lower.startsWith('lno');
}

bool isBolt12Offer(String value) =>
    value.trim().toLowerCase().startsWith('lno1');

String bip321ForBolt12Offer(String offer) {
  if (!isBolt12Offer(offer)) {
    throw const FormatException('Expected a BOLT12 offer');
  }
  return Uri(
    scheme: 'bitcoin',
    queryParameters: {'lno': offer.trim()},
  ).toString();
}

Iterable<String> _paymentCandidates(dynamic value, List<String> mapKeys) sync* {
  if (value is String) {
    final trimmed = value.trim();
    if (trimmed.isNotEmpty) yield trimmed;
    return;
  }
  if (value is Map) {
    for (final key in mapKeys) {
      final candidate = value[key];
      if (candidate is String && candidate.trim().isNotEmpty) {
        yield candidate.trim();
      }
    }
    return;
  }
  for (final getter in <String? Function()>[
    () => (value as dynamic).bip321 as String?,
    () => (value as dynamic).invoice as String?,
    () => (value as dynamic).bolt11 as String?,
    () => (value as dynamic).offer as String?,
  ]) {
    try {
      final candidate = getter();
      if (candidate != null && candidate.trim().isNotEmpty) {
        yield candidate.trim();
      }
    } catch (_) {}
  }
}

String? _queryInstruction(String value, String key) {
  Uri uri;
  try {
    uri = Uri.parse(value);
  } catch (_) {
    return null;
  }
  if (uri.scheme.toLowerCase() != 'bitcoin') return null;
  final values = uri.queryParametersAll[key];
  if (values == null || values.length != 1 || values.single.trim().isEmpty) {
    return null;
  }
  return values.single.trim();
}
