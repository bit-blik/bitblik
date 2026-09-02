import 'package:bitblik_core/core.dart';
import 'package:ndk/presentation_layer/ndk.dart';

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
