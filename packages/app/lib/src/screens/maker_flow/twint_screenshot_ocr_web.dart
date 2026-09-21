import 'dart:js_interop';
import 'dart:typed_data';

@JS('bitblikOcrImage')
external JSPromise<JSString?> _recognizeImage(JSUint8Array bytes);

Future<String?> recognizeTwintScreenshotImage(Uint8List bytes) async {
  final text = await _recognizeImage(bytes.toJS).toDart;
  return text?.toDart;
}
