import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../i18n/gen/strings.g.dart';
import 'twint_web_ocr_stub.dart'
    if (dart.library.js_interop) 'twint_web_ocr.dart';

class TwintScanResult {
  final String? code;
  final double? amount;

  const TwintScanResult({this.code, this.amount});
}

class TwintCodeScannerScreen extends StatefulWidget {
  /// When false, only the 5-digit code is scanned (no amount OCR) and the
  /// scanner keeps running until a code is found — used by the re-code flow
  /// where the amount is fixed.
  final bool scanAmount;

  const TwintCodeScannerScreen({super.key, this.scanAmount = true});

  @override
  State<TwintCodeScannerScreen> createState() => _TwintCodeScannerScreenState();
}

class _TwintCodeScannerScreenState extends State<TwintCodeScannerScreen> {
  static final RegExp _codePattern = RegExp(r'(?<!\d)(\d{5})(?!\d)');
  static final RegExp _amountPattern = RegExp(
    r'(?:CHF|Fr\.?)\s*([0-9]+(?:[.,][0-9]{1,2})?)|([0-9]+(?:[.,][0-9]{1,2})?)\s*(?:CHF|Fr\.?)',
    caseSensitive: false,
  );
  static final RegExp _fallbackDecimalPattern = RegExp(
    r'(?<!\d)([0-9]{1,4}[.,][0-9]{1,2})(?!\d)',
  );

  final MobileScannerController _controller = MobileScannerController(
    formats: const [BarcodeFormat.qrCode],
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: !kIsWeb,
  );
  final TextRecognizer _textRecognizer = TextRecognizer();

  bool _isHandlingCapture = false;
  bool _isFinished = false;
  _TwintScannerStatus _status = _TwintScannerStatus.align;

  // Web-only: mobile_scanner exposes no frame pixels and MLKit is native-only,
  // so on web the QR code comes from mobile_scanner while the amount is OCR'd
  // from snapshots of the <video> element via tesseract.js on a polling loop.
  Timer? _webOcrTimer;
  bool _webOcrBusy = false;
  String? _webCode;

  @override
  void initState() {
    super.initState();
    if (kIsWeb && widget.scanAmount) {
      twintOcrPreload();
      _webOcrTimer = Timer.periodic(
        const Duration(milliseconds: 1500),
        (_) => _webOcrTick(),
      );
    }
  }

  @override
  void dispose() {
    _webOcrTimer?.cancel();
    _controller.dispose();
    _textRecognizer.close();
    super.dispose();
  }

  Future<void> _handleDetect(BarcodeCapture capture) async {
    if (_isHandlingCapture || _isFinished || !mounted) return;
    _isHandlingCapture = true;

    try {
      final qrValue = capture.barcodes
          .map((barcode) => barcode.rawValue ?? '')
          .firstWhere((value) => value.trim().isNotEmpty, orElse: () => '');

      final code = _extractCode(qrValue);

      if (kIsWeb) {
        if (code == null) return;
        if (!widget.scanAmount) {
          await _finish(code: code, amount: null);
          return;
        }
        // Have the code; the amount arrives from the OCR polling loop. Keep the
        // scanner running until then (or the user taps "use code only").
        if (mounted && _webCode == null) {
          setState(() {
            _webCode = code;
            _status = _TwintScannerStatus.scanningAmount;
          });
        } else {
          _webCode ??= code;
        }
        return;
      }

      // Native: single-shot OCR from the returned camera frame.
      double? amount;
      String? resolvedCode = code;
      if (capture.image != null && capture.size != Size.zero) {
        final recognizedText = await _textRecognizer.processImage(
          InputImage.fromBitmap(
            bitmap: capture.image!,
            width: capture.size.width.round(),
            height: capture.size.height.round(),
          ),
        );
        final ocrText = recognizedText.text;
        resolvedCode ??= _extractCode(ocrText);
        if (widget.scanAmount) {
          amount = _extractAmount(ocrText);
        }
      }

      if (resolvedCode != null || amount != null) {
        await _finish(code: resolvedCode, amount: amount);
        return;
      }

      if (mounted) {
        setState(() {
          _status = _TwintScannerStatus.notRecognized;
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

  Future<void> _webOcrTick() async {
    if (_webOcrBusy || _isFinished || !mounted) return;
    _webOcrBusy = true;
    try {
      final text = await twintOcrSnapshot();
      if (text.isEmpty || !mounted || _isFinished) return;
      // mobile_scanner is more reliable for the QR code, but fall back to OCR
      // for the code too in case the QR read never fired.
      _webCode ??= _extractCode(text);
      final amount = _extractAmount(text);
      if (_webCode != null && amount != null) {
        await _finish(code: _webCode, amount: amount);
      } else if (_webCode != null &&
          _status != _TwintScannerStatus.scanningAmount &&
          mounted) {
        setState(() => _status = _TwintScannerStatus.scanningAmount);
      }
    } catch (_) {
      // Keep polling; a single failed frame should not stop the loop.
    } finally {
      _webOcrBusy = false;
    }
  }

  Future<void> _finish({String? code, double? amount}) async {
    if (_isFinished || !mounted) return;
    _isFinished = true;
    _webOcrTimer?.cancel();
    // On web the camera renders via an HtmlElementView platform view; stop it
    // and let teardown settle before popping, otherwise mobile browsers leave
    // the previous route painted white.
    await _controller.stop();
    if (!mounted) return;
    Navigator.of(context).pop(TwintScanResult(code: code, amount: amount));
  }

  String? _extractCode(String text) {
    final match = _codePattern.firstMatch(text);
    return match?.group(1);
  }

  double? _extractAmount(String text) {
    final directMatch = _amountPattern.firstMatch(text);
    final raw =
        directMatch?.group(1) ??
        directMatch?.group(2) ??
        _fallbackDecimalPattern.firstMatch(text)?.group(1);
    if (raw == null) return null;
    return double.tryParse(raw.replaceAll(',', '.'));
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    const codeLabel = 'TWINT';
    final statusText = switch (_status) {
      _TwintScannerStatus.align => t.twint.scanner.status.align(code: codeLabel),
      _TwintScannerStatus.scanningAmount =>
        t.twint.scanner.status.scanningAmount,
      _TwintScannerStatus.notRecognized =>
        t.twint.scanner.status.notRecognized(code: codeLabel),
      _TwintScannerStatus.amountFailed => t.twint.scanner.status.amountFailed,
    };
    // Once the code is known on web but the amount OCR has not resolved, let the
    // user proceed with the code alone and fill the amount manually.
    final showUseCodeOnly = kIsWeb && _webCode != null && !_isFinished;
    return Scaffold(
      appBar: AppBar(title: Text(t.twint.scanner.title(code: codeLabel))),
      body: Stack(
        children: [
          MobileScanner(controller: _controller, onDetect: _handleDetect),
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
                  if (showUseCodeOnly) ...[
                    const SizedBox(height: 12),
                    OutlinedButton(
                      onPressed: () =>
                          _finish(code: _webCode, amount: null),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white70),
                      ),
                      child: Text(t.twint.scanner.status.useCodeOnly),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _TwintScannerStatus { align, scanningAmount, notRecognized, amountFailed }
