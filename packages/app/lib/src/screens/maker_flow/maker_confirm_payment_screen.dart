import 'package:bitblik/src/utils/code_label_ext.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/services.dart';
import 'package:ndk/shared/logger/logger.dart';
import '../../../i18n/gen/strings.g.dart';
import 'package:bitblik_core/core.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../flow/flow_provider.dart' show flowRoute;
import '../../providers/providers.dart';
import 'maker_amount_form.dart'; // For MakerProgressIndicator

class MakerConfirmPaymentScreen extends ConsumerStatefulWidget {
  const MakerConfirmPaymentScreen({super.key});

  @override
  ConsumerState<MakerConfirmPaymentScreen> createState() =>
      _MakerConfirmPaymentScreenState();
}

class _MakerConfirmPaymentScreenState
    extends ConsumerState<MakerConfirmPaymentScreen> {
  bool _fetchAttempted = false;

  /// Active offer's payment method, resolved from its payment-system id (falls
  /// back to the app's selected method when there is no active offer).
  PaymentSystem get _method {
    final o = ref.read(activeOfferProvider);
    return o != null
        ? paymentSystemForOffer(o)
        : ref.read(selectedPaymentSystemProvider);
  }

  /// Active offer's payment-system code term (e.g. BLIK / MB WAY) for UI text.
  String get _code => _method.localizedCodeLabel;

  bool get _makerProvidedCodeFlow => _method.makerProvidesCodeAtOfferCreation;

  // Ticks once per second while in takerCharged to drive the auto-confirm
  // countdown. The expiry itself is derived from offer.createdAt plus the
  // coordinator-advertised duration, so the ticker only triggers repaints.
  Timer? _autoConfirmTicker;

  bool _isPostBlikWindowStatus() {
    final offer = ref.read(activeOfferProvider);
    if (offer == null) return false;
    return offer.status == OfferStatus.expiredBlik ||
        offer.status == OfferStatus.expiredSentBlik ||
        offer.status == OfferStatus.takerCharged;
  }

  bool _canConfirmPayment(OfferStatus status) =>
      (_makerProvidedCodeFlow && status == OfferStatus.reserved) ||
      status == OfferStatus.blikSentToMaker ||
      status == OfferStatus.expiredSentBlik ||
      status == OfferStatus.takerCharged ||
      status == OfferStatus.conflict;

  bool _canMarkBlikInvalid(OfferStatus status) =>
      (_makerProvidedCodeFlow && status == OfferStatus.reserved) ||
      status == OfferStatus.blikSentToMaker ||
      status == OfferStatus.expiredSentBlik ||
      status == OfferStatus.takerCharged;

  @override
  void initState() {
    super.initState();
    // Reset any lingering loading state in post-frame; modifying a provider
    // synchronously inside initState throws
    // "Tried to modify a provider while the widget tree was building".
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        ref.read(isLoadingProvider.notifier).state = false;
      }
    });
    // Only attempt to fetch BLIK code if status is NOT expired
    if (!_isPostBlikWindowStatus() && !_makerProvidedCodeFlow) {
      // Attempt immediately if key is already available
      final pkNow = ref.read(publicKeyProvider).value;
      if (pkNow != null) {
        _fetchBlikCode();
      }
    }
    // If we land here already in takerCharged (incl. app reopen), start the
    // 1s repaint ticker. The displayed remaining time is always recomputed
    // from the persisted offer.createdAt, so it reflects real elapsed time
    // regardless of when this ticker started.
    if (ref.read(activeOfferProvider)?.status == OfferStatus.takerCharged) {
      _startAutoConfirmTicker();
    }
  }

  // Ticker only schedules repaints; it carries no countdown state, so closing
  // and reopening the app or navigating away and back cannot reset the timer.
  void _startAutoConfirmTicker() {
    if (_autoConfirmTicker != null) return;
    _autoConfirmTicker = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) setState(() {});
    });
  }

  @override
  void dispose() {
    _autoConfirmTicker?.cancel();
    super.dispose();
  }

  Future<void> _fetchBlikCode() async {
    if (_fetchAttempted) return;
    _fetchAttempted = true;
    // Previous screen (MakerWaitForBlik/WaitTaker) may have already fetched the code;
    // avoid a redundant RPC call to the coordinator.
    if (ref.read(receivedBlikCodeProvider) != null) return;
    final offer = ref.read(activeOfferProvider);
    final makerId = ref.read(publicKeyProvider).value;
    if (offer == null || makerId == null) return;
    final apiService = ref.read(apiServiceProvider);
    final blikCode = await apiService.getBlikCodeForMaker(
      offer.id,
      makerId,
      offer.coordinatorPubkey,
    );
    if (blikCode != null) {
      ref.read(receivedBlikCodeProvider.notifier).state = blikCode;
    }
  }

  Future<void> _showConfirmationDialog(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text(t.maker.confirmPayment.confirmDialog.title),
          content: Text(
            _makerProvidedCodeFlow
                ? 'This action is irreversible.\n\nOnly confirm if the taker really completed the $_code payment for the requested amount. Once confirmed, the taker will be paid and the coordinator will not be able to undo it.'
                : t.maker.confirmPayment.confirmDialog.content(code: _code),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(t.maker.confirmPayment.confirmDialog.cancel),
              onPressed: () {
                Navigator.of(dialogContext).pop(false);
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
              ),
              child: Text(t.maker.confirmPayment.confirmDialog.confirmButton),
              onPressed: () {
                Navigator.of(dialogContext).pop(true);
              },
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      await _confirmPayment(context, ref);
    }
  }

  Future<void> _confirmPayment(BuildContext context, WidgetRef ref) async {
    final paymentHash = ref.read(paymentHashProvider);
    final makerId = ref.read(publicKeyProvider).value; // Read current value

    if (paymentHash == null || makerId == null) {
      ref.read(errorProvider.notifier).state =
          t.maker.confirmPayment.errors.missingHashOrKey; // Use Slang t
      return;
    }

    ref.read(isLoadingProvider.notifier).state = true;
    ref.read(errorProvider.notifier).state = null;

    final offer = ref.read(activeOfferProvider);
    if (offer == null) {
      ref.read(errorProvider.notifier).state =
          t.offers.errors.detailsMissing; // Use Slang t
      ref.read(isLoadingProvider.notifier).state = false;
      return;
    }
    if (!_canConfirmPayment(offer.status)) {
      ref.read(errorProvider.notifier).state = t.maker.confirmPayment.errors
          .confirming(details: 'offer is in state ${offer.status.name}');
      ref.read(isLoadingProvider.notifier).state = false;
      return;
    }
    final offerId = offer.id;

    try {
      final apiService = ref.read(apiServiceProvider);
      // final offerStatus = await apiService.getOfferStatus(paymentHash, offer.coordinatorPubkey);
      // if (offerStatus == null ||
      //     (offerStatus != OfferStatus.blikReceived &&
      //         offerStatus != OfferStatus.blikSentToMaker)) {
      //   throw Exception(
      //     t.maker.confirmPayment.errors.incorrectState(
      //       status: offerStatus ?? 'null',
      //     ), // Use Slang t
      //   );
      // }

      Logger.log.i(
        () =>
            "[MakerConfirmPaymentScreen] Confirming payment for offer $offerId by maker $makerId",
      );
      await apiService.confirmMakerPayment(
        offerId,
        makerId,
        offer.coordinatorPubkey,
      );

      if (!context.mounted) return;
      final scaffoldMessenger = ScaffoldMessenger.maybeOf(context);
      if (scaffoldMessenger != null) {
        scaffoldMessenger.showSnackBar(
          SnackBar(
            content: Text(t.maker.confirmPayment.feedback.confirmedTakerPaid),
          ), // Use Slang t
        );
      }
      context.go(flowRoute, extra: offer);
    } catch (e) {
      ref.read(errorProvider.notifier).state = t.maker.confirmPayment.errors
          .confirming(details: e.toString()); // Use Slang t
    } finally {
      if (ref.context.mounted) {
        ref.read(isLoadingProvider.notifier).state = false;
      }
    }
  }

  Future<void> _markBlikInvalid(BuildContext context, WidgetRef ref) async {
    final offer = ref.read(activeOfferProvider);
    final makerId = ref.read(publicKeyProvider).value;

    if (offer == null || makerId == null) {
      ref.read(errorProvider.notifier).state =
          t.offers.errors.detailsMissing; // Use Slang t
      return;
    }

    // // If offer is in takerCharged status, show confirmation dialog
    // if (offer.statusEnum == OfferStatus.takerCharged) {
    //   final confirmed = await _showInvalidBlikDisputeDialog(context);
    //   if (confirmed != true) {
    //     return; // User cancelled
    //   }
    // }
    ref.read(isLoadingProvider.notifier).state = true;
    ref.read(errorProvider.notifier).state = null;

    try {
      final apiService = ref.read(apiServiceProvider);
      Logger.log.i(
        () =>
            "[MakerConfirmPaymentScreen] Marking BLIK invalid for offer ${offer.id} by maker $makerId",
      );
      await apiService.markBlikInvalid(
        offer.id,
        makerId,
        offer.coordinatorPubkey,
      );

      if (context.mounted) {
        if (offer.statusEnum == OfferStatus.takerCharged) {
          context.go(flowRoute, extra: offer);
        } else {
          context.go(flowRoute, extra: offer);
        }
      }
    } catch (e) {
      // TODO: Add specific localization for this error in YAML and use it here
      ref.read(errorProvider.notifier).state =
          '${t.system.errors.generic}: $e'; // Use Slang t
    } finally {
      if (ref.context.mounted) {
        ref.read(isLoadingProvider.notifier).state = false;
      }
    }
  }

  void _copyToClipboard(String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(t.system.blik.copied(code: _code)),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formatBlikCode(String code) {
    // Group digits in threes from the left for readability, e.g.
    // "987085" -> "987 085", "1234567890" -> "123 456 789 0".
    final buffer = StringBuffer();
    for (var i = 0; i < code.length; i++) {
      if (i > 0 && i % 3 == 0) buffer.write(' ');
      buffer.write(code[i]);
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    // final strings = AppLocalizations.of(context)!; // REMOVE THIS
    final t = Translations.of(context);

    final ref =
        this.ref; // 'ref' is already available in ConsumerStatefulWidget's state
    // Hard reset any lingering global loader to avoid blocking UI
    // final currentLoading = ref.read(isLoadingProvider);
    // if (currentLoading == true) {
    //   ref.read(isLoadingProvider.notifier).state = false;
    // }
    // Listen for public key availability (must be done during build)
    // Only fetch BLIK code if status is not expired
    ref.listen(publicKeyProvider, (previous, next) {
      if (!_fetchAttempted &&
          next.value != null &&
          !_isPostBlikWindowStatus() &&
          !_makerProvidedCodeFlow) {
        _fetchBlikCode();
      }
    });
    // Listen to the active offer provider for status changes
    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (next != null) {
        // Handle status update only if the status has actually changed
        if (previous == null || previous.status != next.status) {
          _handleStatusUpdate(next.statusEnum);
        }
      }
    });

    final errorMessage = ref.watch(errorProvider);
    final receivedBlikCode = ref.watch(receivedBlikCodeProvider);
    final isExpired = _isPostBlikWindowStatus();
    final offerStatus = ref.watch(activeOfferProvider)?.statusEnum;
    final canConfirm = offerStatus != null && _canConfirmPayment(offerStatus);
    final canMarkInvalid =
        offerStatus != null && _canMarkBlikInvalid(offerStatus);

    final bool isFetchingBlik =
        !_makerProvidedCodeFlow && receivedBlikCode == null && !isExpired;
    final formattedBlikCode = _formatBlikCode(
      receivedBlikCode ?? ('·' * _method.codeLength),
    );
    final blikFontSize = (MediaQuery.of(context).size.width * 0.19).clamp(
      32.0,
      68.0,
    );
    final TextStyle blikStyle = TextStyle(
      fontSize: blikFontSize,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      letterSpacing: 6,
    );
    final TextPainter tp = TextPainter(
      text: const TextSpan(text: ''), // will set below to avoid const issue
      textDirection: TextDirection.ltr,
    );
    tp.text = TextSpan(text: formattedBlikCode, style: blikStyle);
    tp.layout();
    // Match the copy button to the code's on-screen width, but clamp to the
    // available width so long codes (scaled down by the FittedBox above) don't
    // make the button overflow the screen.
    final double maxCodeWidth = MediaQuery.of(context).size.width - 32;
    final double copyButtonWidth = tp.width.clamp(0.0, maxCodeWidth);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: <Widget>[
              // Progress indicator (Step 3: Use BLIK)
              const MakerProgressIndicator(activeStep: 3),
              const SizedBox(height: 20),

              // Expanded section with evenly spaced title, code, and button
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final upperContent =
                        isExpired
                            ? _buildExpiredContent(t)
                            : _makerProvidedCodeFlow
                            ? _buildMakerProvidedContent(t)
                            : _buildNormalContent(
                              t,
                              formattedBlikCode,
                              blikStyle,
                              isFetchingBlik,
                              receivedBlikCode,
                              copyButtonWidth,
                            );
                    // Make upper content scrollable only when needed
                    return SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          minHeight: constraints.maxHeight,
                        ),
                        child: upperContent,
                      ),
                    );
                  },
                ),
              ),

              // Bottom section: Instructions and buttons
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Show info block if offer is in takerCharged status
                  if (ref.watch(activeOfferProvider)?.statusEnum ==
                      OfferStatus.takerCharged) ...[
                    Container(
                      padding: const EdgeInsets.all(16),
                      margin: const EdgeInsets.only(bottom: 12),
                      decoration: BoxDecoration(
                        color: Colors.orange.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: Colors.orange.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 2),
                            child: Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.orange,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              t.maker.confirmPayment.takerChargedWarning(
                                code: _code,
                              ),
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.orange,
                              ),
                              softWrap: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                    _buildAutoConfirmCountdown(ref.watch(activeOfferProvider)!),
                  ],
                  // Error message
                  if (errorMessage != null) ...[
                    Text(
                      errorMessage,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                  ],

                  // Confirm Successful Payment button (green)
                  ElevatedButton(
                    onPressed:
                        canConfirm
                            ? () => _showConfirmationDialog(context, ref)
                            : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.check, color: Colors.white, size: 24),
                        const SizedBox(width: 8),
                        Text(
                          t.maker.confirmPayment.actions.confirm,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),

                  // Invalid BLIK code button (red outlined)
                  OutlinedButton(
                    onPressed:
                        canMarkInvalid
                            ? () => _markBlikInvalid(context, ref)
                            : null,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.red, width: 2),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Row(
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
                            Icons.close_outlined,
                            size: 16,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          t.maker.confirmPayment.actions.markInvalid(
                            code: _code,
                          ),
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNormalContent(
    Translations t,
    String formattedBlikCode,
    TextStyle blikStyle,
    bool isFetchingBlik,
    String? receivedBlikCode,
    double copyButtonWidth,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        // BLIK code received text
        Text(
          t.maker.confirmPayment.title(code: _code),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 24),
        // Large BLIK code (with loading hint if needed). Scale down to a single
        // line so long codes (e.g. 10-digit MB WAY) never wrap.
        Column(
          children: [
            SizedBox(
              width: double.infinity,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  formattedBlikCode,
                  style: blikStyle,
                  maxLines: 1,
                  softWrap: false,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            if (isFetchingBlik) ...[
              const SizedBox(height: 8),
              Text(
                t.maker.confirmPayment.retrieving(code: _code),
                style: const TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ],
        ),
        const SizedBox(height: 24),
        // Copy BLIK button with gradient
        Center(
          child: SizedBox(
            width: copyButtonWidth,
            child: Container(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Color(0xFFFF0000), Color(0xFFFF007F)],
                ),
                borderRadius: BorderRadius.circular(40),
              ),
              child: ElevatedButton(
                onPressed:
                    receivedBlikCode == null
                        ? null
                        : () => _copyToClipboard(receivedBlikCode),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.copy, color: Colors.white, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      t.maker.confirmPayment.actions.copyBlik(code: _code),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        // Optional payment-system + language specific instructions (blue info
        // box). Empty for methods that don't define any.
        ..._buildAdditionalInstructions(t),
        const SizedBox(height: 32),
        // Instructions. The "wait for the taker to confirm in their banking
        // app" step only applies to push-confirmation methods like BLIK; for
        // pull flows (MB WAY ATM) it is dropped and the remaining steps are
        // renumbered.
        ..._buildInstructionSteps(t),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildMakerProvidedContent(Translations t) {
    final offer = ref.read(activeOfferProvider);
    final amountText =
        offer == null
            ? ''
            : '${offer.fiatAmount.toStringAsFixed((offer.fiatAmount * 100).round() % 100 == 0 ? 0 : 2)} ${offer.fiatCurrency}';
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          'Waiting for taker to complete $_code',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 18),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.blue.shade100),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'The taker already received your $_code code and must enter it in their app.',
                style: TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Colors.blue.shade900,
                ),
              ),
              if (amountText.isNotEmpty) ...[
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text(
                      'Requested amount',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.blueGrey.shade700,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      amountText,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 24),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            color: Colors.orange.withValues(alpha: 0.09),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: Colors.orange.withValues(alpha: 0.28)),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.rule_folder_outlined,
                    color: Colors.orange,
                    size: 20,
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      'Before you confirm',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              _buildInstructionItem(
                '1',
                'Confirm only after you see the payment actually succeeded on the merchant or terminal side.',
              ),
              const SizedBox(height: 8),
              _buildInstructionItem(
                '2',
                'If the payment did not go through, mark the $_code code as invalid so the taker is not paid incorrectly.',
              ),
              const SizedBox(height: 8),
              _buildInstructionItem(
                '3',
                'If you are unsure, do not confirm yet.',
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _buildExpiredContent(Translations t) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Warning icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.orange.shade100,
          ),
          child: Icon(
            Icons.warning_amber_rounded,
            size: 48,
            color: Colors.orange.shade700,
          ),
        ),
        const SizedBox(height: 24),
        // Expired title
        Text(
          t.maker.confirmPayment.expiredTitle(code: _code),
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        // Warning message
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            t.maker.confirmPayment.expiredWarning(code: _code),
            style: const TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInstructionItem(
                '✓',
                t.maker.confirmPayment.expiredInstruction1(code: _code),
              ),
              const SizedBox(height: 12),
              _buildInstructionItem(
                '✗',
                t.maker.confirmPayment.expiredInstruction2(code: _code),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildAutoConfirmCountdown(Offer offer) {
    // Expiry mirrors the coordinator's auto-confirm timer: createdAt plus the
    // coordinator-advertised takerCharged auto-confirm duration. Computed from
    // the persisted createdAt every repaint, so it survives app restarts.
    final duration = ref.watch(
      coordinatorTakerChargedAutoConfirmDurationProvider(
        offer.coordinatorPubkey,
      ),
    );
    if (duration == null || duration.inSeconds <= 0) {
      return const SizedBox.shrink();
    }
    final expiresAt = offer.createdAt.toUtc().add(duration);
    final remaining = expiresAt.difference(DateTime.now().toUtc());
    final remainingSeconds = remaining.inSeconds.clamp(0, duration.inSeconds);
    final progress = remainingSeconds / duration.inSeconds;
    final minutes = remainingSeconds ~/ 60;
    final seconds = remainingSeconds % 60;
    final timeStr =
        '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';

    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.blueGrey.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blueGrey.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(
                Icons.timer_outlined,
                size: 18,
                color: Colors.blueGrey,
              ),
              Text(
                t.maker.confirmPayment.autoConfirmCountdown(time: timeStr),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.blueGrey,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.blueGrey.withValues(alpha: 0.15),
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blueGrey),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            t.maker.confirmPayment.autoConfirmInfo(code: _code),
            style: const TextStyle(fontSize: 12, color: Colors.black54),
            softWrap: true,
          ),
        ],
      ),
    );
  }

  /// Numbered confirm-payment steps. Drops the "wait for the taker to confirm
  /// in their app" step for methods that don't require it, renumbering the rest.
  /// Optional, payment-system + language specific instructions rendered in a
  /// blue info box below the code. Returns an empty list for methods that don't
  /// have any (e.g. BLIK).
  List<Widget> _buildAdditionalInstructions(Translations t) {
    final offer = ref.read(activeOfferProvider);
    if (offer == null) return const [];

    final fiat = offer.fiatAmount;
    final amount =
        (fiat * 100).round() % 100 == 0
            ? fiat.toStringAsFixed(0)
            : fiat.toStringAsFixed(2);

    // MB WAY has its own MULTIBANCO wording; the cardless-ATM markets (Tatra
    // banka / SLSP / VÚB) share a generic bank-named instruction + ATM map link.
    // For bank-scoped SK offers the bank name, validity and map link come from
    // the offer's chosen bank, not the market.
    final bank = bankForOffer(offer);
    final validityMinutes = validityForOffer(offer).inMinutes;
    String? text;
    if (_method.id == kMbway.id) {
      text = t.maker.confirmPayment.mbwayAtmInstructions(
        amount: amount,
        minutes: validityMinutes,
      );
    } else if (offer.category == OfferCategory.atm) {
      text = t.maker.confirmPayment.cardlessAtmInstructions(
        amount: amount,
        currency: _method.currencySymbol,
        bank: bank?.label ?? _method.label,
        minutes: validityMinutes,
      );
    }
    if (text == null) return const [];

    final mapUrl = bank?.atmMapUrl ?? instrumentForOffer(offer)?.atmMapUrl;

    return [
      const SizedBox(height: 24),
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.blue.shade200),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.info_outline, color: Colors.blue.shade700, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Builder(
                builder: (context) {
                  final base = TextStyle(
                    fontSize: 14,
                    color: Colors.blue.shade900,
                  );
                  final bankName = bank?.label ?? _method.label;
                  final idx = text!.indexOf(bankName);
                  // Bold only the bank name inside the instruction, if present.
                  if (idx < 0) return Text(text, style: base);
                  return Text.rich(
                    TextSpan(
                      style: base,
                      children: [
                        TextSpan(text: text.substring(0, idx)),
                        TextSpan(
                          text: bankName,
                          style: const TextStyle(fontWeight: FontWeight.w700),
                        ),
                        TextSpan(text: text.substring(idx + bankName.length)),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      if (mapUrl != null) ...[
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton.icon(
            onPressed:
                () => launchUrl(
                  Uri.parse(mapUrl),
                  mode: LaunchMode.externalApplication,
                ),
            icon: const Icon(Icons.map_outlined, size: 18),
            label: Text(
              t.maker.confirmPayment.findAtms(
                bank: bank?.label ?? _method.label,
              ),
            ),
          ),
        ),
      ],
    ];
  }

  List<Widget> _buildInstructionSteps(Translations t) {
    final steps = <String>[
      t.maker.confirmPayment.instruction1(code: _code),
      if (_method.requiresCodeConfirmation) t.maker.confirmPayment.instruction2,
      t.maker.confirmPayment.instruction3,
    ];
    final widgets = <Widget>[];
    for (var i = 0; i < steps.length; i++) {
      if (i > 0) widgets.add(const SizedBox(height: 6));
      widgets.add(_buildInstructionItem('${i + 1}', steps[i]));
    }
    return widgets;
  }

  Widget _buildInstructionItem(String number, String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          number,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 16, color: Colors.black87),
          ),
        ),
      ],
    );
  }

  void _handleStatusUpdate(OfferStatus statusEnum) {
    if (statusEnum == OfferStatus.takerCharged) {
      // Begin the auto-confirm countdown repaint ticker (idempotent).
      _startAutoConfirmTicker();
      setState(() {});
    } else if (statusEnum == OfferStatus.expiredBlik ||
        statusEnum == OfferStatus.expiredSentBlik) {
      // No special action needed, UI will update accordingly
      Logger.log.i(
        () =>
            "[MakerConfirmPaymentScreen] Offer status updated to expired. UI will reflect this.",
      );
      setState(() {});
    } else if (statusEnum == OfferStatus.makerConfirmed ||
        statusEnum == OfferStatus.settled ||
        statusEnum == OfferStatus.payingTaker ||
        statusEnum == OfferStatus.takerPaid) {
      // Coordinator settled the hold invoice and is paying / has paid the
      // taker (e.g. via auto-confirm). Jump to the maker success screen.
      Logger.log.i(
        () =>
            "[MakerConfirmPaymentScreen] Offer ${statusEnum.name}; navigating to maker success.",
      );
      context.go(flowRoute, extra: ref.read(activeOfferProvider));
    } else if (statusEnum == OfferStatus.conflict) {
      // The taker can report a conflict while this confirmation body is
      // mounted. Re-enter the flow route immediately so its state-to-body
      // mapping replaces this screen with MakerConflictScreen (timer + maker
      // actions), rather than leaving the old code-loading UI on screen until
      // the user navigates away and opens the offer again.
      context.go(flowRoute, extra: ref.read(activeOfferProvider));
    } else if (statusEnum == OfferStatus.reserved) {
      context.go(flowRoute);
    } else if (statusEnum == OfferStatus.funded) {
      context.go(flowRoute);
    } else if (statusEnum == OfferStatus.expired) {
      context.go('/');
    }
  }
}
