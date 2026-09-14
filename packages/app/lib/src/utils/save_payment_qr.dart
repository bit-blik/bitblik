import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:gal/gal.dart';

enum PaymentQrSaveResult { saved, downloadStarted, cancelled }

bool get savesPaymentQrToGallery =>
    !kIsWeb &&
    (defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS);

/// Saves only on explicit user action. Gallery access is requested by Gal when
/// needed; the web/desktop picker owns downloading or choosing a destination.
Future<PaymentQrSaveResult> savePaymentQr(Uint8List png) async {
  if (savesPaymentQrToGallery) {
    await Gal.putImageBytes(png, name: 'twint-payment');
    return PaymentQrSaveResult.saved;
  }
  final uri = await FilePicker.saveFile(
    fileName: 'twint-payment.png',
    bytes: png,
    mimeType: 'image/png',
  );
  if (uri == null) return PaymentQrSaveResult.cancelled;
  return kIsWeb
      ? PaymentQrSaveResult.downloadStarted
      : PaymentQrSaveResult.saved;
}
