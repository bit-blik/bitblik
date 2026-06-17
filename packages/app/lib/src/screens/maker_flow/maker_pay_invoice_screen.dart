import 'dart:async';
import 'dart:io'; // For Platform check
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // For Clipboard
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:url_launcher/url_launcher.dart'; // For launching URLs/Intents
import 'package:android_intent_plus/android_intent.dart'; // For Android Intents
import 'package:android_intent_plus/flag.dart'; // Import for flags enum
import '../../providers/providers.dart'; // Import providers
import '../../config/build_flavor.dart' show buildQrLogoAsset;
import 'package:bitblik_core/core.dart'; // Import Offer model for status enum comparison
import 'package:ndk/domain_layer/entities/wallet/wallet.dart';
import 'package:ndk/domain_layer/entities/wallet/providers/nwc/nwc_wallet.dart';
import 'package:ndk/domain_layer/entities/wallet/wallet_balance.dart';
import 'package:ndk/domain_layer/usecases/nwc/consts/budget_renewal_period.dart';
import 'package:ndk/domain_layer/usecases/nwc/consts/nwc_method.dart';
// Import ApiService
import 'package:go_router/go_router.dart';
import '../../../i18n/gen/strings.g.dart'; // Correct Slang import
import 'webln_stub.dart' if (dart.library.js) 'webln_web.dart';
import 'maker_amount_form.dart'; // Import MakerProgressIndicator
import '../../utils/bitcoin_display.dart';
import '../../widgets/premium_info.dart';

// ---------------------------------------------------------------------------
// Budget warning helpers
// ---------------------------------------------------------------------------

class _WalletBudgetInfo {
  final String walletId;
  final String walletName;
  final int balance; // sats (cached; 0 if not yet loaded)
  final int? remainingBudget; // sats; null = NWC budget unavailable
  final bool hasBalanceIssue;
  final bool hasBudgetIssue;

  /// Unix timestamp (seconds) when the NWC budget renews; null if unknown.
  final int? budgetRenewsAt;
  final BudgetRenewalPeriod? budgetRenewalPeriod;

  bool get mightFail => hasBalanceIssue || hasBudgetIssue;

  const _WalletBudgetInfo({
    required this.walletId,
    required this.walletName,
    required this.balance,
    this.remainingBudget,
    required this.hasBalanceIssue,
    required this.hasBudgetIssue,
    this.budgetRenewsAt,
    this.budgetRenewalPeriod,
  });
}

class _BudgetDialogResult {
  final bool proceed;
  final String? selectedWalletId;
  const _BudgetDialogResult({required this.proceed, this.selectedWalletId});
}

// ---------------------------------------------------------------------------

class MakerPayInvoiceScreen extends ConsumerStatefulWidget {
  const MakerPayInvoiceScreen({super.key});

  @override
  ConsumerState<MakerPayInvoiceScreen> createState() =>
      _MakerPayInvoiceScreenState();
}

class _MakerPayInvoiceScreenState extends ConsumerState<MakerPayInvoiceScreen> {
  bool isWallet = false;
  bool _sentWeblnPayment = false;
  bool _isPayingWithWallet = false;
  bool _hasSendingWallet = false;
  bool _isCancelling = false;
  StreamSubscription<List<Wallet>>? _walletsSubscription;

