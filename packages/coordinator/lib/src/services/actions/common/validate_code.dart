part of '../../coordinator_service.dart';

/// Validates the payment code accompanying a submit. For maker-provides-code
/// flows the offer already carries the code; otherwise it comes from the RPC
/// params.
class ValidateCodeAction extends FlowAction {
  @override
  String get name => 'validate_code';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final instrument = flow._c._instrumentForCategory(ctx.offer.category);
    final bank = instrument.bankById(ctx.offer.bankId);
    final provided = instrument.makerProvidesCode
        ? ctx.offer.blikCode
        : _cleanParam(ctx.params['blik_code']);
    if (provided == null || !instrument.validate(provided, bank: bank)) {
      throw Exception('Invalid ${instrument.codeLabel} code.');
    }
    ctx.write.code = provided;
  }
}
