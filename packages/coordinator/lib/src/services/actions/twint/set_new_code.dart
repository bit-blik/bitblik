part of '../../coordinator_service.dart';

/// TWINT: the maker supplies a fresh code from the params (e.g.
/// enter_new_twint re-lists an expired offer). Unlike validate_code this
/// always reads the param, even for maker-provides-code flows where the offer
/// still holds the OLD code.
class SetNewCodeAction extends FlowAction {
  @override
  String get name => 'set_new_code';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final instrument = flow._c._instrumentForCategory(ctx.offer.category);
    final bank = instrument.bankById(ctx.offer.bankId);
    final provided = _cleanParam(ctx.params['blik_code']);
    if (provided == null || !instrument.validate(provided, bank: bank)) {
      throw Exception('Invalid ${instrument.codeLabel} code.');
    }
    ctx.write.code = provided;
  }
}
