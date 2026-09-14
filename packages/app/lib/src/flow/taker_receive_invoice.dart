import 'package:bitblik_core/core.dart';
import 'package:ndk/presentation_layer/ndk.dart';

export 'package:bitblik_core/core.dart' show extractBolt11Invoice;

Future<ReceivingPayment> createBestReceivingPayment(
  Ndk ndk,
  int amountSats, {
  required bool coordinatorSupportsBolt12,
  String? walletId,
}) => createReceivingPayment(
  ndk,
  amountSats,
  coordinatorSupportsBolt12: coordinatorSupportsBolt12,
  walletId: walletId,
  description: 'BitBlik payout',
);
