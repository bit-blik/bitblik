import 'dart:async';

import 'package:ndk/ndk.dart';

import '../constants/kinds.dart';
import '../constants/rpc_methods.dart';
import '../models/coordinator_info.dart';
import '../models/coordinator_record.dart';
import '../protocol/bitblik_rpc_client.dart';
import '../protocol/rpc_envelope.dart';
import 'coordinator_store.dart';

/// Reusable coordinator discovery + health + persistence service.
///
/// One instance per app process. Owns the in-memory `pubkey -> record`
/// map, persists via [CoordinatorStore], publishes changes to listeners
/// through [changes], and offers idempotent helpers for discovery,
/// health probing, and user-driven enable/disable/add/remove.
class CoordinatorRegistry {
  final Ndk ndk;
  final BitblikRpcClient rpcClient;
  final CoordinatorStore store;
  final List<String> relays;

  /// Records whose `lastHealthCheck` is older than this are eligible to
  /// be probed again by [probeAllEnabled].
  final Duration probeStaleAfter;

  /// Wait at most this long for the first `kind=kKindCoordinatorInfo`
  /// event for a manually-added pubkey before giving up.
  final Duration manualAddTimeout;

  /// Window used by [fetchNetworkFinishedCounts].
  final Duration networkFinishedWindow;

  final Map<String, CoordinatorRecord> _records = {};
  final StreamController<List<CoordinatorRecord>> _changes =
      StreamController<List<CoordinatorRecord>>.broadcast();

  bool _initialized = false;
  Timer? _saveDebouncer;
  Future<void>? _discoveryInFlight;

  CoordinatorRegistry({
    required this.ndk,
    required this.rpcClient,
    required this.store,
    required this.relays,
    this.probeStaleAfter = const Duration(seconds: 60),
    this.manualAddTimeout = const Duration(seconds: 5),
    this.networkFinishedWindow = const Duration(days: 30),
  });

  /// Hydrate from persistent storage. Idempotent.
  Future<void> init() async {
    if (_initialized) return;
    final loaded = await store.load();
    for (final r in loaded) {
      _records[r.pubkeyHex] = r;
    }
    _initialized = true;
    _emit();
  }

  /// Broadcast stream of the sorted record list. Emits the initial state
  /// on subscribe via [all].
  Stream<List<CoordinatorRecord>> get changes => _changes.stream;

  /// All records (enabled and disabled), sorted by [_compare].
  List<CoordinatorRecord> get all => _sorted(_records.values.toList());

  /// Enabled records only — what the maker flow should show.
  List<CoordinatorRecord> get enabled =>
      all.where((r) => r.enabled).toList(growable: false);

  CoordinatorRecord? recordFor(String pubkey) =>
      _records[_normalize(pubkey)];

  CoordinatorInfo? infoFor(String pubkey) =>
      recordFor(pubkey)?.info;

  /// One-shot discovery query. Coalesces concurrent calls.
  Future<void> discover() async {
    if (_discoveryInFlight != null) {
      return _discoveryInFlight!;
    }
    final completer = Completer<void>();
    _discoveryInFlight = completer.future;
    try {
      final response = ndk.requests.query(
        name: 'coordinator-discovery',
        filter: Filter(kinds: [kKindCoordinatorInfo]),
        explicitRelays: relays,
      );
      await for (final event in response.stream) {
        _upsertFromEvent(event);
      }
      _schedulePersist();
      _emit();
    } finally {
      _discoveryInFlight = null;
      completer.complete();
    }
  }

  /// Probe a single coordinator via `get_info` and update its record.
  Future<void> probeHealth(String pubkey) async {
    final hex = _normalize(pubkey);
    final existing = _records[hex];
    if (existing == null) return;
    try {
      await rpcClient.send(
        const NostrRequest(method: kRpcGetInfo, params: {}),
        hex,
      );
      _records[hex] = existing.copyWith(
        responsive: true,
        lastHealthCheck: DateTime.now(),
        successfulProbes: existing.successfulProbes + 1,
      );
    } catch (_) {
      _records[hex] = existing.copyWith(
        responsive: false,
        lastHealthCheck: DateTime.now(),
        failedProbes: existing.failedProbes + 1,
      );
    }
    _schedulePersist();
    _emit();
  }

