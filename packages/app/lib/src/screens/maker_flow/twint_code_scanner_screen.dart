import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../i18n/gen/strings.g.dart';

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
    returnImage: true,
  );
  final TextRecognizer _textRecognizer = TextRecognizer();

  bool _isHandlingCapture = false;
  _TwintScannerStatus _status = _TwintScannerStatus.align;

  @override
  void dispose() {
    _controller.dispose();
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

      String? code = _extractCode(qrValue);
      double? amount;

      if (!kIsWeb && capture.image != null && capture.size != Size.zero) {
        final recognizedText = await _textRecognizer.processImage(
          InputImage.fromBitmap(
            bitmap: capture.image!,
            width: capture.size.width.round(),
            height: capture.size.height.round(),
          ),
        );
        final ocrText = recognizedText.text;
        code ??= _extractCode(ocrText);
        if (widget.scanAmount) {
          amount = _extractAmount(ocrText);
        }
      }

      if (code != null || amount != null) {
        if (!mounted) return;
        Navigator.of(context).pop(TwintScanResult(code: code, amount: amount));
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
      _TwintScannerStatus.notRecognized =>
        t.twint.scanner.status.notRecognized(code: codeLabel),
      _TwintScannerStatus.amountFailed =>
        t.twint.scanner.status.amountFailed,
    };
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
              child: Text(
                statusText,
                style: const TextStyle(color: Colors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

enum _TwintScannerStatus { align, notRecognized, amountFailed }
