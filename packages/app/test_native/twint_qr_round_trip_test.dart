import 'dart:io';

import 'package:bitblik/src/utils/twint_qr_image.dart';
import 'package:bitblik/src/widgets/full_frame_qr_scanner.dart';
import 'package:flutter_test/flutter_test.dart';

// Like full_frame_qr_scanner_test.dart, requires the built native ZXing library
// on LD_LIBRARY_PATH. The real decoder verifies exported pixels independently
// of the QR encoder. This does not prove acceptance by a TWINT banking app.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('exported shop PNG decodes into the complete original payload', () {
    const payloads = [
      'Q4SIXZB8VXJ5000000000710CHF00025837',
      'Q4SIXZB8VXJ5000000000710CHF00025838',
    ];
    for (final payload in payloads) {
      final png = renderTwintQrPng(payload);
      expect(decodeLinuxQrFrame(png), payload);
      final output = Platform.environment['TWINT_QR_ARTIFACT_DIR'];
      if (output != null) {
        File(
          '$output/twint-${payloads.indexOf(payload)}.png',
        ).writeAsBytesSync(png);
      }
    }
  });

  final browserPng = Platform.environment['TWINT_QR_BROWSER_PNG'];
  if (browserPng != null) {
    test('browser-downloaded PNG preserves the scanned payload', () {
      expect(
        decodeLinuxQrFrame(File(browserPng).readAsBytesSync()),
        'Q4SIXZB8VXJ5000000000710CHF00025837',
      );
    });
  }
}
