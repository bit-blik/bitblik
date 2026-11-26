part of '../../coordinator_service.dart';

/// Composite: bind the first taker and stamp the reservation time.
///
/// On a multi-bank offer the taker also says which bank's app they will
/// generate the code in (`bank` param). That bank must be one the maker
/// accepted; from here on the offer runs on it (code validity, the maker's
/// ATM). A taker that sends no bank — an older app, which only ever saw the
/// offer's first bank — gets the maker's first choice.
class ReserveTakerAction extends FlowAction {
  @override
  String get name => 'reserve_taker';

  @override
  Future<void> run(GenericOfferFlow flow, FlowEffectContext ctx) async {
    final requested = _cleanParam(ctx.params['bank']);
    final accepted = ctx.offer.acceptedBankIds;
    if (requested != null && accepted.isNotEmpty) {
      if (!accepted.contains(requested)) {
        throw Exception('This offer does not accept bank "$requested" '
            '(accepted: ${accepted.join(', ')}).');
      }
      if (ctx.offer.isMultiBank) ctx.write.takerBank = requested;
    }
    ctx.write.takerPubkey = ctx.userPubkey;
    ctx.write.reservedAt = ctx.now.add(const Duration(seconds: 1));
  }
}
