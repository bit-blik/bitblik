import 'dart:async';

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

FlowTriggerType _triggerFromOn(String raw) {
  switch (raw) {
    case 'timeout':
      return FlowTriggerType.timeout;
    case 'auto':
      return FlowTriggerType.auto;
    default:
      return FlowTriggerType.userAction;
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
  /// For [FlowTriggerType.userAction] edges this IS the driving RPC method
  /// stored in yaml `on:` (see `rpc_methods.dart`, e.g. `reserve_offer`,
  /// `submit_blik`) — the executor dispatches an incoming wire RPC straight to
  /// the matching event. [FlowTriggerType.auto] / [FlowTriggerType.timeout]
  /// transitions have no event name in schema v2.
  final String? event;

  /// Required actor for a user action (`by:`). Null means unrestricted/internal.
  final FlowActor? actor;

  /// Destination state name (`to:`).
  final String target;

  /// Optional failure route (`on_fail:`). When an action reports a definitive
  /// failure, the executor advances to this state instead of [target].
  final String? onFailTarget;

  /// Default timer duration for [FlowTriggerType.timeout] edges (`after:`).
  final int? durationSeconds;

  /// For [FlowTriggerType.timeout] edges, the offer timestamp the duration is
  /// measured from (`from:`). Null means "state entry" (the executor uses the
  /// row's updated_at). Used where a window must span more than one state.
  final String? fromField;

  /// Ordered action keywords (`do:`) applied when this transition fires.
  final List<String> actions;

  /// Optional offer field the RPC response should echo back (e.g. `blik_code`),
  /// for transitions that return data rather than a plain ack.
  final String? returns;

  const FlowTransition({
    required this.trigger,
    required this.target,
    this.event,
    this.actor,
    this.onFailTarget,
    this.durationSeconds,
    this.fromField,
    this.actions = const [],
    this.returns,
  });

  factory FlowTransition.fromYaml(YamlMap m) {
    final on = m['on'] as String?;
    if (on == null || on.isEmpty) {
      throw const FormatException('Flow transition is missing "on".');
    }
    final trigger = _triggerFromOn(on);
    return FlowTransition(
      trigger: trigger,
      target: m['to'] as String,
      event: trigger == FlowTriggerType.userAction ? on : null,
      actor: _actorFromYaml(m['by'] as String?),
      onFailTarget: m['on_fail'] as String?,
      durationSeconds: m['after'] as int?,
      fromField: m['from'] as String?,
      actions: _stringList(m['do']),
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

dynamic _plainYaml(dynamic v) {
  if (v is YamlMap) {
    return {
      for (final entry in v.entries)
        entry.key as String: _plainYaml(entry.value)
    };
  }
  if (v is YamlList) {
    return [for (final item in v) _plainYaml(item)];
  }
  return v;
}

/// One node in a flow definition.
@immutable
class FlowState {
  final String name;
  final bool initial;
  final bool terminal;

  /// Optional NIP-69 status category for broadcast (`pending`, `in-progress`,
  /// `success`, `canceled`, `dispute`). Lets the broadcast layer map state ->
  /// NIP-69 from the flow definition instead of the OfferStatus enum.
  final String? nip69;

  /// Ordered post-commit actions (`do:`) run when this state is entered.
  final List<String> actions;

  final List<FlowTransition> transitions;

  const FlowState({
    required this.name,
    this.initial = false,
    this.terminal = false,
    this.nip69,
    this.actions = const [],
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
    return FlowState(
      name: name,
      initial: (m['initial'] as bool?) ?? false,
      terminal: (m['terminal'] as bool?) ?? false,
      nip69: m['nip69'] as String?,
      actions: _stringList(m['do']),
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
    final expanded = _decodeRoot(yamlSource);
    final imports = _stringList(expanded['imports']);
    if (imports.isNotEmpty) {
      throw const FormatException(
          'Flow definition imports require parseWithImports().');
    }
    return _parseExpanded(expanded);
  }

  static Future<FlowDefinition> parseWithImports(
    String yamlSource,
    Future<String> Function(String importPath) importLoader,
  ) async {
    final expanded =
        await _expandImports(_decodeRoot(yamlSource), importLoader);
    return _parseExpanded(expanded);
  }

  static Map<String, dynamic> _decodeRoot(String yamlSource) {
    final doc = loadYaml(yamlSource);
    if (doc is! YamlMap) {
      throw const FormatException('Flow definition root must be a map.');
    }
    return (_plainYaml(doc) as Map).cast<String, dynamic>();
  }

  static Future<Map<String, dynamic>> _expandImports(
    Map<String, dynamic> root,
    Future<String> Function(String importPath) importLoader, {
    Set<String>? stack,
  }) async {
    final seen = stack ?? <String>{};
    final imports = _stringList(root['imports']);
    if (imports.isEmpty) return root;

    final mergedStates = <String, dynamic>{};
    for (final importPath in imports) {
      if (!seen.add(importPath)) {
        throw FormatException('Circular flow import detected: $importPath');
      }
      final importedSource = await importLoader(importPath);
      final importedRoot = await _expandImports(
          _decodeRoot(importedSource), importLoader,
          stack: seen);
      seen.remove(importPath);
      final importedStates = importedRoot['states'];
      if (importedStates is! Map) {
        throw FormatException(
            'Imported flow fragment "$importPath" has no states map.');
      }
      for (final entry in importedStates.entries) {
        final name = entry.key as String;
        if (mergedStates.containsKey(name)) {
          throw FormatException(
              'Imported flow state "$name" declared more than once.');
        }
        mergedStates[name] = entry.value;
      }
    }

    final localStates = root['states'];
    if (localStates is! Map || localStates.isEmpty) {
      throw const FormatException('Flow definition has no states.');
    }
    for (final entry in localStates.entries) {
      final name = entry.key as String;
      if (mergedStates.containsKey(name)) {
        throw FormatException(
            'Flow definition re-declares imported state "$name".');
      }
      mergedStates[name] = entry.value;
    }

    return {
      ...root,
      'states': mergedStates,
      'imports': const <String>[],
    };
  }

  static FlowDefinition _parseExpanded(Map<String, dynamic> doc) {
    final id = doc['id'] as String?;
    if (id == null || id.isEmpty) {
      throw const FormatException('Flow definition is missing a top-level id.');
    }
    final rawStates = doc['states'];
    if (rawStates is! Map || rawStates.isEmpty) {
      throw const FormatException('Flow definition has no states.');
    }

    final states = <String, FlowState>{};
    String? initial;
    rawStates.forEach((key, value) {
      final name = key as String;
      final state = FlowState.fromYaml(name, YamlMap.wrap(value));
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
        if (t.onFailTarget != null && !states.containsKey(t.onFailTarget)) {
          throw FormatException(
              'Flow "$id": state "${state.name}" routes on_fail to unknown '
              'state "${t.onFailTarget}".');
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