  /// Probe every enabled coordinator whose last probe is older than
  /// [probeStaleAfter] (or never probed). Stale-only by design so calling
  /// on every screen entry stays cheap.
  Future<void> probeAllEnabled() async {
    final now = DateTime.now();
    final due = _records.values
        .where((r) =>
            r.enabled &&
            (r.lastHealthCheck == null ||
                now.difference(r.lastHealthCheck!) > probeStaleAfter))
        .map((r) => r.pubkeyHex)
        .toList();
    if (due.isEmpty) return;
    await Future.wait(due.map(probeHealth));
  }

  /// Probe every listed coordinator, regardless of enabled state or probe age.
  /// Useful for user-triggered manual refreshes where the expectation is a
  /// fresh responsiveness snapshot for the whole visible list.
  Future<void> probeAllListed() async {
    final listed = all.map((r) => r.pubkeyHex).toList(growable: false);
    if (listed.isEmpty) return;
    await Future.wait(listed.map(probeHealth));
  }

  /// Flip a coordinator's enabled flag.
  Future<void> setEnabled(String pubkey, bool value) async {
    final hex = _normalize(pubkey);
    final existing = _records[hex];
    if (existing == null) return;
    _records[hex] = existing.copyWith(enabled: value);
    await store.save(_records.values.toList());
    _emit();
  }

  /// Manually add a coordinator by npub or hex pubkey. Pulls the
  /// coordinator's `kind=kKindCoordinatorInfo` event inline; throws
  /// [CoordinatorInfoUnavailable] if no event arrives within
  /// [manualAddTimeout]. If the coordinator was already known and has
  /// info, this just flips it to enabled.
  Future<CoordinatorRecord> addManual(String npubOrHex) async {
    final trimmed = npubOrHex.trim();
    if (trimmed.isEmpty) {
      throw ArgumentError('Pubkey cannot be empty');
    }
    final hex = _normalize(trimmed);

    final existing = _records[hex];
    if (existing?.info != null) {
      _records[hex] = existing!.copyWith(enabled: true, manualAdded: true);
      await store.save(_records.values.toList());
      _emit();
      return _records[hex]!;
    }

    final response = ndk.requests.query(
      name: 'coordinator-manual-add',
      filter: Filter(
        kinds: [kKindCoordinatorInfo],
        authors: [hex],
      ),
      explicitRelays: relays,
    );

    Nip01Event event;
    try {
      event = await response.stream
          .firstWhere((e) => e.pubKey == hex)
          .timeout(manualAddTimeout);
    } catch (_) {
      throw CoordinatorInfoUnavailable(hex);
    }

    _upsertFromEvent(event, manualAdded: true);
    final after = _records[hex]!;
    _records[hex] = after.copyWith(enabled: true, manualAdded: true);
    await store.save(_records.values.toList());
    _emit();
    return _records[hex]!;
  }

  /// Forget a coordinator entirely. Use for manual-add removals.
  Future<void> remove(String pubkey) async {
    final hex = _normalize(pubkey);
    if (_records.remove(hex) != null) {
      await store.save(_records.values.toList());
      _emit();
    }
  }

  /// Bulk-update the user's personal finished-offer counts per coordinator.
  /// Pass the full map; missing coordinators are left untouched. No-op
  /// (no emit) when every value is already up to date — important to
  /// avoid feedback loops with providers that watch [changes] and also
  /// call this.
  void updateLocalFinishedCounts(Map<String, int> counts) {
    final now = DateTime.now();
    var changed = false;
    counts.forEach((pubkey, count) {
      final hex = _normalize(pubkey);
      final r = _records[hex];
      if (r == null) return;
      if (r.localFinishedCount == count) return;
      _records[hex] = r.copyWith(
        localFinishedCount: count,
        lastFinishedCountUpdate: now,
      );
      changed = true;
    });
    if (changed) {
      _schedulePersist();
      _emit();
    }
  }

