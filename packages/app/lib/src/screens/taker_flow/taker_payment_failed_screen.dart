import '../../../i18n/gen/strings.g.dart'; // Corrected Slang import
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart'; // Import GoRouter
import 'package:ndk/domain_layer/entities/wallet/wallet.dart';
import 'package:ndk/shared/logger/logger.dart';

import 'package:bitblik_core/core.dart';
import '../../providers/providers.dart';
import '../../widgets/progress_indicators.dart';

// Enum to manage screen state
enum PaymentRetryState { initial, loading, success, failed }

class TakerPaymentFailedScreen extends ConsumerStatefulWidget {
  // Changed to StatefulWidget
  final Offer offer;

  const TakerPaymentFailedScreen({super.key, required this.offer});

  @override
  ConsumerState<TakerPaymentFailedScreen> createState() =>
      _TakerPaymentFailedScreenState();
}

class _TakerPaymentFailedScreenState
    extends ConsumerState<TakerPaymentFailedScreen> {
  // State class
  final _bolt11Controller = TextEditingController();
  PaymentRetryState _currentState = PaymentRetryState.initial; // Initial state
  String? _errorMessage; // To store error messages

  Wallet? _defaultReceivingWallet;
  List<Wallet> _otherReceivingWallets = [];
  String? _generatingWalletId;

  @override
  void initState() {
    super.initState();
    _loadWallets();
  }

  void _loadWallets() {
    final ndk = ref.read(ndkProvider);
    if (ndk == null) return;
    final all = ndk.wallets.getWalletsForUnit('sat');
    final defaultW = ndk.wallets.defaultWalletForReceiving;
    final others = all
        .where((w) => w.canReceive && w.id != defaultW?.id)
        .toList();
    if (mounted) {
      setState(() {
        _defaultReceivingWallet = defaultW?.canReceive == true ? defaultW : null;
        _otherReceivingWallets = others;
      });
    }
  }

  void _handleStatusUpdate(OfferStatus? status) {
    if (status == null) return;

    if (mounted) {
      if (status == OfferStatus.takerPaid) {
        setState(() {
          _currentState = PaymentRetryState.success;
        });
      } else if (status == OfferStatus.takerPaymentFailed) {
        setState(() {
          _currentState = PaymentRetryState.failed;
          // _errorMessage = t.taker.paymentFailed.errors.paymentRetryFailed;
        });
      }
    }
  }

  @override
  void dispose() {
    _bolt11Controller.dispose();
    super.dispose();
  }

  Future<void> _generateInvoiceFromWallet(
      Wallet wallet, int amountSats) async {
    if (_generatingWalletId != null) return;
    setState(() => _generatingWalletId = wallet.id);
    try {
      final ndk = ref.read(ndkProvider);
      if (ndk == null) throw Exception('NDK not available');
      final result = await ndk.wallets.receive(
        walletId: wallet.id,
        amountSats: amountSats,
      );
      final invoice = _extractBolt11(result);
      if (invoice == null) throw Exception('No invoice in response');
      if (mounted) {
        setState(() => _bolt11Controller.text = invoice);
      }
    } catch (e) {
      Logger.log.e(() => '[TakerPaymentFailedScreen] Invoice gen failed: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.taker.paymentFailed.errors.generateFailed(details: e.toString()))),
        );
      }
    } finally {
      if (mounted) setState(() => _generatingWalletId = null);
    }
  }

  String? _extractBolt11(dynamic value) {
    String? normalize(String? raw) {
      if (raw == null) return null;
      final trimmed = raw.trim();
      final withoutPrefix = trimmed.toLowerCase().startsWith('lightning:')
          ? trimmed.substring('lightning:'.length).trim()
          : trimmed;
      return withoutPrefix.toLowerCase().startsWith('lnbc')
          ? withoutPrefix
          : null;
    }

    if (value is String) return normalize(value);
    if (value is Map) {
      for (final key in ['bolt11', 'invoice', 'payment_request', 'request']) {
        final candidate = value[key];
        if (candidate is String) {
          final n = normalize(candidate);
          if (n != null) return n;
        }
      }
    }
    return null;
  }

  Future<void> _retryPayment() async {
    final newInvoice = _bolt11Controller.text.trim();
    if (newInvoice.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.taker.paymentFailed.errors.enterValidInvoice)),
      );
      return;
    }

    // Ensure the widget is still mounted before proceeding
    if (!mounted) return;

    setState(() {
      _currentState = PaymentRetryState.loading; // Set loading state
      _errorMessage = null; // Clear previous error
    });

    try {
      final apiService = ref.read(apiServiceProvider);
      final userPubkey = widget.offer.takerPubkey;
      if (userPubkey == null || userPubkey.isEmpty) {
        throw Exception(t.taker.paymentFailed.errors.takerPublicKeyNotFound);
      }

      // 1. Update the invoice first
      await apiService.updateTakerInvoice(
        offerId: widget.offer.id,
        newBolt11: newInvoice,
        userPubkey: userPubkey,
        coordinatorPubkey: widget.offer.coordinatorPubkey,
      );

      // 2. Trigger the retry mechanism on the backend
      await apiService.retryTakerPayment(
        offerId: widget.offer.id,
        userPubkey: userPubkey,
        coordinatorPubkey: widget.offer.coordinatorPubkey,
      );

      if (mounted) {
        setState(() {
          _currentState =
              PaymentRetryState
                  .loading; // Keep loading while waiting for status
        });
      }
    } catch (e) {
      // Handle API errors or other exceptions, only if still mounted
      if (mounted) {
        setState(() {
          _currentState = PaymentRetryState.failed; // Set failed state on error
          _errorMessage = t.taker.paymentFailed.errors.updatingInvoice(
            details: e.toString(),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to the activeOfferProvider for status changes
    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (next != null && next.id == widget.offer.id) {
        try {
          final status = next.status;
          _handleStatusUpdate(status);
        } catch (e) {
          Logger.log.e(
            () => "Error parsing offer status in TakerPaymentFailedScreen: $e",
          );
        }
      }
    });

    // Calculate net amount (moved here for access to widget.offer)
    // Fallback uses 0.5% — historical default when no offer-level fee was
    // recorded. New offers always carry takerFees, so this branch is rare.
    final takerFees = widget.offer.takerFees ??
        OfferQuote.takerFeeSats(widget.offer.amountSats, 0.5);
    final netAmountSats = widget.offer.amountSats - takerFees;

    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          // Dismiss keyboard when tapping outside of text field
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TakerProgressIndicator(activeStep: 3),
              const SizedBox(height: 24),
              _buildContent(context, netAmountSats),
            ],
          ),
        ),
      ),
    );
  }

  // Helper method to build content based on state
  Widget _buildContent(BuildContext context, int netAmountSats) {
    switch (_currentState) {
      case PaymentRetryState.loading:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // const CircularProgressIndicator(),
            // const SizedBox(height: 16),
            Text(t.taker.paymentFailed.loading.processingPayment),
          ],
        );

      case PaymentRetryState.success:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(
              Icons.check_circle_outline,
              color: Colors.green,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              t.taker.paymentFailed.success.title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Text(
              t.taker.paymentFailed.success.message,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                await ref
                    .read(activeOfferProvider.notifier)
                    .setActiveOffer(null);
                if (mounted) {
                  context.go('/');
                }
              },
              child: Text(t.common.buttons.goHome),
            ),
          ],
        );

      case PaymentRetryState.initial:
      case PaymentRetryState.failed:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 64,
            ),
            const SizedBox(height: 16),
            Text(
              t.taker.paymentFailed.title,
              style: Theme.of(context).textTheme.headlineSmall,
              textAlign: TextAlign.center,
            ),
            if (widget.offer.takerLightningAddress != null &&
                widget.offer.takerLightningAddress!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                child: Text(
                  t.lightningAddress.labels.short(
                    address: widget.offer.takerLightningAddress!,
                  ),
                  textAlign: TextAlign.center,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.blueGrey),
                ),
              ),
            if (_defaultReceivingWallet != null)
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.account_balance_wallet_outlined,
                        size: 14, color: Colors.grey[600]),
                    const SizedBox(width: 4),
                    Text(
                      _defaultReceivingWallet!.name,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            if (widget.offer.takerPaymentFailureReason != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  widget.offer.takerPaymentFailureReason!,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.error,
                      ),
                  textAlign: TextAlign.center,
                ),
              ),
            if (_currentState == PaymentRetryState.failed &&
                _errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Text(
                  _errorMessage!,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                  textAlign: TextAlign.center,
                ),
              ),
            Text(
              t.taker.paymentFailed.instructions(
                netAmount: netAmountSats.toString(),
              ),
              textAlign: TextAlign.center,
            ),
            if (_defaultReceivingWallet != null ||
                _otherReceivingWallets.isNotEmpty) ...[
              const SizedBox(height: 16),
              const Divider(height: 1),
              const SizedBox(height: 12),
              Text(
                t.taker.paymentFailed.walletSection.title,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 6),
              if (_defaultReceivingWallet != null)
                _walletTile(
                  context,
                  wallet: _defaultReceivingWallet!,
                  amountSats: netAmountSats,
                  isDefault: true,
                ),
              ..._otherReceivingWallets.map(
                (w) => _walletTile(
                  context,
                  wallet: w,
                  amountSats: netAmountSats,
                  isDefault: false,
                ),
              ),
              const SizedBox(height: 8),
            ],
            const SizedBox(height: 16),
            TextField(
              controller: _bolt11Controller,
              decoration: InputDecoration(
                labelText: t.taker.paymentFailed.form.newInvoiceLabel,
                hintText: t.taker.paymentFailed.form.newInvoiceHint,
                border: const OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _retryPayment,
              child: Text(t.taker.paymentFailed.actions.retryPayment),
            ),
          ],
        );
    }
  }

  Widget _walletTile(
    BuildContext context, {
    required Wallet wallet,
    required int amountSats,
    required bool isDefault,
  }) {
    final isGenerating = _generatingWalletId == wallet.id;
    return InkWell(
      onTap: _generatingWalletId != null
          ? null
          : () => _generateInvoiceFromWallet(wallet, amountSats),
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Icon(
              Icons.account_balance_wallet_outlined,
              size: 18,
              color: Colors.grey[600],
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Text(
                        wallet.name,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (isDefault) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.grey.shade200,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            t.taker.paymentFailed.walletSection.defaultLabel,
                            style: TextStyle(
                                fontSize: 10, color: Colors.grey[600]),
                          ),
                        ),
                      ],
                    ],
                  ),
                  Text(
                    t.taker.paymentFailed.walletSection.tapToGenerate(amountSats: amountSats.toString()),
                    style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                  ),
                ],
              ),
            ),
            if (isGenerating)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Icon(Icons.bolt, size: 16, color: Colors.orange[600]),
          ],
        ),
      ),
    );
  }
}
