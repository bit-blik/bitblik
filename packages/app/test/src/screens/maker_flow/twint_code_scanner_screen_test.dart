import 'package:bitblik/src/screens/maker_flow/twint_code_scanner_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('parses screenshot OCR text containing code and CHF amount', () {
    final result = parseTwintScreenshotText(
      'TWINT\nCode 12345\nTotal CHF 17.90',
      scanAmount: true,
    );

    expect(result?.code, '12345');
    expect(result?.amount, 17.90);
  });

  test('parses spaced five-digit code from TWINT screenshot OCR', () {
    final result = parseTwintScreenshotText(
      'CHF 9.90\n5 4 5 7 6',
      scanAmount: true,
    );

    expect(result?.code, '54576');
    expect(result?.amount, 9.90);
  });

  test('does not accept amount when re-code flow only needs code', () {
    final result = parseTwintScreenshotText(
      '12345 Fr. 17,90',
      scanAmount: false,
    );

    expect(result?.code, '12345');
    expect(result?.amount, isNull);
  });

  test('rejects unrelated screenshot text', () {
    expect(
      parseTwintScreenshotText('Order 1234 complete', scanAmount: true),
      isNull,
    );
  });

  test('keeps camera open after code so amount OCR gets more frames', () {
    const codeOnly = TwintScanResult(code: '12345', rawQr: '12345');
    const complete = TwintScanResult(
      code: '12345',
      amount: 17.90,
      rawQr: '12345',
    );

    expect(
      shouldCompleteTwintCameraScan(
        codeOnly,
        scanAmount: true,
        acceptShopQr: false,
        amountOcrAttempts: 1,
      ),
      isFalse,
    );
    expect(
      shouldCompleteTwintCameraScan(
        complete,
        scanAmount: true,
        acceptShopQr: false,
        amountOcrAttempts: 1,
      ),
      isTrue,
    );
    expect(
      shouldCompleteTwintCameraScan(
        codeOnly,
        scanAmount: true,
        acceptShopQr: false,
        amountOcrAttempts: 6,
      ),
      isTrue,
    );
  });
}
