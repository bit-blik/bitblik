import 'package:bitblik_core/core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_webrtc_zxing/flutter_webrtc_zxing.dart' as zxing;
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../i18n/gen/strings.g.dart';
import '../../widgets/full_frame_qr_scanner.dart';
import 'twint_cloud_ocr.dart';
import 'twint_screenshot_ocr.dart';

class TwintScanResult {
  final String? code;
  final double? amount;
  final String? rawQr;

  const TwintScanResult({this.code, this.amount, this.rawQr});
}

@visibleForTesting
bool shouldCompleteTwintCameraScan(
  TwintScanResult result, {
  required bool scanAmount,
  required bool acceptShopQr,
  required int amountOcrAttempts,
  int maxAmountOcrAttempts = 6,
}) {
  if (acceptShopQr && TwintShopQr.tryParse(result.rawQr ?? '') != null) {
    return true;
  }
  if (result.code == null) return false;
  if (!scanAmount || result.amount != null) return true;
  return amountOcrAttempts >= maxAmountOcrAttempts;
}

final _twintCodePattern = RegExp(r'(?<!\d)(\d{5}|\d(?:[\s-]+\d){4})(?!\d)');
final _twintAmountPattern = RegExp(
  r'(?:CHF|Fr\.?)\s*([0-9]+(?:[.,][0-9]{1,2})?)|([0-9]+(?:[.,][0-9]{1,2})?)\s*(?:CHF|Fr\.?)',
  caseSensitive: false,
);
final _twintFallbackDecimalPattern = RegExp(
  r'(?<!\d)([0-9]{1,4}[.,][0-9]{1,2})(?!\d)',
);

TwintScanResult? parseTwintScreenshotText(
  String text, {
  required bool scanAmount,
}) {
  final code = _twintCodePattern
      .firstMatch(text)
      ?.group(1)
      ?.replaceAll(RegExp(r'[^0-9]'), '');
  final directMatch = _twintAmountPattern.firstMatch(text);
  final rawAmount =
      directMatch?.group(1) ??
      directMatch?.group(2) ??
      _twintFallbackDecimalPattern.firstMatch(text)?.group(1);
  final amount = scanAmount && rawAmount != null
      ? double.tryParse(rawAmount.replaceAll(',', '.'))
      : null;
  return code == null && amount == null
      ? null
      : TwintScanResult(code: code, amount: amount);
}

Future<TwintScanResult?> importTwintScreenshot({
  required bool scanAmount,
  Future<bool> Function()? allowOnlineOcrUpload,
}) async {
  final image = await FilePicker.pickFile(type: FileType.image);
  if (image == null) return null;
  var result = await readTwintScreenshot(image, scanAmount: scanAmount);
  if (scanAmount &&
      result?.amount == null &&
      allowOnlineOcrUpload != null &&
      await allowOnlineOcrUpload()) {
    final text = await recognizeTwintScreenshotOnline(image);
    final online = parseTwintScreenshotText(text ?? '', scanAmount: true);
    if (online != null) {
      result = TwintScanResult(
        code: result?.code ?? online.code,
        amount: result?.amount ?? online.amount,
        rawQr: result?.rawQr,
      );
    }
  }
  return result;
}

Future<TwintScanResult?> readTwintScreenshot(
  PlatformFile image, {
  required bool scanAmount,
}) async {
  final qr = await zxing.zx.readBarcodeImagePath(
    image.xFile,
    zxing.DecodeParams(
      // The native image-path reader converts decoded pixels to RGB bytes.
      imageFormat: zxing.ImageFormat.rgb,
      format: zxing.Format.qrCode,
      tryHarder: true,
      tryRotate: true,
      tryInverted: true,
      tryDownscale: true,
      maxSize: 4096,
    ),
  );
  var result = parseTwintScreenshotText(qr.text ?? '', scanAmount: false);
  final supportsNativeOcr =
      !kIsWeb &&
      (defaultTargetPlatform == TargetPlatform.android ||
          defaultTargetPlatform == TargetPlatform.iOS);
  if (supportsNativeOcr && image.path != null) {
    final recognizer = TextRecognizer();
    try {
      final recognized = await recognizer.processImage(
        InputImage.fromFilePath(image.path!),
      );
      final ocr = parseTwintScreenshotText(
        recognized.text,
        scanAmount: scanAmount,
      );
      result = TwintScanResult(
        code: result?.code ?? ocr?.code,
        amount: ocr?.amount,
        rawQr: qr.text,
      );
    } finally {
      recognizer.close();
    }
  } else if (kIsWeb) {
    final text = await recognizeTwintScreenshotImage(await image.readAsBytes());
    final ocr = parseTwintScreenshotText(text ?? '', scanAmount: scanAmount);
    result = TwintScanResult(
      code: result?.code ?? ocr?.code,
      amount: ocr?.amount,
      rawQr: qr.text,
    );
  }
  return result?.code != null || result?.amount != null || qr.text != null
      ? TwintScanResult(
          code: result?.code,
          amount: result?.amount,
          rawQr: qr.text,
        )
      : null;
}

class TwintCodeScannerScreen extends StatefulWidget {
  /// When false, only the 5-digit code is scanned (no amount OCR) and the
  /// scanner keeps running until a code is found — used by the re-code flow
  /// where the amount is fixed.
  final bool scanAmount;
  final bool acceptShopQr;

  const TwintCodeScannerScreen({
    super.key,
    this.scanAmount = true,
    this.acceptShopQr = false,
  });

  @override
  State<TwintCodeScannerScreen> createState() => _TwintCodeScannerScreenState();
}

class _TwintCodeScannerScreenState extends State<TwintCodeScannerScreen> {
  static const _maxAmountOcrAttempts = 6;

