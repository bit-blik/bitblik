part of '../../coordinator_service.dart';

/// NULLs the taker-owned columns on revert-to-open / terminal transitions.
/// In maker-provides-code flows (e.g. TWINT) the code is the maker's, not the
/// taker's — it must survive the clear (e.g. the taker cancelling their
/// reservation).
class ClearTakerFieldsAction extends FlowAction {
  @override
  String get name => 'clear_taker_fields';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    ctx.write.clearTakerFields = true;
    ctx.write.preserveCodeOnClear = flow._c
        ._instrumentForCategory(ctx.offer.category)
        .makerProvidesCode;
  }
}
