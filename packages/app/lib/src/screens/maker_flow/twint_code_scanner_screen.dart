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
  // once (per attempt) from a snapshot of the <video> element via tesseract.js.
  // A polling loop was too heavy: it starved the mobile-web camera and pegged
  // the CPU on desktop, so OCR now runs single-shot, triggered by QR detection.
  String? _webCode;
  bool _webOcrRunning = false;

  @override
  void initState() {
    super.initState();
    if (kIsWeb && widget.scanAmount) {
      // Warm the OCR worker (compiles ~3MB of wasm) AFTER the camera has had a
      // chance to start. Doing it synchronously here blocks the mobile-web
      // camera platform view and leaves the scanner painted grey.
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted && !_isFinished) twintOcrPreload();
      });
    }
  }

  @override
  void dispose() {
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
        // Have the code. Run the amount OCR once on the current frame; the user
        // can retry or proceed without the amount from the on-screen buttons.
        final firstCode = _webCode == null;
        _webCode ??= code;
        if (firstCode && mounted) {
          setState(() => _status = _TwintScannerStatus.scanningAmount);
          unawaited(_runWebAmountOcr());
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

  /// Web single-shot amount OCR of the current camera frame. Triggered by QR
  /// detection and by the manual "scan amount again" button.
  Future<void> _runWebAmountOcr() async {
    if (_webOcrRunning || _isFinished || !mounted) return;
    setState(() {
      _webOcrRunning = true;
      _status = _TwintScannerStatus.scanningAmount;
    });
    try {
      final text = await twintOcrSnapshot();
      if (!mounted || _isFinished) return;
      final amount = _extractAmount(text);
      if (amount != null) {
        await _finish(code: _webCode, amount: amount);
        return;
      }
      setState(() => _status = _TwintScannerStatus.amountFailed);
    } catch (_) {
      if (mounted) setState(() => _status = _TwintScannerStatus.amountFailed);
    } finally {
      if (mounted && !_isFinished) setState(() => _webOcrRunning = false);
    }
  }

  Future<void> _finish({String? code, double? amount}) async {
    if (_isFinished || !mounted) return;
    _isFinished = true;
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
    // user retry the amount scan or proceed with the code alone.
    final showWebControls = kIsWeb && _webCode != null && !_isFinished;
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
                  if (showWebControls) ...[
                    const SizedBox(height: 12),
                    Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 12,
                      runSpacing: 8,
                      children: [
                        OutlinedButton.icon(
                          onPressed: _webOcrRunning ? null : _runWebAmountOcr,
                          icon: _webOcrRunning
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : const Icon(Icons.refresh, color: Colors.white),
                          label: Text(t.twint.scanner.status.scanAmountAgain),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white70),
                          ),
                        ),
                        OutlinedButton(
                          onPressed: _webOcrRunning
                              ? null
                              : () => _finish(code: _webCode, amount: null),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: Colors.white,
                            side: const BorderSide(color: Colors.white70),
                          ),
                          child: Text(t.twint.scanner.status.useCodeOnly),
                        ),
                      ],
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
