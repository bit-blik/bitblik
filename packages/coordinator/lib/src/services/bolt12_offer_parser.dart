import 'dart:convert';
import 'dart:typed_data';

import 'package:convert/convert.dart';
import 'package:crypto/crypto.dart';

import '../models/bolt12_offer_info.dart';

class Bolt12OfferParser {
  static const _charset = 'qpzry9x8gf2tvdw0s3jn54khce6mua7l';
  static const _bitcoinGenesis =
      '6fe28c0ab6f1b372c1a6a246ae63f74f931e8365e15a089c68d6190000000000';
  static const _chainNames = <String, String>{
    _bitcoinGenesis: 'mainnet',
    '43497fd7f826957108f4a30fd9cec3aeba79972084e90ead01ea330900000000':
        'testnet',
    'f61eee3b63a380a477a063af32b2bbc97c9ff9f01f2c4225e973988108000000':
        'signet',
    '06226e14a1b1a590cacf2a0146b4be5f28c34f3a5e332a1fc7b2b73cf188910f':
        'regtest',
  };
  static const _knownOfferTypes = {2, 4, 6, 8, 10, 12, 14, 16, 18, 20, 22};

  final String expectedNetwork;
  final DateTime Function() now;

  Bolt12OfferParser({
    this.expectedNetwork = 'mainnet',
    DateTime Function()? now,
  }) : now = now ?? DateTime.now;

  Bolt12OfferInfo decode(String input) {
    final normalized = normalize(input);
    final separator = normalized.indexOf('1');
    if (separator != 3 || normalized.substring(0, separator) != 'lno') {
      throw const FormatException('Expected a BOLT12 lno offer');
    }
    final words = <int>[];
    for (final rune in normalized.substring(separator + 1).runes) {
      final value = _charset.indexOf(String.fromCharCode(rune));
      if (value < 0) throw const FormatException('Invalid BOLT12 character');
      words.add(value);
    }
    if (words.isEmpty) throw const FormatException('Empty BOLT12 offer');
    final bytes = _convertBits(words, 5, 8, pad: false);
    final fields = _parseTlv(bytes);
    if (fields.isEmpty) throw const FormatException('Empty BOLT12 TLV stream');

    for (final field in fields) {
      final validRange = (field.type >= 1 && field.type <= 79) ||
          (field.type >= 1000000000 && field.type <= 1999999999);
      if (!validRange) {
        throw FormatException('Unsupported BOLT12 offer field ${field.type}');
      }
      if (!_knownOfferTypes.contains(field.type) && field.type.isEven) {
        throw FormatException(
          'Unknown required BOLT12 offer field ${field.type}',
        );
      }
    }

    final chains = fields.where((field) => field.type == 2).toList();
    final chainNames = <String>{};
    if (chains.isEmpty) {
      chainNames.add('mainnet');
    } else {
      final value = chains.single.value;
      if (value.isEmpty || value.length % 32 != 0) {
        throw const FormatException('Invalid offer_chains');
      }
      for (var i = 0; i < value.length; i += 32) {
        final hash = hex.encode(value.sublist(i, i + 32));
        final name = _chainNames[hash];
        if (name == null) throw FormatException('Unsupported chain $hash');
        chainNames.add(name);
      }
    }
    if (!chainNames.contains(expectedNetwork)) {
      throw FormatException(
        'BOLT12 offer is for ${chainNames.join(', ')}, expected $expectedNetwork',
      );
    }

    final currency = _field(fields, 6);
    if (currency != null) {
      throw const FormatException(
          'Fiat-denominated BOLT12 offers are unsupported');
    }
    final amountField = _field(fields, 8);
    final amountMsat = amountField == null ? null : _tu64(amountField.value);
    if (amountMsat != null && amountMsat <= 0) {
      throw const FormatException('offer_amount must be positive');
    }
    final description = _field(fields, 10);
    if (description != null) _decodeUtf8(description.value, 'description');
    if (amountMsat != null &&
        (description == null || description.value.isEmpty)) {
      throw const FormatException(
        'A fixed offer requires a non-empty description',
      );
    }
    final issuer = _field(fields, 18);
    if (issuer != null) _decodeUtf8(issuer.value, 'issuer');

    final features = _field(fields, 12)?.value;
    if (features != null) _validateFeatures(features);

    final expiryValue = _field(fields, 14);
    final expiry = expiryValue == null ? null : _tu64(expiryValue.value);
    final expired = expiry != null &&
        !now().toUtc().isBefore(
              DateTime.fromMillisecondsSinceEpoch(expiry * 1000, isUtc: true),
            );

    final quantityField = _field(fields, 20);
    final quantityMax =
        quantityField == null ? null : _tu64(quantityField.value);
    if (quantityMax != null && quantityMax != 1) {
      throw const FormatException(
          'Only quantity 1 BOLT12 offers are supported');
    }
    if (_field(fields, 16) == null && _field(fields, 22) == null) {
      throw const FormatException('Offer has no issuer id or blinded path');
    }
    final issuerId = _field(fields, 22);
    if (issuerId != null &&
        (issuerId.value.length != 33 ||
            (issuerId.value.first != 2 && issuerId.value.first != 3))) {
      throw const FormatException('Invalid offer_issuer_id');
    }

    return Bolt12OfferInfo(
      normalized: normalized,
      offerId: hex.encode(_merkleRoot(fields)),
      network: expectedNetwork,
      amountMsat: amountMsat,
      isExpired: expired,
      isVariableAmount: amountMsat == null,
      quantityMax: quantityMax,
    );
  }

