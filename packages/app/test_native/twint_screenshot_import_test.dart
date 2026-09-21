import 'dart:io';

import 'package:bitblik/src/screens/maker_flow/twint_code_scanner_screen.dart';
import 'package:bitblik/src/utils/twint_qr_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart' show XFile;

final class _PickedImage extends PlatformFile {
  _PickedImage(this.file);
  final File file;

  @override
  String get name => 'payment.png';
  @override
  Uri get uri => file.uri;
  @override
  XFile get xFile => XFile(file.path);
  @override
  int lengthSync() => file.lengthSync();
  @override
  Future<int> length() => file.length();
  @override
  Future<Uint8List> readAsBytes() => file.readAsBytes();
  @override
  Stream<Uint8List> readAsByteStream() =>
      file.openRead().map(Uint8List.fromList);
}

// Uses the real native ZXing image-file decoder; see test_native/README.md.
// Mock only ML Kit's platform response to reproduce amount-only Android OCR.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('google_mlkit_text_recognizer');
  late Directory temp;

  setUp(() async {
    temp = await Directory.systemTemp.createTemp('twint-import-test-');
    debugDefaultTargetPlatformOverride = TargetPlatform.android;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          if (call.method == 'vision#startTextRecognizer') {
            return {'text': 'CHF 9.90', 'blocks': <Object>[]};
          }
          return null;
        });
  });

  tearDown(() async {
    debugDefaultTargetPlatformOverride = null;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
    await temp.delete(recursive: true);
  });

  Future<TwintScanResult?> readImage(File file) async {
    return readTwintScreenshot(_PickedImage(file), scanAmount: true);
  }

  test(
    'image QR fills online code when Android OCR returns only amount',
    () async {
      final file = File('${temp.path}/online.png');
      await file.writeAsBytes(renderTwintQrPng('54576'));
      final result = await readImage(file);
      expect(result?.rawQr, '54576');
      expect(result?.code, '54576');
      expect(result?.amount, 9.90);
    },
  );

  test('image import preserves complete shop QR payload', () async {
    const payload = 'Q4SIXZB8VXJ5000000000710CHF00025837';
    final file = File('${temp.path}/shop.png');
    await file.writeAsBytes(renderTwintQrPng(payload));
    expect((await readImage(file))?.rawQr, payload);
  });

  final screenshot = Platform.environment['TWINT_IMPORT_SCREENSHOT'];
  if (screenshot != null) {
    test(
      'original screenshot QR supplies 54576 independently of OCR',
      () async {
        final result = await readImage(File(screenshot));
        expect(result?.rawQr, isNotEmpty);
        expect(result?.code, '54576');
        expect(result?.amount, 9.90);
      },
    );
  }
}
