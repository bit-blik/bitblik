import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

import 'full_frame_qr_scanner.dart';

/// Camera decoder only; ndk_flutter owns the wallet input and connection UI.
Widget buildWalletQrScanner(
  BuildContext context,
  ValueChanged<String> onScan,
  ValueChanged<Object> onError,
) {
  if (kIsWeb || defaultTargetPlatform == TargetPlatform.linux) {
    return FullFrameQrScanner(onScan: onScan, onError: onError);
  }
  return MobileScanner(
    onDetect: (capture) {
      for (final barcode in capture.barcodes) {
        final value = barcode.rawValue?.trim();
        if (value != null && value.isNotEmpty) {
          onScan(value);
          break;
        }
      }
    },
    errorBuilder: (context, error) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) onError(error);
      });
      return const SizedBox.shrink();
    },
  );
}
