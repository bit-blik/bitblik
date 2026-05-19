import '../../../i18n/gen/strings.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/logger/logger.dart';

import '../../models/offer.dart';
import '../../providers/providers.dart';

class TakerConflictScreen extends ConsumerStatefulWidget {
  final String offerId;

  const TakerConflictScreen({super.key, required this.offerId});

  @override
  ConsumerState<TakerConflictScreen> createState() =>
      _TakerConflictScreenState();
}

class _TakerConflictScreenState extends ConsumerState<TakerConflictScreen> {
  @override
  Widget build(BuildContext context) {
    // Listen to active offer provider for status changes
    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (next != null && next.id == widget.offerId) {
        // Handle status update only if the status has actually changed
        if (previous == null || previous.status != next.status) {
          _handleStatusUpdate(next.statusEnum, context);
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(t.taker.conflict.title),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 24),
              Text(
                t.taker.conflict.headline,
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Text(t.taker.conflict.body, textAlign: TextAlign.center),
              const SizedBox(height: 16),
              Text(
                t.taker.conflict.instructions,
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  context.go('/');
                },
                child: Text(t.taker.conflict.actions.back),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _handleStatusUpdate(OfferStatus statusEnum, BuildContext context) {
    Logger.log.i(
      () => "[TakerConflictScreen] Offer status updated to ${statusEnum.name}",
    );

    // Navigate to payment process screen for successful payment statuses
    if (statusEnum == OfferStatus.makerConfirmed ||
        statusEnum == OfferStatus.settled ||
        statusEnum == OfferStatus.payingTaker ||
        statusEnum == OfferStatus.takerPaid) {
      Logger.log.d(
        () =>
            "[TakerConflictScreen] Status is ${statusEnum.name}. Navigating to payment process screen.",
      );
      if (mounted) {
        context.go('/paying-taker');
      }
    }
    // Navigate to payment failed screen
    else if (statusEnum == OfferStatus.takerPaymentFailed) {
      Logger.log.d(
        () =>
            "[TakerConflictScreen] Status is takerPaymentFailed. Navigating to payment failed screen.",
      );
      if (mounted) {
        final offer = ref.read(activeOfferProvider);
        if (offer != null) {
          context.go('/taker-failed', extra: offer);
        }
      }
    }
  }
}
