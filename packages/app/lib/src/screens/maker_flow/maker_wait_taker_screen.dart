import 'package:bitblik/src/utils/code_label_ext.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import '../../../i18n/gen/strings.g.dart'; // Correct Slang import
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';
import 'package:ndk/domain_layer/entities/wallet/providers/nwc/nwc_wallet.dart';
import 'package:ndk/domain_layer/entities/wallet/wallet_balance.dart';

import 'package:bitblik_core/core.dart'; // For OfferStatus enum
import '../../flow/flow_provider.dart' show flowEntryRoute;
import '../../providers/providers.dart';
import '../../utils/bitcoin_display.dart';
import '../../widgets/progress_indicators.dart';
import '../../widgets/premium_info.dart';
import '../../widgets/maker_waiting_body.dart';
import 'maker_amount_form.dart'; // For MakerProgressIndicator

class MakerWaitTakerScreen extends ConsumerStatefulWidget {
  const MakerWaitTakerScreen({super.key});

  @override
  ConsumerState<MakerWaitTakerScreen> createState() =>
      _MakerWaitTakerScreenState();
}

class _MakerWaitTakerScreenState extends ConsumerState<MakerWaitTakerScreen> {
  bool _isCancelling = false;
  bool _isExpired = false;
  bool _isRecreating = false;
  bool _isFetchingBlik = false;
  Timer? _expiryTimer;
  Offer?
  _lastKnownOffer; // snapshot so expired UI has offer details even after state→null

  @override
  void initState() {
    super.initState();
    final offer = ref.read(activeOfferProvider);
    _handleStatusUpdate(offer?.statusEnum);
    _scheduleExpiryTimer(offer);
  }

  @override
  void dispose() {
    _expiryTimer?.cancel();
    super.dispose();
  }

  /// Only `created`/`funded` offers may flip to the expired UI on the client
  /// timer. Once a taker has engaged (reserved/blik*), the trade is live on the
  /// coordinator: showing "expired" here strands the maker while the
  /// coordinator still expects a BLIK confirmation — which auto-settles the
  /// hold invoice against the maker after the dispute timeout. See [_goHome] and
  /// [_fetchBlikAndNavigate].
  static bool _isExpirableStatus(OfferStatus? status) {
    return status == null ||
        status == OfferStatus.created ||
        status == OfferStatus.funded;
  }

  PaymentSystem get _method {
    final offer = ref.read(activeOfferProvider);
    return offer != null
        ? (paymentSystemForCurrency(offer.fiatCurrency) ?? kBlik)
        : ref.read(selectedPaymentSystemProvider);
  }

  void _scheduleExpiryTimer(Offer? offer) {
    if (offer == null) return;
    final expiresAt = offer.createdAt.add(const Duration(minutes: 10));
    final remaining = expiresAt.difference(DateTime.now());
    if (!remaining.isNegative && remaining > Duration.zero) {
      _expiryTimer = Timer(remaining, () {
        if (!mounted) return;
        final current = ref.read(activeOfferProvider);
        final status = current?.statusEnum;
        // A taker engaged just before the timer fired. Do not show expired —
        // route to the correct live screen instead.
        if (!_isExpirableStatus(status)) {
          _handleStatusUpdate(status);
          return;
        }
        _lastKnownOffer ??= current;
        setState(() => _isExpired = true);
      });
    }
  }

