import 'dart:async';
import 'dart:math';

import 'package:bip340/bip340.dart' as bip340;
import 'package:ndk/ndk.dart';

import 'coordinator_service.dart';
import 'package:bitblik_core/core.dart';
import '../logging/app_logger.dart';

/// Service to handle Nostr communication for the coordinator
/// Implements info replaceable events and NIP-44 encrypted request/response
class NostrService {
  final CoordinatorService _coordinatorService;
  late final Ndk _ndk;
  late Bip340EventSigner _signer;
  final RustEventVerifier rustEventVerifier = RustEventVerifier();

  // Relay configuration
  final List<String> _relays;

  // Subscription for incoming requests
  NdkResponse? _requestSubscription;

  NostrService(
    this._coordinatorService, {
    List<String> relays = const [
      'wss://relay.damus.io',
      'wss://relay.primal.net',
    ],
  }) : _relays = relays;

  /// Initialize the Nostr service
  Future<void> init({required String privateKey}) async {
    // Initialize NDK with bootstrap relays config
    _ndk = Ndk(
      NdkConfig(
          cache: MemCacheManager(),
          eventVerifier: rustEventVerifier,
          bootstrapRelays: _relays,
          logLevel: LogLevel.info),
    );

    // Generate or load coordinator keys
    if (privateKey.isNotEmpty) {
      final decodedKey = _decodeNsecKey(privateKey);
      if (decodedKey == null) {
        throw Exception(
            'Invalid private key format. Use hex or nsec1... format.');
      }

      _signer = Bip340EventSigner(
        privateKey: decodedKey,
        publicKey: bip340.getPublicKey(decodedKey),
      );
    } else {
      // Generate new keys
      final random = Random.secure();
      final privateKeyBytes =
          List<int>.generate(32, (_) => random.nextInt(256));
      final privateKeyHex = privateKeyBytes
          .map((byte) => byte.toRadixString(16).padLeft(2, '0'))
          .join('');

      _signer = Bip340EventSigner(
        privateKey: privateKeyHex,
        publicKey: bip340.getPublicKey(privateKey),
      );

      AppLogger.info(
          'Generated new coordinator keys. Private key: $privateKeyHex');
      AppLogger.info(
          'Store this private key in your .env file as NOSTR_PRIVATE_KEY');
    }

    // Publish coordinator info
    await _publishCoordinatorInfo();

    // Start listening for requests
    await _startRequestListener();
  }

  /// Decode nsec bech32 private key to hex format
  String? _decodeNsecKey(String nsecKey) {
    try {
      if (!nsecKey.startsWith('nsec1')) {
        // If it doesn't start with nsec1, assume it's already hex
        return nsecKey;
      }

      // Simple bech32 decoding for nsec keys
      // This is a basic implementation - in production you'd use a proper bech32 library
      // final data = nsecKey.substring(5); // Remove 'nsec1' prefix

      // For now, return the input as-is since NDK should handle nsec decoding
      // In a full implementation, you'd decode the bech32 format properly
      return Nip19.decode(nsecKey); // Let NDK handle the decoding
    } catch (e) {
      AppLogger.info('Error decoding nsec key: $e');
      return null;
    }
  }

