import 'dart:typed_data';

import 'package:flutter_webrtc/flutter_webrtc.dart';

Future<Uint8List> captureWebQrFrame(RTCVideoRenderer renderer) {
  throw UnsupportedError('Web QR frame capture is only available on web');
}
