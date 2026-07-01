part of 'coordinator_service.dart';

/// Mutable accumulator for the atomic status-update write. Pre-commit effects
/// populate it; the executor folds it into a single
/// `updateOfferRawStatusIfCurrent` compare-and-set.
class OfferWriteSpec {
  String? takerPubkey;
  String? expectedTakerPubkey;
  DateTime? reservedAt;
  DateTime? codeReceivedAt;
  DateTime? takerChargedAt;
  DateTime? makerConfirmedAt;
  DateTime? settledAt;
  String? code;
  String? takerInvoice;
  String? takerLightningAddress;
  bool clearTakerFields = false;
}

/// Context handed to each effect. `offer` is the pre-write snapshot; `write` is
/// shared across the pre-commit effects of one transition.
class FlowEffectContext {
  final Offer offer;
  final FlowTransition? transition;
  final Map<String, dynamic> params;
  final String userPubkey;
  final bool isNewTaker;
  final OfferWriteSpec write;
  final DateTime now;

  /// Set by an effect (start_payout) that takes over publishing/advancing, so
  /// the executor skips its default publish + timer-arm tail.
  bool stop = false;

  FlowEffectContext({
    required this.offer,
    required this.transition,
    required this.params,
    required this.userPubkey,
    required this.isNewTaker,
    required this.write,
    required this.now,
  });
}

/// Generic, yaml-driven offer flow. The executor is state-name agnostic: every
/// state-specific behaviour comes from the flow definition (transition `effects`
/// and state `on_entry` effect keywords, resolved against [_effects]) — no
/// `OfferStatus` constants. On reaching a state whose `on_entry` runs
/// `start_payout` it hands off to the shared Lightning payout tail.
///
/// `part of` the coordinator library so it reaches shared services via `_c`.
class GenericOfferFlow implements OfferFlow {
  final CoordinatorService _c;
  GenericOfferFlow(this._c);

  final Map<String, Timer> _stateTimers = {};
  static const Duration _timeoutRetryBackoff = Duration(seconds: 30);

