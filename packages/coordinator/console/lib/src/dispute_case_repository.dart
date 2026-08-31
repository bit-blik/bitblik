import 'package:bitblik_core/core.dart';
import 'package:ndk/ndk.dart';

import 'coordinator_session.dart';

class CoordinatorDisputeCase {
  final Offer offer;
  final List<Map<String, dynamic>> stateHistory;
  final bool makerRefundInvoiceReady;
  final String paymentBackendType;
  final bool paymentBackendAvailable;
  final int makerRefundSats;
  final int takerPayoutSats;

  const CoordinatorDisputeCase({
    required this.offer,
    required this.stateHistory,
    required this.makerRefundInvoiceReady,
    required this.paymentBackendType,
    required this.paymentBackendAvailable,
    required this.makerRefundSats,
    required this.takerPayoutSats,
  });
}

class DisputeCaseRepository {
  final CoordinatorSession session;
  final DisputeCommunicationService communication;

  DisputeCaseRepository({required this.session})
    : communication = DisputeCommunicationService(ndk: session.ndk);

  /// Returns the coordinator's complete dispute history with authoritative
  /// raw states. Older backends fall back to the public open-dispute view.
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
            return await listPublicDisputes();
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
        return await listPublicDisputes();
      }
      rethrow;
    }
    final offers = offersById.values.toList(growable: false);
    offers.sort(
      (a, b) =>
          (b.disputeAt ?? b.createdAt).compareTo(a.disputeAt ?? a.createdAt),
    );
    return offers;
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
}
