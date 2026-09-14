import 'dart:typed_data';

import 'package:image/image.dart' as image;
import 'package:pretty_qr_code/pretty_qr_code.dart';

/// Generates the same lossless image used by the preview and gallery export.
/// Four white modules surround the symbol; every module occupies whole pixels.
Uint8List renderTwintQrPng(String payload) {
  if (payload.isEmpty) throw ArgumentError.value(payload, 'payload');
  final qr = QrImage(
    QrCode.fromData(data: payload, errorCorrectLevel: QrErrorCorrectLevel.M),
  );
  const quietZone = 4;
  const scale = 16;
  final size = (qr.moduleCount + quietZone * 2) * scale;
  final bitmap = image.Image(width: size, height: size, numChannels: 3);
  image.fill(bitmap, color: image.ColorRgb8(255, 255, 255));
  for (var row = 0; row < qr.moduleCount; row++) {
    for (var column = 0; column < qr.moduleCount; column++) {
      if (!qr.isDark(row, column)) continue;
      final x = (column + quietZone) * scale;
      final y = (row + quietZone) * scale;
      image.fillRect(
        bitmap,
        x1: x,
        y1: y,
        x2: x + scale - 1,
        y2: y + scale - 1,
        color: image.ColorRgb8(0, 0, 0),
      );
    }
  }
  return image.encodePng(bitmap);
}