  static const Set<String> _offerActionRpcs = {
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

  /// Effects that must run BEFORE the atomic status write (they shape it).
  static const Set<String> _preCommitEffects = {
    'assign_taker',
    'clear_taker_fields',
    'validate_code',
    'resolve_taker_invoice',
    'accept_taker_invoice',
    'stamp_reserved_at',
    'stamp_code_received_at',
    'stamp_taker_charged_at',
    'stamp_maker_confirmed_at',
  };

  /// Post-commit effects the registry handles (side effects + best-effort
  /// no-ops). Used (with [_preCommitEffects]) to validate the yaml at startup.
  static const Set<String> _postCommitEffects = {
    'settle_hold_invoice',
    'cancel_hold_invoice',
    'start_payout',
    'reveal_code_to_taker',
    'send_offer_notifications',
    'send_twint_code_to_taker',
    'notify_maker_of_charge',
    'request_taker_invoice',
  };

  static const Set<String> _validNip69 = {
    'pending',
    'in-progress',
    'success',
    'canceled',
    'dispute',
  };

  FlowEngine get _engine => _c._flowEngine!;

  @override
  bool handlesRpc(String method) => _offerActionRpcs.contains(method);

  /// Deep startup validation of the loaded flow (beyond [FlowDefinition.parse]'s
  /// structural checks). Throws [StateError] listing every problem found.
  @override
  void validateDefinition() {
    final def = _engine.definition;
    final known = {..._preCommitEffects, ..._postCommitEffects};
    final problems = <String>[];

    for (final s in def.states.values) {
      if (s.nip69 != null && !_validNip69.contains(s.nip69)) {
        problems.add('state "${s.name}": invalid nip69 "${s.nip69}" '
            '(expected one of $_validNip69)');
      }
      for (final e in s.onEntryEffects) {
        if (!known.contains(e)) {
          problems.add('state "${s.name}" on_entry: unknown effect "$e"');
        }
      }
      for (final t in s.transitions) {
        final label = '${s.name} -[${t.event ?? t.trigger.name}]-> ${t.target}';
        // `auto` transitions are documentation of the payout chain; the executor
        // drives them via the payout driver, not the effect registry, so their
        // effects/action are not validated against it.
        if (t.trigger != FlowTriggerType.auto) {
          for (final e in t.effects) {
            if (!known.contains(e)) {
              problems.add('$label: unknown effect "$e"');
            }
          }
        }
        if (t.trigger == FlowTriggerType.timeout && t.durationSeconds == null) {
          problems.add('$label: timeout transition has no duration_seconds');
        }
      }
    }

    // Payout auto-wiring: the start_payout state must chain
    // settle -> paying -> {payment_success, payment_failed} via auto edges.
    FlowState? payoutState;
    for (final s in def.states.values) {
      if (s.onEntryEffects.contains('start_payout')) {
        payoutState = s;
        break;
      }
    }
    if (payoutState != null) {
      final settle = _autoTarget(payoutState.name);
      if (settle == null) {
        problems.add('start_payout state "${payoutState.name}" has no auto '
            'transition to a settle state');
      } else {
        final paying = _autoTarget(settle);
        if (paying == null) {
          problems.add('settle state "$settle" has no auto transition to a '
              'paying state');
        } else {
          if (_autoTargetByEvent(paying, 'payment_success') == null) {
            problems.add('paying state "$paying" missing auto '
                'payment_success target');
          }
          if (_autoTargetByEvent(paying, 'payment_failed') == null) {
            problems.add('paying state "$paying" missing auto '
                'payment_failed target');
          }
        }
      }
    }

    if (problems.isNotEmpty) {
      throw StateError('Generic flow "${def.id}" is invalid:\n - '
          '${problems.join('\n - ')}');
    }
  }

  // ─── RPC entry ────────────────────────────────────────────────────────

  @override
  Future<Map<String, dynamic>> handleRpc(
      String method, Map<String, dynamic> params, String userPubkey,
      {String? clientVersion}) async {
    final offerId = params['offer_id'] as String?;
    if (offerId == null) throw Exception('Missing required parameter: offer_id');
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer == null) throw Exception('Offer not found');

    final t = _engine.transitionFor(offer.statusRaw, method);
    if (t == null) {
      // get_blik may be a data-only re-fetch from the code-sent state.
      if (method == kRpcGetBlik) return _getBlikRefetch(offer, userPubkey);
      throw Exception('Action $method not allowed from "${offer.statusRaw}".');
    }

    // Identity: yaml actor role + pubkey ownership.
    final isNewTaker = offer.takerPubkey == null;
    if (!_identityOk(offer, userPubkey, t.actor, isNewTaker)) {
      throw Exception('Actor not permitted for $method on offer $offerId');
    }
    if (t.actor == FlowActor.taker &&
        isNewTaker &&
        userPubkey == offer.makerPubkey) {
      throw Exception('Maker cannot take their own offer');
    }

    // get_blik returns the code; guard its availability before advancing.
    if (method == kRpcGetBlik && offer.blikCode == null) {
      throw Exception('No code available for offer $offerId');
    }

    final ok = await _applyTransition(offer, t, params,
        trigger: 'user_action',
        actorName: t.actor?.name,
        actorPubkey: userPubkey,
        clientVersion: clientVersion);
    if (!ok) {
      throw Exception('Failed to apply $method (offer state changed).');
    }

    final updated = await _c._dbService.getOfferById(offerId);
    if (updated == null) return {'message': 'ok', 'status': t.target};

    // Transitions that return data (e.g. get_blik -> blik_code) answer with that
    // field instead of the full offer json.
    if (t.returns != null) {
      return {t.returns!: _returnableField(updated, t.returns!)};
    }

    final json = updated.toRpcJson();
    // toRpcJson serializes the enum status (unknown for generic-only states);
    // broadcast the raw state instead, matching _publishStatusUpdate.
    json['status'] = updated.statusRaw;
    // Back-compat: legacy reserve returned reserved_at as epoch ms (int); old
    // clients parse it as int. toRpcJson emits ISO; echo the int form too.
    if (updated.reservedAt != null) {
      json['reserved_at'] = updated.reservedAt!.toUtc().millisecondsSinceEpoch;
    }
    return json;
  }

