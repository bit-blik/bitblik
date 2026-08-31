part of '../../coordinator_service.dart';

/// Caps how many times a taker may re-reserve an offer out of `invalidBlik`.
///
/// Without a cap the maker's "mark invalid" verdict lets the taker loop
/// `reserve_offer` -> `submit_blik` indefinitely (production: 4
/// `mark_blik_invalid` cycles on a single offer, one of them a resubmitted
/// duplicate code — see [RejectReusedCodeAction] for that half of the fix).
class LimitCodeAttemptsAction extends FlowAction {
  @override
  String get name => 'limit_code_attempts';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final history = await flow._c._dbService.getOfferStateHistory(ctx.offer.id);
    final invalidCount =
        history.where((row) => row['event'] == 'mark_blik_invalid').length;
    if (invalidCount >= kMaxInvalidCodeAttempts) {
      throw Exception('Too many invalid codes for this offer '
          '($kMaxInvalidCodeAttempts). Cancel the reservation and pick '
          'another offer.');
    }
  }

  @override
  List<String> validate(
      FlowEngine engine, FlowState fromState, FlowTransition edge) {
    if (edge.actor != FlowActor.taker) {
      return [
        '${fromState.name} -[${edge.event ?? edge.trigger.name}]-> '
            '${edge.target}: limit_code_attempts must only run on a taker '
            'transition'
      ];
    }
    return const [];
  }
}
