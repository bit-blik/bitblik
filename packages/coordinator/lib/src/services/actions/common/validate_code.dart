part of '../../coordinator_service.dart';

/// Validates the payment code accompanying a submit. For maker-provides-code
/// flows the offer already carries the code; otherwise it comes from the RPC
/// params.
class ValidateCodeAction extends FlowAction {
  @override
  String get name => 'validate_code';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final ps = flow._c._paymentSystem;
    final provided = ps.makerProvidesCodeAtOfferCreation
        ? ctx.offer.blikCode
        : _cleanParam(ctx.params['blik_code']);
    if (provided == null || !ps.isValidCode(provided)) {
      throw Exception('Invalid ${ps.codeLabel} code.');
    }
    ctx.write.code = provided;
  }
}