  Object? _returnableField(Offer offer, String field) {
    switch (field) {
      case 'blik_code':
        return offer.blikCode;
      default:
        return null;
    }
  }

  /// Re-fetch of a returnable field from the state that already produced it
  /// (e.g. maker re-pulls the code after it was sent), with no state change.
  Future<Map<String, dynamic>> _getBlikRefetch(
      Offer offer, String userPubkey) async {
    if (offer.makerPubkey != userPubkey) {
      throw Exception('Maker mismatch for get_blik on offer ${offer.id}');
    }
    final code = offer.blikCode;
    if (code == null) throw Exception('No code available for offer ${offer.id}');
    final dst = _eventTargetState(kRpcGetBlik);
    if (dst == null || offer.statusRaw != dst) {
      throw Exception(
          'Offer ${offer.id} not in a state to provide the code (${offer.statusRaw}).');
    }
    return {'blik_code': code};
  }

  /// Destination state of the (single) transition whose event is [event], or
  /// null if no state declares it. Lets the executor reason about the "after"
  /// state without naming it.
  String? _eventTargetState(String event) {
    for (final s in _engine.definition.states.values) {
      for (final tr in s.transitions) {
        if (tr.event == event) return tr.target;
      }
    }
    return null;
  }

  bool _identityOk(
      Offer offer, String userPubkey, FlowActor? actor, bool isNewTaker) {
    switch (actor) {
      case FlowActor.maker:
        return userPubkey == offer.makerPubkey;
      case FlowActor.taker:
        return isNewTaker
            ? userPubkey != offer.makerPubkey
            : userPubkey == offer.takerPubkey;
      case FlowActor.coordinator:
      case FlowActor.server:
      case null:
        return true;
    }
  }

  // ─── transition application (shared by user-action + timeout + advance) ──

  Future<bool> _applyTransition(
    Offer offer,
    FlowTransition t,
    Map<String, dynamic> params, {
    required String trigger,
    String? actorName,
    String actorPubkey = '',
    String? clientVersion,
  }) async {
    final ctx = FlowEffectContext(
      offer: offer,
      transition: t,
      params: params,
      userPubkey: actorPubkey,
      isNewTaker: offer.takerPubkey == null,
      write: OfferWriteSpec(),
      now: _c._clock.now().toUtc(),
    );

    for (final e in t.effects) {
      if (_preCommitEffects.contains(e)) await _runEffect(e, ctx);
    }

    final w = ctx.write;
    // Audit context relevant to this transition (values changed by its effects,
    // plus the code for get_blik which serves it without changing it).
    final auditCtx = <String, dynamic>{
      'client': clientVersion,
      'blik_code':
          w.code ?? (t.returns == 'blik_code' ? offer.blikCode : null),
      'taker_invoice': w.takerInvoice,
      'taker_lightning_address': w.takerLightningAddress,
    };
    final applied = await _c._dbService.updateOfferRawStatusIfCurrent(
      offer.id,
      t.target,
      expectedCurrentStatuses: [offer.statusRaw],
      expectedTakerPubkey: w.expectedTakerPubkey,
      takerPubkey: w.takerPubkey,
      reservedAt: w.reservedAt,
      takerChargedAt: w.takerChargedAt,
      makerConfirmedAt: w.makerConfirmedAt,
      settledAt: w.settledAt,
      code: w.code,
      codeReceivedAt: w.codeReceivedAt,
      takerInvoice: w.takerInvoice,
      takerLightningAddress: w.takerLightningAddress,
      clearTakerFields: w.clearTakerFields,
      transitionMeta: StateTransitionMeta(
        trigger: trigger,
        event: t.event,
        actor: actorName,
        actorPubkey: actorPubkey.isEmpty ? null : actorPubkey,
        extra: _meta(t, t.target, auditCtx),
      ),
    );
    if (!applied) return false;

    _cancelTimer(offer.id);
    final updated = await _c._dbService.getOfferById(offer.id);
    if (updated != null) await _enterState(updated, t);
    return true;
  }

