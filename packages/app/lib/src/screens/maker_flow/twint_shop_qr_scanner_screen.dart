import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webrtc_zxing/flutter_webrtc_zxing.dart' as zxing;
import 'package:mobile_scanner/mobile_scanner.dart';

import '../../../i18n/gen/strings.g.dart';
import '../../widgets/full_frame_qr_scanner.dart';

typedef ShopQrCameraBuilder =
    Widget Function(
      BuildContext context,
      ValueChanged<String> onScan,
      ValueChanged<Object> onError,
    );

Future<TwintShopQr?> importTwintShopQrImage() async {
  final image = await FilePicker.pickFile(type: FileType.image);
  if (image == null) return null;
  final result = await zxing.zx.readBarcodeImagePath(
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
  return result.isValid ? TwintShopQr.tryParse(result.text ?? '') : null;
}

/// QR-only capture. Returns the parsed payload and amount together, or null
/// when cancelled. Replacement scans can require the funded centime amount.
class TwintShopQrScannerScreen extends StatefulWidget {
  final int? requiredCentimes;
  @visibleForTesting
  final ShopQrCameraBuilder? cameraBuilder;

  const TwintShopQrScannerScreen({
    super.key,
    this.requiredCentimes,
    this.cameraBuilder,
  });

  @override
  State<TwintShopQrScannerScreen> createState() =>
      _TwintShopQrScannerScreenState();
}

enum _ScanError { invalid, amountMismatch, camera }

class _TwintShopQrScannerScreenState extends State<TwintShopQrScannerScreen> {
  _ScanError? _error;
  bool _returned = false;
  int _attempt = 0;
  Timer? _invalidQrTimer;

  void _onScan(String raw) {
    if (!mounted || _returned || _error != null) return;
    final qr = TwintShopQr.tryParse(raw);
    if (qr == null) {
      _showInvalidQrTemporarily();
      return;
    }
    if (widget.requiredCentimes != null &&
        qr.amountCentimes != widget.requiredCentimes) {
      setState(() => _error = _ScanError.amountMismatch);
      return;
    }
    _returned = true;
    Navigator.of(context).pop(qr);
  }

  void _onError(Object _) {
    if (mounted && !_returned && _error == null) {
      setState(() => _error = _ScanError.camera);
    }
  }

  void _showInvalidQrTemporarily() {
    _invalidQrTimer?.cancel();
    setState(() => _error = _ScanError.invalid);
    _invalidQrTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted || _error != _ScanError.invalid) return;
      setState(() {
        _error = null;
        _attempt++;
      });
    });
  }

  @override
  void dispose() {
    _invalidQrTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final shop = t.twint.shop;
    final errorText = switch (_error) {
      _ScanError.invalid => shop.invalidQr,
      _ScanError.amountMismatch => shop.amountMismatch,
      _ScanError.camera => shop.cameraFailed,
      null => null,
    };
    return Scaffold(
      appBar: AppBar(title: Text(shop.scanTitle)),
      body: errorText != null
          ? Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Semantics(liveRegion: true, child: Text(errorText)),
                    const SizedBox(height: 16),
                    FilledButton(
                      onPressed: () => setState(() {
                        _invalidQrTimer?.cancel();
                        _error = null;
                        _attempt++;
                      }),
                      child: Text(t.common.buttons.retry),
                    ),
                  ],
                ),
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: KeyedSubtree(
                    key: ValueKey(_attempt),
                    child:
                        widget.cameraBuilder?.call(
                          context,
                          _onScan,
                          _onError,
                        ) ??
                        _ShopCamera(onScan: _onScan, onError: _onError),
                  ),
                ),
                SafeArea(
                  top: false,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(shop.scanInstructions),
                  ),
                ),
              ],
            ),
    );
  }
}

class _ShopCamera extends StatefulWidget {
  final ValueChanged<String> onScan;
  final ValueChanged<Object> onError;
  const _ShopCamera({required this.onScan, required this.onError});

  @override
  State<_ShopCamera> createState() => _ShopCameraState();
}

class _ShopCameraState extends State<_ShopCamera> {
  MobileScannerController? _controller;

  @override
  void initState() {
    super.initState();
    if (!kIsWeb && defaultTargetPlatform != TargetPlatform.linux) {
      _controller = MobileScannerController(
        formats: const [BarcodeFormat.qrCode],
        detectionSpeed: DetectionSpeed.noDuplicates,
      );
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (kIsWeb || defaultTargetPlatform == TargetPlatform.linux) {
      return FullFrameQrScanner(onScan: widget.onScan, onError: widget.onError);
    }
    return MobileScanner(
      controller: _controller,
      onDetect: (capture) {
        for (final barcode in capture.barcodes) {
          final raw = barcode.rawValue;
          if (raw != null && raw.isNotEmpty) {
            widget.onScan(raw);
            break;
          }
        }
      },
      errorBuilder: (context, error) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) widget.onError(error);
        });
        return const SizedBox.shrink();
      },
    );
  }
}
