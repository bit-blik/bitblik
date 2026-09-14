import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';

import 'coordinator_session.dart';

class CoordinatorDisputeCase {
  final Offer offer;
  final List<Map<String, dynamic>> stateHistory;
  final bool isFinal;
  final bool makerRefundInvoiceReady;
  final String paymentBackendType;
  final bool paymentBackendAvailable;
  final int makerRefundSats;
  final int takerPayoutSats;

  const CoordinatorDisputeCase({
    required this.offer,
    required this.stateHistory,
    this.isFinal = false,
    required this.makerRefundInvoiceReady,
    required this.paymentBackendType,
    required this.paymentBackendAvailable,
    required this.makerRefundSats,
    required this.takerPayoutSats,
  });
}

class RulingChatNotificationResult {
  final List<String> failedParticipants;

  const RulingChatNotificationResult({this.failedParticipants = const []});

  bool get deliveredToBoth => failedParticipants.isEmpty;
}

({String maker, String taker}) rulingChatMessages(
  CoordinatorDisputeCase dispute, {
  required bool makerWins,
}) {
  final offer = dispute.offer;
  if (makerWins) {
    return (
      maker:
          'Dispute ruling for offer ${offer.id}: the coordinator ruled in your favor. '
          'The ruling authorizes a refund of ${dispute.makerRefundSats} sats. '
          'Please submit the refund invoice in BitBlik.',
      taker:
          'Dispute ruling for offer ${offer.id}: the coordinator ruled in favor of the maker. '
          'The ruling authorizes a refund of ${dispute.makerRefundSats} sats to the maker.',
    );
  }
  return (
    maker:
        'Dispute ruling for offer ${offer.id}: the coordinator ruled in favor of the taker. '
        'The ruling authorizes a payout of ${dispute.takerPayoutSats} sats to the taker.',
    taker:
        'Dispute ruling for offer ${offer.id}: the coordinator ruled in your favor. '
        'The ruling authorizes your payout of ${dispute.takerPayoutSats} sats.',
  );
}

class DisputeCaseRepository {
  final CoordinatorSession session;
  final DisputeCommunicationService communication;

  DisputeCaseRepository({required this.session})
    : communication = DisputeCommunicationService(ndk: session.ndk);

  /// Returns every non-final coordinator offer with authoritative raw states,
  /// allowing the operator to enter its participant chat at any active stage.
  /// Older backends fall back to the public open-dispute view.
  Future<List<Offer>> listDisputes() async {
    final coordinator = session.expectedCoordinatorPubkey;
    final rpc = session.rpc;
    if (coordinator == null || rpc == null) {
      throw StateError('Log in with a coordinator.');
    }
    const pageSize = 25;
    Map<String, dynamic>? cursor;
    final offersById = <String, Offer>{};
    try {
      while (true) {
        final response = await rpc.send(
          NostrRequest(
            method: kRpcListDisputes,
            params: {'limit': pageSize, 'cursor': ?cursor},
          ),
          coordinator,
          relays: session.coordinatorRelays,
        );
        if (response.error != null) {
          final message =
              response.error!['message']?.toString() ?? 'RPC failed.';
          if (message.toLowerCase().contains('unknown method')) {
            return await _listHydratedPublicDisputes();
          }
          throw StateError(message);
        }
        final raw = response.result?['offers'];
        if (raw is! List) {
          throw const FormatException('Invalid list_disputes response.');
        }
        for (final entry in raw.whereType<Map>()) {
          final offer = Offer.fromJson({
            ...Map<String, dynamic>.from(entry),
            'coordinator_pubkey': coordinator,
          });
          offersById[offer.id] = offer;
        }
        final next = response.result?['next_cursor'];
        if (next == null) break;
        if (next is! Map) {
          throw const FormatException('Invalid list_disputes pagination.');
        }
        final nextCursor = Map<String, dynamic>.from(next);
        if (nextCursor['id'] == cursor?['id']) {
          throw const FormatException('Invalid list_disputes pagination.');
        }
        cursor = nextCursor;
      }
    } catch (error) {
      if (error.toString().toLowerCase().contains('unknown method')) {
        return await _listHydratedPublicDisputes();
      }
      rethrow;
    }
    final offers = await Future.wait(
      offersById.values.map(_hydrateMissingParticipants),
    );
    offers.sort(
      (a, b) =>
          (b.disputeAt ?? b.createdAt).compareTo(a.disputeAt ?? a.createdAt),
    );
    return offers;
  }