  /// Post-commit: run the transition's post effects + the new state's on_entry
  /// effects (deduped), then publish/broadcast and arm the timer — unless an
  /// effect took over (start_payout).
  Future<void> _enterState(Offer offer, FlowTransition? t) async {
    final state = _engine.definition.state(offer.statusRaw);
    final effects = <String>{
      if (t != null)
        for (final e in t.effects)
          if (!_preCommitEffects.contains(e)) e,
      ...?state?.onEntryEffects,
    };

    final ctx = FlowEffectContext(
      offer: offer,
      transition: t,
      params: const {},
      userPubkey: '',
      isNewTaker: offer.takerPubkey == null,
      write: OfferWriteSpec(),
      now: _c._clock.now().toUtc(),
    );
    for (final e in effects) {
      await _runEffect(e, ctx);
      if (ctx.stop) return; // start_payout handled publish + handoff
    }

    await _c._publishStatusUpdate(offer);
    await _c._nostrService?.broadcastNip69OrderFromOffer(offer);

    if (state?.terminal ?? false) return;
    _armTimer(offer);
  }

  /// Metadata recorded in offer_state_history: the transition's effects + the
  /// destination state's on_entry effects, plus any audit [ctx] (null entries
  /// dropped). [ctx] carries event-relevant context — blik code, taker invoice,
  /// amounts, fees, payment preimage, failure reason, etc.
  Map<String, dynamic>? _meta(FlowTransition? t, String targetState,
      [Map<String, dynamic>? ctx]) {
    final m = <String, dynamic>{};
    final eff = t?.effects ?? const [];
    if (eff.isNotEmpty) m['effects'] = eff;
    final onEntry = _engine.definition.state(targetState)?.onEntryEffects;
    if (onEntry != null && onEntry.isNotEmpty) m['on_entry'] = onEntry;
    ctx?.forEach((k, v) {
      if (v != null) m[k] = v;
    });
    return m.isEmpty ? null : m;
  }

  // ─── effect registry ────────────────────────────────────────────────────

