import 'dart:convert';
import 'dart:typed_data';

import 'package:bech32/bech32.dart';
import 'package:crypto/crypto.dart';
import 'package:pointycastle/export.dart';

const fundingHash =
    '1111111111111111111111111111111111111111111111111111111111111111';
const fundingPayee =
    '0279be667ef9dcbbac55a06295ce870b07029bfcdb2dce28d959f2815b16f81798';
final fundingTime = DateTime.utc(2026, 9, 17, 12);

/// Synthetic signed invoices: no node, wallet or payment request is made.
String fundingInvoice(
    {String hrp = 'lnbc15u',
    String hash = fundingHash,
    int expiry = 3600,
    bool invalidSignature = false,
    bool duplicateHash = false,
    bool includeSecret = true,
    bool includePayee = true,
    DateTime? createdAt}) {
  List<int> convert(List<int> input, int from, int to) {
    var buffer = 0, bits = 0;
    final output = <int>[];
    for (final v in input) {
      buffer = ((buffer << from) | v) & 0xffff;
      bits += from;
      while (bits >= to) {
        bits -= to;
        output.add((buffer >> bits) & ((1 << to) - 1));
      }
    }
    if (bits > 0) output.add((buffer << (to - bits)) & ((1 << to) - 1));
    return output;
  }

  List<int> hex(String value) => [
        for (var i = 0; i < value.length; i += 2)
          int.parse(value.substring(i, i + 2), radix: 16)
      ];
  List<int> field(int type, List<int> words) =>
      [type, words.length >> 5, words.length & 31, ...words];
  final timestamp = (createdAt ?? fundingTime).millisecondsSinceEpoch ~/ 1000;
  final expiryWords = <int>[];
  do {
    expiryWords.insert(0, expiry & 31);
    expiry >>= 5;
  } while (expiry != 0);
  final words = <int>[
    for (var i = 6; i >= 0; i--) (timestamp >> (5 * i)) & 31,
    ...field(1, convert(hex(hash), 8, 5)),
    if (duplicateHash) ...field(1, convert(hex(hash), 8, 5)),
    if (includeSecret) ...field(16, convert(List.filled(32, 2), 8, 5)),
    ...field(13, convert(utf8.encode('Synthetic funding test'), 8, 5)),
    ...field(6, expiryWords),
    if (includePayee) ...field(19, convert(hex(fundingPayee), 8, 5)),
  ];
  final domain = ECDomainParameters('secp256k1');
  final signer = ECDSASigner(null, HMac(SHA256Digest(), 64))
    ..init(true,
        PrivateKeyParameter<ECPrivateKey>(ECPrivateKey(BigInt.one, domain)));
  final digest = Uint8List.fromList(
      sha256.convert([...utf8.encode(hrp), ...convert(words, 5, 8)]).bytes);
  final sig = signer.generateSignature(digest) as ECSignature;
  final lowS = sig.s > domain.n >> 1 ? domain.n - sig.s : sig.s;
  final signature = [
    ...hex(sig.r.toRadixString(16).padLeft(64, '0')),
    ...hex(lowS.toRadixString(16).padLeft(64, '0')),
    0,
  ];
  if (invalidSignature) signature[5] ^= 1;
  return const Bech32Codec()
      .encode(Bech32(hrp, [...words, ...convert(signature, 8, 5)]), 10000);
}
