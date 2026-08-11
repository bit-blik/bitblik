import 'package:bitblik_core/core.dart';
import 'package:bip340/bip340.dart' as bip340;
import 'package:test/test.dart';

void main() {
  group('generateSecp256k1PrivateKeyHex', () {
    test('produces 64-char lowercase hex in the valid scalar range', () {
      for (var i = 0; i < 200; i++) {
        final key = generateSecp256k1PrivateKeyHex();
        expect(key, matches(RegExp(r'^[0-9a-f]{64}$')));
        expect(isValidSecp256k1PrivateKeyHex(key), isTrue);
      }
    });

    test('never repeats (CSPRNG uniqueness over a sample)', () {
      final keys =
          List.generate(500, (_) => generateSecp256k1PrivateKeyHex()).toSet();
      expect(keys.length, 500);
    });

    test('every generated key derives a public key via bip340', () {
      for (var i = 0; i < 50; i++) {
        final key = generateSecp256k1PrivateKeyHex();
        expect(bip340.getPublicKey(key), matches(RegExp(r'^[0-9a-f]{64}$')));
      }
    });
  });

  group('isValidSecp256k1PrivateKeyHex', () {
    test('accepts boundary scalars 1 and n-1', () {
      expect(
          isValidSecp256k1PrivateKeyHex(
              '0000000000000000000000000000000000000000000000000000000000000001'),
          isTrue);
      expect(
          isValidSecp256k1PrivateKeyHex(
              'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364140'),
          isTrue);
    });

    test('rejects zero, n, and n+1', () {
      expect(
          isValidSecp256k1PrivateKeyHex(
              '0000000000000000000000000000000000000000000000000000000000000000'),
          isFalse);
      expect(
          isValidSecp256k1PrivateKeyHex(
              'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141'),
          isFalse);
      expect(
          isValidSecp256k1PrivateKeyHex(
              'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364142'),
          isFalse);
    });

    test('rejects 2^256-1 (all-ff) and oversized encodings', () {
      expect(
          isValidSecp256k1PrivateKeyHex(
              'ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff'),
          isFalse);
      expect(
          isValidSecp256k1PrivateKeyHex(
              '1${'0' * 64}'), // 65 hex chars
          isFalse);
    });

    test('rejects bad shape: short, long, non-hex, empty', () {
      expect(isValidSecp256k1PrivateKeyHex('abcd'), isFalse);
      expect(isValidSecp256k1PrivateKeyHex(''), isFalse);
      expect(
          isValidSecp256k1PrivateKeyHex(
              'zzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzzz'),
          isFalse);
    });

    test('accepts uppercase hex (normalization is the caller\'s job)', () {
      expect(
          isValidSecp256k1PrivateKeyHex(
              'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
          isTrue);
    });
  });

  group('requireValidSecp256k1PrivateKeyHex', () {
    test('returns normalized lowercase for valid input', () {
      expect(
          requireValidSecp256k1PrivateKeyHex(
              'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA'),
          'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa');
    });

    test('throws on invalid input', () {
      expect(() => requireValidSecp256k1PrivateKeyHex(''),
          throwsA(isA<FormatException>()));
      expect(
          () => requireValidSecp256k1PrivateKeyHex(
              '0000000000000000000000000000000000000000000000000000000000000000'),
          throwsA(isA<FormatException>()));
      expect(
          () => requireValidSecp256k1PrivateKeyHex(
              'FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBAAEDCE6AF48A03BBFD25E8CD0364141'),
          throwsA(isA<FormatException>()));
    });
  });
}