  Future<void> _runEffect(String name, FlowEffectContext ctx) async {
    final offer = ctx.offer;
    final w = ctx.write;
    switch (name) {
      // ── pre-commit (shape the write) ──
      case 'assign_taker':
        if (ctx.isNewTaker) {
          w.takerPubkey = ctx.userPubkey;
        } else {
          w.expectedTakerPubkey = offer.takerPubkey;
        }
        break;
      case 'clear_taker_fields':
        w.clearTakerFields = true;
        break;
      case 'stamp_reserved_at':
        w.reservedAt = ctx.now.add(const Duration(seconds: 1));
        break;
      case 'stamp_code_received_at':
        w.codeReceivedAt = ctx.now;
        break;
      case 'stamp_taker_charged_at':
        w.takerChargedAt = ctx.now;
        break;
      case 'stamp_maker_confirmed_at':
        w.makerConfirmedAt = ctx.now;
        break;
      case 'validate_code':
        {
          final provided = _c._paymentSystem.makerProvidesCodeAtOfferCreation
              ? offer.blikCode
              : _clean(ctx.params['blik_code']);
          if (provided == null || !_c._paymentSystem.isValidCode(provided)) {
            throw Exception('Invalid ${_c._paymentSystem.codeLabel} code.');
          }
          w.code = provided;
        }
        break;
      case 'resolve_taker_invoice':
        {
          final lnAddr = _clean(ctx.params['taker_lightning_address']);
          var inv = _clean(ctx.params['taker_invoice']);
          if (inv == null) {
            if (lnAddr == null) {
              throw Exception(
                  'Missing taker invoice and lightning address for submit.');
            }
            inv = await _c._resolveLnurlPay(
                lnAddr, _c._expectedTakerNetAmountSats(offer));
            if (inv == null || inv.isEmpty) {
              throw Exception('Could not resolve a taker invoice from $lnAddr.');
            }
          } else {
            _c._validateTakerInvoiceAmount(offer, inv, action: 'submit_blik');
          }
          w.takerInvoice = inv;
          w.takerLightningAddress = lnAddr;
        }
        break;
      case 'accept_taker_invoice':
        w.takerInvoice = _clean(ctx.params['taker_invoice']);
        w.takerLightningAddress = _clean(ctx.params['taker_lightning_address']);
        break;

      // ── post-commit (side effects) ──
      case 'settle_hold_invoice':
        if (_c._paymentBackend != null && offer.holdInvoicePreimage != null) {
          try {
            await _c._paymentBackend!
                .settleInvoice(preimageHex: offer.holdInvoicePreimage!);
          } catch (e) {
            AppLogger.warning(
                'Generic settle_hold_invoice failed for ${offer.id}: $e',
                offerId: offer.id);
          }
        }
        break;
      case 'cancel_hold_invoice':
        if (_c._paymentBackend != null &&
            offer.holdInvoicePaymentHash != null) {
          try {
            await _c._paymentBackend!
                .cancelInvoice(paymentHashHex: offer.holdInvoicePaymentHash!);
          } catch (e) {
            AppLogger.warning(
                'Generic cancel_hold_invoice failed for ${offer.id}: $e',
                offerId: offer.id);
          }
        }
        break;
      case 'start_payout':
        await _startPayout(offer);
        ctx.stop = true;
        break;

      // Best-effort / informational no-ops; clients poll get_offer_details.
      case 'reveal_code_to_taker':
      case 'send_offer_notifications':
      case 'send_twint_code_to_taker':
      case 'notify_maker_of_charge':
      case 'request_taker_invoice':
        break;
      default:
        AppLogger.warning('Generic flow: unknown effect "$name".');
    }
  }

  String? _clean(Object? v) {
    final s = (v as String?)?.trim();
    return (s == null || s.isEmpty) ? null : s;
  }

  /// Settle + hand off to the shared Lightning payout tail. Advances to the
  /// `auto` target of the current state (the settle state), read from the flow.
  Future<void> _startPayout(Offer offer) async {
    if (_c._paymentBackend != null && offer.holdInvoicePreimage != null) {
      try {
        await _c._paymentBackend!
            .settleInvoice(preimageHex: offer.holdInvoicePreimage!);
      } catch (e) {
        AppLogger.warning('Generic payout settle failed for ${offer.id}: $e',
            offerId: offer.id);
        return;
      }
    }
    final settleTarget = _autoTarget(offer.statusRaw);
    if (settleTarget == null) return;
    await _c._publishStatusUpdate(offer); // current (maker-confirmed) state
    final ok = await _c._dbService.updateOfferRawStatusIfCurrent(
      offer.id,
      settleTarget,
      expectedCurrentStatuses: [offer.statusRaw],
      settledAt: _c._clock.now().toUtc(),
      transitionMeta: StateTransitionMeta(
        trigger: 'auto',
        event: 'start_payout',
        actor: 'coordinator',
        extra: _meta(null, settleTarget, {
          'amount_sats': offer.amountSats,
          'taker_fees': _c._effectiveTakerFeeSats(offer),
        }),
      ),
    );
    if (!ok) return;
    final settled = await _c._dbService.getOfferById(offer.id);
    if (settled != null) await _c._publishStatusUpdate(settled);
    // Generic, yaml-driven payout tail (settled -> payingTaker -> takerPaid /
    // takerPaymentFailed). Reuses the shared payment primitive; legacy keeps its
    // own _payTakerAsync untouched.
    Future.microtask(() => _runPayout(offer.id));
  }

