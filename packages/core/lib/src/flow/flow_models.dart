import 'package:meta/meta.dart';
import 'package:yaml/yaml.dart';

/// How a [FlowTransition] is triggered.
enum FlowTriggerType {
  /// Explicitly initiated by a participant via an RPC method.
  userAction,

  /// Fired by a server-side timer on state entry.
  timeout,

  /// Fires immediately on state entry (server-internal, no external input).
  auto,
}

/// Who is allowed to initiate a [FlowTriggerType.userAction] transition.
enum FlowActor { maker, taker, coordinator, server }

FlowTriggerType _triggerFromYaml(String raw) {
  switch (raw) {
    case 'user_action':
      return FlowTriggerType.userAction;
    case 'timeout':
      return FlowTriggerType.timeout;
    case 'auto':
      return FlowTriggerType.auto;
    default:
      throw FormatException('Unknown flow trigger type: $raw');
  }
}

FlowActor? _actorFromYaml(String? raw) {
  if (raw == null) return null;
  switch (raw) {
    case 'maker':
      return FlowActor.maker;
    case 'taker':
      return FlowActor.taker;
    case 'coordinator':
      return FlowActor.coordinator;
    case 'server':
      return FlowActor.server;
    default:
      throw FormatException('Unknown flow actor: $raw');
  }
}

/// A single edge in a flow: from the owning [FlowState] to [target].
@immutable
class FlowTransition {
  final FlowTriggerType trigger;

  /// The unique name of this edge within its owning state.
  ///
  /// For [FlowTriggerType.userAction] edges this IS the driving RPC method (see
  /// `rpc_methods.dart`, e.g. `reserve_offer`, `submit_blik`) — the executor
  /// dispatches an incoming wire RPC straight to the matching event. For
  /// [FlowTriggerType.auto] / [FlowTriggerType.timeout] edges it is a free label
  /// (e.g. `payment_success`), optional where the edge needs no disambiguation.
  final String? event;

  /// Required actor for a user action. Null means unrestricted/internal.
  final FlowActor? actor;

  /// Destination state name.
  final String target;

  /// Default timer duration for [FlowTriggerType.timeout] edges (seconds).
  final int? durationSeconds;

  /// For [FlowTriggerType.timeout] edges, the offer timestamp the duration is
  /// measured from. Null means "state entry" (the executor uses the row's
  /// updated_at). Used where a window must span more than one state — e.g. the
  /// BLIK confirmation window continues from `code_received_at` after the maker
  /// fetches the code (blik_received -> blik_sent_to_maker).
  final String? fromField;

  /// Optional server-side action keyword (e.g. `settle_hold_invoice`).
  ///
  /// DEPRECATED in favour of [effects]; retained for back-compat. When `effects`
  /// is absent and `action` is present, [effects] is `[action]`.
  final String? action;

  /// Ordered effect keywords applied when this transition fires. Resolved by the
  /// generic executor against its effect registry (pre-commit effects shape the
  /// atomic status write; post-commit effects run after it is durably applied).
  final List<String> effects;

  /// Optional offer field the RPC response should echo back (e.g. `blik_code`),
  /// for transitions that return data rather than a plain ack.
  final String? returns;

  const FlowTransition({
    required this.trigger,
    required this.target,
    this.event,
    this.actor,
    this.durationSeconds,
    this.fromField,
    this.action,
    this.effects = const [],
    this.returns,
  });

  factory FlowTransition.fromYaml(YamlMap m) {
    final action = m['action'] as String?;
    final rawEffects = m['effects'];
    return FlowTransition(
      trigger: _triggerFromYaml(m['trigger'] as String),
      target: m['target'] as String,
      event: m['event'] as String?,
      actor: _actorFromYaml(m['actor'] as String?),
      durationSeconds: m['duration_seconds'] as int?,
      fromField: m['from_field'] as String?,
      action: action,
      effects: rawEffects != null
          ? _stringList(rawEffects)
          : (action != null ? [action] : const []),
      returns: m['returns'] as String?,
    );
  }
}

