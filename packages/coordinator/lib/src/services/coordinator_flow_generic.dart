part of 'coordinator_service.dart';

/// Mutable accumulator for the atomic status-update write. Pre-commit actions
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
  DateTime? takerPaidAt;
  String? code;
  String? takerInvoice;
  String? takerLightningAddress;
  int? takerFees;

  /// Lightning routing fee (sats) charged when paying the taker's invoice —
  /// persisted to `taker_invoice_fees`.
  int? takerInvoiceFees;
  String? failureReason;
  bool clearTakerFields = false;
  bool preserveCodeOnClear = false;
  final Map<String, dynamic> audit = {};
}

/// Definitive transition failure: the attempt itself completed and determined
/// it cannot reach its normal target. The executor routes to `on_fail` when the
/// transition declares one; otherwise the offer remains in its current state.
class FlowTransitionFailure implements Exception {
  final String reason;
  final Map<String, dynamic>? auditExtra;

  const FlowTransitionFailure(this.reason, {this.auditExtra});
}

/// One yaml action keyword (`do:` entry), implemented as a self-describing
/// class: it declares its own [name] (== the yaml keyword == its filename under
/// `services/actions/`). Instances are listed once in `actions/all_actions.dart`
/// (the compile-time anchor — Dart AOT has no reflection to discover
/// subclasses); everything else derives from that list, and flow validation
/// exits the coordinator when a yml references an action with no
/// implementation.
abstract class FlowAction {
  /// The yml keyword this action implements.
  String get name;

  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx);

  /// Optional startup wiring checks for each yml occurrence of this action
  /// (`do:` on [edge]). Returned problems abort coordinator startup.
  List<String> validate(
          FlowEngine engine, FlowState fromState, FlowTransition edge) =>
      const [];
}

/// Registry built from [allFlowActions]; throws on duplicate names.
final Map<String, FlowAction> _flowActionRegistry = () {
  final m = <String, FlowAction>{};
  for (final a in allFlowActions) {
    if (m.containsKey(a.name)) {
      throw StateError('Duplicate flow action registered: "${a.name}".');
    }
    m[a.name] = a;
  }
  return m;
}();

String? _cleanParam(Object? v) {
  final s = (v as String?)?.trim();
  return (s == null || s.isEmpty) ? null : s;
}

/// Context handed to each action. `offer` is the pre-write snapshot; `write`
/// is shared across all actions of one transition attempt.
class FlowEffectContext {
  final Offer offer;
  final FlowTransition? transition;
  final Map<String, dynamic> params;
  final String userPubkey;
  final bool isNewTaker;
  final OfferWriteSpec write;
  final DateTime now;

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
/// state-specific behaviour comes from the flow definition (transition `do:`
/// action keywords, resolved against [_flowActionRegistry]) — no `OfferStatus`
/// constants.
///
/// `part of` the coordinator library so it reaches shared services via `_c`.
class GenericOfferFlow implements OfferFlow {
  final CoordinatorService _c;
  GenericOfferFlow(this._c);

  final Map<String, Timer> _stateTimers = {};
  static const Duration _timeoutRetryBackoff = Duration(seconds: 30);

  static const Set<String> _validNip69 = {
    'pending',
    'in-progress',
    'success',
    'canceled',
    'dispute',
  };

  FlowEngine get _engine => _c._flowEngine!;

  /// Events (== RPC method names) the loaded flow declares as user actions.
  /// Derived from the flow so ANY flow's events (e.g. TWINT's
  /// `mark_twint_charged`, `start_dispute`, `enter_new_twint`) route to this
  /// controller without a hardcoded per-flow list.
  late final Set<String> _handledEvents = {
    for (final s in _engine.definition.states.values)
      for (final t in s.transitions)
        if (t.trigger == FlowTriggerType.userAction && t.event != null)
          t.event!,
  };

  @override
  bool handlesRpc(String method) => _handledEvents.contains(method);