  /// Public offer events deliberately omit participant identities. Older
  /// coordinator backends without `list_disputes` therefore need one
  /// authenticated detail lookup per public row before DMs can be assigned to
  /// maker/taker lanes. A stale public row remains visible even if its local
  /// record no longer exists.
  Future<List<Offer>> _listHydratedPublicDisputes() async {
    final publicOffers = await listPublicDisputes();
    final offers = await Future.wait(
      publicOffers.map((offer) async {
        try {
          return (await fetchCase(offer.id)).offer;
        } catch (_) {
          return offer;
        }
      }),
    );
    offers.sort(
      (a, b) =>
          (b.disputeAt ?? b.createdAt).compareTo(a.disputeAt ?? a.createdAt),
    );
    return offers;
  }

  Future<Offer> _hydrateMissingParticipants(Offer offer) async {
    if (offer.makerPubkey.isNotEmpty && offer.takerPubkey?.isNotEmpty == true) {
      return offer;
    }
    try {
      return (await fetchCase(offer.id)).offer;
    } catch (_) {
      return offer;
    }
  }

  Future<List<Offer>> listPublicDisputes() async {
    final coordinator = session.expectedCoordinatorPubkey;
    if (coordinator == null) throw StateError('Log in with a coordinator.');
    // An offer is parameterized replaceable by its `d` tag. Query every
    // public coordinator path we know, then select its latest version locally.
    // Relying on a relay-side `#s=dispute` filter alone can miss an offer when
    // a coordinator's NIP-65 list recently changed or a relay implements tag
    // filtering incompletely.
    final relays = {
      ...session.coordinatorRelays,
      ...kDiscoveryRelays,
    }.toList(growable: false);
    final response = session.ndk.requests.query(
      name: 'coordinator-console-disputes',
      filter: Filter(kinds: [kKindOffer], authors: [coordinator]),
      explicitRelays: relays,
      cacheRead: false,
      timeout: const Duration(seconds: 8),
    );
    final events = await response.future;
    final newest = <String, Nip01Event>{};
    for (final event in events) {
      if (event.pubKey != coordinator) continue;
      final id = event.getDtag();
      if (id == null) continue;
      final current = newest[id];
      if (current == null || event.createdAt > current.createdAt) {
        newest[id] = event;
      }
    }
    final offers = newest.values
        .where((event) => event.getTags('s').contains('dispute'))
        .map(
          (event) => Offer.fromNostrEvent(event).copyWith(
            status: OfferStatus.dispute,
            statusRaw: OfferStatus.dispute.name,
          ),
        )
        .toList();
    offers.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return offers;
  }