  /// settled -> payingTaker -> takerPaid | takerPaymentFailed, with all target
  /// state names read from the flow's `auto` transitions (no OfferStatus).
  Future<void> _runPayout(String offerId) async {
    try {
      final offer = await _c._dbService.getOfferById(offerId);
      if (offer == null) return;
      final settledState = offer.statusRaw;
      final payingTarget = _autoTarget(settledState);
      if (payingTarget == null) return;
      final setupFailTarget =
          _autoTargetByEvent(settledState, 'payout_setup_failed');
      final paidTarget = _autoTargetByEvent(payingTarget, 'payment_success');
      final payFailTarget = _autoTargetByEvent(payingTarget, 'payment_failed');

      final takerFees = _c._effectiveTakerFeeSats(offer);
      final netAmountSats = offer.amountSats - takerFees;

      // Ensure a taker invoice (resolve from LN address if needed).
      var invoice = offer.takerInvoice;
      if (invoice == null || invoice.isEmpty) {
        final lnAddr = offer.takerLightningAddress;
        if (lnAddr == null || lnAddr.isEmpty) {
          await _failPayout(offer.id, setupFailTarget, settledState,
              'Missing both taker invoice and Lightning Address');
          return;
        }
        invoice = await _c._resolveLnurlPay(lnAddr, netAmountSats);
        if (invoice == null || invoice.isEmpty) {
          await _failPayout(offer.id, setupFailTarget, settledState,
              'Failed to get invoice from lightning address (LNURL resolution failed)');
          return;
        }
        await _c._dbService.updateTakerInvoice(offer.id, invoice);
      }
      _c._validateTakerInvoiceAmount(offer, invoice, action: 'pay_taker');

      // settled -> payingTaker
      final moved = await _c._dbService.updateOfferRawStatusIfCurrent(
        offer.id,
        payingTarget,
        expectedCurrentStatuses: [settledState],
        transitionMeta: StateTransitionMeta(
          trigger: 'auto',
          event: 'send_payment',
          actor: 'coordinator',
          extra: _meta(null, payingTarget, {
            'net_amount_sats': netAmountSats,
            'taker_fees': takerFees,
            'taker_invoice': invoice,
          }),
        ),
      );
      if (!moved) return;
      final paying = await _c._dbService.getOfferById(offer.id);
      if (paying != null) await _c._publishStatusUpdate(paying);

      final feeLimitSat = (offer.takerFees! * kTakerFeeLimitFactor).ceil();
      final res =
          await _c._attemptTakerPayment(invoice, netAmountSats, feeLimitSat);

      if (res.ok) {
        if (paidTarget == null) return;
        await _markPaid(offer.id, payingTarget, paidTarget, takerFees,
            res.result?.feeSat ?? 0,
            preimage: res.result?.paymentPreimage);
      } else {
        await _failPayout(offer.id, payFailTarget, payingTarget,
            res.error ?? 'Payment failed');
      }
    } catch (e, st) {
      AppLogger.warning('Generic payout failed for offer $offerId: $e',
          offerId: offerId, error: e, stackTrace: st);
    }
  }

