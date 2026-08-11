import 'dart:math';

/// secp256k1 group order `n`. A valid private key is a scalar in `[1, n-1]`;
/// anything outside that range is not a key at all (0 has no public key,
/// values >= n reduce mod n and collide with a different, smaller key).
final BigInt secp256k1Order = BigInt.parse(
    'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141',
    radix: 16);

final RegExp _hex64 = RegExp(r'^[0-9a-fA-F]{64}$');

/// Generates a secp256k1 private key as a 64-char lowercase hex string.
///
/// Entropy comes exclusively from [Random.secure] — the OS CSPRNG
/// (getrandom/urandom on Linux, SecRandomCopyBytes on Apple platforms,
/// BCryptGenRandom on Windows, crypto.getRandomValues on web). It is never
/// seeded from time, counters, or any other predictable input, so keys are
/// not reproducible and cannot be brute-forced from generator state.
///
/// The 32 bytes are interpreted as a big-endian scalar and accepted only in
/// `[1, n-1]` (rejection sampling). The rejection probability is 2^-256 for
/// zero and ~2^-224 for `>= n`, so the loop effectively never re-draws — but
/// the invariant is enforced, not assumed.
String generateSecp256k1PrivateKeyHex() {
  final random = Random.secure();
  while (true) {
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    final key = BigInt.parse(
        bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join(),
        radix: 16);
    if (key > BigInt.zero && key < secp256k1Order) {
      return key.toRadixString(16).padLeft(64, '0');
    }
  }
}

/// Whether [hex] is a well-formed secp256k1 private key: exactly 64 hex
/// chars and a scalar in `[1, n-1]`.
bool isValidSecp256k1PrivateKeyHex(String hex) {
  if (!_hex64.hasMatch(hex)) return false;
  final key = BigInt.parse(hex, radix: 16);
  return key > BigInt.zero && key < secp256k1Order;
}

/// Validates [hex] as a secp256k1 private key and returns it normalized
/// (lowercase, zero-padded to 64 chars). Throws [FormatException] otherwise.
/// Use for imported keys (env vars, user-provided nsec/hex, stored secrets)
/// so a malformed or out-of-range key fails fast instead of producing
/// invalid signatures or a silently reduced key.
String requireValidSecp256k1PrivateKeyHex(String hex) {
  final trimmed = hex.trim();
  if (!isValidSecp256k1PrivateKeyHex(trimmed)) {
    throw FormatException(
        'Invalid secp256k1 private key: must be 64 hex chars encoding a '
        'scalar in [1, n-1].');
  }
  return trimmed.toLowerCase();
}