  static String normalize(String input) {
    var value = input.trim();
    final lower = value.toLowerCase();
    if (lower.startsWith('lightning:')) {
      value = value.substring('lightning:'.length).trim();
    } else if (lower.startsWith('bitcoin:')) {
      final uri = Uri.parse(value);
      final required = uri.queryParametersAll.keys
          .where((key) => key.toLowerCase().startsWith('req-'));
      if (required.isNotEmpty) {
        throw FormatException(
            'Unsupported required BIP-321 parameter ${required.first}');
      }
      final offers = uri.queryParametersAll['lno'];
      if (offers == null || offers.length != 1 || offers.single.isEmpty) {
        throw const FormatException('BIP-321 URI must contain one lno');
      }
      value = offers.single.trim();
    }

    value = value.replaceAllMapped(
      RegExp(
          r'([02-9ac-hj-np-zAC-HJ-NP-Z])\+\s*(?=[02-9ac-hj-np-zAC-HJ-NP-Z])'),
      (match) => match.group(1)!,
    );
    if (value.contains('+')) {
      throw const FormatException('Invalid BOLT12 continuation marker');
    }
    if (RegExp(r'\s').hasMatch(value)) {
      throw const FormatException(
          'Whitespace requires a BOLT12 continuation marker');
    }
    final hasLower = RegExp('[a-z]').hasMatch(value);
    final hasUpper = RegExp('[A-Z]').hasMatch(value);
    if (hasLower && hasUpper) {
      throw const FormatException('Mixed-case BOLT12 encoding');
    }
    value = value.toLowerCase();
    if (!value.startsWith('lno1')) {
      throw const FormatException('Expected a BOLT12 lno offer');
    }
    return value;
  }

  static _TlvField? _field(List<_TlvField> fields, int type) {
    final matches = fields.where((field) => field.type == type).toList();
    if (matches.length > 1)
      throw FormatException('Duplicate BOLT12 field $type');
    return matches.firstOrNull;
  }

  static List<_TlvField> _parseTlv(Uint8List bytes) {
    final fields = <_TlvField>[];
    var offset = 0;
    int? previous;
    while (offset < bytes.length) {
      final typeRead = _bigSize(bytes, offset);
      offset = typeRead.next;
      final lengthRead = _bigSize(bytes, offset);
      offset = lengthRead.next;
      if (lengthRead.value > bytes.length - offset) {
        throw const FormatException('Truncated BOLT12 TLV field');
      }
      if (previous != null && typeRead.value <= previous) {
        throw const FormatException('BOLT12 TLVs must be strictly ordered');
      }
      final raw = Uint8List.fromList(
        bytes.sublist(typeRead.start, offset + lengthRead.value),
      );
      final value = Uint8List.fromList(
        bytes.sublist(offset, offset + lengthRead.value),
      );
      fields.add(_TlvField(typeRead.value, value, raw, typeRead.encoded));
      previous = typeRead.value;
      offset += lengthRead.value;
    }
    return fields;
  }