  Future<void> _handleCancelPressed() async {
    final t = Translations.of(context);
    setState(() => _isCancelling = true);
    try {
      await ref.read(activeOfferProvider.notifier).cancelActiveOffer();
      if (!mounted) return;
      context.go('/');
    } on OfferAlreadyFundedException {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.maker.payInvoice.errors.cancelOfferAlreadyFunded),
        ),
      );
      // Coordinator says we're funded — surface that flow.
      context.go('/wait-taker');
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.maker.payInvoice.errors.cancelFailed(details: e.toString()),
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _isCancelling = false);
      unawaited(_refreshWalletBalanceAndBudget());
    }
  }

  @override
  void initState() {
    super.initState();

    try {
      checkWeblnSupport((supported) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('checking webLN support')),
        // ); // Can be localized if needed
        // print("!!!!!!!!!!!!!!! isWallet: $isWallet, supported: $supported");
        if (mounted) {
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('webLN support: $supported')),
          // ); // Can be localized if needed
          setState(() {
            isWallet = supported;
          });
        }
      });
    } catch (e) {
      // print("!!!!catch $e");
    }
    _syncWalletState();
    _fetchDefaultWalletBudget();
    final ndk = ref.read(ndkProvider);
    if (ndk != null) {
      _walletsSubscription = ndk.wallets.walletsStream.listen((_) {
        _syncWalletState();
      });
    }
    // No longer need to start polling - will use subscription instead
  }

  @override
  void dispose() {
    _walletsSubscription?.cancel();
    super.dispose();
  }

  Future<void> _syncWalletState() async {
    final ndk = ref.read(ndkProvider);
    if (ndk == null) {
      if (mounted) {
        setState(() {
          _hasSendingWallet = false;
        });
      }
      return;
    }

    final wallets = ndk.wallets.getWalletsForUnit('sat');
    final sendingWallets = wallets.where((wallet) => wallet.canSend).toList();
    final hasSendingWallet = sendingWallets.isNotEmpty;

    final defaultSendingWallet = ndk.wallets.defaultWalletForSending;
    if (hasSendingWallet &&
        (defaultSendingWallet == null || !defaultSendingWallet.canSend)) {
      ndk.wallets.setDefaultWalletForSending(sendingWallets.first.id);
    }

    ref.read(defaultWalletProvider.notifier).refresh();

    if (!mounted) return;
    setState(() {
      _hasSendingWallet = hasSendingWallet;
    });

    // Re-fetch budget whenever the default wallet may have changed.
    _fetchDefaultWalletBudget();
  }

  /// Formats a unix-seconds timestamp as a human-readable "time until" string.
  /// Examples: "3d", "5h", "20m", "<1m".
  String _formatRenewsIn(int renewsAtUnix) {
    final renews = DateTime.fromMillisecondsSinceEpoch(renewsAtUnix * 1000);
    final diff = renews.difference(DateTime.now());
    if (diff.isNegative) return '';
    if (diff.inDays >= 1) return '${diff.inDays}d';
    if (diff.inHours >= 1) return '${diff.inHours}h';
    if (diff.inMinutes >= 1) return '${diff.inMinutes}m';
    return '<1m';
  }

  /// Returns the sat balance for [walletId] via NDK's own balance stream.
  /// If the stream already has a cached value it resolves immediately; otherwise
  /// it waits for the first NWC response (up to 5 s), falling back to 0.
  Future<int> _walletSatBalance(dynamic ndk, String walletId) async {
    try {
      final bs = await ndk.wallets
          .getBalancesStream(walletId)
          .first
          .timeout(const Duration(seconds: 5));
      for (final b in bs) {
        if (b.unit == 'sat') return b.amount as int;
      }
    } catch (_) {}
    return ndk.wallets.getBalance(walletId, 'sat') as int;
  }

  /// Refreshes the NDK balance cache for [walletId] (default wallet if null)
  /// via a live NWC get_balance call, then re-fetches budget for the default
  /// sending wallet. Call fire-and-forget after payment attempts and cancels.
  Future<void> _refreshWalletBalanceAndBudget({String? walletId}) async {
    if (!mounted) return;
    final ndk = ref.read(ndkProvider);
    if (ndk == null) return;

    // Locate the wallet used for the payment.
    NwcWallet? wallet;
    if (walletId != null) {
      for (final w in ndk.wallets.getWalletsForUnit('sat')) {
        if (w.id == walletId && w is NwcWallet) {
          wallet = w;
          break;
        }
      }
    }
    wallet ??=
        ndk.wallets.defaultWalletForSending is NwcWallet
            ? ndk.wallets.defaultWalletForSending as NwcWallet
            : null;

    if (wallet == null || wallet.connection == null) return;

    // Live balance query → push into NDK cache (updates wallet screen too).
    try {
      final resp = await ndk.nwc.getBalance(
        wallet.connection!,
        timeout: const Duration(seconds: 10),
      );
      if (wallet.balanceSubject != null && !wallet.balanceSubject!.isClosed) {
        wallet.balanceSubject!.add([
          WalletBalance(
            walletId: wallet.id,
            unit: 'sat',
            amount: resp.balanceSats,
          ),
        ]);
      }
    } catch (_) {}

    // Always re-fetch budget for the default wallet — it's what the next
    // payment attempt checks against.
    if (mounted) _fetchDefaultWalletBudget();
  }

  /// Pre-fetches NWC budget for the default sending wallet and stores the
  /// result directly on [NwcWallet.cachedRemainingBudgetSats] so that
  /// [_checkBudgetAndPay] has data before the first NWC payment notification
  /// fires. No screen state is updated — NDK owns the cache.
  Future<void> _fetchDefaultWalletBudget() async {
    if (!mounted) return;
    final ndk = ref.read(ndkProvider);
    if (ndk == null) return;
    final defaultWallet = ndk.wallets.defaultWalletForSending;
    if (defaultWallet is! NwcWallet || defaultWallet.connection == null) return;

    // Skip if wallet doesn't advertise get_budget support.
    final effectivePerms =
        defaultWallet.connection!.permissions.isNotEmpty
            ? defaultWallet.connection!.permissions
            : defaultWallet.cachedPermissions;
    if (!effectivePerms.contains(NwcMethod.GET_BUDGET.name)) return;

    // Skip if balance is already the limiting factor — budget irrelevant.
    final offer = ref.read(activeOfferProvider);
    if (offer != null) {
      final balance = ndk.wallets.getBalance(defaultWallet.id, 'sat');
      if (balance < offer.amountSats) return;
    }

    try {
      final budget = await ndk.nwc
          .getBudget(defaultWallet.connection!)
          .timeout(const Duration(seconds: 10));
      // totalBudget == 0 → no spending limit configured → null (unlimited).
      defaultWallet.cachedRemainingBudgetSats =
          budget.totalBudget > 0
              ? budget.totalBudgetSats - budget.userBudgetSats
              : null;
    } catch (e) {
      Logger.log.w(
        () =>
            '[MakerPayInvoiceScreen] Could not fetch default wallet NWC budget: $e',
      );
    }
  }

  // --- Status Update Handler ---
  void _handleStatusUpdate(
    OfferStatus? status,
    String coordinatorPubkey,
  ) async {
    if (status == null || !mounted) return;

    Logger.log.d(
      () => '[MakerPayInvoiceScreen] Status update received: $status',
    );

    // final publicKey = ref.read(publicKeyProvider).value;
    // if (publicKey == null) {
    //   throw Exception(t.maker.payInvoice.errors.publicKeyNotAvailable);
    // }
    //
    // final apiService = ref.read(apiServiceProvider);
    // final fullOfferData = await apiService.getOfferDetails(
    //   publicKey,
    //   coordinatorPubkey,
    // );
    // final offer = ref.read(activeOfferProvider);
    //
    // if (fullOfferData == null || offer == null) {
    //   throw Exception(t.maker.payInvoice.errors.couldNotFetchActive);
    // }

    // Map<String, dynamic> json = offer.toJson();
    //
    // json['id'] = fullOfferData['id'];
    // json['status'] = fullOfferData['status'];
    // json['created_at'] = fullOfferData['created_at'];
    // json['fiat_amount'] = fullOfferData['fiat_amount'];
    // json['fiat_currency'] = fullOfferData['fiat_currency'];
    // json['amount_sats'] = fullOfferData['amount_sats'];
    // json['maker_fees'] = fullOfferData['maker_fees'];
    //
    // final updatedOffer = Offer.fromJson(json);
    // await ref.read(activeOfferProvider.notifier).setActiveOffer(updatedOffer);

    if (status.index >= OfferStatus.funded.index) {
      Logger.log.i(
        () =>
            '[MakerPayInvoiceScreen] Invoice paid! Offer status: $status. Moving to next step.',
      );
      // Hold invoice accepted — balance has been debited. Refresh now so wallet
      // settings and next budget check reflect the new balance immediately.
      final usedWalletId = ref.read(activeOfferProvider)?.paymentWalletId;
      unawaited(_refreshWalletBalanceAndBudget(walletId: usedWalletId));
      if (mounted) {
        context.go("/wait-taker");
      }
      _isPayingWithWallet = false;
    } else {
      Logger.log.d(
        () =>
            '[MakerPayInvoiceScreen] Offer status: $status. No action needed yet.',
      );
    }
  }

  // --- Budget check + warning dialog ---

  /// Called when the user taps Pay. Checks balance and (pre-fetched) NWC
  /// budget for the default wallet. If either is too low, shows a warning
  /// dialog that lets the user pick an alternate wallet or proceed anyway.
  Future<void> _checkBudgetAndPay(String invoice) async {
    final ndk = ref.read(ndkProvider);
    final offer = ref.read(activeOfferProvider);

    if (ndk == null || offer == null) {
      await _payWithNwc(invoice);
      return;
    }

    final requiredSats = offer.amountSats;
    final defaultWallet = ndk.wallets.defaultWalletForSending;
    if (defaultWallet == null) {
      await _payWithNwc(invoice);
      return;
    }

    // Use NDK's balance stream: returns immediately if already cached,
    // otherwise waits for the NWC round-trip to populate the cache.
    int balance = await _walletSatBalance(ndk, defaultWallet.id);
    final hasBalanceIssue = balance < requiredSats;
    int? remainingBudget =
        defaultWallet is NwcWallet
            ? defaultWallet.cachedRemainingBudgetSats
            : null;
    bool hasBudgetIssue =
        remainingBudget != null && remainingBudget < requiredSats;

    if (!hasBalanceIssue && !hasBudgetIssue) {
      await _payWithNwc(invoice);
      return;
    }

    // Budget issue detected — fetch live get_budget for the default wallet to
    // get accurate remaining budget and renewal info for the dialog.
    int? defaultRenewsAt;
    BudgetRenewalPeriod? defaultRenewalPeriod;
    if (hasBudgetIssue &&
        defaultWallet is NwcWallet &&
        defaultWallet.connection != null) {
      try {
        final b = await ndk.nwc
            .getBudget(defaultWallet.connection!)
            .timeout(const Duration(seconds: 5));
        if (b.totalBudget > 0) {
          remainingBudget = b.totalBudgetSats - b.userBudgetSats;
          hasBudgetIssue = remainingBudget < requiredSats;
          defaultWallet.cachedRemainingBudgetSats = remainingBudget;
        } else {
          remainingBudget = null;
          hasBudgetIssue = false;
        }
        defaultRenewsAt = b.renewsAt;
        defaultRenewalPeriod = b.renewalPeriod;
      } catch (_) {}
    }

    // Re-check after live budget refresh — might now be fine.
    if (!hasBalanceIssue && !hasBudgetIssue) {
      await _payWithNwc(invoice);
      return;
    }

    // Build default wallet info.
    final defaultInfo = _WalletBudgetInfo(
      walletId: defaultWallet.id,
      walletName: defaultWallet.name,
      balance: balance,
      remainingBudget: remainingBudget,
      hasBalanceIssue: hasBalanceIssue,
      hasBudgetIssue: hasBudgetIssue,
      budgetRenewsAt: defaultRenewsAt,
      budgetRenewalPeriod: defaultRenewalPeriod,
    );

    // Fetch info for every other NWC+canSend wallet for the picker.
    // Live get_budget call per wallet so budget issues and renewal times
    // are accurate at the moment the dialog is shown.
    final allSendingWallets =
        ndk.wallets
            .getWalletsForUnit('sat')
            .where((w) => w.canSend && w.id != defaultWallet.id)
            .toList();

    final otherInfos = <_WalletBudgetInfo>[];
    for (final w in allSendingWallets) {
      final bal = await _walletSatBalance(ndk, w.id);
      int? remainBudget;
      bool budgetIssue = false;
      int? renewsAt;
      BudgetRenewalPeriod? renewalPeriod;
      if (w is NwcWallet && w.connection != null) {
        try {
          final b = await ndk.nwc
              .getBudget(w.connection!)
              .timeout(const Duration(seconds: 5));
          if (b.totalBudget > 0) {
            remainBudget = b.totalBudgetSats - b.userBudgetSats;
            budgetIssue = remainBudget < requiredSats;
            if (budgetIssue) {
              renewsAt = b.renewsAt;
              renewalPeriod = b.renewalPeriod;
            }
          }
        } catch (_) {}
      }
      otherInfos.add(
        _WalletBudgetInfo(
          walletId: w.id,
          walletName: w.name,
          balance: bal,
          remainingBudget: remainBudget,
          hasBalanceIssue: bal < requiredSats,
          hasBudgetIssue: budgetIssue,
          budgetRenewsAt: renewsAt,
          budgetRenewalPeriod: renewalPeriod,
        ),
      );
    }

    if (!mounted) return;

    final result = await _showBudgetWarningDialog(
      defaultInfo: defaultInfo,
      otherWalletInfos: otherInfos,
      requiredSats: requiredSats,
    );

    if (result == null || !result.proceed) return;

    // Use selected wallet for this payment only — do NOT change the default.
    // The default wallet's budget may renew before the next offer.
    await _payWithNwc(invoice, walletId: result.selectedWalletId);
  }

  Widget _hintBox(String text) => Container(
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: Colors.blue.shade50,
      borderRadius: BorderRadius.circular(8),
    ),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(Icons.info_outline, size: 15, color: Colors.blue[700]),
        const SizedBox(width: 6),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: Colors.blue[900]),
          ),
        ),
      ],
    ),
  );

  Future<_BudgetDialogResult?> _showBudgetWarningDialog({
    required _WalletBudgetInfo defaultInfo,
    required List<_WalletBudgetInfo> otherWalletInfos,
    required int requiredSats,
  }) async {
    final t = Translations.of(context);
    final bw = t.maker.payInvoice.budgetWarning;
    final bitcoinDisplayUnit = ref.read(bitcoinDisplayUnitProvider);

    return showDialog<_BudgetDialogResult>(
      context: context,
      barrierDismissible: false,
      builder: (ctx) {
        // null = no alternative selected — uses default wallet if "try anyway".
        String? selectedAlternativeId;
        // Live copy of default wallet info, updated by the refresh button.
        _WalletBudgetInfo liveDefault = defaultInfo;
        bool isRefreshing = false;

        return StatefulBuilder(
          builder: (ctx, setDialogState) {
            // Smart refresh:
            //   balance issue   → re-read cached balance only
            //   budget issue (balance ok) → re-fetch NWC budget only
            Future<void> doRefresh() async {
              setDialogState(() => isRefreshing = true);
              final ndk = ref.read(ndkProvider);
              if (ndk == null) {
                setDialogState(() => isRefreshing = false);
                return;
              }
              final wallet = ndk.wallets.defaultWalletForSending;
              if (wallet == null) {
                setDialogState(() => isRefreshing = false);
                return;
              }

              int newBalance = liveDefault.balance;
              int? newBudget = liveDefault.remainingBudget;
              int? newRenewsAt = liveDefault.budgetRenewsAt;
              BudgetRenewalPeriod? newRenewalPeriod =
                  liveDefault.budgetRenewalPeriod;

              if (liveDefault.hasBalanceIssue) {
                // For NWC wallets, query the relay directly for a live balance.
                // For other types, fall back to the local cache.
                if (wallet is NwcWallet && wallet.connection != null) {
                  try {
                    final resp = await ndk.nwc.getBalance(
                      wallet.connection!,
                      timeout: const Duration(seconds: 5),
                    );
                    newBalance = resp.balanceSats;
                  } catch (_) {
                    newBalance = ndk.wallets.getBalance(wallet.id, 'sat');
                  }
                } else {
                  newBalance = ndk.wallets.getBalance(wallet.id, 'sat');
                }
              } else if (liveDefault.hasBudgetIssue &&
                  wallet is NwcWallet &&
                  wallet.connection != null) {
                // Balance is fine — refresh NWC budget only.
                try {
                  final b = await ndk.nwc
                      .getBudget(wallet.connection!)
                      .timeout(const Duration(seconds: 5));
                  newBudget =
                      b.totalBudget > 0
                          ? b.totalBudgetSats - b.userBudgetSats
                          : null;
                  newRenewsAt = b.renewsAt;
                  newRenewalPeriod = b.renewalPeriod;
                } catch (_) {}
                // Persist refreshed budget to NDK wallet cache.
                wallet.cachedRemainingBudgetSats = newBudget;
              }

              // Push fresh balance into NDK's in-memory cache so
              // ndk.wallets.getBalance() and balance streams (e.g. wallet
              // settings screen) reflect the updated value immediately.
              if (wallet is NwcWallet &&
                  wallet.balanceSubject != null &&
                  !wallet.balanceSubject!.isClosed) {
                wallet.balanceSubject!.add([
                  WalletBalance(
                    walletId: wallet.id,
                    unit: 'sat',
                    amount: newBalance,
                  ),
                ]);
              }

              setDialogState(() {
                liveDefault = _WalletBudgetInfo(
                  walletId: wallet.id,
                  walletName: wallet.name,
                  balance: newBalance,
                  remainingBudget: newBudget,
                  hasBalanceIssue: newBalance < requiredSats,
                  hasBudgetIssue: newBudget != null && newBudget < requiredSats,
                  budgetRenewsAt: newRenewsAt,
                  budgetRenewalPeriod: newRenewalPeriod,
                );
                isRefreshing = false;
              });
            }

            Widget infoRow(IconData icon, String label, {Color? color}) =>
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 2),
                  child: Row(
                    children: [
                      Icon(icon, size: 15, color: color ?? Colors.grey[600]),
                      const SizedBox(width: 6),
                      Text(
                        label,
                        style: TextStyle(
                          fontSize: 13,
                          color: color ?? Colors.grey[800],
                        ),
                      ),
                    ],
                  ),
                );

            // "Pay" button in actions enabled only when a wallet without
            // funding issues is selected.
            final selectedAlt =
                selectedAlternativeId != null
                    ? otherWalletInfos.cast<_WalletBudgetInfo?>().firstWhere(
                      (w) => w!.walletId == selectedAlternativeId,
                      orElse: () => null,
                    )
                    : null;
            final canPayWithAlt = selectedAlt != null && !selectedAlt.mightFail;

            // After a successful refresh the default wallet may now be fine.
            final allClear = !liveDefault.mightFail;

            return AlertDialog(
              title: Row(
                children: [
                  Icon(
                    allClear
                        ? Icons.check_circle_outline
                        : Icons.warning_amber_rounded,
                    color: allClear ? Colors.green : Colors.orange,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      allClear ? bw.readyTitle : bw.title,
                      style: const TextStyle(fontSize: 17),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    visualDensity: VisualDensity.compact,
                    padding: EdgeInsets.zero,
                    onPressed: () => Navigator.of(ctx).pop(null),
                  ),
                ],
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Issue description — uses live data and wallet name
                    if (liveDefault.hasBalanceIssue)
                      Text(
                        bw.balanceTooLow(name: liveDefault.walletName),
                        style: const TextStyle(fontSize: 14),
                      ),
                    if (liveDefault.hasBudgetIssue)
                      Text(
                        bw.budgetTooLow(name: liveDefault.walletName),
                        style: const TextStyle(fontSize: 14),
                      ),
                    const SizedBox(height: 10),

                    // Amount details — live data
                    infoRow(
                      Icons.account_balance_wallet_outlined,
                      bw.balanceLine(
                        available: formatBitcoinAmount(
                          context,
                          bitcoinDisplayUnit,
                          liveDefault.balance,
                        ),
                      ),
                      color:
                          liveDefault.hasBalanceIssue ? Colors.red[700] : null,
                    ),
                    if (liveDefault.remainingBudget != null)
                      infoRow(
                        Icons.tune,
                        bw.budgetLine(
                          remaining: formatBitcoinAmount(
                            context,
                            bitcoinDisplayUnit,
                            liveDefault.remainingBudget!,
                          ),
                        ),
                        color:
                            liveDefault.hasBudgetIssue ? Colors.red[700] : null,
                      ),
                    if (liveDefault.hasBudgetIssue &&
                        liveDefault.budgetRenewsAt != null &&
                        liveDefault.budgetRenewalPeriod !=
                            BudgetRenewalPeriod.never)
                      infoRow(
                        Icons.autorenew,
                        '${t.nwc.labels.renewsIn} ${_formatRenewsIn(liveDefault.budgetRenewsAt!)}',
                        color: Colors.grey[600],
                      ),
                    infoRow(
                      Icons.bolt,
                      bw.requiredLine(
                        required: formatBitcoinAmount(
                          context,
                          bitcoinDisplayUnit,
                          requiredSats,
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Context-aware hint boxes:
                    // • balance issue  → generic "add funds" hint
                    // • NWC budget issue → NWC-specific budget hint
                    if (liveDefault.hasBalanceIssue)
                      _hintBox(bw.addFundsHint(name: liveDefault.walletName)),
                    if (liveDefault.hasBalanceIssue &&
                        liveDefault.hasBudgetIssue)
                      const SizedBox(height: 6),
                    if (liveDefault.hasBudgetIssue)
                      _hintBox(bw.increaseBudgetHint),

                    const SizedBox(height: 16),

                    // Primary actions row — adapts after a successful refresh.
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // "Try anyway" hidden once wallet looks fine.
                        if (!allClear)
                          TextButton(
                            onPressed:
                                () => Navigator.of(ctx).pop(
                                  _BudgetDialogResult(
                                    proceed: true,
                                    selectedWalletId: null,
                                  ),
                                ),
                            child: Text(bw.payAnyway),
                          ),
                        // Refresh spinner / button
                        IconButton(
                          tooltip: 'Refresh',
                          icon:
                              isRefreshing
                                  ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                  : const Icon(Icons.refresh),
                          onPressed: isRefreshing ? null : doRefresh,
                        ),
                        // Cancel → Pay once all clear.
                        if (allClear)
                          ElevatedButton.icon(
                            autofocus: true,
                            icon: const Icon(Icons.bolt),
                            label: Text(t.maker.payInvoice.actions.payWithNwc),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.orange[700],
                              foregroundColor: Colors.white,
                            ),
                            onPressed:
                                () => Navigator.of(ctx).pop(
                                  _BudgetDialogResult(
                                    proceed: true,
                                    selectedWalletId: null,
                                  ),
                                ),
                          )
                        else
                          OutlinedButton(
                            autofocus: true,
                            style: OutlinedButton.styleFrom(
                              backgroundColor: Colors.grey[100],
                              side: BorderSide(color: Colors.orange[700]!),
                              foregroundColor: Colors.orange[700],
                            ),
                            onPressed: () => Navigator.of(ctx).pop(null),
                            child: Text(bw.cancel),
                          ),
                      ],
                    ),

                    // Wallet picker — default excluded, alternatives only
                    if (otherWalletInfos.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Divider(height: 1),
                      const SizedBox(height: 12),
                      Text(
                        bw.switchWalletLabel,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 6),
                      ...otherWalletInfos.map((info) {
                        final isSelected =
                            info.walletId == selectedAlternativeId;
                        final renewsInStr =
                            info.hasBudgetIssue &&
                                    info.budgetRenewsAt != null &&
                                    info.budgetRenewalPeriod !=
                                        BudgetRenewalPeriod.never
                                ? _formatRenewsIn(info.budgetRenewsAt!)
                                : null;
                        final parts = <String>[
                          bw.balanceLine(
                            available: formatBitcoinAmount(
                              context,
                              bitcoinDisplayUnit,
                              info.balance,
                            ),
                          ),
                          if (info.remainingBudget != null)
                            bw.budgetLine(
                              remaining: formatBitcoinAmount(
                                context,
                                bitcoinDisplayUnit,
                                info.remainingBudget!,
                              ),
                            ),
                          if (renewsInStr != null && renewsInStr.isNotEmpty)
                            '${t.nwc.labels.renewsIn} $renewsInStr',
                        ];
                        final subLine = parts.join(' · ');

                        return InkWell(
                          onTap:
                              () => setDialogState(
                                () => selectedAlternativeId = info.walletId,
                              ),
                          borderRadius: BorderRadius.circular(8),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  isSelected
                                      ? Colors.orange.shade50
                                      : Colors.transparent,
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  isSelected
                                      ? Border.all(
                                        color: Colors.orange.shade200,
                                      )
                                      : null,
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  isSelected
                                      ? Icons.radio_button_checked
                                      : Icons.radio_button_unchecked,
                                  size: 20,
                                  color:
                                      isSelected
                                          ? Colors.orange[700]
                                          : Colors.grey[400],
                                ),
                                const SizedBox(width: 8),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        info.walletName,
                                        style: const TextStyle(fontSize: 14),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        subLine,
                                        style: TextStyle(
                                          fontSize: 11,
                                          color: Colors.grey[600],
                                        ),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                                if (info.mightFail)
                                  Container(
                                    margin: const EdgeInsets.only(left: 6),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.orange.shade100,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Text(
                                      bw.walletLowFundsTag,
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.orange[900],
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ],
                  ],
                ),
              ),
              // "Pay with selected wallet" — only active when selection is good
              actions:
                  otherWalletInfos.isEmpty
                      ? null
                      : [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.bolt),
                            label: Text(t.maker.payInvoice.actions.payWithNwc),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  canPayWithAlt
                                      ? Colors.orange[700]
                                      : Colors.grey[300],
                              foregroundColor:
                                  canPayWithAlt
                                      ? Colors.white
                                      : Colors.grey[600],
                            ),
                            onPressed:
                                canPayWithAlt
                                    ? () => Navigator.of(ctx).pop(
                                      _BudgetDialogResult(
                                        proceed: true,
                                        selectedWalletId: selectedAlternativeId,
                                      ),
                                    )
                                    : null,
                          ),
                        ),
                      ],
            );
          },
        );
      },
    );
  }

  // --- Intent/URL Launching ---
  Future<void> _launchLightningUrl(String invoice) async {
    if (kIsWeb) {
      Logger.log.d(() => "!! launch lightning URL -> sending invoice");
      bool webLnSuccess = true;
      await sendWeblnPayment(invoice).then((_) {}).catchError((e) {
        // if (mounted) {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('WebLN payment failed: $e')),
        //   ); // Can be localized if needed
        // }
        webLnSuccess = false;
      });
      if (webLnSuccess) {
        return;
      }
    }

    final link = 'lightning:$invoice';
    try {
      if (!kIsWeb && Platform.isAndroid) {
        final intent = AndroidIntent(
          action: 'action_view',
          data: link,
          flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
        );
        await intent.launch();
      } else {
        final url = Uri.parse(link);
        // if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
        // } else {
        //   if (kDebugMode) {
        //     Logger.log.w(() => 'Could not launch $link');
        //   }
        //   if (mounted) {
        //     ScaffoldMessenger.of(context).showSnackBar(
        //       SnackBar(
        //         content: Text(t.maker.payInvoice.errors.couldNotOpenApp),
        //       ),
        //     );
        //   }
        // }
      }
    } catch (e) {
      Logger.log.e(() => 'Error launching lightning URL: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.maker.payInvoice.errors.openingApp(details: e.toString()),
            ),
          ),
        );
      }
    }
  }

  Future<void> _payWithNwc(String invoice, {String? walletId}) async {
    final t = Translations.of(context);
    final ndk = ref.read(ndkProvider);
    final defaultWallet = ref.read(defaultWalletProvider);

    if (ndk == null || defaultWallet == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.maker.payInvoice.errors.nwcNotConnected),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isPayingWithWallet = true;
    });

    // Persist which wallet is being used so other screens (e.g. wait-taker
    // cancel) can refresh the correct wallet's balance/budget after restart.
    final effectiveWalletId =
        walletId ?? ndk.wallets.defaultWalletForSending?.id;
    final currentOffer = ref.read(activeOfferProvider);
    if (currentOffer != null && effectiveWalletId != null) {
      unawaited(
        ref
            .read(activeOfferProvider.notifier)
            .setActiveOffer(
              currentOffer.copyWith(paymentWalletId: effectiveWalletId),
            ),
      );
    }

    try {
      await ndk.wallets.send(
        walletId: walletId,
        invoice: invoice,
        timeout: const Duration(seconds: 30),
      );
      // Note: Code below is unreachable until payment is implemented
      // Logger.log.i(() => '[MakerPayInvoiceScreen] Invoice accepted');
      // if (mounted) {
      //   context.go("/wait-taker");
      // }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Payment failed: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isPayingWithWallet = false;
        });
      }
      unawaited(_refreshWalletBalanceAndBudget(walletId: walletId));
    }
  }

  Widget _buildNwcButtons(
    BuildContext context,
    WidgetRef ref,
    String holdInvoice,
    Translations t,
  ) {
    final isConnected = _hasSendingWallet;
    if (!isConnected) {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          icon: const Icon(Icons.wallet),
          label: Text(t.maker.payInvoice.actions.connectWallet),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            await context.push('/wallet');
            if (!mounted) return;
            for (var i = 0; i < 6; i++) {
              await _syncWalletState();
              if (_hasSendingWallet) break;
              await Future<void>.delayed(const Duration(milliseconds: 250));
            }
          },
        ),
      );
    }

    // Show pay button with balance
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon:
            _isPayingWithWallet
                ? const SizedBox(
                  width: 16,
                  height: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                )
                : const Icon(Icons.bolt),
        label: Text(
          _isPayingWithWallet
              ? t.maker.payInvoice.actions.paying
              : isConnected
              ? t.maker.payInvoice.actions.payWithNwc
              : t.maker.payInvoice.actions.connectWallet,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orange[700],
          foregroundColor: Colors.white,
        ),
        onPressed:
            _isPayingWithWallet ? null : () => _checkBudgetAndPay(holdInvoice),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (next != null && mounted) {
        _handleStatusUpdate(next.statusEnum, next.coordinatorPubkey);
      }
    });

    final offer = ref.watch(activeOfferProvider);
    final t = Translations.of(context);

    final holdInvoiceFromProvider = ref.watch(holdInvoiceProvider);
    // Get hold invoice from either provider or active offer
    final holdInvoice = holdInvoiceFromProvider ?? offer?.holdInvoice;

    // WebLN auto-pay logic
    if (isWallet && holdInvoice != null && !_sentWeblnPayment) {
      Logger.log.d(
        () => "isWallet: $isWallet, _sentWeblnPayment: $_sentWeblnPayment",
      );
      sendWeblnPayment(holdInvoice)
          .then((_) {
            if (mounted) {
              setState(() {
                _sentWeblnPayment = true;
              });
            }
          })
          .catchError((e) {
            // Handle error if needed
          });
    }

    // Add Scaffold wrapper
    return Builder(
      builder: (context) {
        if (holdInvoice == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  t.offers.errors.detailsMissing,
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  'Hold invoice not available for this offer.',
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: Text(t.common.buttons.goHome),
                ),
              ],
            ),
          );
        }

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Progress indicator (Step 1: Create Offer)
                const MakerProgressIndicator(activeStep: 1),
                // Text(
                //   t.maker.payInvoice.title,
                //   style: const TextStyle(fontSize: 18),
                //   textAlign: TextAlign.center,
                // ),
                // const SizedBox(height: 15),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 15,
                      height: 15,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    SizedBox(width: 8),
                    Text(
                      t.maker.payInvoice.feedback.waitingConfirmation,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Center(
                  child: GestureDetector(
                    onTap: () => _launchLightningUrl(holdInvoice),
                    child: Container(
                      width: 250,
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(color: Colors.white),
                      child: PrettyQrView.data(
                        data: holdInvoice.toUpperCase(),
                        errorCorrectLevel: QrErrorCorrectLevel.M,
                        decoration: PrettyQrDecoration(
                          quietZone: PrettyQrQuietZone.standart,
                          background: Colors.white,
                          shape: const PrettyQrSmoothSymbol(
                            color: Colors.black,
                            roundFactor: 0.3,
                          ),
                          image: PrettyQrDecorationImage(
                            scale: 0.3,
                            image: AssetImage(buildQrLogoAsset),
                          ),
                        ),
                      ),
                    ),
                    // child: QrImageView(
                    //   data: holdInvoice.toUpperCase(),
                    //   version: QrVersions.auto,
                    //   size: 200.0,
                    //   backgroundColor: Colors.white,
                    //   embeddedImage: const AssetImage('assets/logo.png'),
                    //   embeddedImageStyle: QrEmbeddedImageStyle(
                    //     size: const Size(60, 60),
                    //   ),
                    // ),
                  ),
                ),
                Builder(
                  builder: (context) {
                    if (offer == null) return const SizedBox.shrink();
                    final sats = offer.amountSats;
                    final fiat = offer.fiatAmount;
                    final bitcoinDisplayUnit = ref.watch(
                      bitcoinDisplayUnitProvider,
                    );
                    final apiService = ref.watch(apiServiceProvider);
                    final coordinatorInfo = apiService
                        .getCoordinatorInfoByPubkey(offer.coordinatorPubkey);
                    String formatFiat(double value) => value.toStringAsFixed(
                      value.truncateToDouble() == value ? 0 : 2,
                    );
                    if (coordinatorInfo == null) return const SizedBox.shrink();
                    // final feeFiat = fiat * feePct / 100;
                    // final totalFiat = fiat + feeFiat;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          formatBitcoinAmount(
                            context,
                            bitcoinDisplayUnit,
                            sats,
                          ),
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "${formatFiat(fiat)} ${offer.fiatCurrency}",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[700], fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
                        if (offer.premiumPercent > 0) ...[
                          const SizedBox(height: 8),
                          PremiumChip(premiumPercent: offer.premiumPercent),
                        ],
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                Column(
                  children: [
                    _buildNwcButtons(context, ref, holdInvoice, t),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.account_balance_wallet_outlined),
                        label: Text(t.maker.payInvoice.actions.payInWallet),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () => _launchLightningUrl(holdInvoice),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon: const Icon(Icons.copy),
                        label: Text(t.maker.payInvoice.actions.copy),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          Clipboard.setData(ClipboardData(text: holdInvoice));
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(t.maker.payInvoice.feedback.copied),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        icon:
                            _isCancelling
                                ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                                : const Icon(Icons.cancel),
                        label: Text(t.common.buttons.cancel),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed:
                            (_isCancelling || _isPayingWithWallet)
                                ? null
                                : _handleCancelPressed,
                      ),
                    ),
                  ],
                ),
                // const SizedBox(height: 25),
                // InkWell(
                //   onTap: () => _launchLightningUrl(holdInvoice),
                //   child: Padding(
                //     padding: const EdgeInsets.symmetric(vertical: 8.0),
                //     child: SelectableText(
                //       holdInvoice,
                //       textAlign: TextAlign.center,
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }
}