  MobileScannerController? _controller;
  final TextRecognizer _textRecognizer = TextRecognizer();

  bool _isHandlingCapture = false;
  _TwintScannerStatus _status = _TwintScannerStatus.align;
  String? _pendingCode;
  double? _pendingAmount;
  String? _pendingRawQr;
  int _amountOcrAttempts = 0;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      _controller = MobileScannerController(
        formats: const [BarcodeFormat.qrCode],
        detectionSpeed: DetectionSpeed.normal,
        returnImage: true,
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _handleDetect(BarcodeCapture capture) async {
    if (_isHandlingCapture || !mounted) return;
    _isHandlingCapture = true;

    try {
      final qrValue = capture.barcodes
          .map((barcode) => barcode.rawValue ?? '')
          .firstWhere((value) => value.trim().isNotEmpty, orElse: () => '');

      _pendingRawQr = qrValue.isEmpty ? _pendingRawQr : qrValue;
      _pendingCode ??= parseTwintScreenshotText(
        qrValue,
        scanAmount: false,
      )?.code;

      if (widget.acceptShopQr && TwintShopQr.tryParse(qrValue) != null) {
        await _returnResult(TwintScanResult(rawQr: qrValue));
        return;
      }

      if (!kIsWeb && capture.image != null && capture.size != Size.zero) {
        final recognizedText = await _textRecognizer.processImage(
          InputImage.fromBitmap(
            bitmap: capture.image!,
            width: capture.size.width.round(),
            height: capture.size.height.round(),
          ),
        );
        final parsed = parseTwintScreenshotText(
          recognizedText.text,
          scanAmount: widget.scanAmount,
        );
        _pendingCode ??= parsed?.code;
        _pendingAmount ??= parsed?.amount;
      }

      if (_pendingCode != null && widget.scanAmount && _pendingAmount == null) {
        _amountOcrAttempts++;
      }
      final result = TwintScanResult(
        code: _pendingCode,
        amount: _pendingAmount,
        rawQr: _pendingRawQr,
      );
      if (_cameraResultReady(result)) {
        if (!mounted) return;
        await _returnResult(result);
        return;
      }

      if (mounted) {
        setState(() {
          _status = _pendingCode == null
              ? _TwintScannerStatus.notRecognized
              : _TwintScannerStatus.amountFailed;
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _status = _TwintScannerStatus.amountFailed;
        });
      }
    } finally {
      _isHandlingCapture = false;
    }
  }

  bool _cameraResultReady(TwintScanResult result) {
    return shouldCompleteTwintCameraScan(
      result,
      scanAmount: widget.scanAmount,
      acceptShopQr: widget.acceptShopQr,
      amountOcrAttempts: _amountOcrAttempts,
      maxAmountOcrAttempts: _maxAmountOcrAttempts,
    );
  }

  Future<bool> _inspectWebScanFrame(String raw, Uint8List frameBytes) async {
    _pendingRawQr = raw;
    _pendingCode ??= parseTwintScreenshotText(raw, scanAmount: false)?.code;
    if (widget.acceptShopQr && TwintShopQr.tryParse(raw) != null) return true;

    final text = await recognizeTwintScreenshotImage(frameBytes);
    final parsed = parseTwintScreenshotText(
      text ?? '',
      scanAmount: widget.scanAmount,
    );
    _pendingCode ??= parsed?.code;
    _pendingAmount ??= parsed?.amount;
    if (_pendingCode != null && widget.scanAmount && _pendingAmount == null) {
      _amountOcrAttempts++;
    }
    final ready = _cameraResultReady(
      TwintScanResult(
        code: _pendingCode,
        amount: _pendingAmount,
        rawQr: _pendingRawQr,
      ),
    );
    if (mounted && !ready) {
      setState(() {
        _status = _pendingCode == null
            ? _TwintScannerStatus.notRecognized
            : _TwintScannerStatus.amountFailed;
      });
    }
    return ready;
  }

  void _handleWebScan(String raw) {
    if (!mounted || _isHandlingCapture) return;
    final result = TwintScanResult(
      code:
          _pendingCode ??
          parseTwintScreenshotText(raw, scanAmount: false)?.code,
      amount: _pendingAmount,
      rawQr: raw,
    );
    if (!_cameraResultReady(result)) {
      setState(() => _status = _TwintScannerStatus.notRecognized);
      return;
    }
    _isHandlingCapture = true;
    _returnResult(result);
  }

  void _handleWebError(Object _) {
    if (mounted) {
      setState(() => _status = _TwintScannerStatus.amountFailed);
    }
  }

  Future<void> _returnResult(TwintScanResult result) async {
    // Image imports have no controller on web, so stopping stays optional.
    await _controller?.stop();
    if (mounted) Navigator.of(context).pop(result);
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    const codeLabel = 'TWINT';
    final statusText = switch (_status) {
      _TwintScannerStatus.align => t.twint.scanner.status.align(
        code: codeLabel,
      ),
      _TwintScannerStatus.notRecognized => t.twint.scanner.status.notRecognized(
        code: codeLabel,
      ),
      _TwintScannerStatus.amountFailed => t.twint.scanner.status.amountFailed,
    };
    return Scaffold(
      appBar: AppBar(title: Text(t.twint.scanner.title(code: codeLabel))),
      body: Stack(
        children: [
          if (kIsWeb)
            FullFrameQrScanner(
              onScan: _handleWebScan,
              onError: _handleWebError,
              shouldAcceptScan: _inspectWebScanFrame,
            )
          else
            MobileScanner(controller: _controller!, onDetect: _handleDetect),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              color: Colors.black87,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    statusText,
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _TwintScannerStatus { align, notRecognized, amountFailed }