  /// Deep startup validation of the loaded flow (beyond [FlowDefinition.parse]'s
  /// structural checks). Throws [StateError] listing every problem found.
  @override
  void validateDefinition() {
    final def = _engine.definition;
    final problems = <String>[];

    // Every yaml action must have a registered [FlowAction] implementation;
    // each action may also contribute its own wiring checks. A missing
    // implementation aborts coordinator startup.
    void checkActions(String label, Iterable<String> names, FlowState state,
        FlowTransition edge) {
      for (final a in names) {
        final impl = _flowActionRegistry[a];
        if (impl == null) {
          problems.add('$label: unknown action "$a"');
        } else {
          problems.addAll(impl.validate(_engine, state, edge));
        }
      }
    }

    for (final s in def.states.values) {
      if (s.nip69 != null && !_validNip69.contains(s.nip69)) {
        problems.add('state "${s.name}": invalid nip69 "${s.nip69}" '
            '(expected one of $_validNip69)');
      }
      final autoCount =
          s.transitions.where((t) => t.trigger == FlowTriggerType.auto).length;
      if (autoCount > 1) {
        problems.add(
            'state "${s.name}": schema v2 allows at most one auto transition');
      }
      for (final t in s.transitions) {
        final label = '${s.name} -[${t.event ?? t.trigger.name}]-> ${t.target}';
        checkActions(label, t.actions, s, t);
        if (t.trigger == FlowTriggerType.timeout &&
            t.durationSeconds == null &&
            t.durationParam == null) {
          problems.add('$label: timeout transition has no after');
        }
        if (t.durationParam != null &&
            !CoordinatorService._knownFlowDurationParams
                .contains(t.durationParam)) {
          problems.add('$label: unknown timeout parameter '
              '"\$${t.durationParam}" (known: '
              '${CoordinatorService._knownFlowDurationParams.join(', ')})');
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
    if (offerId == null)
      throw Exception('Missing required parameter: offer_id');
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

    // Taker-facing responses omit maker-private fields (maker pubkey, hold
    // invoice, maker fees) — takers must not be able to harvest maker
    // identities by reserving offers. The code itself goes to the ASSIGNED
    // taker in maker-provides-code flows (TWINT): reserving entitles them to
    // it (it's what they must pay), same gate as get_offer_details.
    final revealCodeToTaker = t.actor == FlowActor.taker &&
        _c._instrumentForCategory(updated.category).makerProvidesCode &&
        updated.takerPubkey == userPubkey;
    final json = updated.toRpcJson(
      includeBlikCode: revealCodeToTaker,
      forTaker: t.actor == FlowActor.taker,
    );
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
    if (code == null)
      throw Exception('No code available for offer ${offer.id}');
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
        // Coordinator-actor RPCs (e.g. dispute resolutions) must be signed by
        // the coordinator's own key — otherwise any client could fire them.
        final coordinatorPubkey = _c._nostrService?.coordinatorPubkey;
        return coordinatorPubkey != null && userPubkey == coordinatorPubkey;
      case FlowActor.server:
      case null:
        return true;
    }
  }

  // ─── transition application (shared by user-action + timeout + auto) ─────

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

    var targetState = t.target;
    try {
      for (final a in t.actions) {
        await _runAction(a, ctx);
      }
    } on FlowTransitionFailure catch (e) {
      if (t.onFailTarget == null) rethrow;
      targetState = t.onFailTarget!;
      ctx.write.failureReason ??= e.reason;
      if (e.auditExtra != null) {
        ctx.write.audit.addAll(e.auditExtra!);
      }
    }

    final w = ctx.write;
    // Audit context relevant to this transition (values changed by its effects,
    // plus the code for get_blik which serves it without changing it).
    final auditCtx = <String, dynamic>{
      'client': clientVersion,
      'blik_code': w.code ?? (t.returns == 'blik_code' ? offer.blikCode : null),
      'taker_invoice': w.takerInvoice,
      'taker_lightning_address': w.takerLightningAddress,
      'taker_fees': w.takerFees,
      'maker_invoice': _cleanParam(params['maker_invoice']),
      'failure_reason': w.failureReason,
      ...w.audit,
    };
    final applied = await _c._dbService.updateOfferRawStatusIfCurrent(
      offer.id,
      targetState,
      expectedCurrentStatuses: [offer.statusRaw],
      expectedTakerPubkey: w.expectedTakerPubkey,
      takerPubkey: w.takerPubkey,
      reservedAt: w.reservedAt,
      takerChargedAt: w.takerChargedAt,
      makerConfirmedAt: w.makerConfirmedAt,
      settledAt: w.settledAt,
      takerPaidAt: w.takerPaidAt,
      code: w.code,
      codeReceivedAt: w.codeReceivedAt,
      takerInvoice: w.takerInvoice,
      takerLightningAddress: w.takerLightningAddress,
      takerFees: w.takerFees,
      takerInvoiceFees: w.takerInvoiceFees,
      failureReason: w.failureReason,
      clearTakerFields: w.clearTakerFields,
      preserveCodeOnClear: w.preserveCodeOnClear,
      transitionMeta: StateTransitionMeta(
        trigger: trigger,
        event: t.event,
        actor: actorName,
        actorPubkey: actorPubkey.isEmpty ? null : actorPubkey,
        extra: _meta(t, auditCtx),
      ),
    );
    if (!applied) return false;

    _cancelTimer(offer.id);
    final updated = await _c._dbService.getOfferById(offer.id);
    if (updated != null) await _enterState(updated);
    return true;
  }

  /// After a successful commit: publish/broadcast, arm the timer and drive any
  /// detached `auto` transition leaving the new state.
  Future<void> _enterState(Offer offer) async {
    final state = _engine.definition.state(offer.statusRaw);
    final isTerminal = state?.terminal ?? false;

    // Arm the entered state's timeout before slow side effects so a stale
    // earlier enterState() cannot later overwrite a newer state's timer.
    if (!isTerminal) {
      _armTimer(offer);
    }

    await _c._publishStatusUpdate(offer);
    await _c._nostrService?.broadcastNip69OrderFromOffer(offer);
    await _c._syncTelegramOfferMessagesForState(offer);
    await _runStateActions(offer);

    if (isTerminal) {
      // Offer will never transition or broadcast again — drop the NostrService
      // created_at-tracking entry so it can't accumulate across offer lifetime.
      _c._nostrService?.forgetOfferTracking(offer.id);
      return;
    }

    // Side effects above may take long enough for a newer transition to commit.
    // Only launch detached auto edges if this state is still current.
    final current = await _c._dbService.getOfferById(offer.id);
    if (current == null || current.statusRaw != offer.statusRaw) return;
    _driveAuto(current);
  }

  Future<void> _runStateActions(Offer offer) async {
    final state = _engine.definition.state(offer.statusRaw);
    if (state == null || state.actions.isEmpty) return;

    final ctx = FlowEffectContext(
      offer: offer,
      transition: null,
      params: const {},
      userPubkey: '',
      isNewTaker: offer.takerPubkey == null,
      write: OfferWriteSpec(),
      now: _c._clock.now().toUtc(),
    );
    for (final actionName in state.actions) {
      try {
        await _runAction(actionName, ctx);
      } catch (e, st) {
        AppLogger.warning(
            'Generic state action "$actionName" failed for offer ${offer.id} '
            'in state "${offer.statusRaw}": $e',
            offerId: offer.id,
            error: e,
            stackTrace: st);
      }
    }
  }

  /// Starts the state's detached `auto` transition, if present.
  void _driveAuto(Offer offer) {
    final state = _engine.definition.state(offer.statusRaw);
    if (state == null) return;
    for (final tr in state.transitions) {
      if (tr.trigger == FlowTriggerType.auto) {
        unawaited(_runDetachedAuto(offer.id, offer.statusRaw, tr));
        return;
      }
    }
  }

  Future<void> _runDetachedAuto(
      String offerId, String expectedState, FlowTransition t) async {
    final offer = await _c._dbService.getOfferById(offerId);
    if (offer == null || offer.statusRaw != expectedState) return;
    try {
      await _applyTransition(offer, t, const {},
          trigger: 'auto', actorName: 'coordinator');
    } catch (e, st) {
      AppLogger.warning(
          'Generic auto transition failed for offer $offerId '
          '(${offer.statusRaw} -> ${t.target}): $e',
          offerId: offerId,
          error: e,
          stackTrace: st);
    }
  }

  /// Metadata recorded in offer_state_history: transition `do:` actions plus
  /// any audit [ctx] (null entries dropped). [ctx] carries event-relevant
  /// context — blik code, invoices, fees, payment preimage, failure reason, etc.
  Map<String, dynamic>? _meta(FlowTransition? t, [Map<String, dynamic>? ctx]) {
    final m = <String, dynamic>{};
    final acts = t?.actions ?? const [];
    if (acts.isNotEmpty) m['do'] = acts;
    if (t?.onFailTarget != null) m['on_fail'] = t!.onFailTarget;
    ctx?.forEach((k, v) {
      if (v != null) m[k] = v;
    });
    return m.isEmpty ? null : m;
  }

  // ─── action registry ─────────────────────────────────────────────────────

  Future<void> _runAction(String name, FlowEffectContext ctx) async {
    final action = _flowActionRegistry[name];
    if (action == null) {
      AppLogger.warning('Generic flow: unknown action "$name".');
      return;
    }
    await action.run(this, ctx);
  }

  /// Finalize a reconciled successful taker payment from the payout-failed
  /// state into the send_payment transition's success target.
  Future<void> _markPaid(String offerId, String fromState,
      FlowTransition sendPayment, int takerFees, int feeSat,
      {String? preimage}) async {
    await _c._dbService.updateOfferRawStatusIfCurrent(
      offerId,
      sendPayment.target,
      expectedCurrentStatuses: [fromState],
      takerPaidAt: _c._clock.now().toUtc(),
      takerFees: takerFees,
      takerInvoiceFees: feeSat,
      transitionMeta: StateTransitionMeta(
        trigger: 'auto',
        actor: 'coordinator',
        extra: _meta(sendPayment, {
          'taker_fees': takerFees,
          'fee_sats': feeSat,
          'preimage': preimage,
        }),
      ),
    );
    final paid = await _c._dbService.getOfferById(offerId);
    if (paid != null) {
      await _c._publishStatusUpdate(paid);
      await _c._nostrService?.broadcastNip69OrderFromOffer(paid);
    }
    await _c._deleteTelegramOfferMessages(offerId);
  }

  ({String payingState, String failedState, FlowTransition transition})?
      _sendPaymentTail() {
    for (final s in _engine.definition.states.values) {
      for (final t in s.transitions) {
        if (t.actions.contains('send_payment') && t.onFailTarget != null) {
          return (
            payingState: s.name,
            failedState: t.onFailTarget!,
            transition: t,
          );
        }
      }
    }
    return null;
  }

  // ─── timers ─────────────────────────────────────────────────────────────

  void _armTimer(Offer offer) {
    final t = _engine.timeoutFor(offer.statusRaw);
    if (t == null) return;
    final durationSeconds = _c._resolveTimeoutSeconds(offer, t);
    if (durationSeconds == null) return;
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
    final fireAt = base.add(Duration(seconds: durationSeconds));
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
        extra: _meta(null, {
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
    unawaited(_runStateActions(offer));
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
      // Resume any auto chain interrupted by a crash (e.g. stuck in
      // makerConfirmed before the settle edge ran, or in payingTaker before
      // the detached send_payment attempt completed).
      _driveAuto(o);
    }
    AppLogger.info(
        'FLOW ENGINE: generic startup recovery armed $armed timer(s) across '
        '${offers.length} live offer(s).');

    await _recoverFailedPayouts();
  }

  @override
  Map<String, int> debugCounters() => {
        'state_timers': _stateTimers.length,
      };

  /// Startup reconciliation: a payout may have actually SETTLED on the wallet
  /// even though it was recorded as failed (the NWC pay_invoice request is not
  /// idempotent — a timeout/transport error or a crash right after the wallet
  /// settled leaves the offer stuck in the payment-failed state). Re-check the
  /// wallet for every offer in that state and finalize the ones that paid.
  Future<void> _recoverFailedPayouts() async {
    final tail = _sendPaymentTail();
    if (tail == null) return;
    final offers = await _c._dbService.getOffersByRawStatus(tail.failedState);
    var reconciled = 0;
    for (final o in offers) {
      final invoice = o.takerInvoice;
      if (invoice == null || invoice.isEmpty) continue;
      PayInvoiceResult? rec;
      try {
        rec = await _c._paymentBackend
            ?.reconcileOutgoingPayment(invoice: invoice);
      } catch (e) {
        AppLogger.warning(
            'Generic startup payout reconcile failed for offer ${o.id}: $e',
            offerId: o.id);
        continue;
      }
      if (rec != null && rec.isSuccess) {
        await _markPaid(o.id, tail.failedState, tail.transition,
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
          'FLOW ENGINE: reconciled $reconciled stale ${tail.failedState} offer(s) to '
          'paid on startup.');
    }
  }
}
