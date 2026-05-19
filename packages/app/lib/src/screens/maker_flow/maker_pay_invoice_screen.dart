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
import '../../models/offer.dart'; // Import Offer model for status enum comparison
import 'package:ndk/domain_layer/entities/wallet/wallet.dart';
// Import ApiService
import 'package:go_router/go_router.dart';
import '../../../i18n/gen/strings.g.dart'; // Correct Slang import
import 'webln_stub.dart' if (dart.library.js) 'webln_web.dart';
import 'maker_amount_form.dart'; // Import MakerProgressIndicator

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
  StreamSubscription<List<Wallet>>? _walletsSubscription;

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
    // final fullOfferData = await apiService.getMyActiveOffer(
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

  Future<void> _payWithNwc(String invoice) async {
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

    try {
      await ndk.wallets.send(invoice: invoice);
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
        onPressed: _isPayingWithWallet ? null : () => _payWithNwc(holdInvoice),
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
                        decoration: const PrettyQrDecoration(
                          quietZone: PrettyQrQuietZone.standart,
                          background: Colors.white,
                          shape: PrettyQrSmoothSymbol(
                            color: Colors.black,
                            roundFactor: 0.3,
                          ),
                          image: PrettyQrDecorationImage(
                            scale: 0.3,
                            image: AssetImage('assets/logo2.png'),
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
                    final fiat = offer.fiatAmount ?? 0.0;
                    final apiService = ref.watch(apiServiceProvider);
                    final coordinatorInfo =
                        offer.coordinatorPubkey != null
                            ? apiService.getCoordinatorInfoByPubkey(
                              offer.coordinatorPubkey!,
                            )
                            : null;
                    String formatFiat(double value) => value.toStringAsFixed(
                      value.truncateToDouble() == value ? 0 : 2,
                    );
                    if (coordinatorInfo == null) return const SizedBox.shrink();
                    final feePct = coordinatorInfo.makerFee;
                    // final feeFiat = fiat * feePct / 100;
                    // final totalFiat = fiat + feeFiat;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "$sats sats",
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w400,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          //                          "${formatFiat(fiat)} + ${formatFiat(feeFiat)} fee = ${formatFiat(totalFiat)} PLN",
                          "${formatFiat(fiat)} PLN",
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[700], fontSize: 14),
                          textAlign: TextAlign.center,
                        ),
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
                        icon: const Icon(Icons.cancel),
                        label: Text(t.common.buttons.cancel),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          foregroundColor: Colors.white,
                        ),
                        onPressed: () async {
                          await ref
                              .read(activeOfferProvider.notifier)
                              .setActiveOffer(null);
                          context.go('/');
                        },
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
