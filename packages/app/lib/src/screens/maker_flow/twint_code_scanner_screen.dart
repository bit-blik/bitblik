import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class TwintScanResult {
  final String? code;
  final double? amount;

  const TwintScanResult({this.code, this.amount});
}

class TwintCodeScannerScreen extends StatefulWidget {
  const TwintCodeScannerScreen({super.key});

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
  String _status =
      'Align the TWINT QR code and amount text inside the camera frame.';

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
        amount = _extractAmount(ocrText);
      }

      if (code != null || amount != null) {
        if (!mounted) return;
        Navigator.of(context).pop(TwintScanResult(code: code, amount: amount));
        return;
      }

      if (mounted) {
        setState(() {
          _status =
              'TWINT code not recognized yet. Keep the QR and amount text in view, or fill the form manually.';
        });
      }
    } catch (_) {
      if (mounted) {
        setState(() {
          _status =
              'Camera scan could not extract the amount. You can still use the QR result and correct the fields manually.';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Scan TWINT Code')),
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
                _status,
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