  static ({int value, int start, int next, Uint8List encoded}) _bigSize(
    Uint8List bytes,
    int offset,
  ) {
    if (offset >= bytes.length)
      throw const FormatException('Truncated bigsize');
    final start = offset;
    final marker = bytes[offset++];
    int value;
    int length;
    if (marker < 0xfd) {
      value = marker;
      length = 1;
    } else {
      length = marker == 0xfd
          ? 2
          : marker == 0xfe
              ? 4
              : 8;
      if (offset + length > bytes.length) {
        throw const FormatException('Truncated bigsize');
      }
      value = 0;
      for (var i = 0; i < length; i++) value = value * 256 + bytes[offset + i];
      if ((length == 2 && value < 0xfd) ||
          (length == 4 && value < 0x10000) ||
          (length == 8 && value < 0x100000000)) {
        throw const FormatException('Non-minimal bigsize');
      }
      offset += length;
      length++;
    }
    return (
      value: value,
      start: start,
      next: offset,
      encoded: Uint8List.fromList(bytes.sublist(start, start + length)),
    );
  }

  static int _tu64(Uint8List bytes) {
    if (bytes.length > 8 || (bytes.isNotEmpty && bytes.first == 0)) {
      throw const FormatException('Invalid truncated u64');
    }
    var value = 0;
    for (final byte in bytes) value = value * 256 + byte;
    return value;
  }

  static String _decodeUtf8(Uint8List bytes, String field) {
    try {
      return utf8.decode(bytes, allowMalformed: false);
    } on FormatException {
      throw FormatException('Invalid UTF-8 in BOLT12 $field');
    }
  }

  static void _validateFeatures(Uint8List bytes) {
    // BOLT12 defines no compulsory offer-only feature needed by BitBlik today.
    // Unknown odd bits are optional; any even bit is compulsory and is rejected.
    for (var byteIndex = 0; byteIndex < bytes.length; byteIndex++) {
      final byte = bytes[bytes.length - 1 - byteIndex];
      for (var bit = 0; bit < 8; bit++) {
        final index = byteIndex * 8 + bit;
        if (byte & (1 << bit) != 0 && index.isEven) {
          throw FormatException(
              'Unsupported required BOLT12 feature bit $index');
        }
      }
    }
  }

  static Uint8List _merkleRoot(List<_TlvField> fields) {
    final first = fields.first.raw;
    final nodes = <Uint8List>[];
    for (final field in fields) {
      final leaf = _taggedHash(utf8.encode('LnLeaf'), field.raw);
      final nonceTag =
          Uint8List.fromList([...utf8.encode('LnNonce'), ...first]);
      final nonce = _taggedHash(nonceTag, field.typeEncoding);
      nodes.add(_branch(leaf, nonce));
    }
    return _merkle(nodes);
  }

  static Uint8List _merkle(List<Uint8List> nodes) {
    if (nodes.length == 1) return nodes.single;
    var split = 1;
    while (split * 2 < nodes.length) split *= 2;
    return _branch(
      _merkle(nodes.sublist(0, split)),
      _merkle(nodes.sublist(split)),
    );
  }

  static Uint8List _branch(Uint8List a, Uint8List b) {
    final compare = _compareBytes(a, b);
    return _taggedHash(
      utf8.encode('LnBranch'),
      Uint8List.fromList(compare <= 0 ? [...a, ...b] : [...b, ...a]),
    );
  }

  static int _compareBytes(Uint8List a, Uint8List b) {
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return a[i] - b[i];
    }
    return 0;
  }

  static Uint8List _taggedHash(List<int> tag, List<int> message) {
    final tagHash = sha256.convert(tag).bytes;
    return Uint8List.fromList(
      sha256.convert([...tagHash, ...tagHash, ...message]).bytes,
    );
  }

  static Uint8List _convertBits(
    List<int> data,
    int from,
    int to, {
    required bool pad,
  }) {
    var accumulator = 0;
    var bits = 0;
    final result = <int>[];
    final maxValue = (1 << to) - 1;
    for (final value in data) {
      if (value < 0 || value >> from != 0) {
        throw const FormatException('Invalid BOLT12 data word');
      }
      accumulator = (accumulator << from) | value;
      bits += from;
      while (bits >= to) {
        bits -= to;
        result.add((accumulator >> bits) & maxValue);
      }
    }
    if (pad && bits > 0) result.add((accumulator << (to - bits)) & maxValue);
    if (!pad &&
        (bits >= from || ((accumulator << (to - bits)) & maxValue) != 0)) {
      throw const FormatException('Invalid BOLT12 padding');
    }
    return Uint8List.fromList(result);
  }
}

class _TlvField {
  final int type;
  final Uint8List value;
  final Uint8List raw;
  final Uint8List typeEncoding;

  const _TlvField(this.type, this.value, this.raw, this.typeEncoding);
}

extension<T> on Iterable<T> {
  T? get firstOrNull {
    final iterator = this.iterator;
    return iterator.moveNext() ? iterator.current : null;
  }
}
