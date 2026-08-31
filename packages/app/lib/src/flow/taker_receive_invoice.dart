import 'package:ndk/presentation_layer/ndk.dart';

/// Generate a bolt11 invoice for [amountSats] from the taker's default receiving
/// wallet. Shared by the BLIK submit screen and the generic-flow (TWINT) pay
/// screen so both produce the payout invoice the same way. Throws when no
/// receiving wallet is configured or the wallet returns no bolt11.
Future<String> createReceivingInvoice(Ndk ndk, int amountSats) async {
  // ignore: experimental_member_use
  final wallet = ndk.wallets.defaultWalletForReceiving;
  if (wallet == null) {
    throw Exception('No default receiving wallet configured');
  }
  // ignore: experimental_member_use
  final result = await ndk.wallets.receive(
    walletId: wallet.id,
    amountSats: amountSats,
  );
  final invoice = extractBolt11Invoice(result);
  if (invoice == null) {
    throw Exception('Unable to generate invoice from receiving wallet');
  }
  return invoice;
}

/// Best-effort extraction of a bolt11 string from the various shapes NDK wallet
/// backends return (raw string, map, or an object with an `invoice` field).
String? extractBolt11Invoice(dynamic value) {
  String? normalize(String? raw) {
    if (raw == null) return null;
    final trimmed = raw.trim();
    final withoutPrefix =
        trimmed.toLowerCase().startsWith('lightning:')
            ? trimmed.substring('lightning:'.length).trim()
            : trimmed;
    final lower = withoutPrefix.toLowerCase();
    return lower.startsWith('lnbc') ||
            lower.startsWith('lntb') ||
            lower.startsWith('lnbcrt')
        ? withoutPrefix
        : null;
  }

  if (value is String) return normalize(value);
  if (value is Map) {
    for (final key in const [
      'bolt11',
      'invoice',
      'payment_request',
      'request',
    ]) {
      final candidate = value[key];
      if (candidate is String) {
        final normalized = normalize(candidate);
        if (normalized != null) return normalized;
      }
    }
    return null;
  }
  try {
    final invoice = (value as dynamic).invoice;
    if (invoice is String) return normalize(invoice);
  } catch (_) {}
  return null;
}