  /// Finalize a successful taker payment: [fromState] -> [paidState], record
  /// fees, publish/broadcast, clean up. Shared by the live payout and the
  /// startup reconciliation.
  Future<void> _markPaid(String offerId, String fromState, String paidState,
      int takerFees, int feeSat,
      {String? preimage}) async {
    await _c._dbService.updateOfferRawStatusIfCurrent(
      offerId,
      paidState,
      expectedCurrentStatuses: [fromState],
      takerFees: takerFees,
      transitionMeta: StateTransitionMeta(
        trigger: 'auto',
        event: 'payment_success',
        actor: 'coordinator',
        extra: _meta(null, paidState, {
          'taker_fees': takerFees,
          'fee_sats': feeSat,
          'preimage': preimage,
        }),
      ),
    );
    await _c._dbService.updateTakerInvoiceFees(offerId, feeSat);
    final paid = await _c._dbService.getOfferById(offerId);
    if (paid != null) {
      await _c._publishStatusUpdate(paid);
      await _c._nostrService?.broadcastNip69OrderFromOffer(paid);
    }
    await _c._deleteTelegramOfferMessages(offerId);
  }

  Future<void> _failPayout(
      String offerId, String? target, String fromState, String reason) async {
    if (target == null) return;
    await _c._dbService.updateOfferRawStatusIfCurrent(
      offerId,
      target,
      expectedCurrentStatuses: [fromState],
      failureReason: reason,
      transitionMeta: StateTransitionMeta(
        trigger: 'auto',
        event: 'payment_failed',
        actor: 'coordinator',
        extra: _meta(null, target, {'failure_reason': reason}),
      ),
    );
    final failed = await _c._dbService.getOfferById(offerId);
    if (failed != null) await _c._publishStatusUpdate(failed);
  }

  /// Target of the FIRST `auto` transition leaving [state], if any.
  String? _autoTarget(String state) {
    final s = _engine.definition.state(state);
    if (s == null) return null;
    for (final t in s.transitions) {
      if (t.trigger == FlowTriggerType.auto) return t.target;
    }
    return null;
  }

  /// Target of the `auto` transition leaving [state] tagged with [event].
  String? _autoTargetByEvent(String state, String event) {
    final s = _engine.definition.state(state);
    if (s == null) return null;
    for (final t in s.transitions) {
      if (t.trigger == FlowTriggerType.auto && t.event == event) return t.target;
    }
    return null;
  }

  // ─── timers ─────────────────────────────────────────────────────────────

  void _armTimer(Offer offer) {
    final t = _engine.timeoutFor(offer.statusRaw);
    if (t == null || t.durationSeconds == null) return;
    _cancelTimer(offer.id);
    final DateTime base;
    switch (t.fromField) {
      case 'code_received_at':
        base = (offer.blikReceivedAt ?? offer.updatedAt ?? offer.createdAt)
            .toUtc();
        break;
      case 'created_at':
        // Total offer lifetime: not reset by reserve/revert (updated_at bumps).
        base = offer.createdAt.toUtc();
        break;
      default:
        base = (offer.updatedAt ?? offer.createdAt).toUtc();
    }
    final fireAt = base.add(Duration(seconds: t.durationSeconds!));
    final remaining = fireAt.difference(_c._clock.now().toUtc());
    final dur = remaining.isNegative ? Duration.zero : remaining;
    final expectedState = offer.statusRaw;
    _stateTimers[offer.id] = Timer(dur, () {
      _stateTimers.remove(offer.id);
      _fireTimeout(offer.id, expectedState, t);
    });
  }

  void _cancelTimer(String offerId) {
    _stateTimers[offerId]?.cancel();
    _stateTimers.remove(offerId);
  }

  Future<void> _fireTimeout(
      String offerId, String expectedState, FlowTransition t) async {
    // Runs from a Timer callback: an unhandled error would crash the
    // coordinator. Swallow + retry on a fixed backoff.
    try {
      final offer = await _c._dbService.getOfferById(offerId);
      if (offer == null || offer.statusRaw != expectedState) return;
      await _applyTransition(offer, t, const {},
          trigger: 'timeout', actorName: 'coordinator');
    } catch (e, st) {
      AppLogger.warning('Generic timeout firing failed for offer $offerId: $e',
          offerId: offerId, error: e, stackTrace: st);
      _cancelTimer(offerId);
      _stateTimers[offerId] = Timer(_timeoutRetryBackoff, () {
        _stateTimers.remove(offerId);
        _fireTimeout(offerId, expectedState, t);
      });
    }
  }