  void _handleStatusUpdate(OfferStatus? status) async {
    if (status == null) return;

    final offer = ref.read(activeOfferProvider);
    final makerId = ref.read(publicKeyProvider).value;
    final coordinatorPubkey = offer?.coordinatorPubkey;

    if (offer == null || makerId == null || coordinatorPubkey == null) {
      if (offer == null && mounted) {
        _resetToRoleSelection(t.maker.waitTaker.errorActiveOfferDetailsLost);
      }
      return;
    }

    Logger.log.d(() => "[MakerWaitTaker] Status update received: $status");

    if (status == OfferStatus.reserved) {
      if (mounted) {
        context.go(
          flowEntryRoute(
            ref,
            _method.makerProvidesCodeAtOfferCreation
                ? '/confirm-blik'
                : '/wait-blik',
          ),
        );
      }
    } else if (status == OfferStatus.funded) {
      // Continue waiting
    } else if (status == OfferStatus.blikReceived ||
        status == OfferStatus.blikSentToMaker) {
      await _fetchBlikAndNavigate(offer, makerId, coordinatorPubkey);
    } else if (status == OfferStatus.expired) {
      if (mounted) {
        setState(() => _isExpired = true);
      }
    } else {
      if (mounted) {
        // _resetToRoleSelection(
        //   t.maker.waitTaker.offerNoLongerAvailable(status: status.name),
        // );
      }
    }
  }