  Future<CoordinatorDisputeCase> fetchCase(String offerId) async {
    final coordinator = session.expectedCoordinatorPubkey;
    final rpc = session.rpc;
    if (coordinator == null || rpc == null) {
      throw StateError('Coordinator signer is not authenticated.');
    }
    final response = await rpc.send(
      NostrRequest(method: kRpcGetOfferDetails, params: {'offer_id': offerId}),
      coordinator,
      relays: session.coordinatorRelays,
    );
    if (response.error != null) {
      throw StateError(response.error!['message']?.toString() ?? 'RPC failed.');
    }
    final result = response.result;
    if (result == null || result.isEmpty) {
      throw StateError(
        'The coordinator has no local record for offer $offerId. '
        'The public relay event may be stale or belong to a different '
        'coordinator database.',
      );
    }
    final historyRaw = result['state_history'];
    final backend = result['payment_backend'];
    final amounts = result['decision_amounts'];
    return CoordinatorDisputeCase(
      // Older coordinator DB rows may predate coordinator_pubkey. The signed
      // RPC destination is authoritative and must bind dispute DMs to the
      // same offer coordinate used by participants.
      offer: Offer.fromJson({...result, 'coordinator_pubkey': coordinator}),
      stateHistory: historyRaw is List
          ? historyRaw
                .whereType<Map>()
                .map((entry) => Map<String, dynamic>.from(entry))
                .toList(growable: false)
          : const [],
      isFinal: result['is_final'] == true,
      makerRefundInvoiceReady: result['maker_refund_invoice_ready'] == true,
      paymentBackendType: backend is Map
          ? backend['type']?.toString() ?? 'unknown'
          : 'unknown',
      paymentBackendAvailable: backend is Map && backend['available'] == true,
      makerRefundSats: amounts is Map
          ? (amounts['maker_refund_sats'] as num?)?.toInt() ?? 0
          : 0,
      takerPayoutSats: amounts is Map
          ? (amounts['taker_payout_sats'] as num?)?.toInt() ?? 0
          : 0,
    );
  }

  Future<void> ruleForMaker(CoordinatorDisputeCase dispute) async {
    _requireOpen(dispute);
    await _decision(dispute.offer.id, 'resolve_dispute_refund_maker');
  }

  Future<void> ruleForTaker(CoordinatorDisputeCase dispute) =>
      _ruleForTaker(dispute);

  Future<void> _ruleForTaker(CoordinatorDisputeCase dispute) async {
    _requireOpen(dispute);
    await _decision(dispute.offer.id, 'resolve_dispute_pay_taker');
  }

  void _requireOpen(CoordinatorDisputeCase dispute) {
    if (dispute.offer.statusRaw != OfferStatus.dispute.name) {
      throw StateError(
        'This case is already resolved or changed state. Refresh before acting.',
      );
    }
  }

  Future<void> _decision(String offerId, String method) async {
    final coordinator = session.expectedCoordinatorPubkey;
    final rpc = session.rpc;
    if (coordinator == null || rpc == null) {
      throw StateError('Coordinator signer is not authenticated.');
    }
    final response = await rpc.send(
      NostrRequest(method: method, params: {'offer_id': offerId}),
      coordinator,
      relays: session.coordinatorRelays,
    );
    if (response.error != null) {
      throw StateError(response.error!['message']?.toString() ?? 'RPC failed.');
    }
  }

  /// Announces an already-committed ruling in both private participant lanes.
  /// Delivery errors are returned per lane and never reinterpret a successful
  /// financial transition as a failed decision.
  Future<RulingChatNotificationResult> notifyRuling(
    CoordinatorDisputeCase dispute, {
    required bool makerWins,
  }) async {
    final offer = dispute.offer;
    final coordinator = session.expectedCoordinatorPubkey;
    final taker = offer.takerPubkey;
    if (coordinator == null || taker == null || taker.isEmpty) {
      return const RulingChatNotificationResult(
        failedParticipants: ['maker', 'taker'],
      );
    }
    final messages = rulingChatMessages(dispute, makerWins: makerWins);

    Future<String?> sendTo(
      String label,
      String participantPubkey,
      String content,
    ) async {
      try {
        final participantRelays = await session.loadUserRelayUrls(
          participantPubkey,
        );
        await communication.sendText(
          offer: offer,
          myPubkey: coordinator,
          participantPubkey: participantPubkey,
          content: content,
          recipientDmRelayDiscoveryRelays: session.dmRelayDiscoveryRelays,
          legacyRendezvousRelays: {
            ...session.dmRelayDiscoveryRelays,
            ...participantRelays,
          },
        );
        return null;
      } catch (_) {
        return label;
      }
    }

    final failures = (await Future.wait([
      sendTo('maker', offer.makerPubkey, messages.maker),
      sendTo('taker', taker, messages.taker),
    ])).whereType<String>().toList(growable: false);
    return RulingChatNotificationResult(failedParticipants: failures);
  }
}