  // ─── lifecycle hooks ──────────────────────────────────────────────────────

  @override
  void onOfferFunded(Offer offer) {
    if (!_c.isGenericFlow) return;
    // Genesis row: the offer is INSERTed already funded, so no status-update
    // fires — seed the history explicitly.
    _c._dbService.recordOfferTransition(
      offerId: offer.id,
      fromState: null,
      toState: offer.statusRaw,
      meta: StateTransitionMeta(
        // The maker created the offer and paid the hold invoice; funded is their
        // action, not a coordinator-internal one.
        trigger: 'user_action',
        event: 'create_offer',
        actor: FlowActor.maker.name,
        actorPubkey: offer.makerPubkey,
        extra: _meta(null, offer.statusRaw, {
          'client': offer.clientVersion,
          'amount_sats': offer.amountSats,
          'maker_fees': offer.makerFees,
          'fiat_amount': offer.fiatAmount,
          'fiat_currency': offer.fiatCurrency,
          'premium_percent': offer.premiumPercent,
          // Present for maker-provides-code flows (e.g. TWINT); null for BLIK.
          'blik_code': offer.blikCode,
        }),
      ),
    );
    _armTimer(offer);
  }

  @override
  Future<void> recoverTimers() async {
    if (!_c.isGenericFlow) return;
    final terminal = <String>{
      for (final s in _engine.definition.states.values)
        if (s.terminal) s.name,
    };
    final offers =
        await _c._dbService.getOffersNotInRawStatuses(terminal.toList());
    var armed = 0;
    for (final o in offers) {
      // Only states with a timeout edge get a timer; payout-tail / handoff
      // states have none, so they are skipped without naming them.
      if (_engine.timeoutFor(o.statusRaw) != null) {
        _armTimer(o);
        armed++;
      }
    }
    AppLogger.info(
        'FLOW ENGINE: generic startup recovery armed $armed timer(s) across '
        '${offers.length} live offer(s).');

    await _recoverFailedPayouts();
  }

  /// Startup reconciliation: a payout may have actually SETTLED on the wallet
  /// even though it was recorded as failed (the NWC pay_invoice request is not
  /// idempotent — a timeout/transport error or a crash right after the wallet
  /// settled leaves the offer stuck in the payment-failed state). Re-check the
  /// wallet for every offer in that state and finalize the ones that paid.
  Future<void> _recoverFailedPayouts() async {
    final failedState = _eventTargetState('payment_failed');
    final paidState = _eventTargetState('payment_success');
    if (failedState == null || paidState == null) return;
    final offers = await _c._dbService.getOffersByRawStatus(failedState);
    var reconciled = 0;
    for (final o in offers) {
      final invoice = o.takerInvoice;
      if (invoice == null || invoice.isEmpty) continue;
      PayInvoiceResult? rec;
      try {
        rec = await _c._paymentBackend?.reconcileOutgoingPayment(
            invoice: invoice);
      } catch (e) {
        AppLogger.warning(
            'Generic startup payout reconcile failed for offer ${o.id}: $e',
            offerId: o.id);
        continue;
      }
      if (rec != null && rec.isSuccess) {
        await _markPaid(o.id, failedState, paidState,
            _c._effectiveTakerFeeSats(o), rec.feeSat ?? 0);
        reconciled++;
        AppLogger.info(
            'FLOW ENGINE: offer ${o.id} reconciled to paid on startup '
            '(wallet had settled the taker payment).',
            offerId: o.id);
      }
    }
    if (reconciled > 0) {
      AppLogger.info(
          'FLOW ENGINE: reconciled $reconciled stale $failedState offer(s) to '
          'paid on startup.');
    }
  }
}
