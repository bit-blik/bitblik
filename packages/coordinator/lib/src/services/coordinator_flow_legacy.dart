part of 'coordinator_service.dart';

/// Legacy enum offer flow: the hardcoded BLIK state machine the coordinator
/// enforced before the generic FlowEngine existed. Owns the per-stage timers,
/// the per-stage expiry sweeps, and the offer-action RPC handlers.
///
/// Implemented as a `part of` the coordinator library so it reaches the shared
/// private services on [CoordinatorService] (`_c`). Deleting this file (plus its
/// `part` directive and the construction branch in [CoordinatorService.flow])
/// removes the legacy flow entirely.
class LegacyEnumOfferFlow implements OfferFlow {
  final CoordinatorService _c;
  LegacyEnumOfferFlow(this._c);

  // Per-stage timers owned by the legacy flow.
  final Map<String, Timer> _reservationTimers = {};
  final Map<String, Timer> _blikConfirmationTimers = {};
  final Map<String, Timer> _fundedOfferTimers = {};
  final Map<String, Timer> _takerChargedTimers = {};
  final Map<String, Timer> _disputeEscalationTimers = {};
  final Map<String, Timer> _expiredBlikRelistTimers = {};

  // expiredBlik -> funded auto-relist timeout configuration.
  static const int _expiredBlikRelistTimeoutSeconds = 60;

  /// Offer-action RPCs the legacy enum handlers enforce. Mirrors the generic
  /// flow's action set; the payout-tail RPCs (update_taker_invoice,
  /// retry_taker_payment) are shared and handled by the coordinator directly.
  static const Set<String> _actionRpcs = {
    kRpcReserveOffer,
    kRpcSubmitBlik,
    kRpcGetBlik,
    kRpcCancelOffer,
    kRpcCancelReservation,
    kRpcMarkBlikCharged,
    kRpcConfirmPayment,
    kRpcMarkBlikInvalid,
    kRpcOpenDispute,
  };

  @override
  bool handlesRpc(String method) => _actionRpcs.contains(method);

  @override
  void validateDefinition() {/* legacy enum flow uses no yaml definition */}

  @override
  void onOfferFunded(Offer offer) => _startFundedOfferTimer(offer);

  @override
  Future<void> recoverTimers() async {
    await _checkExpiredFundedOffers();
    await _checkExpiredReservations();
    await _checkExpiredBlikConfirmations();
    await _checkExpiredBlikRelists();
    await _checkTakerChargedAutoConfirm();
    await _checkDisputeEscalationAutoDispute();
  }

  @override
  Future<Map<String, dynamic>> handleRpc(
      String method, Map<String, dynamic> params, String userPubkey,
      {String? clientVersion}) async {
    // clientVersion unused: legacy records to log_audit, not offer_state_history.
    switch (method) {
      case kRpcReserveOffer:
        {
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }
          final reservationTimestamp = await reserveOffer(offerId, userPubkey);
          if (reservationTimestamp != null) {
            return {
              'message': 'Offer reserved successfully',
              'reserved_at': reservationTimestamp.millisecondsSinceEpoch,
            };
          }
          throw Exception(
              'Failed to reserve offer. It might be unavailable or already reserved.');
        }

      case kRpcSubmitBlik:
        {
          final offerId = params['offer_id'] as String?;
          final blikCode = params['blik_code'] as String?;
          final takerLightningAddress =
              params['taker_lightning_address'] as String?;
          final takerInvoice = params['taker_invoice'] as String?;
          if (offerId == null ||
              (takerLightningAddress == null && takerInvoice == null)) {
            throw Exception(
                'Missing required parameters: offer_id and taker invoice/lightning address');
          }
          final success = await submitBlikCode(
              offerId, userPubkey, blikCode, takerLightningAddress, takerInvoice);
          if (success) {
            return {'message': 'BLIK code submitted successfully'};
          }
          throw Exception(
              'Failed to submit BLIK code. Offer state might be invalid or taker mismatch.');
        }

      case kRpcGetBlik:
        {
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }
          final blikCode = await getBlikCodeForMaker(offerId, userPubkey);
          if (blikCode != null) {
            return {'blik_code': blikCode};
          }
          throw Exception(
              'BLIK code not found or not available for this offer/maker.');
        }

