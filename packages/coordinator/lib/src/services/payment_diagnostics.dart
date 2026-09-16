/// Operator diagnostics must never contain wallet credentials or payment proofs.
String redactPaymentDiagnostic(String text,
    {Iterable<String?> secrets = const []}) {
  var safe = text;
  for (final secret in secrets) {
    if (secret != null && secret.isNotEmpty) {
      safe = safe.replaceAll(secret, '[redacted]');
    }
  }
  safe = safe.replaceAll(
      RegExp(r'authorization\s*[:=]\s*(?:Bearer|Basic)\s+\S+',
          caseSensitive: false),
      '[redacted credential]');
  safe = safe.replaceAll(
      RegExp(r'(?:nostr\+walletconnect|nostrwalletconnect|https?)://\S+',
          caseSensitive: false),
      '[redacted URL]');
  safe = safe.replaceAll(
      RegExp(r'\b(?:lnbc|lntb|lnbcrt|lno1|lni1|lnr1|nsec1)[a-z0-9]+',
          caseSensitive: false),
      '[redacted payment instruction]');
  safe = safe.replaceAll(
      RegExp(r'\b[0-9a-f]{64}\b', caseSensitive: false), '[redacted hex]');
  safe = safe.replaceAll(
      RegExp(
          r'''["']?(?:secret|token|password|api[_ -]?key|authorization|preimage|payer[_ -]?proof)["']?\s*[:=]\s*(?:"[^"]*"|'[^']*'|\S+)''',
          caseSensitive: false),
      '[redacted credential]');
  return safe.length > 12000
      ? '${safe.substring(0, 12000)}\n[truncated]'
      : safe;
}
