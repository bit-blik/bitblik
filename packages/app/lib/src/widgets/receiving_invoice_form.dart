import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/domain_layer/entities/wallet/wallet.dart';
import 'package:ndk/shared/logger/logger.dart';

import '../flow/taker_receive_invoice.dart';
import '../providers/providers.dart';
import '../utils/bitcoin_display.dart';

/// Copy used by [ReceivingInvoiceForm].
///
/// Keeping this separate from the widget lets payout flows reuse the wallet
/// and invoice behavior without inheriting taker-payment-failure wording.
class ReceivingInvoiceFormLabels {
  final String walletSectionTitle;
  final String defaultWalletLabel;
  final String Function(String amount) tapToGenerate;
  final String invoiceLabel;
  final String invoiceHint;
  final String submitLabel;
  final String emptyInvoiceError;
  final String Function(Object error) generationError;
  final String addWalletLabel;
  final String noReceivingWalletMessage;
  final String walletUnavailableError;
  final String missingBolt11Error;

  const ReceivingInvoiceFormLabels({
    required this.walletSectionTitle,
    required this.defaultWalletLabel,
    required this.tapToGenerate,
    required this.invoiceLabel,
    required this.invoiceHint,
    required this.submitLabel,
    required this.emptyInvoiceError,
    required this.generationError,
    required this.addWalletLabel,
    required this.noReceivingWalletMessage,
    required this.walletUnavailableError,
    required this.missingBolt11Error,
  });
}

/// Selects a receive-capable wallet or accepts a manually pasted BOLT11.
///
/// The caller owns the payout-specific action. This widget only creates and
/// submits an exact-amount invoice.
class ReceivingInvoiceForm extends ConsumerStatefulWidget {
  final int amountSats;
  final ReceivingInvoiceFormLabels labels;
  final Future<void> Function(String bolt11) onSubmit;
  final bool enabled;

  const ReceivingInvoiceForm({
    super.key,
    required this.amountSats,
    required this.labels,
    required this.onSubmit,
    this.enabled = true,
  });

  @override
  ConsumerState<ReceivingInvoiceForm> createState() =>
      _ReceivingInvoiceFormState();
}

class _ReceivingInvoiceFormState extends ConsumerState<ReceivingInvoiceForm> {
  final _invoiceController = TextEditingController();
  Wallet? _defaultReceivingWallet;
  List<Wallet> _otherReceivingWallets = const [];
  String? _selectedWalletId;
  String? _generatingWalletId;
  bool _submitting = false;

  bool get _busy => _generatingWalletId != null || _submitting;

  @override
  void initState() {
    super.initState();
    _loadWallets();
  }

  @override
  void dispose() {
    _invoiceController.dispose();
    super.dispose();
  }

  void _loadWallets() {
    final ndk = ref.read(ndkProvider);
    if (ndk == null) {
      if (mounted) {
        setState(() {
          _defaultReceivingWallet = null;
          _otherReceivingWallets = const [];
        });
      }
      return;
    }

    // ignore: experimental_member_use
    final all = ndk.wallets.getWalletsForUnit('sat');
    // ignore: experimental_member_use
    final defaultWallet = ndk.wallets.defaultWalletForReceiving;
    final usableDefault =
        defaultWallet?.canReceive == true ? defaultWallet : null;
    final others = all
        .where((wallet) => wallet.canReceive && wallet.id != usableDefault?.id)
        .toList(growable: false);

    if (!mounted) return;
    setState(() {
      _defaultReceivingWallet = usableDefault;
      _otherReceivingWallets = others;
    });
  }

  Future<void> _openWalletSettings() async {
    await context.push('/wallet');
    if (mounted) _loadWallets();
  }

