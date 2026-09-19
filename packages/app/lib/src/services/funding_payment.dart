import 'package:bitblik_core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Captured from the form before the coordinator RPC, never from its response.
class FundingEstimate {
  final String coordinatorPubkey;
  final String makerPubkey;
  final double fiatAmount;
  final String fiatCurrency;
  final double premiumPercent;
  final int totalSats;
  final int makerFeesSats;

  const FundingEstimate({
    required this.coordinatorPubkey,
    required this.makerPubkey,
    required this.fiatAmount,
    required this.fiatCurrency,
    required this.premiumPercent,
    required this.totalSats,
    required this.makerFeesSats,
  });

  Map<String, dynamic> toJson() => {
    'coordinatorPubkey': coordinatorPubkey,
    'makerPubkey': makerPubkey,
    'fiatAmount': fiatAmount,
    'fiatCurrency': fiatCurrency,
    'premiumPercent': premiumPercent,
    'totalSats': totalSats,
    'makerFeesSats': makerFeesSats,
  };

  factory FundingEstimate.fromJson(Map<String, dynamic> json) => FundingEstimate(
    coordinatorPubkey: json['coordinatorPubkey'] as String,
    makerPubkey: json['makerPubkey'] as String,
    fiatAmount: (json['fiatAmount'] as num).toDouble(),
    fiatCurrency: json['fiatCurrency'] as String,
    premiumPercent: (json['premiumPercent'] as num).toDouble(),
    totalSats: json['totalSats'] as int,
    makerFeesSats: json['makerFeesSats'] as int,
  );

  // 0.5%, rounded down, with a tiny rounding floor and an absolute loss cap.
  int get toleranceSats => (totalSats ~/ 200).clamp(5, 100);
  int get feeToleranceSats =>
      makerFeesSats == 0 ? 0 : (makerFeesSats ~/ 200).clamp(1, toleranceSats);

  void requireMatches(Offer offer) {
    if (totalSats <= 0 || makerFeesSats < 0 || makerFeesSats >= totalSats) {
      throw const FormatException('The original client estimate is invalid.');
    }
    if (coordinatorPubkey != offer.coordinatorPubkey ||
        makerPubkey != offer.makerPubkey) {
      throw const FormatException(
        'The coordinator or maker differs from the original request.',
      );
    }
    if (fiatAmount != offer.fiatAmount || fiatCurrency != offer.fiatCurrency) {
      throw const FormatException(
        'The fiat amount or currency differs from the original request.',
      );
    }
    if (premiumPercent != offer.premiumPercent) {
      throw const FormatException(
        'The premium differs from the original request.',
      );
    }
    final returnedTotal = offer.amountSats + offer.makerFees;
    if ((returnedTotal - totalSats).abs() > toleranceSats) {
      throw FormatException(
        'The coordinator returned $returnedTotal sats; the client estimated '
        '$totalSats sats. The allowed difference is $toleranceSats sats. '
        'Exchange rates may have moved, or the coordinator returned an unexpected amount.',
      );
    }
    if ((offer.makerFees - makerFeesSats).abs() > feeToleranceSats) {
      throw FormatException(
        'The coordinator fee is ${offer.makerFees} sats; the client estimated '
        '$makerFeesSats sats. The allowed fee difference is $feeToleranceSats sats.',
      );
    }
  }
}

// Bind the pre-RPC estimate to its response, so another offer cannot reuse it.
final fundingEstimateProvider =
    StateProvider<({String offerId, FundingEstimate estimate})?>((ref) => null);

// Network selection belongs to the app build, never to a coordinator response.
final fundingNetworkProvider = Provider<String>(
  (ref) => const String.fromEnvironment(
    'LIGHTNING_NETWORK',
    defaultValue: 'mainnet',
  ),
);

/// Immutable, validated quote. Separate from mutable RPC/relay offer data.
/// The payment gate additionally checks the independent pre-RPC estimate.
class FundingPaymentAuthorization {
  final String offerId;
  final String coordinatorPubkey;
  final String makerPubkey;
  final int principalSats;
  final int makerFeesSats;
  final double fiatAmount;
  final String fiatCurrency;
  final double premiumPercent;
  final String network;
  final FundingInvoice funding;

  FundingPaymentAuthorization.review(
    Offer offer,
    String invoice, {
    required this.network,
    required String makerPubkey,
    DateTime? now,
  }) : offerId = offer.id,
       coordinatorPubkey = offer.coordinatorPubkey,
       makerPubkey = offer.makerPubkey,
       principalSats = offer.amountSats,
       makerFeesSats = offer.makerFees,
       fiatAmount = offer.fiatAmount,
       fiatCurrency = offer.fiatCurrency,
       premiumPercent = offer.premiumPercent,
       funding = _validate(offer, invoice, network, makerPubkey, now);

  int get totalSats => principalSats + makerFeesSats;

  static FundingInvoice _validate(
    Offer offer,
    String invoice,
    String network,
    String makerPubkey,
    DateTime? now,
  ) {
    if (makerPubkey.isEmpty ||
        offer.makerPubkey != makerPubkey ||
        offer.coordinatorPubkey.isEmpty ||
        offer.amountSats <= 0 ||
        offer.makerFees < 0 ||
        offer.amountSats + offer.makerFees > 2100000000000000 ||
        !offer.fiatAmount.isFinite ||
        offer.fiatAmount <= 0 ||
        !offer.premiumPercent.isFinite ||
        offer.premiumPercent < 0 ||
        offer.premiumPercent > 100) {
      throw const FormatException('Invalid funding quote.');
    }
    return FundingInvoice.validate(
      invoice: invoice,
      expectedAmountMsat:
          (BigInt.from(offer.amountSats) + BigInt.from(offer.makerFees)) *
          BigInt.from(1000),
      expectedPaymentHash: offer.holdInvoicePaymentHash ?? '',
      expectedNetwork: network,
      now: now,
    );
  }

  /// Rechecked at the moment of use, including after asynchronous wallet/budget
  /// dialogs. An updated Offer cannot silently replace the validated quote.
  void requireCurrent(
    Offer? offer,
    String invoice, {
    required String network,
    required String makerPubkey,
    DateTime? now,
  }) {
    if (offer == null ||
        offer.id != offerId ||
        offer.coordinatorPubkey != coordinatorPubkey ||
        offer.makerPubkey != this.makerPubkey ||
        makerPubkey != this.makerPubkey ||
        offer.amountSats != principalSats ||
        offer.makerFees != makerFeesSats ||
        offer.fiatAmount != fiatAmount ||
        offer.fiatCurrency != fiatCurrency ||
        offer.premiumPercent != premiumPercent ||
        network != this.network ||
        invoice.trim().toLowerCase() != funding.invoice ||
        offer.holdInvoicePaymentHash?.toLowerCase() != funding.paymentHash ||
        (offer.holdInvoice != null &&
            offer.holdInvoice!.trim().toLowerCase() != funding.invoice)) {
      throw const FormatException(
        'Payment details changed after validation. Cancel this offer and request a new quote.',
      );
    }
    if (!(now ?? DateTime.now()).toUtc().isBefore(funding.expiresAt)) {
      throw const FormatException('Invoice has expired.');
    }
  }
}
