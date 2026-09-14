// Browser-only integration harness for the production scanner and exporter.
// It does not connect to coordinators, wallets or payment services.
import 'package:bitblik/i18n/gen/strings.g.dart';
import 'package:bitblik/src/screens/maker_flow/twint_shop_qr_scanner_screen.dart';
import 'package:bitblik/src/widgets/twint_payment_qr.dart';
import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    TranslationProvider(
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
          scaffoldBackgroundColor: Colors.white,
        ),
        home: const _QrCheck(),
      ),
    ),
  );
}

class _QrCheck extends StatefulWidget {
  const _QrCheck();
  @override
  State<_QrCheck> createState() => _QrCheckState();
}

class _QrCheckState extends State<_QrCheck> {
  TwintShopQr? _qr;
  DateTime? _expiresAt;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TWINT QR browser check')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            FilledButton(
              onPressed: () async {
                final qr = await Navigator.of(context).push<TwintShopQr>(
                  MaterialPageRoute(
                    builder: (_) => const TwintShopQrScannerScreen(),
                  ),
                );
                if (!mounted || qr == null) return;
                setState(() {
                  _qr = qr;
                  _expiresAt = DateTime.now().add(const Duration(minutes: 5));
                });
              },
              child: const Text('Scan shop QR'),
            ),
            if (_qr case final qr?) ...[
              Text('CHF ${qr.amountText}'),
              TwintPaymentQr(payload: qr.payload, expiresAt: _expiresAt!),
            ],
          ],
        ),
      ),
    );
  }
}