  /// Background query for `kind=kKindOffer` events with `#s=success`
  /// within [networkFinishedWindow], grouped by event author. Updates
  /// `networkFinishedCount` per known record. Unknown authors are
  /// ignored — discovery will pick them up separately.
  Future<void> fetchNetworkFinishedCounts() async {
    final since = DateTime.now()
            .subtract(networkFinishedWindow)
            .millisecondsSinceEpoch ~/
        1000;
    final response = ndk.requests.query(
      name: 'coordinator-network-finished',
      filter: Filter(
        kinds: [kKindOffer],
        tags: {
          '#s': ['success'],
        },
        since: since,
      ),
      explicitRelays: relays,
    );
    final counts = <String, int>{};
    await for (final event in response.stream) {
      counts[event.pubKey] = (counts[event.pubKey] ?? 0) + 1;
    }
    final now = DateTime.now();
    var changed = false;
    counts.forEach((pubkey, count) {
      final r = _records[pubkey];
      if (r == null) return;
      if (r.networkFinishedCount == count) return;
      _records[pubkey] = r.copyWith(
        networkFinishedCount: count,
        lastFinishedCountUpdate: now,
      );
      changed = true;
    });
    if (changed) {
      _schedulePersist();
      _emit();
    }
  }

  Future<void> dispose() async {
    _saveDebouncer?.cancel();
    if (!_changes.isClosed) {
      await _changes.close();
    }
  }

  // --- internals ---

  void _upsertFromEvent(Nip01Event event, {bool manualAdded = false}) {
    final info = CoordinatorInfo.fromNostrEvent(event);
    final pubkey = event.pubKey;
    final eventTime =
        DateTime.fromMillisecondsSinceEpoch(event.createdAt * 1000);
    final existing = _records[pubkey];
    final now = DateTime.now();
    if (existing == null) {
      _records[pubkey] = CoordinatorRecord(
        pubkeyHex: pubkey,
        info: info,
        lastSeen: eventTime,
        firstSeenAt: now,
        enabled: true,
        manualAdded: manualAdded,
      );
    } else {
      final newer = existing.lastSeen == null ||
          existing.lastSeen!.isBefore(eventTime);
      _records[pubkey] = existing.copyWith(
        info: info,
        lastSeen: newer ? eventTime : existing.lastSeen,
        firstSeenAt: existing.firstSeenAt ?? now,
        manualAdded: existing.manualAdded || manualAdded,
      );
    }
  }

  void _emit() {
    if (_changes.isClosed) return;
    _changes.add(all);
  }

  void _schedulePersist() {
    _saveDebouncer?.cancel();
    _saveDebouncer = Timer(const Duration(milliseconds: 200), () {
      store.save(_records.values.toList());
    });
  }

  /// Cancel any pending debounced save and persist immediately.
  /// Call this before process exit to guarantee health probe results are written.
  Future<void> flushPersist() async {
    _saveDebouncer?.cancel();
    _saveDebouncer = null;
    await store.save(_records.values.toList());
  }

  List<CoordinatorRecord> _sorted(List<CoordinatorRecord> list) {
    list.sort(_compare);
    return list;
  }

  static int _compare(CoordinatorRecord a, CoordinatorRecord b) {
    final byScore = b.score.compareTo(a.score);
    if (byScore != 0) return byScore;
    final aFirst = a.firstSeenAt;
    final bFirst = b.firstSeenAt;
    if (aFirst != null && bFirst != null) {
      final byAge = aFirst.compareTo(bFirst);
      if (byAge != 0) return byAge;
    }
    final aName = a.info?.name ?? a.pubkeyHex;
    final bName = b.info?.name ?? b.pubkeyHex;
    return aName.compareTo(bName);
  }

  static String _normalize(String pubkey) {
    final trimmed = pubkey.trim();
    if (trimmed.startsWith('npub')) {
      try {
        return Nip19.decode(trimmed);
      } catch (_) {
        return trimmed;
      }
    }
    return trimmed;
  }
}

/// Thrown by [CoordinatorRegistry.addManual] when no
/// `kind=kKindCoordinatorInfo` event was received from the target
/// pubkey within [CoordinatorRegistry.manualAddTimeout].
class CoordinatorInfoUnavailable implements Exception {
  final String pubkeyHex;
  CoordinatorInfoUnavailable(this.pubkeyHex);

  @override
  String toString() =>
      'CoordinatorInfoUnavailable: no kind 38383 event from $pubkeyHex';
}