  /// A taker submitted a BLIK. The coordinator flips the offer to
  /// `blikSentToMaker` the moment we fetch the code, which makes the maker
  /// liable: if no confirmation arrives within the coordinator's BLIK-confirm
  /// window the hold invoice is auto-settled against the maker. So we must NEVER
  /// silently fail here — keep retrying until the code is shown or the offer
  /// leaves the BLIK state, and surface every failure to the user.
  Future<void> _fetchBlikAndNavigate(
    Offer offer,
    String makerId,
    String coordinatorPubkey,
  ) async {
    if (_isFetchingBlik) return;
    _isFetchingBlik = true;
    // Trade is live — clear any stale expired UI so the maker isn't stranded.
    if (_isExpired && mounted) {
      setState(() => _isExpired = false);
    }
    final apiService = ref.read(apiServiceProvider);
    try {
      while (mounted) {
        final current = ref.read(activeOfferProvider);
        final status = current?.statusEnum;
        if (status != OfferStatus.blikReceived &&
            status != OfferStatus.blikSentToMaker) {
          // Offer moved on (confirmed/expired/etc) — stop; the listener handles it.
          return;
        }
        try {
          final blikCode = await apiService.getBlikCodeForMaker(
            offer.id,
            makerId,
            coordinatorPubkey,
          );
          if (blikCode != null && blikCode.isNotEmpty) {
            ref.read(receivedBlikCodeProvider.notifier).state = blikCode;
            if (mounted) context.go(flowEntryRoute(ref, '/confirm-blik'));
            return;
          }
          Logger.log.w(
            () =>
                '[MakerWaitTaker] BLIK fetch returned empty for offer ${offer.id}, retrying.',
          );
        } catch (e) {
          Logger.log.w(
            () =>
                '[MakerWaitTaker] BLIK fetch failed for offer ${offer.id}: $e',
          );
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  t.maker.waitTaker.errorRetrievingBlik(
                    details: e.toString(),
                    code:
                        ref
                            .read(selectedPaymentSystemProvider)
                            .localizedCodeLabel,
                  ),
                ),
              ),
            );
          }
        }
        await Future.delayed(const Duration(seconds: 3));
      }
    } finally {
      _isFetchingBlik = false;
    }
  }

  Future<void> _resetToRoleSelection(String message) async {
    // await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
    ref.read(holdInvoiceProvider.notifier).state = null;
    ref.read(paymentHashProvider.notifier).state = null;
    ref.read(receivedBlikCodeProvider.notifier).state = null;
    ref.read(errorProvider.notifier).state = null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
        if (scaffoldMessenger != null) {
          scaffoldMessenger.showSnackBar(SnackBar(content: Text(message)));
        }
        context.go("/");
      }
    });
  }

  /// Refreshes balance (via live NWC query) for the wallet that was used to
  /// pay the hold invoice, then re-fetches its budget if it's an NWC wallet.
  /// Reads [Offer.paymentWalletId] so it survives app restarts.
  Future<void> _refreshPaymentWallet() async {
    // Capture NDK + wallet before any async gap so widget disposal doesn't
    // prevent us from reaching the NWC object.
    final ndk = ref.read(ndkProvider);
    if (ndk == null) return;

    final offer = ref.read(activeOfferProvider);
    final walletId = offer?.paymentWalletId;

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

    // Give the coordinator time to release the hold invoice before querying.
    await Future.delayed(const Duration(seconds: 3));

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
    } catch (e) {
      Logger.log.w(
        () => '[MakerWaitTakerScreen] Could not refresh wallet balance: $e',
      );
    }
  }

  Future<void> _goHome() async {
    // Clear the active offer too — otherwise RoleSelectionScreen re-syncs it and
    // auto-routes straight back here, making "Go Home" appear to do nothing.
    await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
    ref.read(holdInvoiceProvider.notifier).state = null;
    ref.read(paymentHashProvider.notifier).state = null;
    ref.read(receivedBlikCodeProvider.notifier).state = null;
    ref.read(errorProvider.notifier).state = null;
    if (mounted) context.go('/');
  }

  Future<void> _recreateOffer() async {
    final offer = _lastKnownOffer ?? ref.read(activeOfferProvider);
    final makerId = ref.read(publicKeyProvider).value;
    if (offer == null || makerId == null) return;

    setState(() => _isRecreating = true);
    try {
      final apiService = ref.read(apiServiceProvider);
      final result = await apiService.initiateOfferFiat(
        fiatAmount: offer.fiatAmount,
        fiatCurrency: offer.fiatCurrency,
        category: offer.category,
        coordinatorPubkey: offer.coordinatorPubkey,
        premiumPercent: offer.premiumPercent,
      );
      final paymentHash = result['paymentHash'] as String;
      ref.read(holdInvoiceProvider.notifier).state = result['holdInvoice'];
      ref.read(paymentHashProvider.notifier).state = paymentHash;
      await ref
          .read(activeOfferProvider.notifier)
          .setActiveOffer(
            Offer(
              id: paymentHash,
              amountSats: result['makerFees'] + result['amountSats'],
              makerFees: result['makerFees'],
              status: OfferStatus.created,
              fiatAmount: offer.fiatAmount,
              fiatCurrency: offer.fiatCurrency,
              createdAt: DateTime.now(),
              holdInvoicePaymentHash: paymentHash,
              holdInvoice: result['holdInvoice'],
              makerPubkey: makerId,
              coordinatorPubkey: offer.coordinatorPubkey,
              paymentSystemId: offer.paymentSystemId,
              category: offer.category,
              premiumPercent:
                  (result['premiumPercent'] as num?)?.toDouble() ??
                  offer.premiumPercent,
            ),
          );
      if (mounted) context.go(flowEntryRoute(ref, '/pay'));
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to create offer: $e')));
      }
    } finally {
      if (mounted) setState(() => _isRecreating = false);
    }
  }

  Future<void> _cancelOffer() async {
    final offer = ref.read(activeOfferProvider);
    final makerPubKey = ref.read(publicKeyProvider).value;

    if (offer == null || makerPubKey == null) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.maker.waitTaker.errorCouldNotIdentifyOffer)),
        );
      }
      return;
    }
    if (offer.status != OfferStatus.funded) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.maker.waitTaker.offerCannotBeCancelled(status: offer.status),
            ),
          ),
        );
      }
      return;
    }

    setState(() {
      _isCancelling = true;
    });
    ref.read(errorProvider.notifier).state = null;

    try {
      await ref.read(activeOfferProvider.notifier).cancelActiveOffer();
      _resetToRoleSelection(t.maker.waitTaker.offerCancelledSuccessfully);
    } on OfferAlreadyFundedException {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(t.maker.payInvoice.errors.cancelOfferAlreadyFunded),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        final errorMsg = t.maker.waitTaker.failedToCancelOffer(
          details: e.toString(),
        );
        ref.read(errorProvider.notifier).state = errorMsg;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(errorMsg)));
      }
    } finally {
      if (mounted) {
        setState(() {
          _isCancelling = false;
        });
      }
      unawaited(_refreshPaymentWallet());
    }
  }

  @override
  Widget build(BuildContext context) {
    // Watch the active offer provider to get real-time status updates
    final offer = ref.watch(activeOfferProvider);
    final t = Translations.of(context);
    final bitcoinDisplayUnit = ref.watch(bitcoinDisplayUnitProvider);

    if (offer != null) _lastKnownOffer = offer;

    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (!mounted) return;
      if (next != null) {
        _handleStatusUpdate(next.statusEnum);
      } else if (previous != null &&
          !_isExpired &&
          _isExpirableStatus(previous.statusEnum)) {
        // Offer cleared by coordinator (applyStatusUpdate goes funded→null for
        // terminal statuses without passing through expired in memory).
        // Treat as expiry only if it was still a pre-taker offer and the 10-min
        // window has elapsed — never for a live (reserved/blik*) offer.
        final expiresAt = previous.createdAt.add(const Duration(minutes: 10));
        if (!DateTime.now().isBefore(expiresAt)) {
          _lastKnownOffer = previous;
          setState(() => _isExpired = true);
        }
      }
    });

    if (_isExpired) {
      final expiredOffer = _lastKnownOffer;
      return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const MakerProgressIndicator(activeStep: 2),
                  const SizedBox(height: 40),
                  Icon(
                    Icons.timer_off_outlined,
                    size: 80,
                    color: Colors.orange[700],
                  ),
                  const SizedBox(height: 20),
                  Text(
                    t.maker.waitTaker.offerExpiredTitle,
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    t.maker.waitTaker.offerExpiredMessage,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                    textAlign: TextAlign.center,
                  ),
                  if (expiredOffer != null) ...[
                    const SizedBox(height: 30),
                    _buildDetailRow(
                      context,
                      t.offers.details.amountLabel,
                      '${(expiredOffer.fiatAmount * 100).round() % 100 == 0 ? expiredOffer.fiatAmount.toStringAsFixed(0) : expiredOffer.fiatAmount.toStringAsFixed(2)} ${expiredOffer.fiatCurrency}',
                    ),
                    const SizedBox(height: 8),
                    _buildDetailRow(
                      context,
                      t.maker.amountForm.labels.fee,
                      formatBitcoinAmount(
                        context,
                        bitcoinDisplayUnit,
                        expiredOffer.makerFees,
                      ),
                    ),
                    if (expiredOffer.premiumPercent > 0) ...[
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () => showPremiumInfoDialog(context),
                        child: _buildDetailRow(
                          context,
                          t.offers.labels.premium,
                          '+${formatPremium(expiredOffer.premiumPercent)}%',
                        ),
                      ),
                    ],
                  ],
                  const SizedBox(height: 30),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: _isRecreating ? null : _recreateOffer,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child:
                          _isRecreating
                              ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                              : Text(
                                t.maker.waitTaker.recreateOffer,
                                style: const TextStyle(fontSize: 16),
                              ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: _goHome,
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(t.common.buttons.goHome),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (offer == null) {
      return const Center(child: CircularProgressIndicator());
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: MakerWaitingBody(
          offer: offer,
          message: t.maker.waitTaker.message,
          countdown:
              offer.status == OfferStatus.funded
                  ? CircularCountdownTimer(
                    startTime: offer.createdAt,
                    maxDuration: const Duration(minutes: 10),
                    size: 200,
                    strokeWidth: 16,
                    progressColor: Colors.green,
                    backgroundColor: Colors.white,
                    fontSize: 48,
                  )
                  : const CircularProgressIndicator(),
          error: Consumer(
            builder: (context, ref, _) {
              final error = ref.watch(errorProvider);
              if (error != null &&
                  error.startsWith(
                    t.maker.waitTaker
                        .failedToCancelOffer(details: '')
                        .split(' {details}')[0],
                  )) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                    textAlign: TextAlign.center,
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          actions: SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed:
                  _isCancelling || (offer.status != OfferStatus.funded)
                      ? null
                      : _cancelOffer,
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Colors.red, width: 2),
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child:
                  _isCancelling
                      ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                        ),
                      )
                      : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            t.offers.actions.cancel,
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black87),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