  /// Publish coordinator info as a replaceable event
  Future<void> _publishCoordinatorInfo() async {
    try {
      final info = await _coordinatorService.getCoordinatorInfo();

      final event = Nip01Event(
        kind: kKindCoordinatorInfo,
        pubKey: _signer.getPublicKey(),
        content: '',
        tags: info.toNostrTags(),
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      await _signer.sign(event);
      await _ndk.broadcast
          .broadcast(nostrEvent: event, specificRelays: _relays);

      AppLogger.info(
          'Published coordinator info event for pub key: ${event.pubKey} to relays: $_relays');
    } catch (e) {
      AppLogger.info('Error publishing coordinator info: $e');
    }
  }

  /// Send encrypted offer status update to relevant users
  Future<void> publishOfferStatusUpdate({
    required String offerId,
    required String paymentHash,
    required String status,
    required DateTime timestamp,
    required String makerPubkey,
    String? takerPubkey,
    DateTime? reservedAt,
    DateTime? createdAt,
  }) async {
    try {
      final payload = <String, dynamic>{
        'offer_id': offerId,
        'payment_hash': paymentHash,
        'status': status,
        'created_at':
            createdAt != null ? createdAt.millisecondsSinceEpoch ~/ 1000 : null,
        'reserved_at': reservedAt != null
            ? reservedAt.millisecondsSinceEpoch ~/ 1000
            : null,
        'timestamp': timestamp.millisecondsSinceEpoch ~/ 1000,
      };

      await _sendEncryptedStatusUpdate(makerPubkey, payload, offerId);
      if (takerPubkey != null && takerPubkey.isNotEmpty) {
        await _sendEncryptedStatusUpdate(takerPubkey, payload, offerId);
      }
    } catch (e) {
      AppLogger.info('Error sending encrypted offer status updates: $e',
          offerId: offerId);
    }
  }

  /// Send encrypted status update to a specific user
  Future<void> _sendEncryptedStatusUpdate(
    String recipientPubkey,
    Map<String, dynamic> payload,
    String offerId,
  ) async {
    try {
      final privateKey = _signer.privateKey;
      if (privateKey == null) {
        throw Exception('No private key available for encryption');
      }

      final event = await ProtocolCodec.encryptStatusUpdate(
        payload: payload,
        offerId: offerId,
        senderPrivateKeyHex: privateKey,
        senderPubkeyHex: _signer.getPublicKey(),
        recipientPubkey: recipientPubkey,
      );

      await _signer.sign(event);
      await _ndk.broadcast
          .broadcast(nostrEvent: event, specificRelays: _relays);
    } catch (e) {
      AppLogger.info(
          'Error sending encrypted status update to $recipientPubkey: $e');
    }
  }

  /// Start listening for encrypted requests
  Future<void> _startRequestListener() async {
    try {
      final filter = Filter(
        kinds: [kKindCoordinatorRequest],
        pTags: [_signer.getPublicKey()], // Events tagged with our pubkey
        since: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      final response = _ndk.requests.subscription(
        name: "coordinator-requests",
        filters: [filter],
      );
      _requestSubscription = response;

      response.stream.listen(_handleRequest).onError((e) {
        AppLogger.info('!!!!!!!!!!!!!! Error in request listener: $e');
        AppLogger.info('!!!!!!!!!!!!!! SHOULD RETRY subscription');
      });

      AppLogger.info(
          'Started listening for coordinator requests on kind ${kKindCoordinatorRequest}');
    } catch (e) {
      AppLogger.info('Error starting request listener: $e');
    }
  }

  /// Handle incoming encrypted requests
  Future<void> _handleRequest(Nip01Event event) async {
    final privateKey = _signer.privateKey;
    if (privateKey == null) {
      throw Exception('No private key available for decryption');
    }

    final request = await ProtocolCodec.decryptRequest(event, privateKey);
    final id = request.id;
    if (id == null) {
      await _sendErrorResponse(
          event.pubKey, null, 'INVALID_REQUEST', 'Missing id');
      return;
    }
    try {
      final response =
          await _processRequest(request.method, request.params, event.pubKey);
      await _sendResponse(event.pubKey, id, response);
    } catch (e) {
      AppLogger.info('Error handling request: $e');
      await _sendErrorResponse(
          event.pubKey, id, 'INTERNAL_ERROR', e.toString());
    }
  }

  /// Process a coordinator request
  Future<Map<String, dynamic>> _processRequest(
      String method, Map<String, dynamic> params, String userPubkey) async {
    try {
      switch (method) {
        case kRpcGetInfo:
          final info = await _coordinatorService.getCoordinatorInfo();
          return info.toJson();

        // case 'list_offers':
        //   final offers = await _coordinatorService.listAvailableOffers();
        //   return {'offers': offers};

        case kRpcInitiateOffer:
          final fiatAmount = (params['fiat_amount'] as num?)?.toDouble();
          final makerId = params['maker_id'] as String? ?? userPubkey;

          if (fiatAmount == null) {
            throw Exception('Missing required parameter: fiat_amount');
          }

          return await _coordinatorService.initiateOfferFiat(
            fiatAmount: fiatAmount,
            makerId: makerId,
          );

        case kRpcReserveOffer:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final reservationTimestamp =
              await _coordinatorService.reserveOffer(offerId, userPubkey);
          if (reservationTimestamp != null) {
            return {
              'message': 'Offer reserved successfully',
              'reserved_at': reservationTimestamp.millisecondsSinceEpoch,
            };
          } else {
            throw Exception(
                'Failed to reserve offer. It might be unavailable or already reserved.');
          }

        case kRpcSubmitBlik:
          final offerId = params['offer_id'] as String?;
          final blikCode = params['blik_code'] as String?;
          final takerLightningAddress =
              params['taker_lightning_address'] as String?;
          final taker_invoice = params['taker_invoice'] as String?;

          if (offerId == null ||
              blikCode == null ||
              (takerLightningAddress == null && taker_invoice == null)) {
            throw Exception(
                'Missing required parameters: offer_id, blik_code, taker_lightning_address');
          }

          final success = await _coordinatorService.submitBlikCode(offerId,
              userPubkey, blikCode, takerLightningAddress, taker_invoice);

          if (success) {
            return {'message': 'BLIK code submitted successfully'};
          } else {
            throw Exception(
                'Failed to submit BLIK code. Offer state might be invalid or taker mismatch.');
          }

        case kRpcGetBlik:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final blikCode = await _coordinatorService.getBlikCodeForMaker(
              offerId, userPubkey);
          if (blikCode != null) {
            return {'blik_code': blikCode};
          } else {
            throw Exception(
                'BLIK code not found or not available for this offer/maker.');
          }

        case kRpcConfirmPayment:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success = await _coordinatorService.confirmMakerPayment(
              offerId, userPubkey);
          if (success) {
            return {
              'message': 'Payment confirmed, invoice settled, taker paid.'
            };
          } else {
            throw Exception(
                'Failed to confirm payment. Check offer state, LND connection, or logs.');
          }

        case kRpcGetMyActiveOffer:
          final activeOffers =
              await _coordinatorService.getMyActiveOffers(userPubkey);
          if (activeOffers.isNotEmpty) {
            final offer = activeOffers.first;
            return offer.toJsonWithPubkeys();
          } else {
            return {};
          }

        case kRpcGetMyFinishedOffers:
          final activeOffers =
              await _coordinatorService.getMyActiveOffers(userPubkey);
          final now = DateTime.now().toUtc();
          final finished = activeOffers
              .where((offer) =>
                  offer.status.name != 'expired' &&
                      offer.status.name != 'cancelled' ||
                  offer.takerPaidAt != null &&
                      now.difference(offer.takerPaidAt!.toUtc()).inHours < 24)
              .toList();

          final finishedList =
              finished.map((offer) => offer.toJsonWithPubkeys()).toList();
          return {'offers': finishedList};

        case kRpcCancelOffer:
          //PILA Error handling request: Exception: Error processing request: PostgreSQLSeverity.error 22P02: invalid input syntax for type uuid: "unknown_id"
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.cancelOffer(offerId, userPubkey);
          if (success) {
            return {'message': 'Offer cancelled successfully'};
          } else {
            throw Exception(
                'Failed to cancel offer. It might be in the wrong state or you are not the maker.');
          }

        case kRpcCancelReservation:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.cancelReservation(offerId, userPubkey);
          if (success) {
            return {'message': 'Reservation cancelled successfully'};
          } else {
            throw Exception(
                'Failed to cancel reservation. It might be in the wrong state or you are not the taker.');
          }

        case kRpcMarkBlikInvalid:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.markBlikInvalid(offerId, userPubkey);
          if (success) {
            return {'message': 'BLIK code marked as invalid successfully'};
          } else {
            throw Exception(
                'Failed to mark BLIK as invalid. Offer might be in the wrong state, not found, or maker ID mismatch.');
          }

        case kRpcMarkBlikCharged:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.markBlikCharged(offerId, userPubkey);
          if (success) {
            return {'message': 'Offer marked as conflict successfully'};
          } else {
            throw Exception(
                'Failed to mark offer as conflict. Offer might be in the wrong state, not found, or taker ID mismatch.');
          }

        case kRpcOpenDispute:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final success =
              await _coordinatorService.openDispute(offerId, userPubkey);
          if (success) {
            return {'message': 'Offer marked as open dispute successfully'};
          } else {
            throw Exception(
                'Failed to mark offer as dispute. Offer might be in the wrong state, not found, or taker ID mismatch.');
          }

        case kRpcUpdateTakerInvoice:
          final offerId = params['offer_id'] as String?;
          final bolt11 = params['bolt11'] as String?;

          if (offerId == null || bolt11 == null) {
            throw Exception('Missing required parameters: offer_id, bolt11');
          }

          final success = await _coordinatorService.updateTakerInvoice(
              offerId, bolt11, userPubkey);
          if (success) {
            return {'message': 'Taker invoice updated'};
          } else {
            throw Exception('Failed to update taker invoice');
          }

        case kRpcRetryTakerPayment:
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }

          final error =
              await _coordinatorService.retryTakerPayment(offerId, userPubkey);
          if (error == null) {
            return {'message': 'Taker payment retried'};
          } else {
            throw Exception(error);
          }

        case kRpcGetSuccessfulOffersStats:
          return await _coordinatorService.getSuccessfulOffersWithStats();

        default:
          throw Exception('Unknown method: $method');
      }
    } catch (e) {
      throw Exception('Error processing request: $e');
    }
  }

  /// Send a successful response
  Future<void> _sendResponse(String recipientPubkey, String requestId,
      Map<String, dynamic> result) async {
    await _sendEncryptedResponse(
        recipientPubkey, NostrResponse(id: requestId, result: result));
  }

  /// Send an error response
  Future<void> _sendErrorResponse(String recipientPubkey, String? requestId,
      String errorCode, String errorMessage) async {
    await _sendEncryptedResponse(
      recipientPubkey,
      NostrResponse(
        id: requestId,
        error: {'code': errorCode, 'message': errorMessage},
      ),
    );
  }

  /// Send an encrypted [NostrResponse] to a recipient.
  Future<void> _sendEncryptedResponse(
      String recipientPubkey, NostrResponse response) async {
    try {
      final privateKey = _signer.privateKey;
      if (privateKey == null) {
        throw Exception('No private key available for encryption');
      }

      final event = await ProtocolCodec.encryptResponse(
        response: response,
        senderPrivateKeyHex: privateKey,
        senderPubkeyHex: _signer.getPublicKey(),
        recipientPubkey: recipientPubkey,
      );

      await _signer.sign(event);
      await _ndk.broadcast
          .broadcast(nostrEvent: event, specificRelays: _relays);

      AppLogger.info('Sent encrypted response to $recipientPubkey');
    } catch (e) {
      AppLogger.info('Error sending encrypted message: $e');
    }
  }

  /// Get the coordinator's public key
  String? get coordinatorPubkey => _signer.getPublicKey();

  /// Refresh coordinator info (republish)
  Future<void> refreshInfo() async {
    await _publishCoordinatorInfo();
  }

  /// Disconnect and cleanup
  Future<void> disconnect() async {
    if (_requestSubscription != null) {
      await _ndk.requests.closeSubscription(_requestSubscription!.requestId);
    }
    await _ndk.destroy();
  }

  /// Broadcast a NIP-69 peer-to-peer order event based on Offer data
  // PILA also broadcast on other state changes
  // reserved, blikReceived, blikSentToTaker = in-progress
  // cancelled/expired = canceled
  // takerPaid = success
  // * reszta = ?

  Future<void> broadcastNip69OrderFromOffer(
    Offer offer, {
    String orderType = 'sell',
    List<String> paymentMethods = const ['BLIK'],
    String platform = 'Bitblik',
    int? expiration,
    double premium = 0,
    String network = "mainnet",
    String layer = "lightning",
    String? name,
    String? geohash,
    String? ratingJson,
    String document = 'order',
    String bond = "0",
  }) async {
    final status = _mapOfferStatusToNip69Status(offer.status);
    try {
      final tags = <List<String>>[
        ['d', offer.id],
        ['k', orderType],
        ['f', offer.fiatCurrency],
        ['s', status],
        ['amt', offer.amountSats.toString()],
        ['fa', offer.fiatAmount.toString()],
        ['pm', ...paymentMethods],
        ['premium', premium.toString()],
        if (ratingJson != null) ['rating', ratingJson],
        [
          'source',
          "https://${_coordinatorService.frontendDomain}/offers/${offer.id}",
        ],
        ['network', network],
        ['layer', layer],
        ['name', name ?? ''],
        if (geohash != null) ['g', geohash],
        ['bond', bond],
        if (expiration != null) ['expiration', expiration.toString()],
        ['y', platform],
        ['z', document],
        [
          'reserved_at',
          offer.reservedAt != null
              ? (offer.reservedAt!.millisecondsSinceEpoch ~/ 1000).toString()
              : ''
        ],
        [
          'created_at',
          (offer.createdAt.millisecondsSinceEpoch ~/ 1000).toString()
        ],
        [
          'paid_at',
          offer.takerPaidAt != null
              ? (offer.takerPaidAt!.millisecondsSinceEpoch ~/ 1000).toString()
              : ''
        ],
        if (offer.takerFees != null && offer.takerFees! > 0)
          ['taker_fees', offer.takerFees.toString()],
        if (offer.makerFees > 0) ['maker_fees', offer.makerFees.toString()],
      ];

      final event = Nip01Event(
        kind: kKindOffer,
        pubKey: _signer.getPublicKey(),
        content: '',
        tags: tags,
        createdAt: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      );

      await _ndk.broadcast.broadcast(
          nostrEvent: event, customSigner: _signer, specificRelays: _relays);
      // AppLogger.info(
      //     'Broadcasted NIP-69 order event for offer ${offer.id}, status: ${status} id:${event.id}',
      //     offerId: offer.id);
    } catch (e) {
      AppLogger.info(
          'Error broadcasting NIP-69 order event for offer ${offer.id}: $e',
          offerId: offer.id);
    }
  }

  /// Rebroadcast all offers to update their status on Nostr relays
  Future<void> rebroadcastOffers(List<Offer> offers) async {
    AppLogger.info('Starting rebroadcast of offers...');

    try {
      for (final offer in offers) {
        // final status = _mapOfferStatusToNip69Status(offer.status);

        AppLogger.info(
            'Rebroadcasting offer ${offer.id} with status ${offer.status.name}',
            offerId: offer.id);
        // Calculate expiration if the offer is still active
        int? expiration;
        if (offer.status == OfferStatus.funded) {
          // Use the same expiration logic as in the original broadcast
          expiration = offer.createdAt
                  .add(Duration(seconds: 600)) // _fundedExpireTimeoutSeconds
                  .millisecondsSinceEpoch ~/
              1000;
        }

        await broadcastNip69OrderFromOffer(
          offer,
          expiration: expiration,
        );

        // Small delay between broadcasts to avoid overwhelming relays
        await Future.delayed(Duration(milliseconds: 500));
      }

      AppLogger.info('Completed rebroadcasting offers');
    } catch (e) {
      AppLogger.info('Error during rebroadcast of offers: $e');
    }
  }

  /// Map internal offer status to NIP-69 status
  String _mapOfferStatusToNip69Status(OfferStatus status) {
    switch (status) {
      case OfferStatus.created:
      case OfferStatus.funded:
        return 'pending';
      case OfferStatus.reserved:
      case OfferStatus.blikReceived:
      case OfferStatus.blikSentToMaker:
      case OfferStatus.makerConfirmed:
      case OfferStatus.settled:
      case OfferStatus.payingTaker:
      case OfferStatus.takerPaymentFailed:
      case OfferStatus.invalidBlik:
      case OfferStatus.expiredBlik:
      case OfferStatus.expiredSentBlik:
      case OfferStatus.takerCharged:
        return 'in-progress';
      case OfferStatus.takerPaid:
        return 'success';
      case OfferStatus.cancelled:
      case OfferStatus.expired:
        return 'canceled';
      case OfferStatus.conflict:
      case OfferStatus.dispute:
        return 'dispute';
      case OfferStatus.unknown:
        // Coordinator never emits offers in `unknown` state — sentinel exists
        // only on the client side for forward-compat decoding.
        return 'canceled';
    }
  }
}
