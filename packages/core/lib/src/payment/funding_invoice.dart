import 'dart:convert';
import 'dart:typed_data';

import 'package:bech32/bech32.dart';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

/// Local validation before a funding invoice can reach any wallet or export.
/// Encoding/signatures: https://github.com/lightning/bolts/blob/master/11-payment-encoding.md
/// A valid signature identifies a Lightning payee, not a trusted custodian.
class FundingInvoice {
  final String invoice;
  final BigInt amountMsat;
  final String paymentHash;
  final String payeePubkey;
  final DateTime expiresAt;

  const FundingInvoice._(this.invoice, this.amountMsat, this.paymentHash,
      this.payeePubkey, this.expiresAt);

  factory FundingInvoice.validate({
    required String invoice,
    required BigInt expectedAmountMsat,
    required String expectedPaymentHash,
    required String expectedNetwork,
    String? expectedPayeePubkey,
    DateTime? now,
  }) {
    try {
      // Do not normalize mixed case before checking Bech32 validity.
      final encoded = invoice.trim();
      if (encoded.length > 10000)
        throw const FormatException('Invoice is too long.');
      final decoded = const Bech32Codec().decode(encoded, 10000);
      final hrp = decoded.hrp.toLowerCase();
      final match =
          RegExp(r'^ln(bcrt|tbs|bc|tb)([1-9][0-9]*)([munp]?)$').firstMatch(hrp);
      if (match == null)
        throw const FormatException('Invoice must specify a positive amount.');
      final prefix = switch (expectedNetwork) {
        'mainnet' => 'bc',
        'testnet' => 'tb',
        'signet' => 'tbs',
        'regtest' => 'bcrt',
        _ => throw const FormatException('Unsupported payment network.'),
      };
      if (match[1] != prefix)
        throw const FormatException('Invoice is for a different network.');
      var amount = BigInt.parse(match[2]!);
      final multiplier = match[3]!;
      if (multiplier == 'p') {
        if (amount % BigInt.from(10) != BigInt.zero) {
          throw const FormatException(
              'Invoice amount is below millisatoshi precision.');
        }
        amount ~/= BigInt.from(10);
      } else {
        amount *= BigInt.from(switch (multiplier) {
          '' => 100000000000,
          'm' => 100000000,
          'u' => 100000,
          'n' => 100,
          _ => throw const FormatException('Invalid invoice amount.'),
        });
      }
      if (expectedAmountMsat <= BigInt.zero || amount != expectedAmountMsat) {
        throw const FormatException('Invoice amount does not match the offer.');
      }
      final words = decoded.data;
      if (words.length < 111)
        throw const FormatException('Incomplete invoice.');
      final signedWords = words.sublist(0, words.length - 104);
      final timestamp = _integer(signedWords.take(7)).toInt();
      final fields = <int, List<List<int>>>{};
      var offset = 7;
      while (offset < signedWords.length) {
        if (offset + 3 > signedWords.length)
          throw const FormatException('Invalid invoice fields.');
        final type = signedWords[offset++];
        final length = signedWords[offset++] * 32 + signedWords[offset++];
        if (offset + length > signedWords.length)
          throw const FormatException('Invalid invoice fields.');
        fields
            .putIfAbsent(type, () => [])
            .add(signedWords.sublist(offset, offset + length));
        offset += length;
      }
      List<int>? single(int type) {
        final entries = fields[type];
        if (entries == null) return null;
        if (entries.length != 1)
          throw const FormatException('Duplicate invoice field.');
        return entries.single;
      }

      final hashWords = single(1);
      if (hashWords == null || hashWords.length != 52)
        throw const FormatException('Missing invoice payment hash.');
      final hash = _hex(_bytes(hashWords));
      if (!RegExp(r'^[0-9a-fA-F]{64}$').hasMatch(expectedPaymentHash) ||
          hash != expectedPaymentHash.toLowerCase()) {
        throw const FormatException(
            'Invoice payment hash does not match the offer.');
      }
      final description = single(13);
      final descriptionHash = single(23);
      if ((description == null) == (descriptionHash == null)) {
        throw const FormatException('Invalid invoice description.');
      }
      if (description != null) utf8.decode(_bytes(description));
      if (descriptionHash != null && _bytes(descriptionHash).length != 32) {
        throw const FormatException('Invalid invoice description hash.');
      }
      final secret = single(16);
      if (secret == null || secret.length != 52 || _bytes(secret).length != 32)
        throw const FormatException('Invalid invoice payment secret.');
      final expiryWords = single(6);
      final expiry =
          expiryWords == null ? BigInt.from(3600) : _integer(expiryWords);
      final expires = BigInt.from(timestamp) + expiry;
      final current =
          (now ?? DateTime.now()).toUtc().millisecondsSinceEpoch ~/ 1000;
      if (expiry <= BigInt.zero || expires <= BigInt.from(current))
        throw const FormatException('Invoice has expired.');
      if (timestamp > current + 300 || expires > BigInt.from(8640000000000)) {
        throw const FormatException('Invalid invoice timestamp.');
      }
      final signature = _bytes(words.sublist(words.length - 104));
      if (signature.length != 65 || signature.last > 3)
        throw const FormatException('Invalid invoice signature.');
      final digest = Uint8List.fromList(sha256.convert([
        ...utf8.encode(hrp),
        ..._bytes(signedWords, pad: true),
      ]).bytes);
      final curve = ECDomainParameters('secp256k1');
      final r = _big(signature.sublist(0, 32));
      final s = _big(signature.sublist(32, 64));
      if (r <= BigInt.zero ||
          r >= curve.n ||
          s <= BigInt.zero ||
          s >= curve.n) {
        throw const FormatException('Invalid invoice signature.');
      }
      final payeeWords = single(19);
      ECPoint? payee;
      if (payeeWords != null) {
        if (s > curve.n >> 1)
          throw const FormatException('Invalid invoice signature.');
        final key = _bytes(payeeWords);
        if (key.length != 33 || (key[0] != 2 && key[0] != 3))
          throw const FormatException('Invalid invoice payee.');
        payee = curve.curve.decodePoint(key);
      } else {
        // Recover Q = r^-1(sR - eG), using PointyCastle's curve arithmetic.
        final x = r + curve.n * BigInt.from(signature.last >> 1);
        final prime = BigInt.parse(
            'fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f',
            radix: 16);
        if (x >= prime)
          throw const FormatException('Invalid invoice signature.');
        final xHex = x.toRadixString(16).padLeft(64, '0');
        final recoveryPoint = curve.curve.decodePoint([
          2 + (signature.last & 1),
          for (var i = 0; i < 64; i += 2)
            int.parse(xHex.substring(i, i + 2), radix: 16),
        ]);
        if (recoveryPoint == null || !(recoveryPoint * curve.n)!.isInfinity)
          throw const FormatException('Invalid invoice signature.');
        final inverse = r.modInverse(curve.n);
        payee = (recoveryPoint * ((s * inverse) % curve.n))! +
            (curve.G *
                (((curve.n - _big(digest) % curve.n) * inverse) % curve.n));
      }
      if (payee == null || payee.isInfinity)
        throw const FormatException('Invalid invoice signature.');
      final verifier = ECDSASigner()
        ..init(
            false, PublicKeyParameter<ECPublicKey>(ECPublicKey(payee, curve)));
      if (!verifier.verifySignature(digest, ECSignature(r, s)))
        throw const FormatException('Invalid invoice signature.');
      final payeeHex = _hex(payee.getEncoded());
      if (expectedPayeePubkey != null &&
          payeeHex != expectedPayeePubkey.toLowerCase()) {
        throw const FormatException(
            'Invoice is for a different payment recipient.');
      }
      return FundingInvoice._(
          encoded.toLowerCase(),
          amount,
          hash,
          payeeHex,
          DateTime.fromMillisecondsSinceEpoch(expires.toInt() * 1000,
              isUtc: true));
    } on FormatException {
      rethrow;
    } catch (_) {
      throw const FormatException('Invalid funding invoice.');
    }
  }

  static BigInt _integer(Iterable<int> words) => words.fold(
      BigInt.zero, (value, word) => (value << 5) + BigInt.from(word));
  static BigInt _big(List<int> bytes) => BigInt.parse(_hex(bytes), radix: 16);
  static String _hex(List<int> bytes) =>
      bytes.map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  static List<int> _bytes(List<int> words, {bool pad = false}) {
    var accumulator = 0;
    var bits = 0;
    final result = <int>[];
    for (final word in words) {
      accumulator = ((accumulator << 5) | word) & 0xffff;
      bits += 5;
      while (bits >= 8) {
        bits -= 8;
        result.add((accumulator >> bits) & 255);
      }
    }
    if (pad && bits > 0) {
      result.add((accumulator << (8 - bits)) & 255);
    } else if (bits >= 5 || ((accumulator << (8 - bits)) & 255) != 0) {
      throw const FormatException('Invalid invoice padding.');
    }
    return result;
  }
}
