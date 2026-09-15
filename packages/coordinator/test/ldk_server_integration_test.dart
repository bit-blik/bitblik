import 'dart:io';
import 'dart:math';

import 'package:bitblik_coordinator/src/models/invoice_status.dart';
import 'package:bitblik_coordinator/src/models/pay_invoice_result.dart';
import 'package:bitblik_coordinator/src/models/payment_status.dart';
import 'package:bitblik_coordinator/src/services/ldk_server_service.dart';
import 'package:crypto/crypto.dart';
import 'package:test/test.dart';

final integrationEnabled =
    Platform.environment['LDK_SERVER_INTEGRATION'] == '1';

void main() {
  test(
    'two-node ldk-server hold lifecycle and outgoing reconciliation',
    () async {
      final receiver = serviceFromEnvironment('RECEIVER');
      final payer = serviceFromEnvironment('PAYER');
      final services = <LdkServerService>[receiver, payer];
      addTearDown(() async {
        for (final service in services.reversed) {
          await service.disconnect();
        }
      });

      await receiver.connect();
      await payer.connect();

      final preimage = randomHex32();
      final paymentHash = sha256.convert(hexToBytes(preimage)).toString();
      final created = await receiver.createHoldInvoice(
        amountSats: 1000,
        memo: 'BitBlik ldk-server integration settlement',
        paymentHashHex: paymentHash,
      );
      final accepted = receiver
          .subscribeToInvoiceUpdates(paymentHashHex: paymentHash)
          .firstWhere((update) => update.status == InvoiceStatus.ACCEPTED);
      final outgoing = payer.payInvoice(
        invoice: created.invoice,
        amountSat: 1000,
        feeLimitSat: 100,
      );

      await accepted.timeout(const Duration(seconds: 90));
      await receiver.settleInvoice(preimageHex: preimage);
      final paid = await outgoing.timeout(const Duration(seconds: 90));
      expect(paid.status, PaymentStatus.SUCCEEDED);
      expect(
        (await receiver.lookupInvoice(paymentHashHex: paymentHash)).status,
        InvoiceStatus.SETTLED,
      );
      await expectLater(
        receiver.cancelInvoice(paymentHashHex: paymentHash),
        throwsStateError,
      );
      expect(
        (await receiver.lookupInvoice(paymentHashHex: paymentHash)).status,
        InvoiceStatus.SETTLED,
      );

      await payer.disconnect();
      services.remove(payer);
      final reconnectedPayer = serviceFromEnvironment('PAYER');
      services.add(reconnectedPayer);
      await reconnectedPayer.connect();
      final reconciled = await reconnectedPayer.reconcileOutgoingPayment(
        invoice: created.invoice,
      );
      expect(reconciled?.status, PaymentStatus.SUCCEEDED);
      expect(reconciled?.paymentPreimage, paid.paymentPreimage);

      final canceledPreimage = randomHex32();
      final canceledHash =
          sha256.convert(hexToBytes(canceledPreimage)).toString();
      await receiver.createHoldInvoice(
        amountSats: 1000,
        memo: 'BitBlik ldk-server integration cancellation',
        paymentHashHex: canceledHash,
      );
      final canceled =
          await receiver.cancelInvoice(paymentHashHex: canceledHash);
      expect(canceled.isCancelled, isTrue);
      expect(
        (await receiver.lookupInvoice(paymentHashHex: canceledHash)).status,
        InvoiceStatus.CANCELED,
      );

      final failedPreimage = randomHex32();
      final failedHash = sha256.convert(hexToBytes(failedPreimage)).toString();
      final failedInvoice = await receiver.createHoldInvoice(
        amountSats: 1000,
        memo: 'BitBlik ldk-server integration failed outgoing payment',
        paymentHashHex: failedHash,
      );
      await receiver.cancelInvoice(paymentHashHex: failedHash);
      final failed = await reconnectedPayer.payInvoice(
        invoice: failedInvoice.invoice,
        amountSat: 1000,
        feeLimitSat: 100,
      );
      expect(failed.status, isNot(PaymentStatus.SUCCEEDED));
      expect(
        (await waitForReconciledStatus(
          reconnectedPayer,
          failedInvoice.invoice,
          PaymentStatus.FAILED,
        ))
            ?.status,
        PaymentStatus.FAILED,
      );

      await reconnectedPayer.disconnect();
      services.remove(reconnectedPayer);
      final finalPayer = serviceFromEnvironment('PAYER');
      services.add(finalPayer);
      await finalPayer.connect();
      final reconciledFailure = await finalPayer.reconcileOutgoingPayment(
        invoice: failedInvoice.invoice,
      );
      expect(reconciledFailure?.status, PaymentStatus.FAILED);
    },
    skip: integrationEnabled
        ? false
        : 'Set LDK_SERVER_INTEGRATION=1 and two-node credentials.',
    timeout: const Timeout(Duration(minutes: 5)),
  );
}

LdkServerService serviceFromEnvironment(String role) {
  String required(String suffix) {
    final key = 'LDK_SERVER_INTEGRATION_${role}_$suffix';
    final value = Platform.environment[key];
    if (value == null || value.isEmpty) {
      throw StateError('$key is required.');
    }
    return value;
  }

  return LdkServerService(
    host: required('HOST'),
    port: int.tryParse(
          Platform.environment['LDK_SERVER_INTEGRATION_${role}_PORT'] ?? '',
        ) ??
        3536,
    certificatePath: required('CERT_PATH'),
    apiKey: required('API_KEY'),
    operationTimeout: const Duration(seconds: 90),
  );
}

String randomHex32() {
  final random = Random.secure();
  return List<int>.generate(32, (_) => random.nextInt(256))
      .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
      .join();
}

List<int> hexToBytes(String value) => [
      for (var i = 0; i < value.length; i += 2)
        int.parse(value.substring(i, i + 2), radix: 16),
    ];

Future<PayInvoiceResult?> waitForReconciledStatus(
  LdkServerService service,
  String invoice,
  PaymentStatus expected,
) async {
  final deadline = DateTime.now().add(const Duration(seconds: 90));
  while (DateTime.now().isBefore(deadline)) {
    final result = await service.reconcileOutgoingPayment(invoice: invoice);
    if (result?.status == expected) return result;
    await Future<void>.delayed(const Duration(milliseconds: 500));
  }
  return service.reconcileOutgoingPayment(invoice: invoice);
}
