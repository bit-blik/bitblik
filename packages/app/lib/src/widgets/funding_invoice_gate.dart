import 'dart:async';

import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';

import '../services/funding_payment.dart';

/// Payment controls are exposed only after invoice validation and comparison
/// against the independent client estimate. Only failures show an extra screen.
class FundingInvoiceGate extends StatefulWidget {
  final Offer? offer;
  final String? invoice;
  final String makerPubkey;
  final String network;
  final FundingEstimate? estimate;
  final VoidCallback onCancel;
  final Widget Function(BuildContext, FundingPaymentAuthorization) builder;
  final DateTime Function()? now;

  const FundingInvoiceGate({
    super.key,
    required this.offer,
    required this.invoice,
    required this.makerPubkey,
    required this.network,
    required this.onCancel,
    required this.builder,
    this.estimate,
    this.now,
  });

  @override
  State<FundingInvoiceGate> createState() => _FundingInvoiceGateState();
}

class _FundingInvoiceGateState extends State<FundingInvoiceGate> {
  FundingPaymentAuthorization? _validated;
  String? _changedError;
  Timer? _expiryTimer;
  DateTime get _now => widget.now?.call() ?? DateTime.now();

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String error;
    try {
      final offer = widget.offer;
      if (offer == null || widget.invoice == null) {
        throw const FormatException('Funding details are missing.');
      }
      if (_changedError != null) throw FormatException(_changedError!);
      final previous = _validated;
      if (previous != null) {
        try {
          previous.requireCurrent(
            offer,
            widget.invoice!,
            network: widget.network,
            makerPubkey: widget.makerPubkey,
            now: _now,
          );
        } on FormatException catch (e) {
          // Never move the baseline, or revive a quote after remote data reverts.
          _changedError = e.message;
          rethrow;
        }
      }
      final estimate = widget.estimate;
      if (estimate == null) {
        throw const FormatException(
          'The original client estimate is unavailable for this offer. '
          'Its amount cannot be checked safely. Cancel it and create a new offer.',
        );
      }
      final quote =
          previous ??
          FundingPaymentAuthorization.review(
            offer,
            widget.invoice!,
            network: widget.network,
            makerPubkey: widget.makerPubkey,
            now: _now,
          );
      estimate.requireMatches(offer);
      if (previous == null) {
        _validated = quote;
        _expiryTimer = Timer(quote.funding.expiresAt.difference(_now), () {
          if (mounted) setState(() {});
        });
      }
      return widget.builder(context, quote);
    } on FormatException catch (e) {
      error = e.message;
    }
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Payment blocked',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 16),
              Text(error, textAlign: TextAlign.center),
              const SizedBox(height: 12),
              if (widget.estimate != null)
                Text(
                  'Client estimate: ${widget.estimate!.totalSats} sats; '
                  'fee: ${widget.estimate!.makerFeesSats} sats',
                  textAlign: TextAlign.center,
                ),
              if (widget.offer != null)
                Text(
                  'Coordinator quote: ${widget.offer!.amountSats + widget.offer!.makerFees} sats; '
                  'fee: ${widget.offer!.makerFees} sats',
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 12),
              const Text(
                'No payment controls are available. Cancel this offer and try again '
                'with a fresh quote. If the problem persists, choose another coordinator.',
                textAlign: TextAlign.center,
              ),
              TextButton(
                onPressed: widget.onCancel,
                child: const Text('Cancel offer'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