  Future<void> _generateInvoice(Wallet wallet) async {
    if (_busy || !widget.enabled) return;
    setState(() {
      _selectedWalletId = wallet.id;
      _generatingWalletId = wallet.id;
    });
    try {
      final ndk = ref.read(ndkProvider);
      if (ndk == null) throw StateError(widget.labels.walletUnavailableError);
      // ignore: experimental_member_use
      final result = await ndk.wallets.receive(
        walletId: wallet.id,
        amountSats: widget.amountSats,
      );
      final invoice = extractBolt11Invoice(result);
      if (invoice == null) {
        throw FormatException(widget.labels.missingBolt11Error);
      }
      if (mounted) _invoiceController.text = invoice;
    } catch (error) {
      Logger.log.e(
        () => '[ReceivingInvoiceForm] Invoice generation failed: $error',
      );
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.labels.generationError(error))),
        );
      }
    } finally {
      if (mounted) setState(() => _generatingWalletId = null);
    }
  }

  Future<void> _submit() async {
    if (_busy || !widget.enabled) return;
    final invoice = _invoiceController.text.trim();
    if (invoice.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(widget.labels.emptyInvoiceError)));
      return;
    }

    setState(() => _submitting = true);
    try {
      await widget.onSubmit(invoice);
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final wallets = <({Wallet wallet, bool isDefault})>[
      if (_defaultReceivingWallet != null)
        (wallet: _defaultReceivingWallet!, isDefault: true),
      for (final wallet in _otherReceivingWallets)
        (wallet: wallet, isDefault: false),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (wallets.isNotEmpty) ...[
          const Divider(height: 1),
          const SizedBox(height: 12),
          Text(
            widget.labels.walletSectionTitle,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          RadioGroup<String>(
            groupValue: _selectedWalletId,
            onChanged: (walletId) {
              if (walletId == null) return;
              final wallet =
                  wallets
                      .where((entry) => entry.wallet.id == walletId)
                      .firstOrNull
                      ?.wallet;
              if (wallet != null) _generateInvoice(wallet);
            },
            child: Column(
              children: [
                for (final entry in wallets)
                  _walletTile(entry.wallet, isDefault: entry.isDefault),
              ],
            ),
          ),
        ] else ...[
          Text(
            widget.labels.noReceivingWalletMessage,
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 8),
        ],
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: _busy || !widget.enabled ? null : _openWalletSettings,
            icon: const Icon(Icons.add),
            label: Text(widget.labels.addWalletLabel),
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _invoiceController,
          enabled: widget.enabled && !_submitting,
          decoration: InputDecoration(
            labelText: widget.labels.invoiceLabel,
            hintText: widget.labels.invoiceHint,
            border: const OutlineInputBorder(),
          ),
          maxLines: 2,
        ),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: _busy || !widget.enabled ? null : _submit,
          child:
              _submitting
                  ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                  : Text(widget.labels.submitLabel),
        ),
      ],
    );
  }

  Widget _walletTile(Wallet wallet, {required bool isDefault}) {
    final isGenerating = _generatingWalletId == wallet.id;
    final isSelected = _selectedWalletId == wallet.id;
    final enabled = !_busy && widget.enabled;
    final amount = formatBitcoinAmount(
      context,
      ref.watch(bitcoinDisplayUnitProvider),
      widget.amountSats,
    );
    final colorScheme = Theme.of(context).colorScheme;
    return Card(
      margin: const EdgeInsets.only(bottom: 6),
      elevation: 0,
      color:
          isSelected
              ? colorScheme.primaryContainer.withValues(alpha: 0.5)
              : null,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: BorderSide(
          color: isSelected ? colorScheme.primary : colorScheme.outlineVariant,
          width: isSelected ? 1.5 : 1,
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: enabled ? () => _generateInvoice(wallet) : null,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Row(
            children: [
              Radio<String>(
                value: wallet.id,
                enabled: enabled,
                visualDensity: VisualDensity.compact,
              ),
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
                        Flexible(
                          child: Text(
                            wallet.name,
                            style: const TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        if (isDefault) ...[
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 5,
                              vertical: 1,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              widget.labels.defaultWalletLabel,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                    Text(
                      widget.labels.tapToGenerate(amount),
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
      ),
    );
  }
}
