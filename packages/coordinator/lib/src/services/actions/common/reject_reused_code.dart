part of '../../coordinator_service.dart';

/// Rejects a submitted code that was already used earlier on this offer.
///
/// Guards the SK ATM loop the maker's "mark invalid" verdict opens up:
/// `reserved -[submit_blik]-> blikReceived -[get_blik]-> blikSentToMaker
/// -[mark_blik_invalid]-> invalidBlik -[reserve_offer]-> reserved`, which the
/// taker may repeat unboundedly (bounded separately by
/// [LimitCodeAttemptsAction]). Production history shows the exact same
/// 6-digit code resubmitted on the second loop (offers 0f4947d6, 44ad1390) —
/// `validate_code` only checks the digit shape, not reuse.
class RejectReusedCodeAction extends FlowAction {
  @override
  String get name => 'reject_reused_code';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final instrument = flow._c._instrumentForCategory(ctx.offer.category);
    // Only meaningful where the taker submits a fresh code each attempt. In a
    // maker-provides-code flow the submitted code IS the one already stored on
    // the offer, so every submit would look like a reuse of itself.
    if (instrument.makerProvidesCode) return;
    final provided = _cleanParam(ctx.params['blik_code']);
    if (provided == null) return;

    final used = <String>{
      if (ctx.offer.blikCode != null) ctx.offer.blikCode!,
    };
    final history = await flow._c._dbService.getOfferStateHistory(ctx.offer.id);
    for (final row in history) {
      if (row['event'] != 'submit_blik') continue;
      final metadata = row['metadata'];
      if (metadata is Map) {
        final code = metadata['blik_code'];
        if (code is String) used.add(code);
      }
    }

    if (used.contains(provided)) {
      throw Exception('This withdrawal code was already used for this '
          'offer. Generate a new code in your banking app.');
    }
  }

  @override
  List<String> validate(
      FlowEngine engine, FlowState fromState, FlowTransition edge) {
    if (edge.actor != FlowActor.taker) {
      return [
        '${fromState.name} -[${edge.event ?? edge.trigger.name}]-> '
            '${edge.target}: reject_reused_code must only run on a taker '
            'transition'
      ];
    }
    return const [];
  }
}
