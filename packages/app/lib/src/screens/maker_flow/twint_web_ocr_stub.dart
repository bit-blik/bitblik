// Native/no-op fallback for the web-only TWINT amount OCR bridge.
// The real implementation lives in twint_web_ocr.dart and is selected on web
// via a conditional import. On native platforms MLKit handles the OCR, so
// these are never called.

void twintOcrPreload() {}

Future<String> twintOcrSnapshot() async => '';
