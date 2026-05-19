import '../../../i18n/gen/strings.g.dart'; // Import Slang
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Use Riverpod
import 'package:go_router/go_router.dart'; // Import GoRouter
import 'package:ndk/shared/logger/logger.dart';

import '../../models/offer.dart';
import '../../providers/providers.dart';
import 'maker_amount_form.dart'; // Import providers

class MakerInvalidBlikScreen extends ConsumerWidget {
  final Offer offer;

  const MakerInvalidBlikScreen({super.key, required this.offer});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Listen to the active offer provider for status changes
    ref.listen<Offer?>(activeOfferProvider, (previous, next) {
      if (next != null && next.id == offer.id) {
        final status = next.statusEnum;
        if (status == OfferStatus.conflict) {
          Logger.log.d(
            () =>
                "[MakerInvalidBlikScreen] Offer status changed to conflict. Navigating...",
          );
          context.go('/maker-conflict', extra: offer);
        } else if (status == OfferStatus.reserved) {
          Logger.log.d(
            () =>
                "[MakerInvalidBlikScreen] Offer status changed to reserved. Navigating back to wait-blik.",
          );
          context.go('/wait-blik', extra: offer);
        } else if (status == OfferStatus.funded) {
          Logger.log.d(
            () =>
                "[MakerInvalidBlikScreen] Offer status changed to funded. Navigating back to wait taker.",
          );
          context.go('/wait-taker', extra: offer);
        } else if (status == OfferStatus.expired) {
          Logger.log.d(
            () =>
                "[MakerInvalidBlikScreen] Offer status changed to expired. Navigating back to home.",
          );
          ref.read(activeOfferProvider.notifier).setActiveOffer(null);
          context.go('/');
        }
      }
    });

    return Scaffold(
      // appBar: AppBar(
      //   title: Text(t.maker.invalidBlik.title),
      //   automaticallyImplyLeading: false,
      // ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const MakerProgressIndicator(activeStep: 2),
              const SizedBox(height: 30),
              const Icon(
                Icons.warning_amber_rounded,
                size: 60,
                color: Colors.orange,
              ),
              const SizedBox(height: 30),
              Text(
                t.maker.invalidBlik.info,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 30),
              // Text(t.offers.details.id(id: offer.id.substring(0, 8)), style: Theme.of(context).textTheme.bodySmall),
              // const SizedBox(height: 16),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
