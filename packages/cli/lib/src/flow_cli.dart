import 'package:bitblik_core/core.dart';

import 'cli_context.dart';

/// Flow-engine view for the maker-side CLI.
///
/// Wraps the [FlowEngine] loaded from the active payment system's `*.yml`
/// definition and answers the questions the offer commands ask: which states
/// allow which maker action, which states are terminal, and how to describe a
/// state while waiting.
///
/// Everything keys off the verbatim flow-state string ([Offer.statusRaw]),
/// **not** the [OfferStatus] enum. Generic flows (TWINT) carry states such as
/// `invalidTwint` / `expiredTwint` that have no enum value — they round-trip as
/// [OfferStatus.unknown] but their [Offer.statusRaw] matches the engine's state
/// names directly. See [[project-dual-flow-engine]].
class MakerFlow {
  final FlowEngine engine;

  MakerFlow(this.engine);

  /// Load the flow for the process's active payment system.
  static Future<MakerFlow> load() async {
    final flowId = activePaymentSystem.flowId;
    if (flowId == null) {
      throw StateError(
          'Payment system "${activePaymentSystem.id}" has no flow definition.');
    }
    return MakerFlow(await FlowFileLoader.load(flowId));
  }

  /// Local-only pre-funding state. The CLI stamps a freshly created offer with
  /// this before the coordinator confirms the hold invoice; no flow defines it
  /// (every flow's initial state is `funded`).
  static const String localCreated = 'created';

  /// The flow-state string for an offer, as understood by the engine.
  static String stateOf(Offer offer) => offer.statusRaw;

  bool isKnown(String state) => engine.definition.state(state) != null;

  bool isTerminal(String state) => engine.isTerminal(state);

  /// An offer still moving through the flow: the local pre-fund state, or a
  /// known non-terminal state. Truly-unknown states (a newer coordinator's) are
  /// treated as not in progress.
  bool isInProgress(String state) =>
      state == localCreated || (isKnown(state) && !isTerminal(state));

  /// States from which the maker may fire [event].
  Set<String> makerStatesFor(String event) =>
      engine.statesAllowing(event, actor: FlowActor.maker);

  /// The pre-code states a `get_blik`/`get-code` wait may start from (BLIK / MB
  /// WAY). The maker fetches the code once the taker submits it in
  /// `blikReceived`; the earlier states lead there.
  static const Set<String> _awaitCodeStates = {
    'funded',
    'reserved',
    'blikReceived',
    'blikSentToMaker',
  };

  bool canAwaitCode(String state) =>
      state == localCreated || _awaitCodeStates.contains(state);

  bool makerCan(String state, String event) => engine
      .resolveUserAction(
        fromState: state,
        event: event,
        actor: FlowActor.maker,
      )
      .allowed;

  /// The maker's dispute action for this flow: `open_dispute` (BLIK / MB WAY,
  /// after a taker conflict) or `start_dispute` (TWINT, from `takerCharged`).
  /// Null when the flow gives the maker no dispute action.
  String? get disputeEvent {
    for (final e in const ['open_dispute', 'start_dispute']) {
      if (makerStatesFor(e).isNotEmpty) return e;
    }
    return null;
  }

  /// TWINT-style re-code action (`enter_new_twint`), or null when the flow has
  /// none. Present when the maker supplies the payment code up front and can
  /// replace it after it expires.
  String? get newCodeEvent =>
      makerStatesFor('enter_new_twint').isNotEmpty ? 'enter_new_twint' : null;

  /// True when the maker pulls a taker-submitted code (`get_blik`) — BLIK / MB
  /// WAY. False for flows where the maker provides the code (TWINT).
  bool get supportsGetCode => makerStatesFor('get_blik').isNotEmpty;

  /// True when the maker can report the code invalid (`mark_blik_invalid`).
  bool get supportsMarkInvalid =>
      makerStatesFor('mark_blik_invalid').isNotEmpty;

  /// Short human message describing [state] while waiting for it to advance.
  String waitMessage(String state) {
    switch (state) {
      case localCreated:
        return 'Waiting for the hold invoice to be funded…';
      case 'funded':
        return 'Funded. Waiting for a taker to reserve the offer…';
      case 'reserved':
        return supportsGetCode
            ? 'Reserved. Waiting for the taker to submit the code…'
            : 'Reserved. Taker has the code; waiting for them to pay…';
      case 'blikReceived':
      case 'blikSentToMaker':
        return 'Code received.';
      case 'takerCharged':
        return 'Taker reported payment. You can confirm or dispute.';
    }
    // Fall back to the NIP-69 phase the flow assigns the state, else its name.
    final phase = engine.definition.state(state)?.nip69;
    if (phase != null && phase.isNotEmpty) return 'Status: $state ($phase)';
    return 'Status: $state';
  }
}
