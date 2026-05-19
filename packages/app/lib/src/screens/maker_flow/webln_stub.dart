/// Stub for WebLN integration on non-web platforms.
library;

bool get isWeblnSupported => false;

Future<void> sendWeblnPayment(String invoice) async {
  // No-op on non-web platforms.
}

void checkWeblnSupport(Function(bool) callback) async {
  callback(false);
}
