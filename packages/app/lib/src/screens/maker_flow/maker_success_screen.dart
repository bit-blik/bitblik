import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_confetti/flutter_confetti.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../i18n/gen/strings.g.dart'; // Import Slang
import '../../models/offer.dart';
import '../../providers/providers.dart'; // To reset state
import 'maker_amount_form.dart'; // For MakerProgressIndicator

class MakerSuccessScreen extends ConsumerStatefulWidget {
  final Offer completedOffer;

  const MakerSuccessScreen({required this.completedOffer, super.key});

  @override
  ConsumerState<MakerSuccessScreen> createState() => _MakerSuccessScreenState();
}

class _MakerSuccessScreenState extends ConsumerState<MakerSuccessScreen> {
  late final DateTime _enteredAt;
  Timer? _confettiTimer;
  int _confettiCount = 0;
  static const int _maxConfettiLaunches = 10;

  @override
  void initState() {
    super.initState();
    _enteredAt = DateTime.now();

    // Launch confetti after screen is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _launchConfetti();

        // Launch confetti every 5 seconds, up to 5 times total
        _confettiTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
          if (mounted && _confettiCount < _maxConfettiLaunches) {
            _launchConfetti();
          } else {
            timer.cancel();
          }
        });
      }
    });
  }

  void _launchConfetti() {
    _confettiCount++;
    Confetti.launch(
      context,
      options: const ConfettiOptions(particleCount: 100, spread: 70, y: 0.6),
    );
  }

  @override
  void dispose() {
    _confettiTimer?.cancel();
    super.dispose();
  }

  Future<void> _goHome(BuildContext context, WidgetRef ref) async {
    // Reset relevant state providers before going home
    await ref.read(activeOfferProvider.notifier).setActiveOffer(null);
    ref.read(holdInvoiceProvider.notifier).state = null;
    ref.read(paymentHashProvider.notifier).state = null;
    ref.read(receivedBlikCodeProvider.notifier).state = null;
    ref.read(errorProvider.notifier).state = null;
    ref.read(isLoadingProvider.notifier).state = false;
    ref.invalidate(availableOffersProvider); // Invalidate offer list

    if (context.mounted) {
      context.go('/');
    }
  }

  @override
  Widget build(BuildContext context) {
    final offer = ref.watch(activeOfferProvider) ?? widget.completedOffer;
    final t = Translations.of(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const MakerProgressIndicator(activeStep: 3),
              const SizedBox(height: 16),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        t.maker.success.title,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      Center(
                        child: Container(
                          width: 140,
                          height: 140,
                          decoration: const BoxDecoration(
                            color: Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            size: 72,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Duration info (mm:ss) under the check icon
                      Text(
                        t.offers.success.duration(
                          time: _formatMMSS(
                            ((offer.takerPaidAt ?? _enteredAt)
                                .difference(offer.createdAt)
                                .inSeconds),
                          ),
                        ),
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 24),
                      Text(
                        t.maker.success.subtitle,
                        style: TextStyle(fontSize: 16, color: Colors.grey[700]),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 24),
                      // Details
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                          side: BorderSide(color: Colors.grey[300]!),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              _rowDetail(
                                context,
                                label: t.offers.details.amountLabel,
                                value:
                                    '${(offer.fiatAmount * 100).round() % 100 == 0 ? offer.fiatAmount.toStringAsFixed(0) : offer.fiatAmount.toStringAsFixed(2)} ${offer.fiatCurrency}',
                              ),
                              const SizedBox(height: 8),
                              _rowDetail(
                                context,
                                label: t.offers.details.feeLabel,
                                value: '${offer.makerFees} sats',
                              ),
                              // const SizedBox(height: 8),
                              // _rowDetail(
                              //   context,
                              //   label: t.offers.details.statusLabel,
                              //   value: offer.status,
                              // ),
                              const SizedBox(height: 8),
                              _rowDetail(
                                context,
                                label: 'Offer ID',
                                value: offer.id,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              // Temporary test button for confetti
              // ElevatedButton(
              //   onPressed: () {
              //     Confetti.launch(
              //       context,
              //       options: const ConfettiOptions(
              //         particleCount: 100,
              //         spread: 70,
              //         y: 0.6,
              //       ),
              //     );
              //   },
              //   style: ElevatedButton.styleFrom(
              //     backgroundColor: Colors.purple,
              //     foregroundColor: Colors.white,
              //   ),
              //   child: const Text('🎉 Test Confetti'),
              // ),
              // const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () => _goHome(context, ref),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                  ),
                  child: Text(t.common.buttons.goHome),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _rowDetail(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        Flexible(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14),
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  String _formatMMSS(int totalSeconds) {
    final minutes = (totalSeconds ~/ 60).toString();
    final seconds = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
}
