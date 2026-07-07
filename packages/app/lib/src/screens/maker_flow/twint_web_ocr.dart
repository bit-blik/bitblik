// Web-only OCR bridge. Calls the tesseract.js glue defined in
// web/tesseract/twint_ocr.js. Selected via conditional import from
// twint_code_scanner_screen.dart; native builds get twint_web_ocr_stub.dart.

import 'dart:js_interop';

@JS('twintOcrPreload')
external void _twintOcrPreload();

@JS('twintOcrSnapshot')
external JSPromise<JSString> _twintOcrSnapshot();

void twintOcrPreload() {
  _twintOcrPreload();
}

Future<String> twintOcrSnapshot() async {
  final result = await _twintOcrSnapshot().toDart;
  return result.toDart;
}
