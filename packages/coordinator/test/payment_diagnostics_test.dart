import 'package:bitblik_coordinator/src/services/payment_diagnostics.dart';
import 'package:test/test.dart';

void main() {
  test('retains useful errors while stripping credentials and proofs', () {
    final proof = 'ab' * 32;
    final result = redactPaymentDiagnostic(
      'InvoiceRequestExpired FAILED_PRECONDITION '
      'authorization: Bearer sensitive-value token=another-secret '
      '"password": "quoted password" '
      'nostr+walletconnect://wallet?secret=secret '
      'https://user:password@example.com lno1abcdefgh $proof known-proof',
      secrets: ['known-proof'],
    );
    expect(result, contains('InvoiceRequestExpired FAILED_PRECONDITION'));
    for (final secret in [
      'sensitive-value',
      'another-secret',
      'quoted password',
      'wallet?',
      'example.com',
      'lno1abcdefgh',
      proof,
      'known-proof'
    ]) {
      expect(result, isNot(contains(secret)));
    }
  });

  test('bounds backend error size', () {
    expect(redactPaymentDiagnostic('x' * 15000), endsWith('[truncated]'));
  });
}
