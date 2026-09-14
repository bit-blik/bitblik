import 'dart:async';
import 'dart:js_interop';
import 'dart:typed_data';

import 'package:flutter_webrtc/flutter_webrtc.dart';
import 'package:web/web.dart' as web;

/// Captures one full-resolution frame without relying on ImageCapture, which
/// Firefox does not implement. Canvas drawImage works with the video element
/// already owned by RTCVideoRenderer in both Firefox and Chromium browsers.
Future<Uint8List> captureWebQrFrame(RTCVideoRenderer renderer) async {
  final element = web.document.getElementById(
    'video_RTCVideoRenderer-${renderer.textureId}',
  );
  if (element == null || !element.isA<web.HTMLVideoElement>()) {
    throw StateError('QR camera video element is not ready');
  }
  final video = element as web.HTMLVideoElement;

  final width = video.videoWidth;
  final height = video.videoHeight;
  if (width <= 0 || height <= 0) {
    throw StateError('QR camera has not produced a frame yet');
  }

  final canvas = web.HTMLCanvasElement()
    ..width = width
    ..height = height;
  canvas.context2D.drawImage(video, 0, 0, width.toDouble(), height.toDouble());

  final completer = Completer<web.Blob>();
  canvas.toBlob(
    (web.Blob blob) {
      completer.complete(blob);
    }.toJS,
    'image/png',
  );
  final blob = await completer.future;
  final arrayBuffer = await blob.arrayBuffer().toDart;
  return arrayBuffer.toDart.asUint8List();
}
