import 'package:bitblik_core/core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/providers.dart' show apiServiceProvider, keyServiceProvider;

/// The current user's flow role for [offer], or null for a bystander.
FlowActor? roleForOffer(WidgetRef ref, Offer offer) {
  final me = ref.read(keyServiceProvider).publicKeyHex;
  if (offer.makerPubkey == me) return FlowActor.maker;
  if (offer.takerPubkey == me) return FlowActor.taker;
  return null;
}

/// Fire a yaml-driven flow action ([event], which equals the coordinator RPC
/// method) on [offer], with any [extraParams] a screen collected. The
/// coordinator enforces + advances the state; the offer-status subscription
/// then updates the active offer, which re-drives navigation. Throws on error.
Future<Map<String, dynamic>> fireFlowAction(
  WidgetRef ref,
  Offer offer,
  String event, {
  Map<String, dynamic> extraParams = const {},
}) {
  return ref.read(apiServiceProvider).sendFlowAction(
        event: event,
        offerId: offer.id,
        coordinatorPubkey: offer.coordinatorPubkey,
        extraParams: extraParams,
      );
}
