import 'dart:async';

import 'package:ndk/ndk.dart';

import '../constants/kinds.dart';
import '../constants/relays.dart';
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

  /// Discovery relays — used ONLY to find coordinators (their kind
  /// [kKindCoordinatorInfo] and kind [kKindRelayList] events). All
  /// per-coordinator communication is routed to each coordinator's own
  /// [CoordinatorRecord.relays] instead.
  ///
  /// Resolved from Bitblik's profile NIP-65 ([kBitblikPubkeyHex]) on
  /// [discover]; starts as (and falls back to) the hardcoded bootstrap relays
  /// passed to the constructor.
  List<String> relays;

  /// Hardcoded bootstrap relays — fallback when Bitblik's relay list can't be
  /// fetched.
  late final List<String> _bootstrapRelays;

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
  }) {
    _bootstrapRelays = List.from(relays);
  }

  /// Resolve the discovery relays from Bitblik's profile NIP-65
  /// ([kBitblikPubkeyHex]). Fetched **fresh** (cacheRead:false) from the
  /// hardcoded bootstrap relays so a stale cached copy can't pin discovery to
  /// outdated relays.
  ///
  /// The result is the UNION of the hardcoded bootstrap relays and Bitblik's
  /// advertised relays: the bootstrap relays are always queried (so a missing
  /// or misconfigured Bitblik list can never hide coordinators), while Bitblik
  /// can add more relays without a new build.
  Future<void> refreshDiscoveryRelays() async {
    Nip01Event? newest;
    try {
      final response = ndk.requests.query(
        name: 'bitblik-discovery-relays',
        filter: Filter(
          kinds: [kKindRelayList],
          authors: [kBitblikPubkeyHex],
        ),
        explicitRelays: _bootstrapRelays,
        cacheRead: false,
      );
      await for (final event in response.stream.timeout(
        const Duration(seconds: 6),
        onTimeout: (sink) => sink.close(),
      )) {
        if (event.pubKey != kBitblikPubkeyHex) continue;
        if (newest == null || event.createdAt > newest.createdAt) {
          newest = event;
        }
      }
    } catch (_) {
      // Network/timeout — fall back to bootstrap-only discovery below.
    }
    final resolved = <String>{..._bootstrapRelays.map(normalizeRelayUrl)};
    if (newest != null) {
      for (final tag in newest.tags) {
        if (tag.length >= 2 && tag[0] == 'r') {
          final u = normalizeRelayUrl(tag[1]);
          if (u.isNotEmpty) resolved.add(u);
        }
      }
    }
    relays = resolved.toList();
  }

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
      // Resolve the live discovery relays from Bitblik's profile NIP-65 first,
      // so coordinator lookups target the relays Bitblik currently advertises.
      await refreshDiscoveryRelays();
      final response = ndk.requests.query(
        name: 'coordinator-discovery',
        // ONLY kind 15125 here. Adding kind 0 without an `authors` filter would
        // request every profile on the relay (the whole metadata firehose),
        // which relays cap with a default limit and can crowd out / truncate
        // the coordinator advertisements. Profiles are fetched separately,
        // scoped to the discovered authors (see [_refreshProfiles]).
        filter: Filter(kinds: [kKindCoordinatorInfo]),
        explicitRelays: relays,
        // Always pull fresh from relays. kind 15125 is replaceable; reading
        // from cache can return a stale copy without re-fetching the current
        // event, leaving old coordinators showing outdated info.
        cacheRead: false,
      );
      final discovered = <String>{};
      await for (final event in response.stream) {
        _upsertFromEvent(event);
        discovered.add(event.pubKey);
      }
      _schedulePersist();
      _emit();
      // Resolve each coordinator's NIP-65 relays FIRST, then read their kind-0
      // profile from those relays (outbox model) — the canonical, most current
      // source, with discovery relays as fallback.
      await Future.wait(discovered.map(_refreshRelayList));
      await _refreshProfiles(discovered);
    } finally {
      _discoveryInFlight = null;
      completer.complete();
    }
  }

  /// Fetch kind-0 profile metadata (name/picture) for the given coordinator
  /// [authors] and apply the newest per author to its record. Read from each
  /// coordinator's own NIP-65 relays (outbox model) unioned with the discovery
  /// relays as fallback; scoped by `authors` so it never pulls the metadata
  /// firehose. Call AFTER NIP-65 relays are resolved.
  Future<void> _refreshProfiles(Set<String> authors) async {
    if (authors.isEmpty) return;
    final profileRelays = <String>{...relays.map(normalizeRelayUrl)};
    for (final hex in authors) {
      profileRelays.addAll(relaysFor(hex).map(normalizeRelayUrl));
    }
    final response = ndk.requests.query(
      name: 'coordinator-profiles',
      filter: Filter(kinds: [Metadata.kKind], authors: authors.toList()),
      explicitRelays: profileRelays.toList(),
      cacheRead: false,
    );
    final profiles = <String, Nip01Event>{};
    await for (final event in response.stream) {
      if (event.kind != Metadata.kKind) continue;
      final cur = profiles[event.pubKey];
      if (cur == null || event.createdAt > cur.createdAt) {
        profiles[event.pubKey] = event;
      }
    }
    if (profiles.isEmpty) return;
    var changed = false;
    profiles.forEach((pubkey, event) {
      final rec = _records[pubkey];
      if (rec == null) return;
      final m = Metadata.fromEvent(event);
      // Prefer the kind-0 display_name; fall back to name (username).
      final displayName =
          (m.displayName != null && m.displayName!.isNotEmpty)
              ? m.displayName
              : null;
      final name =
          displayName ?? ((m.name != null && m.name!.isNotEmpty) ? m.name : null);
      final picture =
          (m.picture != null && m.picture!.isNotEmpty) ? m.picture : null;
      if (name == null && picture == null) return;
      _records[pubkey] =
          rec.copyWith(profileName: name, profilePicture: picture);
      changed = true;
    });
    if (changed) {
      _schedulePersist();
      _emit();
    }
  }

  /// Union of the relays of all enabled coordinators. Falls back to the
  /// discovery relays for any enabled coordinator whose relay set is not yet
  /// known. This is the set the client subscribes to for responses, offers,
  /// and status updates, and the only relays shown as "in use".
  Set<String> relaysForEnabled() {
    final out = <String>{};
    for (final r in _records.values) {
      if (!r.enabled) continue;
      if (r.relays.isNotEmpty) {
        out.addAll(r.relays);
      } else {
        out.addAll(relays.map(normalizeRelayUrl));
      }
    }
    return out;
  }

  /// Relays for a single coordinator (NIP-65 or fallback). Falls back to the
  /// discovery relays when nothing is known yet.
  List<String> relaysFor(String pubkey) {
    final r = _records[_normalize(pubkey)];
    if (r != null && r.relays.isNotEmpty) return r.relays;
    return relays.map(normalizeRelayUrl).toList(growable: false);
  }

  /// Probe a single coordinator via `get_info` and update its record.
  Future<void> probeHealth(String pubkey) async {
    final hex = _normalize(pubkey);
    final existing = _records[hex];
    if (existing == null) return;
    // Refresh the NIP-65 relay list before probing so health checks track
    // coordinators that move relays, and the probe goes to current relays.
    await _refreshRelayList(hex);
    final coordRelays = relaysFor(hex);
    try {
      await rpcClient.send(
        const NostrRequest(method: kRpcGetInfo, params: {}),
        hex,
        relays: coordRelays,
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

  /// Reset a coordinator's responsiveness to unknown and emit, so the UI can
  /// show a pending/"checking" state immediately before a fresh [probeHealth].
  void markProbing(String pubkey) {
    final hex = _normalize(pubkey);
    final existing = _records[hex];
    if (existing == null) return;
    _records[hex] = existing.copyWith(responsive: null);
    _emit();
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
    // Pull its NIP-65 relay list so we route to its own relays from now on.
    await _refreshRelayList(hex);
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

    // Page size requested from relays. We paginate with an `until` cursor
    // because relays cap how many events a single REQ returns (commonly
    // 100–500). Without pagination the count silently tops out at that cap
    // and badly under-reports coordinators with many finished offers.
    const pageSize = 500;

    // Dedupe across pages by addressable coordinate (author + `d` offer id).
    // kKindOffer (38383) is addressable, so each offer maps to one event; the
    // same event can still surface in adjacent pages around the cursor.
    final seen = <String>{};
    final counts = <String, int>{};

    var until = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    while (true) {
      final response = ndk.requests.query(
        name: 'coordinator-network-finished',
        filter: Filter(
          kinds: [kKindOffer],
          tags: {
            '#s': ['success'],
          },
          since: since,
          until: until,
          limit: pageSize,
        ),
        explicitRelays: relays,
      );

      var pageCount = 0;
      var oldest = until;
      await for (final event in response.stream) {
        pageCount++;
        if (event.createdAt < oldest) oldest = event.createdAt;
        final dTag = event.getDtag() ?? event.id;
        final coordinate = '${event.pubKey}:$dTag';
        if (!seen.add(coordinate)) continue;
        counts[event.pubKey] = (counts[event.pubKey] ?? 0) + 1;
      }

      // Last page reached when the relay returned fewer than requested.
      if (pageCount < pageSize) break;
      // Advance the cursor just past the oldest event seen. Guard against a
      // stuck cursor (a whole page sharing one timestamp) to avoid looping.
      final nextUntil = oldest - 1;
      if (nextUntil >= until || nextUntil < since) break;
      until = nextUntil;
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
    // Fallback relays: the discovery relays this info event was actually seen
    // on. Used only until/unless a NIP-65 event provides an explicit list.
    final fallbackRelays = event.sources
        .map(normalizeRelayUrl)
        .where((u) => u.isNotEmpty)
        .toList();
    if (existing == null) {
      _records[pubkey] = CoordinatorRecord(
        pubkeyHex: pubkey,
        info: info,
        lastSeen: eventTime,
        firstSeenAt: now,
        enabled: true,
        manualAdded: manualAdded,
        relays: fallbackRelays,
      );
    } else {
      final newer = existing.lastSeen == null ||
          existing.lastSeen!.isBefore(eventTime);
      // kind 15125 is replaceable: different relays may hold different
      // versions. Only adopt info/lastSeen from a STRICTLY NEWER event so a
      // stale copy on one discovery relay can't clobber the current one.
      _records[pubkey] = existing.copyWith(
        info: newer ? info : existing.info,
        lastSeen: newer ? eventTime : existing.lastSeen,
        firstSeenAt: existing.firstSeenAt ?? now,
        manualAdded: existing.manualAdded || manualAdded,
        // Keep known relays; only seed from sources when we have none yet.
        relays: existing.relays.isNotEmpty
            ? existing.relays
            : (fallbackRelays.isNotEmpty ? fallbackRelays : existing.relays),
      );
    }
  }

  /// Fetch the newest NIP-65 relay list for [hex] via NDK's user-relay-list
  /// usecase (which resolves NIP-65/NIP-02 over the configured relays and
  /// caches). Returns the advertised relay URLs, or `null` when none is found
  /// (callers keep the existing/fallback relays in that case).
  Future<List<String>?> _fetchRelayList(String hex) async {
    final list = await ndk.userRelayLists.getSingleUserRelayList(
      hex,
      forceRefresh: true,
    );
    if (list == null) return null;
    final urls = list.urls
        .map(normalizeRelayUrl)
        .where((u) => u.isNotEmpty)
        .toList();
    return urls.isEmpty ? null : urls;
  }

  /// Refresh the relay list for [hex] from its NIP-65 event and store it on the
  /// record. No-op when the coordinator is unknown or publishes no NIP-65 (the
  /// `event.sources` fallback set by [_upsertFromEvent] is left intact).
  Future<void> _refreshRelayList(String hex) async {
    final existing = _records[hex];
    if (existing == null) return;
    final relayList = await _fetchRelayList(hex);
    if (relayList == null) return;
    if (existing.relays.length == relayList.length &&
        existing.relays.toSet().containsAll(relayList)) {
      return;
    }
    _records[hex] = existing.copyWith(relays: relayList);
    _schedulePersist();
    _emit();
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