      case kRpcConfirmPayment:
        {
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }
          final success = await confirmMakerPayment(offerId, userPubkey);
          if (success) {
            return {'message': 'Payment confirmed, invoice settled, taker paid.'};
          }
          throw Exception(
              'Failed to confirm payment. Check offer state, LND connection, or logs.');
        }

      case kRpcCancelOffer:
        {
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }
          final success = await cancelOffer(offerId, userPubkey);
          if (success) {
            return {'message': 'Offer cancelled successfully'};
          }
          throw Exception(
              'Failed to cancel offer. It might be in the wrong state or you are not the maker.');
        }

      case kRpcCancelReservation:
        {
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }
          final success = await cancelReservation(offerId, userPubkey);
          if (success) {
            return {'message': 'Reservation cancelled successfully'};
          }
          throw Exception(
              'Failed to cancel reservation. It might be in the wrong state or you are not the taker.');
        }

      case kRpcMarkBlikInvalid:
        {
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }
          final success = await markBlikInvalid(offerId, userPubkey);
          if (success) {
            return {'message': 'BLIK code marked as invalid successfully'};
          }
          throw Exception(
              'Failed to mark BLIK as invalid. Offer might be in the wrong state, not found, or maker ID mismatch.');
        }

      case kRpcMarkBlikCharged:
        {
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }
          final success = await markBlikCharged(offerId, userPubkey);
          if (success) {
            return {'message': 'Offer marked as conflict successfully'};
          }
          throw Exception(
              'Failed to mark offer as conflict. Offer might be in the wrong state, not found, or taker ID mismatch.');
        }

      case kRpcOpenDispute:
        {
          final offerId = params['offer_id'] as String?;
          if (offerId == null) {
            throw Exception('Missing required parameter: offer_id');
          }
          final success = await openDispute(offerId, userPubkey);
          if (success) {
            return {'message': 'Offer marked as open dispute successfully'};
          }
          throw Exception(
              'Failed to mark offer as dispute. Offer might be in the wrong state, not found, or taker ID mismatch.');
        }

      default:
        throw Exception('Unknown offer-action method: $method');
    }
  }

  // ─── moved legacy bodies (timers, sweeps, RPC handlers) ───────────────
  Future<void> _checkExpiredFundedOffers() async {
    AppLogger.info('Checking for expired funded offers on startup...');
    if (_c._paymentBackend == null) {
      AppLogger.info(
          "Skipping expired funded offers check: No payment backend configured.");
      return;
    }
    try {
      final fundedOffers =
          await _c._dbService.getOffersByStatus(OfferStatus.funded, limit: 1000);
      final now = DateTime.now().toUtc();
      final expirationDuration = Duration(seconds: _c._fundedExpireTimeoutSeconds);

      int cancelledCount = 0;
      for (final offer in fundedOffers) {
        final createdAt = offer.createdAt;
        final expiryTime = createdAt.add(expirationDuration);
        if (now.isAfter(expiryTime)) {
          AppLogger.info(
              'Offer ${offer.id} funded expired (created at $createdAt, expired at $expiryTime). Cancelling.',
              offerId: offer.id);
          try {
            final cancelResult = await _c._paymentBackend!
                .cancelInvoice(paymentHashHex: offer.holdInvoicePaymentHash!);
            if (cancelResult.isAlreadyMissing) {
              AppLogger.info(
                  'Hold invoice for offer ${offer.id} is already missing on ${_c._paymentBackendType} during startup expiration check.',
                  offerId: offer.id);
            } else {
              AppLogger.info(
                  'Hold invoice for offer ${offer.id} cancelled via ${_c._paymentBackendType} due to startup expiration check.',
                  offerId: offer.id);
            }
          } catch (e) {
            AppLogger.info(
                'Error cancelling hold invoice for expired offer ${offer.id} using ${_c._paymentBackendType}: $e',
                offerId: offer.id);
          }
          final currentOffer = await _c._dbService.getOfferById(offer.id);
          if (currentOffer?.status != OfferStatus.funded) {
            AppLogger.info(
                'Offer ${offer.id} changed state during startup funded expiration check (current status: ${currentOffer?.status}). Skipping expiration.',
                offerId: offer.id);
            continue;
          }
          final dbSuccess = await _c._dbService.updateOfferStatusIfCurrentStatus(
              offer.id, OfferStatus.expired, [OfferStatus.funded]);
          if (dbSuccess) {
            cancelledCount++;
            AppLogger.info(
                'Offer ${offer.id} status updated to expired in DB due to startup expiration check.',
                offerId: offer.id);

            // Publish status update
            final expiredOffer = await _c._dbService.getOfferById(offer.id);
            if (expiredOffer != null) {
              await _c._publishStatusUpdate(expiredOffer);
              await _c._nostrService?.broadcastNip69OrderFromOffer(expiredOffer);
            }

            await _c._strikeTelegramOfferMessages(offer.id);
          } else {
            AppLogger.info(
                'Failed to update offer ${offer.id} status to expired in DB after startup expiration check.',
                offerId: offer.id);
          }
        } else {
          // Offer not yet expired: restart its expiration timer so it
          // still expires after the coordinator restart.
          AppLogger.info(
              'Offer ${offer.id} still within funded window (expires at $expiryTime). Restarting timer.',
              offerId: offer.id);
          _startFundedOfferTimer(offer);
        }
      }
      AppLogger.info(
          'Expired funded offer check complete. Marked $cancelledCount offers as expired.');
    } catch (e) {
      AppLogger.info('Error during expired funded offer check: $e');
    }
  }

  Future<void> _checkTakerChargedAutoConfirm() async {
    AppLogger.info('Checking for takerCharged auto confirm on startup...');
    if (_c._paymentBackend == null) {
      AppLogger.info("Skipping, no payment backend configured.");
      return;
    }
    try {
      final offers = await _c._dbService
          .getOffersByStatus(OfferStatus.takerCharged, limit: 1000);
      final now = DateTime.now().toUtc();
      final expirationDuration =
          Duration(seconds: _c._takerChargedAutoConfirmTimeoutSeconds);

      int cancelledCount = 0;
      int timerRestartedCount = 0;
      for (final offer in offers) {
        // Use createdAt as the base for expiration since that's when the hold invoice was created
        final expiryTime = offer.createdAt.add(expirationDuration);
        if (now.isAfter(expiryTime)) {
          AppLogger.info(
              'Offer ${offer.id} takerCharged auto confirm (created at ${offer.createdAt}, expired at $expiryTime). Auto confirming.',
              offerId: offer.id);
          try {
            await confirmMakerPayment(offer.id, offer.makerPubkey);
            cancelledCount++;
          } catch (e) {
            AppLogger.info(
                'Error takerCharged auto confirming for offer ${offer.id} using  $e',
                offerId: offer.id);
          }
        } else {
          // Restart timer for offers that haven't expired yet
          AppLogger.info(
              'Offer ${offer.id} still within takerCharged window (expires at $expiryTime). Restarting timer.',
              offerId: offer.id);
          _startTakerChargedTimer(offer);
          timerRestartedCount++;
        }
      }
      AppLogger.info(
          'takerCharged auto confirm offer check complete. Auto confirmed $cancelledCount offers, restarted timers for $timerRestartedCount offers.');
    } catch (e) {
      AppLogger.info('Error during takerCharged auto confirm check: $e');
    }
  }

  Future<void> _checkDisputeEscalationAutoDispute() async {
    AppLogger.info(
        'Checking for invalidBlik/expiredSentBlik/conflict dispute escalation on startup...');
    if (_c._paymentBackend == null) {
      AppLogger.info('Skipping, no payment backend configured.');
      return;
    }

    try {
      final offers = [
        ...await _c._dbService.getOffersByStatus(OfferStatus.invalidBlik,
            limit: 1000),
        ...await _c._dbService.getOffersByStatus(OfferStatus.expiredSentBlik,
            limit: 1000),
        ...await _c._dbService.getOffersByStatus(OfferStatus.conflict,
            limit: 1000),
      ];
      final now = _c._clock.now().toUtc();
      final timeoutDuration =
          Duration(seconds: _c._conflictAutoDisputeTimeoutSeconds);

      int autoDisputedCount = 0;
      int timerRestartedCount = 0;
      for (final offer in offers) {
        final statusChangedAt = (offer.updatedAt ?? offer.createdAt).toUtc();
        final expiryTime = statusChangedAt.add(timeoutDuration);
        if (now.isAfter(expiryTime)) {
          AppLogger.info(
              'Offer ${offer.id} ${offer.status} timeout reached (entered status at $statusChangedAt, expired at $expiryTime). Settling and opening dispute.',
              offerId: offer.id);
          await _handleDisputeEscalationTimeout(offer.id);
          autoDisputedCount++;
        } else {
          AppLogger.info(
              'Offer ${offer.id} still within ${offer.status} window (expires at $expiryTime). Restarting timer.',
              offerId: offer.id);
          _startDisputeEscalationTimer(offer);
          timerRestartedCount++;
        }
      }

      AppLogger.info(
          'Dispute escalation check complete. Auto disputed $autoDisputedCount offers, restarted timers for $timerRestartedCount offers.');
    } catch (e) {
      AppLogger.info('Error during dispute escalation auto dispute check: $e');
    }
  }

  Future<void> _checkExpiredReservations() async {
    AppLogger.info('Checking for expired reserved offers on startup...');
    try {
      final reservedOffers =
          await _c._dbService.getOffersByStatus(OfferStatus.reserved, limit: 1000);
      final now = DateTime.now().toUtc();
      final timeoutDuration =
          Duration(seconds: _c._reservationTimeoutSeconds); // Reservation timeout

      int revertedCount = 0;
      for (final offer in reservedOffers) {
        if (offer.reservedAt != null) {
          final expiryTime = offer.reservedAt!.add(timeoutDuration);
          if (now.isAfter(expiryTime)) {
            AppLogger.info(
                'Offer ${offer.id} reservation expired (reserved at ${offer.reservedAt}, expired at $expiryTime). Reverting status.',
                offerId: offer.id);
            final success = await _c._dbService.updateOfferStatus(
              offer.id,
              OfferStatus.funded,
              // Clear reservation related fields
              takerPubkey: null,
              reservedAt: null,
            );
            if (success) {
              revertedCount++;

              // Publish status update
              final revertedOffer = await _c._dbService.getOfferById(offer.id);
              if (revertedOffer != null) {
                await _c._publishStatusUpdate(revertedOffer);
                _startFundedOfferTimer(revertedOffer);
              }
            } else {
              AppLogger.info(
                  'Error reverting expired offer ${offer.id} on startup.',
                  offerId: offer.id);
            }
          } else {
            // Reservation not yet expired: restart its timer with the
            // remaining duration so it still times out after the restart.
            AppLogger.info(
                'Offer ${offer.id} still within reservation window (expires at $expiryTime). Restarting timer.',
                offerId: offer.id);
            _startReservationTimer(offer.id,
                duration: expiryTime.difference(now));
          }
        } else {
          AppLogger.info(
              'Warning: Offer ${offer.id} is reserved but has no reserved_at timestamp. Reverting.',
              offerId: offer.id);
          final success = await _c._dbService.updateOfferStatus(
            offer.id,
            OfferStatus.funded,
            // Clear reservation related fields
            takerPubkey: null,
            reservedAt: null,
          );
          if (success) {
            revertedCount++;
            final revertedOffer = await _c._dbService.getOfferById(offer.id);
            if (revertedOffer != null) {
              _startFundedOfferTimer(revertedOffer);
            }
          } else {
            AppLogger.info(
                'Error reverting reserved offer ${offer.id} with missing timestamp on startup.',
                offerId: offer.id);
          }
        }
      }
      AppLogger.info(
          'Expired reservation check complete. Reverted $revertedCount offers.');
    } catch (e) {
      AppLogger.info('Error during expired reservation check: $e');
    }
  }

  Future<void> _checkExpiredBlikConfirmations() async {
    AppLogger.info(
        '### COORDINATOR: Running _checkExpiredBlikConfirmations on startup...');
    try {
      final offersToCheck = [
        ...await _c._dbService.getOffersByStatus(OfferStatus.blikReceived,
            limit: 1000),
        ...await _c._dbService.getOffersByStatus(OfferStatus.blikSentToMaker,
            limit: 1000),
      ];

      final now = _c._clock.now().toUtc();
      final timeoutDuration = _c._paymentSystem.confirmationWindow;

      int expiredCount = 0;
      for (final offer in offersToCheck) {
        if (offer.blikReceivedAt != null) {
          final expiryTime = offer.blikReceivedAt!.add(timeoutDuration);
          if (now.isAfter(expiryTime)) {
            // Determine the appropriate expired status based on current status
            final newStatus = offer.status == OfferStatus.blikReceived
                ? OfferStatus.expiredBlik
                : OfferStatus.expiredSentBlik;
            AppLogger.info(
                'Offer ${offer.id} BLIK confirmation expired (BLIK received at ${offer.blikReceivedAt}, expired at $expiryTime). Transitioning to $newStatus.',
                offerId: offer.id);
            final success = await _c._dbService.updateOfferStatus(
              offer.id,
              newStatus,
              // Clear BLIK related fields as well
              blikCode: null,
              takerLightningAddress: null,
              blikReceivedAt: null,
            );
            if (success) {
              expiredCount++;

              // Publish status update
              final expiredOffer = await _c._dbService.getOfferById(offer.id);
              if (expiredOffer != null) {
                await _c._publishStatusUpdate(expiredOffer);
              }
            } else {
              AppLogger.info(
                  'Error updating expired BLIK confirmation for offer ${offer.id} on startup.',
                  offerId: offer.id);
            }
          } else {
            // Confirmation window not yet over: restart the timer with the
            // remaining duration so it still expires after the restart.
            AppLogger.info(
                'Offer ${offer.id} still within BLIK confirmation window (expires at $expiryTime). Restarting timer.',
                offerId: offer.id);
            _startBlikConfirmationTimer(offer.id,
                duration: expiryTime.difference(now));
          }
        } else {
          AppLogger.info(
              'Warning: Offer ${offer.id} is in state ${offer.status} but has no blik_received_at timestamp. Transitioning to expired status.',
              offerId: offer.id);
          // Determine the appropriate expired status based on current status
          final newStatus = offer.status == OfferStatus.blikReceived
              ? OfferStatus.expiredBlik
              : OfferStatus.expiredSentBlik;
          final success = await _c._dbService.updateOfferStatus(
            offer.id,
            newStatus,
            // Clear BLIK related fields as well
            blikCode: null,
            takerLightningAddress: null,
            blikReceivedAt: null, // Though it's missing, good to be explicit
          );
          if (success) {
            expiredCount++;
            // Publish status update
            final expiredOffer = await _c._dbService.getOfferById(offer.id);
            if (expiredOffer != null) {
              await _c._publishStatusUpdate(expiredOffer);
            }
          } else {
            AppLogger.info(
                'Error updating offer ${offer.id} with missing BLIK timestamp on startup.',
                offerId: offer.id);
          }
        }
      }
      AppLogger.info(
          'Expired BLIK confirmation check complete. Expired $expiredCount offers.');
    } catch (e) {
      AppLogger.info('Error during expired BLIK confirmation check: $e');
    }
  }

  Future<void> _checkExpiredBlikRelists() async {
    AppLogger.info('Checking for expiredBlik auto-relist on startup...');
    try {
      final offers = await _c._dbService.getOffersByStatus(
        OfferStatus.expiredBlik,
        limit: 1000,
      );
      final now = _c._clock.now().toUtc();
      const timeoutDuration =
          Duration(seconds: _expiredBlikRelistTimeoutSeconds);

      int relistedCount = 0;
      int timerRestartedCount = 0;
      for (final offer in offers) {
        final statusChangedAt = (offer.updatedAt ?? offer.createdAt).toUtc();
        final expiryTime = statusChangedAt.add(timeoutDuration);
        if (now.isAfter(expiryTime)) {
          AppLogger.info(
              'Offer ${offer.id} expiredBlik grace period elapsed (entered status at $statusChangedAt, expires at $expiryTime). Relisting as funded.',
              offerId: offer.id);
          await _handleExpiredBlikRelistTimeout(offer.id);
          relistedCount++;
        } else {
          AppLogger.info(
              'Offer ${offer.id} still within expiredBlik grace period (expires at $expiryTime). Restarting timer.',
              offerId: offer.id);
          _startExpiredBlikRelistTimer(offer);
          timerRestartedCount++;
        }
      }

      AppLogger.info(
          'expiredBlik auto-relist check complete. Relisted $relistedCount offers, restarted timers for $timerRestartedCount offers.');
    } catch (e) {
      AppLogger.info('Error during expiredBlik auto-relist check: $e');
    }
  }

  void _startFundedOfferTimer(Offer offer) {
    _fundedOfferTimers[offer.id]?.cancel();

    final now = _c._clock.now().toUtc();
    final expirationTime =
        offer.createdAt.add(Duration(seconds: _c._fundedExpireTimeoutSeconds));
    final remainingDuration = expirationTime.difference(now);

    if (remainingDuration.isNegative || remainingDuration.inSeconds == 0) {
      AppLogger.info(
          'Offer ${offer.id} has already passed its expiration time. Handling expiration immediately.',
          offerId: offer.id);
      // Ensure it's not processed in a tight loop if already handled
      _fundedOfferTimers.remove(offer.id);
      _handleFundedOfferExpiration(offer);
    } else {
      AppLogger.info(
          'Starting funded offer expiration timer for offer ${offer.id} with remaining duration: ${remainingDuration.inSeconds}s',
          offerId: offer.id);
      _fundedOfferTimers[offer.id] = Timer(remainingDuration, () {
        AppLogger.info('Funded offer timer expired for offer ${offer.id}',
            offerId: offer.id);
        _handleFundedOfferExpiration(offer);
        _fundedOfferTimers.remove(offer.id);
      });
    }
  }

  Future<void> _handleFundedOfferExpiration(Offer offer) async {
    AppLogger.info('Handling funded offer expiration for offer ${offer.id}',
        offerId: offer.id);
    final currentOffer = await _c._dbService.getOfferById(offer.id);
    if (currentOffer?.status == OfferStatus.funded) {
      if (_c._paymentBackend != null) {
        try {
          final cancelResult = await _c._paymentBackend!.cancelInvoice(
              paymentHashHex: currentOffer!.holdInvoicePaymentHash!);
          if (cancelResult.isAlreadyMissing) {
            AppLogger.info(
                'Hold invoice ${currentOffer.holdInvoicePaymentHash} is already missing on ${_c._paymentBackendType} for expired offer ${offer.id}; proceeding with DB expiration.',
                offerId: offer.id);
          } else {
            AppLogger.info(
                'Hold invoice for offer ${offer.id} cancelled via ${_c._paymentBackendType} due to expiration.',
                offerId: offer.id);
          }
        } catch (e) {
          AppLogger.info(
              'Error cancelling hold invoice for expired offer ${offer.id} using ${_c._paymentBackendType}: $e',
              offerId: offer.id);
          return;
        }
      } else {
        AppLogger.info(
            'CRITICAL: No payment backend to cancel invoice for expired offer ${offer.id}.',
            offerId: offer.id);
      }
      final dbSuccess = await _c._dbService.updateOfferStatusIfCurrentStatus(
          offer.id, OfferStatus.expired, [OfferStatus.funded]);
      if (dbSuccess) {
        AppLogger.info(
            'Offer ${offer.id} status updated to expired in DB due to expiration.',
            offerId: offer.id);

        // Publish status update
        final expiredOffer = await _c._dbService.getOfferById(offer.id);
        if (expiredOffer != null) {
          await _c._publishStatusUpdate(expiredOffer);
          await _c._nostrService?.broadcastNip69OrderFromOffer(expiredOffer);
        }

        await _c._strikeTelegramOfferMessages(offer.id);
      } else {
        AppLogger.info(
            'Failed to update offer ${offer.id} status to expired in DB after expiration.',
            offerId: offer.id);
      }
    } else {
      AppLogger.info(
          'Offer ${offer.id} is no longer funded (current status: ${currentOffer?.status}). No action needed for funded expiration.',
          offerId: offer.id);
    }
  }

  void _startTakerChargedTimer(Offer offer) {
    if (offer.status != OfferStatus.takerCharged) {
      AppLogger.info(
          'Error: Cannot start taker charged timer for offer ${offer.id} - not in state takerCharged, status is ${offer.status}',
          offerId: offer.id);
      return;
    }
    _takerChargedTimers[offer.id]?.cancel();

    final now = _c._clock.now().toUtc();
    // Use createdAt as the base for timer calculation since that's when the hold invoice was created
    final expirationTime = offer.createdAt
        .add(Duration(seconds: _c._takerChargedAutoConfirmTimeoutSeconds));
    final remainingDuration = expirationTime.difference(now);

    if (remainingDuration.isNegative || remainingDuration.inSeconds == 0) {
      AppLogger.info(
          'Offer ${offer.id} has already passed its expiration time. Handling expiration immediately.',
          offerId: offer.id);
      // Ensure it's not processed in a tight loop if already handled
      _takerChargedTimers.remove(offer.id);
      _handleTakerChargedAutoConfirmation(offer);
    } else {
      AppLogger.info(
          'Starting taker charged auto confirmationtimer for offer ${offer.id} with remaining duration: ${remainingDuration.inSeconds}s',
          offerId: offer.id);
      _takerChargedTimers[offer.id] = Timer(remainingDuration, () {
        AppLogger.info(
            'taker charged auto confirmation timer expired for offer ${offer.id}',
            offerId: offer.id);
        _handleTakerChargedAutoConfirmation(offer);
        _takerChargedTimers.remove(offer.id);
      });
    }
  }

  void _startDisputeEscalationTimer(Offer offer) {
    if (offer.status != OfferStatus.invalidBlik &&
        offer.status != OfferStatus.expiredSentBlik &&
        offer.status != OfferStatus.conflict) {
      AppLogger.info(
          'Error: Cannot start dispute escalation timer for offer ${offer.id} - not in invalidBlik, expiredSentBlik, or conflict, status is ${offer.status}',
          offerId: offer.id);
      return;
    }

    _disputeEscalationTimers[offer.id]?.cancel();

    final now = _c._clock.now().toUtc();
    final statusChangedAt = (offer.updatedAt ?? offer.createdAt).toUtc();
    final expirationTime = statusChangedAt
        .add(Duration(seconds: _c._conflictAutoDisputeTimeoutSeconds));
    final remainingDuration = expirationTime.difference(now);

    if (remainingDuration.isNegative || remainingDuration.inSeconds == 0) {
      AppLogger.info(
          'Offer ${offer.id} has already passed dispute escalation timeout. Handling immediately.',
          offerId: offer.id);
      _disputeEscalationTimers.remove(offer.id);
      _handleDisputeEscalationTimeout(offer.id);
      return;
    }

    AppLogger.info(
        'Starting dispute escalation timer for offer ${offer.id} (status: ${offer.status}) with remaining duration: ${remainingDuration.inSeconds}s',
        offerId: offer.id);
    _disputeEscalationTimers[offer.id] = Timer(remainingDuration, () {
      AppLogger.info('Dispute escalation timer expired for offer ${offer.id}',
          offerId: offer.id);
      _disputeEscalationTimers.remove(offer.id);
      _handleDisputeEscalationTimeout(offer.id);
    });
  }

  Future<void> _handleDisputeEscalationTimeout(String offerId) async {
    AppLogger.info('Handling dispute escalation timeout for offer $offerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer == null) {
      AppLogger.info(
          'Offer $offerId not found while handling dispute escalation timeout.',
          offerId: offerId);
      return;
    }
    if (offer.status != OfferStatus.invalidBlik &&
        offer.status != OfferStatus.expiredSentBlik &&
        offer.status != OfferStatus.conflict) {
      AppLogger.info(
          'Offer $offerId is no longer in invalidBlik, expiredSentBlik, or conflict (current status: ${offer.status}). No action needed.',
          offerId: offerId);
      return;
    }

    try {
      if (_c._paymentBackend != null) {
        await _c._paymentBackend!
            .settleInvoice(preimageHex: offer.holdInvoicePreimage!);
        AppLogger.info(
            'Hold invoice for offer $offerId settled via ${_c._paymentBackendType} due to dispute escalation timeout.',
            offerId: offerId);
      } else {
        AppLogger.info(
            'CRITICAL: No payment backend to settle invoice for offer $offerId during dispute escalation.',
            offerId: offerId);
        return;
      }
    } catch (e, st) {
      AppLogger.severe(
          'Error settling hold invoice for offer $offerId during dispute escalation',
          offerId: offerId,
          error: e,
          stackTrace: st);
      return;
    }

    final disputeReason = switch (offer.status) {
      OfferStatus.expiredSentBlik =>
        DisputeEscalationReason.autoExpiredSentBlikTimeout,
      OfferStatus.invalidBlik => DisputeEscalationReason.autoInvalidBlikTimeout,
      OfferStatus.conflict => DisputeEscalationReason.autoConflictTimeout,
      _ => DisputeEscalationReason.unknown,
    };

    final success = await _c._dbService.updateOfferStatus(
      offerId,
      OfferStatus.dispute,
      disputeEscalationReason: disputeReason,
    );
    if (success) {
      AppLogger.info(
          'Offer $offerId status updated to dispute after escalation timeout.',
          offerId: offerId);
      final updatedOffer = await _c._dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _c._publishStatusUpdate(updatedOffer);
        await _c._nostrService?.broadcastNip69OrderFromOffer(updatedOffer);
      }
    } else {
      AppLogger.info(
          'Failed to update offer $offerId status to dispute after escalation timeout.',
          offerId: offerId);
    }
  }

  Future<void> _handleTakerChargedAutoConfirmation(Offer offer) async {
    AppLogger.info(
        'Handling taker charged auto confirmation expiration for offer ${offer.id}',
        offerId: offer.id);
    if (offer.status == OfferStatus.takerCharged) {
      if (_c._paymentBackend != null) {
        try {
          final success =
              await confirmMakerPayment(offer.id, offer.makerPubkey);
          if (!success) {
            throw Exception(
                'Failed to confirm payment. Check offer state, LND connection, or logs.');
          }
        } catch (e) {
          AppLogger.info(
              'Error auto confirming offer after ${_c._takerChargedAutoConfirmTimeoutSeconds} seconds in status taker charged $e');
          return; // Exit if cancellation fails
        }
      } else {
        AppLogger.info(
            'CRITICAL: No payment backend auto confirm offer in status takerCharged.');
      }
    } else {
      AppLogger.info(
          'Offer ${offer.id} is no longer in takerCharged status (current status: ${offer.status}). No action needed for takerCharged auto confirmation expiration',
          offerId: offer.id);
    }
  }

  // --- Coordinator Info Endpoint ---
  Future<DateTime?> reserveOffer(String offerId, String takerId) async {
    AppLogger.info('Reserving offer $offerId for taker $takerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer == null ||
        (offer.status != OfferStatus.funded &&
            offer.status != OfferStatus.invalidBlik &&
            offer.status != OfferStatus.expiredSentBlik &&
            offer.status != OfferStatus.expiredBlik) ||
        ((offer.status == OfferStatus.invalidBlik ||
                offer.status == OfferStatus.expiredBlik) &&
            offer.takerPubkey != takerId)) {
      AppLogger.info(
          'Offer $offerId not found or not available for reservation status:${offer?.status}.',
          offerId: offerId);
      _fundedOfferTimers[offerId]?.cancel();
      _fundedOfferTimers.remove(offerId);
      _expiredBlikRelistTimers[offerId]?.cancel();
      _expiredBlikRelistTimers.remove(offerId);
      return null;
    }

    // Maker cannot take their own offer.
    if (offer.makerPubkey == takerId) {
      AppLogger.info(
          'Offer $offerId reservation rejected: taker $takerId is the maker.',
          offerId: offerId);
      return null;
    }

    final now = DateTime.now().toUtc();
    final timestampToStore = now.add(const Duration(seconds: 1));

    // Atomic compare-and-set on the exact status validated above: if another
    // taker (or a timer) changed the status since the read, no row matches and
    // the reservation is rejected instead of double-booking the offer.
    // expectedTakerPubkey pins the row to the taker observed in the read (null
    // for funded offers, where the clause is skipped and taker_pubkey is
    // cleared anyway), closing ABA cycles on re-take states.
    _c._shadowCheckTransition(
      from: offer.status,
      event: kRpcReserveOffer,
      actor: FlowActor.taker,
      to: OfferStatus.reserved,
    );
    final success = await _c._dbService.updateOfferStatusIfCurrentStatus(
      offerId,
      OfferStatus.reserved,
      [offer.status],
      takerPubkey: takerId,
      reservedAt: timestampToStore,
      expectedTakerPubkey: offer.takerPubkey,
    );

    if (success) {
      AppLogger.info(
          'Offer $offerId reserved successfully, DB timestamp set to $timestampToStore.',
          offerId: offerId);
      _fundedOfferTimers[offerId]?.cancel();
      _fundedOfferTimers.remove(offerId);
      _expiredBlikRelistTimers[offerId]?.cancel();
      _expiredBlikRelistTimers.remove(offerId);
      _disputeEscalationTimers[offerId]?.cancel();
      _disputeEscalationTimers.remove(offerId);
      _startReservationTimer(offerId);

      // Publish status update
      final updatedOffer = await _c._dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _c._publishStatusUpdate(updatedOffer);
        await _c._nostrService?.broadcastNip69OrderFromOffer(updatedOffer);
      }

      return timestampToStore;
    } else {
      AppLogger.info('Failed to reserve offer $offerId in DB.',
          offerId: offerId);
      return null;
    }
  }

  void _startReservationTimer(String offerId, {Duration? duration}) {
    _reservationTimers[offerId]?.cancel();
    final timerDuration =
        duration ?? Duration(seconds: _c._reservationTimeoutSeconds);
    AppLogger.info(
        'Starting ${timerDuration.inSeconds}s reservation timer for offer $offerId',
        offerId: offerId);
    _reservationTimers[offerId] = Timer(timerDuration, () {
      AppLogger.info('Reservation timer expired for offer $offerId',
          offerId: offerId);
      _handleReservationTimeout(offerId);
      _reservationTimers.remove(offerId);
    });
  }

  // New private method to handle reverting an offer to funded state
  Future<bool> _revertOfferToFunded(String offerId) async {
    AppLogger.info('Reverting offer $offerId to funded state.',
        offerId: offerId);
    final success = await _c._dbService.updateOfferStatus(
      offerId,
      OfferStatus.funded,
      takerPubkey: null,
      blikCode: null,
      takerLightningAddress: null,
      reservedAt: null, // Ensure reservedAt is cleared
    );
    if (success) {
      // AppLogger.info('Offer $offerId successfully reverted to funded.',
      //     offerId: offerId);
      // Restart the funded offer timer
      final offer = await _c._dbService.getOfferById(offerId);
      if (offer != null) {
        _startFundedOfferTimer(offer);
      } else {
        AppLogger.info(
            'Error: Could not find offer $offerId after reverting to funded to restart timer.',
            offerId: offerId);
      }
    } else {
      AppLogger.info('Error reverting offer $offerId to funded in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<void> _handleReservationTimeout(String offerId) async {
    AppLogger.info('Handling reservation timeout for offer $offerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer != null && offer.status == OfferStatus.reserved) {
      AppLogger.info(
          'Offer $offerId is still reserved. Reverting status to funded due to timeout.',
          offerId: offerId);
      final reverted = await _revertOfferToFunded(offerId);
      if (reverted) {
        // Publish status update
        final revertedOffer = await _c._dbService.getOfferById(offerId);
        if (revertedOffer != null) {
          await _c._publishStatusUpdate(revertedOffer);
          await _c._nostrService?.broadcastNip69OrderFromOffer(revertedOffer);
        }
      }
    } else {
      AppLogger.info(
          'Offer $offerId no longer reserved (current status: ${offer?.status}). No action needed for reservation timeout.',
          offerId: offerId);
    }
  }

  void _startBlikConfirmationTimer(String offerId, {Duration? duration}) {
    _blikConfirmationTimers[offerId]?.cancel();
    final window = duration ?? _c._paymentSystem.confirmationWindow;
    AppLogger.info(
        '### COORDINATOR: Starting ${window.inSeconds}s BLIK confirmation timer for offer $offerId',
        offerId: offerId);
    _blikConfirmationTimers[offerId] = Timer(window, () {
      AppLogger.info(
          '### COORDINATOR: Raw timer expired for offer $offerId. Calling handler...',
          offerId: offerId);
      _handleBlikConfirmationTimeout(offerId);
      _blikConfirmationTimers.remove(offerId);
    });
  }

  Future<void> _handleBlikConfirmationTimeout(String offerId) async {
    AppLogger.info(
        '### COORDINATOR: Handling BLIK confirmation timeout for offer $offerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer != null &&
        (offer.status == OfferStatus.blikReceived ||
            offer.status == OfferStatus.blikSentToMaker)) {
      final newStatus = offer.status == OfferStatus.blikReceived
          ? OfferStatus.expiredBlik
          : OfferStatus.expiredSentBlik;
      AppLogger.info(
          'Offer ${offer.id} BLIK confirmation timed out (status: ${offer.status}). Transitioning to $newStatus',
          offerId: offer.id);
      final success = await _c._dbService.updateOfferStatus(
        offerId,
        newStatus,
        // Clear BLIK related fields as well
        blikCode: null,
        takerLightningAddress: null,
        blikReceivedAt: null,
      );
      if (success) {
        AppLogger.info(
            'Offer $offerId status reverted to $newStatus to BLIK confirmation timeout.',
            offerId: offerId);

        // Publish status update
        final revertedOffer = await _c._dbService.getOfferById(offerId);
        if (revertedOffer != null) {
          await _c._publishStatusUpdate(revertedOffer);
          if (revertedOffer.status == OfferStatus.expiredSentBlik) {
            _startDisputeEscalationTimer(revertedOffer);
          } else if (revertedOffer.status == OfferStatus.expiredBlik) {
            _startExpiredBlikRelistTimer(
              revertedOffer,
              remainingDuration:
                  const Duration(seconds: _expiredBlikRelistTimeoutSeconds),
            );
          }
        }
      } else {
        AppLogger.info(
            'Error reverting offer $offerId status after BLIK confirmation timeout.',
            offerId: offerId);
      }
    } else {
      AppLogger.info(
          'Offer $offerId no longer awaiting BLIK confirmation (current status: ${offer?.status}). No action needed for BLIK timeout.',
          offerId: offerId);
    }
  }

  void _startExpiredBlikRelistTimer(
    Offer offer, {
    Duration? remainingDuration,
  }) {
    if (offer.status != OfferStatus.expiredBlik) {
      AppLogger.info(
          'Error: Cannot start expiredBlik relist timer for offer ${offer.id} - status is ${offer.status}',
          offerId: offer.id);
      return;
    }

    _expiredBlikRelistTimers[offer.id]?.cancel();

    final effectiveRemainingDuration = remainingDuration ??
        (offer.updatedAt ?? offer.createdAt)
            .toUtc()
            .add(const Duration(seconds: _expiredBlikRelistTimeoutSeconds))
            .difference(_c._clock.now().toUtc());

    if (effectiveRemainingDuration.isNegative ||
        effectiveRemainingDuration.inSeconds == 0) {
      AppLogger.info(
          'Offer ${offer.id} has already passed expiredBlik relist timeout. Handling immediately.',
          offerId: offer.id);
      _expiredBlikRelistTimers.remove(offer.id);
      _handleExpiredBlikRelistTimeout(offer.id);
      return;
    }

    AppLogger.info(
        'Starting expiredBlik relist timer for offer ${offer.id} with remaining duration: ${effectiveRemainingDuration.inSeconds}s',
        offerId: offer.id);
    _expiredBlikRelistTimers[offer.id] = Timer(effectiveRemainingDuration, () {
      AppLogger.info('expiredBlik relist timer expired for offer ${offer.id}',
          offerId: offer.id);
      _expiredBlikRelistTimers.remove(offer.id);
      _handleExpiredBlikRelistTimeout(offer.id);
    });
  }

  Future<void> _handleExpiredBlikRelistTimeout(String offerId) async {
    AppLogger.info('Handling expiredBlik relist timeout for offer $offerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer == null || offer.status != OfferStatus.expiredBlik) {
      AppLogger.info(
          'Offer $offerId no longer in expiredBlik status (current status: ${offer?.status}). No action needed for relist timeout.',
          offerId: offerId);
      return;
    }

    final reverted = await _revertOfferToFunded(offerId);
    if (!reverted) {
      AppLogger.info(
          'Failed to relist offer $offerId as funded after expiredBlik grace period.',
          offerId: offerId);
      return;
    }

    final revertedOffer = await _c._dbService.getOfferById(offerId);
    if (revertedOffer != null) {
      await _c._publishStatusUpdate(revertedOffer);
      await _c._nostrService?.broadcastNip69OrderFromOffer(revertedOffer);
    }
  }
  Future<bool> submitBlikCode(String offerId, String takerId, String? blikCode,
      String? takerLightningAddress, String? takerInvoice) async {
    AppLogger.info(
        'Submitting ${_c._paymentSystem.codeLabel} flow for offer $offerId by taker $takerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer == null ||
        offer.status != OfferStatus.reserved ||
        offer.takerPubkey != takerId) {
      AppLogger.info(
          'Offer $offerId not found, not reserved, or taker mismatch.',
          offerId: offerId);
      return false;
    }

    final effectiveCode = _c._paymentSystem.makerProvidesCodeAtOfferCreation
        ? offer.blikCode
        : blikCode?.trim();
    if (effectiveCode == null || !_c._paymentSystem.isValidCode(effectiveCode)) {
      AppLogger.info(
          'Offer $offerId has no valid ${_c._paymentSystem.codeLabel} code available.',
          offerId: offerId);
      return false;
    }

    final netAmountSats = _c._expectedTakerNetAmountSats(offer);
    AppLogger.info(
        'Calculated net amount for taker invoice: $netAmountSats sats (Original: ${offer.amountSats}, Fee: ${offer.takerFees})');

    if (takerInvoice == null) {
      if (takerLightningAddress == null || takerLightningAddress.isEmpty) {
        AppLogger.info(
            'Cannot resolve LNURL invoice for offer $offerId: missing takerLightningAddress and takerInvoice.',
            offerId: offerId);
        return false;
      }
      takerInvoice =
          await _c._resolveLnurlPay(takerLightningAddress, netAmountSats);
    } else {
      _c._validateTakerInvoiceAmount(
        offer,
        takerInvoice,
        action: 'submit_blik',
      );
    }
    if (takerInvoice == null || takerInvoice.isEmpty) {
      AppLogger.info(
          'Could not get an invoice for net amount $netAmountSats sats for LN address $takerLightningAddress');
      return false;
    }
    _c._validateTakerInvoiceAmount(
      offer,
      takerInvoice,
      action: 'submit_blik',
    );
    // The following line seems to be a copy-paste error, the condition is already checked above.
    // AppLogger.info('Offer $offerId not found, not reserved, or taker mismatch.', offerId: offerId);

    _reservationTimers[offerId]?.cancel();
    _reservationTimers.remove(offerId);
    AppLogger.info(
        'Cancelled reservation timer for offer $offerId due to BLIK submission.',
        offerId: offerId);

    final blikReceivedTime = DateTime.now().toUtc();

    // expectedTakerPubkey guards the ABA case: reservation expired, offer was
    // re-reserved by another taker, status is "reserved" again but the row no
    // longer belongs to this taker.
    _c._shadowCheckTransition(
      from: offer.status,
      event: kRpcSubmitBlik,
      actor: FlowActor.taker,
      to: OfferStatus.blikReceived,
    );
    final success = await _c._dbService.updateOfferStatusIfCurrentStatus(
        offerId, OfferStatus.blikReceived, [OfferStatus.reserved],
        blikCode: effectiveCode,
        takerInvoice: takerInvoice,
        takerLightningAddress: takerLightningAddress,
        blikReceivedAt: blikReceivedTime,
        expectedTakerPubkey: takerId);

    if (success) {
      AppLogger.info('BLIK code for offer $offerId stored.', offerId: offerId);
      _startBlikConfirmationTimer(offerId);

      // Publish status update
      final updatedOffer = await _c._dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _c._publishStatusUpdate(updatedOffer);
      }
    } else {
      AppLogger.info('Failed to store BLIK code for offer $offerId in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<String?> getBlikCodeForMaker(String offerId, String makerId) async {
    AppLogger.info('Maker $makerId requesting BLIK for offer $offerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer == null ||
        offer.makerPubkey != makerId ||
        offer.blikCode == null) {
      AppLogger.info(
          'Offer $offerId not found, maker mismatch, status not blikReceived/blikSentToMaker, or no BLIK code available.',
          offerId: offerId);
      return null;
    }
    // Allow fetching if status is blikReceived OR blikSentToMaker
    if (offer.status != OfferStatus.blikReceived &&
        offer.status != OfferStatus.blikSentToMaker) {
      AppLogger.info(
          'Offer $offerId not in correct state (${offer.status}) to provide BLIK code to maker.',
          offerId: offerId);
      return null;
    }

    try {
      // Only update to blikSentToMaker if it's currently blikReceived
      if (offer.status == OfferStatus.blikReceived) {
        _c._shadowCheckTransition(
          from: offer.status,
          event: kRpcGetBlik,
          actor: FlowActor.maker,
          to: OfferStatus.blikSentToMaker,
        );
        final statusUpdated = await _c._dbService.updateOfferStatusIfCurrentStatus(
            offerId, OfferStatus.blikSentToMaker, [OfferStatus.blikReceived]);
        if (!statusUpdated) {
          AppLogger.info(
              'Warning: Failed to update offer $offerId status to blikSentToMaker, but returning code anyway.',
              offerId: offerId);
        } else {
          AppLogger.info('Offer $offerId status updated to blikSentToMaker.',
              offerId: offerId);

          // Publish status update
          final updatedOffer = await _c._dbService.getOfferById(offerId);
          if (updatedOffer != null) {
            await _c._publishStatusUpdate(updatedOffer);
          }
        }
      }
      // Restart timer to continue monitoring for expiration even after maker gets the code.
      // The timer should still fire after the method's confirmation window from
      // blikReceivedAt to check if maker confirmed (BLIK 2 min, MB WAY 30 min).
      _blikConfirmationTimers[offerId]?.cancel();
      _blikConfirmationTimers.remove(offerId);
      // Restart the timer, but calculate remaining time from blikReceivedAt
      if (offer.blikReceivedAt != null) {
        final now = _c._clock.now().toUtc();
        final elapsed = now.difference(offer.blikReceivedAt!);
        final timeoutDuration = _c._paymentSystem.confirmationWindow;
        final remaining = timeoutDuration - elapsed;
        if (remaining > Duration.zero) {
          _blikConfirmationTimers[offerId] = Timer(remaining, () {
            AppLogger.info(
                '### COORDINATOR: Raw timer expired for offer $offerId. Calling handler...',
                offerId: offerId);
            _handleBlikConfirmationTimeout(offerId);
            _blikConfirmationTimers.remove(offerId);
          });
        } else {
          // Already expired, handle immediately
          _handleBlikConfirmationTimeout(offerId);
        }
      } else {
        // Fallback: restart with full duration if blikReceivedAt is missing
        _startBlikConfirmationTimer(offerId);
      }
    } catch (e) {
      AppLogger.info('Error during getBlikCodeForMaker for offer $offerId: $e',
          offerId: offerId);
    }

    AppLogger.info('Returning BLIK code for offer $offerId to maker.',
        offerId: offerId);
    return offer.blikCode;
  }

  Future<bool> markBlikInvalid(String offerId, String makerId) async {
    AppLogger.warning(
        'Maker $makerId marking BLIK as invalid for offer $offerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);

    if (offer == null || offer.makerPubkey != makerId) {
      AppLogger.warning(
          'Offer $offerId not found or maker ID mismatch for marking BLIK invalid.',
          offerId: offerId);
      return false;
    }

    final allowDirectMakerConfirmationFromReserved =
        _c._paymentSystem.makerProvidesCodeAtOfferCreation &&
            offer.status == OfferStatus.reserved;

    if (!allowDirectMakerConfirmationFromReserved &&
        offer.status != OfferStatus.takerCharged &&
        offer.status != OfferStatus.blikSentToMaker &&
        offer.status != OfferStatus.expiredSentBlik) {
      AppLogger.warning(
          'Offer $offerId is not in a state where BLIK can be marked invalid (current state: ${offer.status}).',
          offerId: offerId);
      return false;
    }

    _blikConfirmationTimers[offerId]?.cancel();
    _blikConfirmationTimers.remove(offerId);
    // AppLogger.info(
    //     'Cancelled BLIK confirmation timer for offer $offerId (if active).',
    //     offerId: offerId);

    final newStatus = offer.status != OfferStatus.takerCharged
        ? OfferStatus.invalidBlik
        : OfferStatus.conflict;

    // newStatus depends on the observed status, so CAS on exactly that status:
    // if it changed since the read, the invalidBlik/conflict mapping would be
    // stale — abort instead.
    _c._shadowCheckTransition(
      from: offer.status,
      event: kRpcMarkBlikInvalid,
      actor: FlowActor.maker,
      to: newStatus,
    );
    final success = await _c._dbService
        .updateOfferStatusIfCurrentStatus(offerId, newStatus, [offer.status]);

    if (success) {
      AppLogger.info('Offer $offerId status updated to $newStatus.',
          offerId: offerId);

      // Publish status update
      final updatedOffer = await _c._dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _c._publishStatusUpdate(updatedOffer);
        _startDisputeEscalationTimer(updatedOffer);
      }
    } else {
      AppLogger.warning(
          'Failed to update offer $offerId status to $newStatus in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<bool> markBlikCharged(String offerId, String takerId) async {
    AppLogger.info('Taker $takerId marking offer $offerId as charged.',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);

    if (offer == null || offer.takerPubkey != takerId) {
      AppLogger.info(
          'Offer $offerId not found or taker ID mismatch for marking conflict.',
          offerId: offerId);
      return false;
    }

    if (offer.status != OfferStatus.invalidBlik &&
        offer.status != OfferStatus.expiredSentBlik) {
      AppLogger.info(
          'Offer $offerId is in wrong state (current state: ${offer.status}). Cannot mark as charged.',
          offerId: offerId);
      return false;
    }

    final newStatus = offer.status == OfferStatus.invalidBlik
        ? OfferStatus.conflict
        : OfferStatus.takerCharged;
    // newStatus depends on the observed status, so CAS on exactly that status.
    // expectedTakerPubkey guards the ABA case where the status cycled back
    // with a different taker on the row.
    _c._shadowCheckTransition(
      from: offer.status,
      event: kRpcMarkBlikCharged,
      actor: FlowActor.taker,
      to: newStatus,
    );
    final success = await _c._dbService.updateOfferStatusIfCurrentStatus(
      offerId,
      newStatus,
      [offer.status],
      expectedTakerPubkey: takerId,
      takerChargedAt: _c._clock.now().toUtc(),
    );

    if (success) {
      AppLogger.info('Offer $offerId status updated to $newStatus.',
          offerId: offerId);

      // Publish status update
      final updatedOffer = await _c._dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _c._publishStatusUpdate(updatedOffer);
        await _c._nostrService?.broadcastNip69OrderFromOffer(updatedOffer);
        _disputeEscalationTimers[offerId]?.cancel();
        _disputeEscalationTimers.remove(offerId);
        if (newStatus == OfferStatus.conflict) {
          _startDisputeEscalationTimer(updatedOffer);
        }
      }
      if (newStatus == OfferStatus.takerCharged && updatedOffer != null) {
        _startTakerChargedTimer(updatedOffer);
      }
    } else {
      AppLogger.info(
          'Failed to update offer $offerId status to $newStatus in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<bool> openDispute(String offerId, String makerId) async {
    AppLogger.info('Maker $makerId marking offer $offerId as dispute.',
        offerId: offerId);
    _disputeEscalationTimers[offerId]?.cancel();
    _disputeEscalationTimers.remove(offerId);
    final offer = await _c._dbService.getOfferById(offerId);

    if (offer == null || offer.makerPubkey != makerId) {
      AppLogger.info(
          'Offer $offerId not found or maker ID mismatch for opening dispute.',
          offerId: offerId);
      return false;
    }

    if (offer.status != OfferStatus.conflict) {
      AppLogger.info(
          'Offer $offerId is not in the conflict state (current state: ${offer.status}). Cannot mark as open dispute.',
          offerId: offerId);
      return false;
    }
    try {
      if (_c._paymentBackend != null) {
        await _c._paymentBackend!
            .settleInvoice(preimageHex: offer.holdInvoicePreimage!);
        AppLogger.info(
            'Hold invoice for offer $offerId settled successfully via ${_c._paymentBackendType}.',
            offerId: offerId);
      } else {
        AppLogger.info(
            'CRITICAL: No payment backend to settle invoice for offer $offerId.',
            offerId: offerId);
        throw Exception("No payment backend to settle invoice.");
      }
    } catch (e, st) {
      AppLogger.severe('Error settling hold invoice for offer $offerId',
          offerId: offerId, error: e, stackTrace: st);
      return false;
    }

    _c._shadowCheckTransition(
      from: offer.status,
      event: kRpcOpenDispute,
      actor: FlowActor.maker,
      to: OfferStatus.dispute,
    );
    final success = await _c._dbService.updateOfferStatus(
      offerId,
      OfferStatus.dispute,
      disputeEscalationReason: DisputeEscalationReason.makerOpenedDispute,
    );

    if (success) {
      AppLogger.info('Offer $offerId status updated to dispute.',
          offerId: offerId);

      // Publish status update
      final updatedOffer = await _c._dbService.getOfferById(offerId);
      if (updatedOffer != null) {
        await _c._publishStatusUpdate(updatedOffer);
        await _c._nostrService?.broadcastNip69OrderFromOffer(updatedOffer);
      }
    } else {
      AppLogger.info('Failed to update offer $offerId status to dispute in DB.',
          offerId: offerId);
    }
    return success;
  }

  Future<bool> confirmMakerPayment(String offerId, String makerId) async {
    AppLogger.info('Maker $makerId confirming payment for offer $offerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    final allowDirectMakerConfirmationFromReserved =
        offer != null &&
        _c._paymentSystem.makerProvidesCodeAtOfferCreation &&
        offer.status == OfferStatus.reserved;

    if (offer == null ||
        offer.makerPubkey != makerId ||
        (!allowDirectMakerConfirmationFromReserved &&
            offer.status !=
                OfferStatus
                    .conflict && // Allow confirmation from conflict state
            offer.status !=
                OfferStatus
                    .takerCharged && // Allow confirmation from takerCharged state
            offer.status !=
                OfferStatus
                    .blikSentToMaker && // Allow confirmation from blikSentToMaker state
            offer.status !=
                OfferStatus
                    .expiredSentBlik // Allow confirmation from expiredSentBlik state
        )) {
      AppLogger.info(
          'Offer $offerId not found, maker mismatch, or not in correct state for confirmation (current: ${offer?.status}).',
          offerId: offerId);
      return false;
    }

    _reservationTimers[offerId]?.cancel();
    _reservationTimers.remove(offerId);
    _blikConfirmationTimers[offerId]?.cancel();
    _blikConfirmationTimers.remove(offerId);
    _expiredBlikRelistTimers[offerId]?.cancel();
    _expiredBlikRelistTimers.remove(offerId);
    _disputeEscalationTimers[offerId]?.cancel();
    _disputeEscalationTimers.remove(offerId);
    AppLogger.info(
        'Cancelled timers for offer $offerId during maker confirmation.',
        offerId: offerId);

    _c._shadowCheckTransition(
      from: offer.status,
      event: kRpcConfirmPayment,
      actor: FlowActor.maker,
      to: OfferStatus.makerConfirmed,
    );
    // CAS on the states maker confirmation is allowed from; losing the race
    // aborts before the hold invoice is settled below.
    bool success = await _c._dbService
        .updateOfferStatusIfCurrentStatus(offerId, OfferStatus.makerConfirmed, [
      OfferStatus.conflict,
      OfferStatus.takerCharged,
      OfferStatus.blikSentToMaker,
      OfferStatus.expiredSentBlik,
      if (_c._paymentSystem.makerProvidesCodeAtOfferCreation) OfferStatus.reserved,
    ]);
    if (!success) {
      AppLogger.info(
          'Failed to update offer $offerId status to makerConfirmed in DB.',
          offerId: offerId);
      return false;
    }
    AppLogger.info('Offer $offerId status updated to makerConfirmed.',
        offerId: offerId);

    final updatedOffer = await _c._dbService.getOfferById(offerId);
    if (updatedOffer != null) {
      await _c._publishStatusUpdate(updatedOffer);
    }

    try {
      if (_c._paymentBackend != null) {
        await _c._paymentBackend!
            .settleInvoice(preimageHex: offer.holdInvoicePreimage!);
        AppLogger.info(
            'Hold invoice for offer $offerId settled successfully via ${_c._paymentBackendType}.',
            offerId: offerId);
      } else {
        AppLogger.info(
            'CRITICAL: No payment backend to settle invoice for offer $offerId.',
            offerId: offerId);
        throw Exception("No payment backend to settle invoice.");
      }
      await Future.delayed(_kDebugDelayDuration);
      success =
          await _c._dbService.updateOfferStatus(offerId, OfferStatus.settled);
      if (!success) {
        AppLogger.info(
            'Failed to update offer $offerId status to settled in DB.',
            offerId: offerId);
      } else {
        // Publish status update
        final settledOffer = await _c._dbService.getOfferById(offerId);
        if (settledOffer != null) {
          await _c._publishStatusUpdate(settledOffer);
        }
      }
    } catch (e, st) {
      AppLogger.severe('Error settling hold invoice for offer $offerId',
          offerId: offerId, error: e, stackTrace: st);
      // Potentially revert makerConfirmed status or set to a failed state
      return false;
    }

    Future.microtask(() => _c._payTakerAsync(offerId));
    return true;
  }
  Future<bool> cancelReservation(String offerId, String takerId) async {
    AppLogger.info(
        'Taker $takerId attempting to cancel reservation for offer $offerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer == null) {
      AppLogger.info('Offer $offerId not found.', offerId: offerId);
      return false;
    }
    if (offer.takerPubkey != takerId) {
      AppLogger.info(
          'Taker mismatch for cancelling reservation on offer $offerId.',
          offerId: offerId);
      return false;
    }
    if (offer.status != OfferStatus.reserved &&
        offer.status != OfferStatus.expiredBlik &&
        offer.status != OfferStatus.invalidBlik) {
      AppLogger.info(
          'Offer $offerId cannot be cancelled in status ${offer.status}.',
          offerId: offerId);
      _reservationTimers[offerId]?.cancel();
      _reservationTimers.remove(offerId);
      return false;
    }

    _reservationTimers[offerId]?.cancel();
    _reservationTimers.remove(offerId);
    _disputeEscalationTimers[offerId]?.cancel();
    _disputeEscalationTimers.remove(offerId);

    _c._shadowCheckTransition(
      from: offer.status,
      event: kRpcCancelReservation,
      actor: FlowActor.taker,
      to: OfferStatus.funded,
    );
    // Revert offer to funded using the new method
    final reverted = await _revertOfferToFunded(offerId);

    if (reverted) {
      AppLogger.info('Reservation for offer $offerId cancelled by taker.',
          offerId: offerId);

      // Publish status update
      final revertedOffer = await _c._dbService.getOfferById(offerId);
      if (revertedOffer != null) {
        await _c._publishStatusUpdate(revertedOffer);
        await _c._nostrService?.broadcastNip69OrderFromOffer(revertedOffer);
      }

      return true;
    } else {
      AppLogger.info(
          'Failed to cancel reservation for offer $offerId (DB update failed).',
          offerId: offerId);
      return false;
    }
  }

  Future<bool> cancelOffer(String offerId, String makerId) async {
    AppLogger.info('Maker $makerId attempting to cancel offer $offerId',
        offerId: offerId);
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer == null) {
      AppLogger.info('Offer $offerId not found.', offerId: offerId);
      return false;
    }
    if (offer.makerPubkey != makerId) {
      AppLogger.info('Maker mismatch for cancelling offer $offerId.',
          offerId: offerId);
      return false;
    }
    if (offer.status != OfferStatus.funded) {
      AppLogger.info(
          'Offer $offerId cannot be cancelled in status ${offer.status}.',
          offerId: offerId);
      _fundedOfferTimers[offerId]?.cancel();
      _fundedOfferTimers.remove(offerId);
      return false;
    }

    _fundedOfferTimers[offerId]?.cancel();
    _fundedOfferTimers.remove(offerId);

    if (_c._paymentBackend != null) {
      try {
        final cancelResult = await _c._paymentBackend!
            .cancelInvoice(paymentHashHex: offer.holdInvoicePaymentHash!);
        if (cancelResult.isAlreadyMissing) {
          AppLogger.info(
              'Hold invoice for offer $offerId is already missing on ${_c._paymentBackendType}.',
              offerId: offerId);
        } else {
          AppLogger.info(
              'Hold invoice for offer $offerId cancelled successfully via ${_c._paymentBackendType}.',
              offerId: offerId);
        }
      } catch (e) {
        AppLogger.info(
            'Error cancelling hold invoice for offer $offerId using ${_c._paymentBackendType}: $e',
            offerId: offerId);
      }
    } else {
      AppLogger.info(
          'CRITICAL: No payment backend to cancel invoice for offer $offerId.',
          offerId: offerId);
    }

    _c._shadowCheckTransition(
      from: offer.status,
      event: kRpcCancelOffer,
      actor: FlowActor.maker,
      to: OfferStatus.cancelled,
    );
    final dbSuccess = await _c._dbService.cancelOffer(offerId, makerId);
    if (dbSuccess) {
      AppLogger.info('Offer $offerId status updated to cancelled in DB.',
          offerId: offerId);

      // Publish status update
      final cancelledOffer = await _c._dbService.getOfferById(offerId);
      if (cancelledOffer != null) {
        await _c._publishStatusUpdate(cancelledOffer);
        await _c._nostrService?.broadcastNip69OrderFromOffer(cancelledOffer);
      }

      await _c._strikeTelegramOfferMessages(offerId);

      _c._invoiceSubscriptions[offer.holdInvoicePaymentHash]?.cancel();
      _c._invoiceSubscriptions.remove(offer.holdInvoicePaymentHash);
      _c._pendingOffers.remove(offer.holdInvoicePaymentHash);
      return true;
    } else {
      AppLogger.info(
          'Failed to update offer $offerId status to cancelled in DB.',
          offerId: offerId);
      return false;
    }
  }
}