/// Normalize a yaml value that may be a single string or a list of strings into
/// a `List<String>`. Null yields the empty list.
List<String> _stringList(dynamic v) {
  if (v == null) return const [];
  if (v is String) return [v];
  if (v is YamlList) return v.map((e) => e as String).toList(growable: false);
  if (v is List) return v.map((e) => e as String).toList(growable: false);
  throw FormatException('Expected a string or list of strings, got: $v');
}

/// One node in a flow definition.
@immutable
class FlowState {
  final String name;
  final bool initial;
  final bool terminal;

  /// DEPRECATED single on-entry action; retained for back-compat. Non-null only
  /// when `on_entry` is a scalar in the yaml. Prefer [onEntryEffects].
  final String? onEntry;

  /// Ordered effect keywords run on entering this state (post-commit). Accepts a
  /// scalar or a list in the yaml.
  final List<String> onEntryEffects;

  /// Optional NIP-69 status category for broadcast (`pending`, `in-progress`,
  /// `success`, `canceled`, `dispute`). Lets the broadcast layer map state ->
  /// NIP-69 from the flow definition instead of the OfferStatus enum.
  final String? nip69;

  final List<FlowTransition> transitions;

  const FlowState({
    required this.name,
    this.initial = false,
    this.terminal = false,
    this.onEntry,
    this.onEntryEffects = const [],
    this.nip69,
    this.transitions = const [],
  });

  /// The single timeout edge of this state, if any.
  FlowTransition? get timeoutTransition {
    for (final t in transitions) {
      if (t.trigger == FlowTriggerType.timeout) return t;
    }
    return null;
  }

  factory FlowState.fromYaml(String name, YamlMap m) {
    final rawTransitions = m['transitions'] as YamlList?;
    final rawOnEntry = m['on_entry'];
    return FlowState(
      name: name,
      initial: (m['initial'] as bool?) ?? false,
      terminal: (m['terminal'] as bool?) ?? false,
      onEntry: rawOnEntry is String ? rawOnEntry : null,
      onEntryEffects: _stringList(rawOnEntry),
      nip69: m['nip69'] as String?,
      transitions: rawTransitions == null
          ? const []
          : rawTransitions
              .map((e) => FlowTransition.fromYaml(e as YamlMap))
              .toList(growable: false),
    );
  }
}

/// A parsed, validated state-machine definition for one payment flow.
@immutable
class FlowDefinition {
  final String id;
  final Map<String, FlowState> states;
  final String initialState;

  const FlowDefinition({
    required this.id,
    required this.states,
    required this.initialState,
  });

  /// Parse [yamlSource] (the contents of a `*.yml` flow file).
  ///
  /// Validates that exactly one state is `initial`, that no state is both
  /// terminal and has transitions, and that every transition target names a
  /// known state. Throws [FormatException] on any violation.
  factory FlowDefinition.parse(String yamlSource) {
    final doc = loadYaml(yamlSource);
    if (doc is! YamlMap) {
      throw const FormatException('Flow definition root must be a map.');
    }
    final id = doc['id'] as String?;
    if (id == null || id.isEmpty) {
      throw const FormatException('Flow definition is missing a top-level id.');
    }
    final rawStates = doc['states'];
    if (rawStates is! YamlMap || rawStates.isEmpty) {
      throw const FormatException('Flow definition has no states.');
    }

    final states = <String, FlowState>{};
    String? initial;
    rawStates.forEach((key, value) {
      final name = key as String;
      final state = FlowState.fromYaml(name, value as YamlMap);
      states[name] = state;
      if (state.initial) {
        if (initial != null) {
          throw FormatException(
              'Flow "$id" declares multiple initial states: $initial, $name.');
        }
        initial = name;
      }
    });

    if (initial == null) {
      throw FormatException('Flow "$id" declares no initial state.');
    }

    // Structural validation.
    for (final state in states.values) {
      if (state.terminal && state.transitions.isNotEmpty) {
        throw FormatException(
            'Flow "$id": terminal state "${state.name}" has transitions.');
      }
      for (final t in state.transitions) {
        if (!states.containsKey(t.target)) {
          throw FormatException(
              'Flow "$id": state "${state.name}" targets unknown state '
              '"${t.target}".');
        }
      }
    }

    return FlowDefinition(
      id: id,
      states: Map.unmodifiable(states),
      initialState: initial!,
    );
  }

  FlowState? state(String name) => states[name];
}
