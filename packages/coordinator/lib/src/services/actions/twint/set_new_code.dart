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
    final ps = flow._c._paymentSystem;
    final provided = _cleanParam(ctx.params['blik_code']);
    if (provided == null || !ps.isValidCode(provided)) {
      throw Exception('Invalid ${ps.codeLabel} code.');
    }
    ctx.write.code = provided;
  }
}
