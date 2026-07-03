import 'flow_models.dart';

/// Outcome of asking the [FlowEngine] whether an action is allowed from a state.
class FlowResolution {
  /// True when a matching transition exists.
  final bool allowed;

  /// Destination state name (only meaningful when [allowed]).
  final String? target;

  /// The matched transition (only when [allowed]).
  final FlowTransition? transition;

  /// Human-readable rejection reason (only when not [allowed]).
  final String? rejectReason;

  const FlowResolution._({
    required this.allowed,
    this.target,
    this.transition,
    this.rejectReason,
  });

  factory FlowResolution.allow(FlowTransition t) =>
      FlowResolution._(allowed: true, target: t.target, transition: t);

  factory FlowResolution.reject(String reason) =>
      FlowResolution._(allowed: false, rejectReason: reason);
}

/// Enforces a [FlowDefinition]. Pure and side-effect free: it computes what a
/// transition *should* do; the coordinator performs the actual DB compare-and-set
/// using [FlowResolution.target] as the new status and `[fromState]` as the
/// expected-current guard.
class FlowEngine {
  final FlowDefinition definition;

  FlowEngine(this.definition);

  /// Parse [yamlSource] into a definition and wrap it.
  factory FlowEngine.fromYaml(String yamlSource) =>
      FlowEngine(FlowDefinition.parse(yamlSource));

  String get initialState => definition.initialState;

  bool isTerminal(String state) =>
      definition.state(state)?.terminal ?? false;

  /// Resolve a participant-driven action.
  ///
  /// Matches the [FlowTriggerType.userAction] transition of [fromState] whose
  /// [FlowTransition.event] equals [event]. Since user-action events ARE the RPC
  /// method names, the executor passes the incoming wire RPC straight in as
  /// [event]. If [actor] is supplied it must match the transition's declared
  /// actor (a transition with no declared actor accepts any).
  FlowResolution resolveUserAction({
    required String fromState,
    required String event,
    FlowActor? actor,
  }) {
    final state = definition.state(fromState);
    if (state == null) {
      return FlowResolution.reject('Unknown state "$fromState".');
    }
    if (state.terminal) {
      return FlowResolution.reject('State "$fromState" is terminal.');
    }
    FlowTransition? eventMatch;
    for (final t in state.transitions) {
      if (t.trigger != FlowTriggerType.userAction) continue;
      if (t.event != event) continue;
      eventMatch = t;
      if (t.actor != null && actor != null && t.actor != actor) continue;
      if (t.actor == null || actor == null || t.actor == actor) {
        return FlowResolution.allow(t);
      }
    }
    if (eventMatch != null) {
      return FlowResolution.reject(
          'Event "$event" in "$fromState" requires actor ${eventMatch.actor}, '
          'got $actor.');
    }
    return FlowResolution.reject(
        'No "$event" transition from "$fromState".');
  }


  /// The timeout transition leaving [state], if the state has one.
  FlowTransition? timeoutFor(String state) =>
      definition.state(state)?.timeoutTransition;

  /// The user-action transitions available from [state] to [actor], in yaml
  /// order. Drives the UI: a client renders exactly one button per returned
  /// transition (labelled by its [FlowTransition.event]) and fires that event's
  /// RPC. Empty when the state is terminal/unknown or the actor has no actions.
  List<FlowTransition> userActionsFor(String state, FlowActor actor) {
    final s = definition.state(state);
    if (s == null) return const [];
    return [
      for (final t in s.transitions)
        if (t.trigger == FlowTriggerType.userAction &&
            (t.actor == null || t.actor == actor))
          t,
    ];
  }

  /// The first transition leaving [state] whose [FlowTransition.event] equals
  /// [event] (optionally constrained to [actor]). Lets the executor resolve a
  /// transition by event without naming source/target states in code.
  FlowTransition? transitionFor(String state, String event, {FlowActor? actor}) {
    final s = definition.state(state);
    if (s == null) return null;
    for (final t in s.transitions) {
      if (t.event != event) continue;
      if (actor != null && t.actor != null && t.actor != actor) continue;
      return t;
    }
    return null;
  }

  /// Set of states from which [event] is a valid user action. Useful for
  /// building the expected-current-status list of a DB compare-and-set when an
  /// RPC is allowed from several states.
  Set<String> statesAllowing(String event, {FlowActor? actor}) {
    final result = <String>{};
    for (final state in definition.states.values) {
      for (final t in state.transitions) {
        if (t.trigger != FlowTriggerType.userAction) continue;
        if (t.event != event) continue;
        if (actor != null && t.actor != null && t.actor != actor) continue;
        result.add(state.name);
      }
    }
    return result;
  }
}
