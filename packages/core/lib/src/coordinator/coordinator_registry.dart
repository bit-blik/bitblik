import 'dart:async';

import 'package:ndk/ndk.dart';

import '../constants/kinds.dart';
import '../constants/relays.dart';
import '../constants/rpc_methods.dart';
import '../models/coordinator_info.dart';
import '../models/coordinator_record.dart';
import '../models/offer.dart';
import '../protocol/bitblik_rpc_client.dart';
import '../protocol/rpc_envelope.dart';
import 'coordinator_store.dart';

const int _coldStartDefaultEnabledCount = 3;
const int _coldStartCandidatePoolSize = 8;

enum CoordinatorColdStartPhase {
  loadingMuteList,
  discovering,
  loadingProfiles,
  loadingStats,
  checkingHealth,
  finalizing,
  completed,
}

enum CoordinatorColdStartOrigin { onboarding, settings }

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

  /// The project Nostr identity (hex) whose NIP-65 yields the discovery relays
  /// and against which coordinator advertisements are matched. Defaults to
  /// Bitblik; switched per active payment system (e.g. Bitway for MB WAY) via
  /// [setDiscoveryPubkey] so each market discovers its own relays + coordinators.
  String discoveryPubkeyHex;
  String activePaymentSystemId;

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
  final StreamController<CoordinatorColdStartState?> _coldStart =
      StreamController<CoordinatorColdStartState?>.broadcast();

  bool _initialized = false;
  Timer? _saveDebouncer;
  Future<void>? _discoveryInFlight;
  final Set<String> _mutedPubkeys = {};
  CoordinatorColdStartState? _coldStartState;
  bool _coldStartDismissed = false;

  CoordinatorRegistry({
    required this.ndk,
    required this.rpcClient,
    required this.store,
    required this.relays,
    this.discoveryPubkeyHex = kBitblikPubkeyHex,
    this.activePaymentSystemId = 'blik',
    this.probeStaleAfter = const Duration(seconds: 60),
    this.manualAddTimeout = const Duration(seconds: 5),
    this.networkFinishedWindow = const Duration(days: 30),
  }) {
    _bootstrapRelays = List.from(relays);
  }

  Duration get _queryTimeout => rpcClient.timeout + kRelayRequestGrace;

  /// Re-point discovery at a different project identity (hex pubkey), e.g. when
  /// the active payment system changes. No-op when unchanged. The next
  /// [discover] / [refreshDiscoveryRelays] resolves that identity's relays.
  void setDiscoveryPubkey(String hex) {
    if (hex == discoveryPubkeyHex) return;
    discoveryPubkeyHex = hex;
    _mutedPubkeys.clear();
  }

  void setDiscoveryContext({
    required String hex,
    required String paymentSystemId,
  }) {
    activePaymentSystemId = paymentSystemId;
    setDiscoveryPubkey(hex);
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
          authors: [discoveryPubkeyHex],
        ),
        explicitRelays: _bootstrapRelays,
        cacheRead: false,
      );
      await for (final event in response.stream.timeout(
        _queryTimeout,
        onTimeout: (sink) => sink.close(),
      )) {
        if (_normalize(event.pubKey) != _normalize(discoveryPubkeyHex)) {
          continue;
        }
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
    unawaited(() async {
      try {
        await refreshDiscoveryRelays();
        await _refreshMutedPubkeys();
      } catch (_) {
        // Best-effort only. If network is unavailable, fall back to the stored
        // state and let the next discovery refresh apply the hard mute filter.
      }
    }());
  }

  /// Broadcast stream of the sorted record list. Emits the initial state
  /// on subscribe via [all].
  Stream<List<CoordinatorRecord>> get changes => _changes.stream;
  Stream<CoordinatorColdStartState?> get coldStartChanges => _coldStart.stream;
  CoordinatorColdStartState? get coldStartState => _coldStartState;
  void showColdStartState(
    CoordinatorColdStartPhase phase, {
    Set<String> discovered = const {},
    Set<String> candidates = const {},
    Set<String> enabledPubkeys = const {},
    CoordinatorColdStartOrigin origin = CoordinatorColdStartOrigin.onboarding,
  }) => _setColdStartState(
    phase,
    discovered: discovered,
    candidates: candidates,
    enabledPubkeys: enabledPubkeys,
    origin: origin,
  );

  /// All records (enabled and disabled), sorted by [_compare].
  List<CoordinatorRecord> get all => _sorted(
      _records.values
          .where((r) => !_mutedPubkeys.contains(r.pubkeyHex))
          .where((r) => r.paymentSystem == activePaymentSystemId)
          .toList(),
    );

  /// Enabled records only — what the maker flow should show.
  List<CoordinatorRecord> get enabled =>
      all.where((r) => r.enabled).toList(growable: false);

  CoordinatorRecord? recordFor(String pubkey) {
    final hex = _normalize(pubkey);
    if (_mutedPubkeys.contains(hex)) return null;
    return _records[hex];
  }

  CoordinatorInfo? infoFor(String pubkey) => recordFor(pubkey)?.info;

  /// One-shot discovery query. Coalesces concurrent calls.
  Future<void> discover() async {
    if (_discoveryInFlight != null) {
      return _discoveryInFlight!;
    }
    final completer = Completer<void>();
    _discoveryInFlight = completer.future;
    var coldStartStarted = false;
    try {
      final shouldBootstrap =
          !await store.loadBootstrapCompleted(activePaymentSystemId);
      if (shouldBootstrap) {
        coldStartStarted = true;
        _disableActivePaymentSystemRecords();
        _setColdStartState(CoordinatorColdStartPhase.loadingMuteList);
      }
      // Resolve the live discovery relays from Bitblik's profile NIP-65 first,
      // so coordinator lookups target the relays Bitblik currently advertises.
      await refreshDiscoveryRelays();
      await _refreshMutedPubkeys();
      if (shouldBootstrap) {
        _setColdStartState(CoordinatorColdStartPhase.discovering);
      }
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
      await for (final event in response.stream.timeout(
        _queryTimeout,
        onTimeout: (sink) => sink.close(),
      )) {
        final eventPubkey = _normalize(event.pubKey);
        if (_mutedPubkeys.contains(eventPubkey)) continue;
        if (CoordinatorInfo.fromNostrEvent(event).paymentSystem !=
            activePaymentSystemId) {
          continue;
        }
        _upsertFromEvent(event);
        discovered.add(eventPubkey);
        if (shouldBootstrap) {
          _setColdStartState(
            CoordinatorColdStartPhase.discovering,
            discovered: discovered,
          );
        }
      }
      final runBootstrap = discovered.isNotEmpty && shouldBootstrap;
      if (runBootstrap) {
        _applyColdStartDisabledDefaults(discovered);
      }
      _schedulePersist();
      _emit();
      if (runBootstrap) {
        _setColdStartState(
          CoordinatorColdStartPhase.loadingProfiles,
          discovered: discovered,
        );
      }
      // Resolve each coordinator's NIP-65 relays FIRST, then read their kind-0
      // profile from those relays (outbox model) — the canonical, most current
      // source, with discovery relays as fallback.
      await Future.wait(discovered.map(_refreshRelayList));
      await _refreshProfiles(discovered);
      if (runBootstrap) {
        _setColdStartState(
          CoordinatorColdStartPhase.loadingStats,
          discovered: discovered,
        );
        await fetchNetworkFinishedCounts();
        final selection = await _finalizeColdStartDefaults(discovered);
        await store.saveBootstrapCompleted(activePaymentSystemId, true);
        _setColdStartState(
          CoordinatorColdStartPhase.completed,
          discovered: discovered,
          candidates: selection.candidatePubkeys,
          enabledPubkeys: selection.enabledPubkeys,
        );
      }
    } finally {
      if (coldStartStarted &&
          _coldStartState != null &&
          _coldStartState!.phase != CoordinatorColdStartPhase.completed) {
        _clearColdStartState();
      }
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
    await for (final event in response.stream.timeout(
      _queryTimeout,
      onTimeout: (sink) => sink.close(),
    )) {
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
      final displayName = (m.displayName != null && m.displayName!.isNotEmpty)
          ? m.displayName
          : null;
      final name = displayName ??
          ((m.name != null && m.name!.isNotEmpty) ? m.name : null);
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
      if (!r.enabled ||
          r.paymentSystem != activePaymentSystemId ||
          _mutedPubkeys.contains(r.pubkeyHex)) {
        continue;
      }
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
    final hex = _normalize(pubkey);
    if (_mutedPubkeys.contains(hex)) {
      return const [];
    }
    final r = _records[hex];
    if (r != null && r.relays.isNotEmpty) return r.relays;
    return relays.map(normalizeRelayUrl).toList(growable: false);
  }

  /// Probe a single coordinator via `get_info` and update its record.
  Future<void> probeHealth(
    String pubkey, {
    Duration? timeoutOverride,
    bool refreshRelayList = true,
  }) async {
    final hex = _normalize(pubkey);
    if (_records[hex] == null) return;
    // Refresh the NIP-65 relay list before probing so health checks track
    // coordinators that move relays, and the probe goes to current relays.
    if (refreshRelayList) {
      await _refreshRelayList(hex);
    }
    final existing = _records[hex];
    if (existing == null) return;
    final coordRelays = relaysFor(hex);
    try {
      await rpcClient.send(
        const NostrRequest(method: kRpcGetInfo, params: {}),
        hex,
        relays: coordRelays,
        timeoutOverride: timeoutOverride,
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

  /// Fast refresh path for one coordinator details view.
  ///
  /// Refreshes discovery relays, fetches only this coordinator's latest
  /// kind-15125 + NIP-65 from those discovery relays, then runs a `get_info`
  /// health probe using the updated relay set.
  Future<void> refreshCoordinator(
    String pubkey, {
    Duration discoveryTimeout = const Duration(seconds: 3),
    Duration healthTimeout = const Duration(seconds: 3),
  }) async {
    final hex = _normalize(pubkey);
    if (_records[hex] == null || _mutedPubkeys.contains(hex)) return;

    await refreshDiscoveryRelays();

    Nip01Event? newest;
    try {
      final response = ndk.requests.query(
        name: 'coordinator-single-refresh',
        filter: Filter(
          kinds: [kKindCoordinatorInfo],
          authors: [hex],
        ),
        explicitRelays: relays,
        cacheRead: false,
      );
      await for (final event in response.stream.timeout(
        discoveryTimeout,
        onTimeout: (sink) => sink.close(),
      )) {
        if (event.pubKey != hex) continue;
        if (newest == null || event.createdAt > newest.createdAt) {
          newest = event;
        }
      }
    } catch (_) {
      // Best-effort refresh; keep existing record when discovery relays fail.
    }

    if (newest != null) {
      _upsertFromEvent(newest);
      _schedulePersist();
      _emit();
    }

    await _refreshRelayListFromDiscovery(hex, timeout: discoveryTimeout);
    await probeHealth(
      hex,
      timeoutOverride: healthTimeout,
      refreshRelayList: false,
    );
  }

  /// Probe every enabled coordinator whose last probe is older than
  /// [probeStaleAfter] (or never probed). Stale-only by design so calling
  /// on every screen entry stays cheap.
  Future<void> probeAllEnabled() async {
    final now = DateTime.now();
    final due = _records.values
        .where((r) =>
            r.enabled &&
            r.paymentSystem == activePaymentSystemId &&
            !_mutedPubkeys.contains(r.pubkeyHex) &&
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
    if (value && _mutedPubkeys.contains(hex)) return;
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
    if (_mutedPubkeys.contains(hex)) {
      throw ArgumentError('Coordinator is muted by the active discovery list');
    }

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

    final info = CoordinatorInfo.fromNostrEvent(event);
    if (info.paymentSystem != activePaymentSystemId) {
      throw ArgumentError(
        'Coordinator payment system ${info.paymentSystem} does not match active payment system $activePaymentSystemId',
      );
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
  /// within [networkFinishedWindow]. Updates `networkFinishedCount` per
  /// known record.
  ///
  /// Offer events are published to each coordinator's OWN relays (its
  /// NIP-65 set), NOT to the discovery relays — so we query each
  /// coordinator on [relaysFor] its pubkey rather than the discovery set.
  /// Querying discovery relays here badly under-reports (only the few
  /// stray offer events that happen to land there are visible).
  Future<void> fetchNetworkFinishedCounts() async {
    final now = DateTime.now();
    var changed = false;

    // Snapshot pubkeys up front; the per-coordinator awaits below let other
    // code mutate `_records`, so we don't iterate it live.
    for (final pubkey in _records.keys.toList()) {
      final stats = await _fetchFinishedStatsFor(pubkey);
      final r = _records[pubkey];
      if (r == null) continue;
      if (r.networkFinishedCount == stats.count &&
          r.networkDistinctCounterpartyCount ==
              stats.distinctCounterpartyCount &&
          r.networkFinishedVolumeSats == stats.volumeSats) {
        continue;
      }
      _records[pubkey] = r.copyWith(
        networkFinishedCount: stats.count,
        networkDistinctCounterpartyCount: stats.distinctCounterpartyCount,
        networkFinishedVolumeSats: stats.volumeSats,
        lastFinishedCountUpdate: now,
      );
      changed = true;
    }

    if (changed) {
      _schedulePersist();
      _emit();
    }
  }

  /// Count `#s=success` [kKindOffer] events for a single coordinator within
  /// [networkFinishedWindow], querying that coordinator's own relays.
  Future<_FinishedOfferStats> _fetchFinishedStatsFor(String pubkey) async {
    final since =
        DateTime.now().subtract(networkFinishedWindow).millisecondsSinceEpoch ~/
            1000;
    final coordinatorRelays = relaysFor(pubkey);

    // Page size requested from relays. We paginate with an `until` cursor
    // because relays cap how many events a single REQ returns (commonly
    // 100–500). Without pagination the count silently tops out at that cap
    // and badly under-reports coordinators with many finished offers.
    const pageSize = 500;

    // Dedupe across pages by addressable `d` offer id. kKindOffer (38383) is
    // addressable, so each offer maps to one event; the same event can still
    // surface in adjacent pages around the cursor.
    final seen = <String>{};
    final counterpartyCounts = <String, int>{};
    var volumeSats = 0;

    var until = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    while (true) {
      final response = ndk.requests.query(
        name: 'coordinator-network-finished',
        filter: Filter(
          kinds: [kKindOffer],
          authors: [pubkey],
          tags: {
            '#s': ['success'],
          },
          since: since,
          until: until,
          limit: pageSize,
        ),
        explicitRelays: coordinatorRelays,
      );

      var pageCount = 0;
      var oldest = until;
      await for (final event in response.stream.timeout(
        _queryTimeout,
        onTimeout: (sink) => sink.close(),
      )) {
        if (event.pubKey != pubkey) continue;
        pageCount++;
        if (event.createdAt < oldest) oldest = event.createdAt;
        final dTag = event.getDtag() ?? event.id;
        if (!seen.add(dTag)) continue;
        final offer = Offer.fromNostrEvent(event);
        volumeSats += offer.amountSats;
        for (final counterparty in <String?>[
          offer.makerPubkey,
          offer.takerPubkey,
        ]) {
          if (counterparty == null || counterparty.isEmpty) continue;
          final count = counterpartyCounts[counterparty] ?? 0;
          if (count >= 3) continue;
          counterpartyCounts[counterparty] = count + 1;
        }
      }

      // Last page reached when the relay returned fewer than requested.
      if (pageCount < pageSize) break;
      // Advance the cursor just past the oldest event seen. Guard against a
      // stuck cursor (a whole page sharing one timestamp) to avoid looping.
      final nextUntil = oldest - 1;
      if (nextUntil >= until || nextUntil < since) break;
      until = nextUntil;
    }

    return _FinishedOfferStats(
      count: seen.length,
      distinctCounterpartyCount: counterpartyCounts.length,
      volumeSats: volumeSats,
    );
  }

  Future<void> dispose() async {
    _saveDebouncer?.cancel();
    if (!_coldStart.isClosed) {
      await _coldStart.close();
    }
    if (!_changes.isClosed) {
      await _changes.close();
    }
  }

  // --- internals ---

  void _upsertFromEvent(Nip01Event event, {bool manualAdded = false}) {
    final pubkey = _normalize(event.pubKey);
    if (_mutedPubkeys.contains(pubkey)) return;
    final info = CoordinatorInfo.fromNostrEvent(event);
    if (info.paymentSystem != activePaymentSystemId) return;
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
        oldestObservedEventAt: eventTime,
        enabled: false,
        manualAdded: manualAdded,
        relays: fallbackRelays,
        relayListFromNip65: false,
      );
    } else {
      final newer =
          existing.lastSeen == null || existing.lastSeen!.isBefore(eventTime);
      // kind 15125 is replaceable: different relays may hold different
      // versions. Only adopt info/lastSeen from a STRICTLY NEWER event so a
      // stale copy on one discovery relay can't clobber the current one.
      _records[pubkey] = existing.copyWith(
        info: newer ? info : existing.info,
        lastSeen: newer ? eventTime : existing.lastSeen,
        firstSeenAt: existing.firstSeenAt ?? now,
        oldestObservedEventAt: _earliest(
          existing.oldestObservedEventAt,
          eventTime,
        ),
        manualAdded: existing.manualAdded || manualAdded,
        // Keep known relays; only seed from sources when we have none yet.
        relays: existing.relays.isNotEmpty
            ? existing.relays
            : (fallbackRelays.isNotEmpty ? fallbackRelays : existing.relays),
        relayListFromNip65: existing.relayListFromNip65,
      );
    }
  }

  Future<void> _refreshMutedPubkeys() async {
    Nip01Event? newest;
    final muteListRelays = <String>{
      ..._bootstrapRelays.map(normalizeRelayUrl),
      ...relays.map(normalizeRelayUrl),
    }.where((u) => u.isNotEmpty).toList(growable: false);
    try {
      final response = ndk.requests.query(
        name: 'bitblik-mute-list',
        filter: Filter(
          kinds: [Nip51List.kMute],
          authors: [discoveryPubkeyHex],
        ),
        explicitRelays: muteListRelays,
        cacheRead: false,
      );
      await for (final event in response.stream.timeout(
        _queryTimeout,
        onTimeout: (sink) => sink.close(),
      )) {
        if (_normalize(event.pubKey) != _normalize(discoveryPubkeyHex)) {
          continue;
        }
        if (newest == null || event.createdAt > newest.createdAt) {
          newest = event;
        }
      }
    } catch (_) {
      return;
    }

    final nextMuted = <String>{};
    if (newest == null) {
      return;
    }
    for (final tag in newest.tags) {
      if (tag.length >= 2 && tag[0] == 'p') {
        final pubkey = _normalize(tag[1]);
        if (pubkey.isNotEmpty) nextMuted.add(pubkey);
      }
    }

    if (_mutedPubkeys.length == nextMuted.length &&
        _mutedPubkeys.containsAll(nextMuted)) {
      return;
    }

    _mutedPubkeys
      ..clear()
      ..addAll(nextMuted);
    if (_mutedPubkeys.isEmpty) return;
    _records.removeWhere((pubkey, _) => _mutedPubkeys.contains(pubkey));
    _schedulePersist();
    _emit();
  }

  void _applyColdStartDisabledDefaults(Set<String> discovered) {
    final candidates = discovered
        .where((pubkey) => !_mutedPubkeys.contains(pubkey))
        .map((pubkey) => _records[pubkey])
        .whereType<CoordinatorRecord>()
        .toList(growable: false);
    if (candidates.isEmpty) return;
    for (final record in candidates) {
      if (record.enabled) {
        _records[record.pubkeyHex] = record.copyWith(enabled: false);
      }
    }
  }

  void _disableActivePaymentSystemRecords() {
    var changed = false;
    for (final entry in _records.entries.toList()) {
      final record = entry.value;
      if (record.paymentSystem != activePaymentSystemId || !record.enabled) {
        continue;
      }
      _records[entry.key] = record.copyWith(enabled: false);
      changed = true;
    }
    if (changed) {
      _schedulePersist();
      _emit();
    }
  }

  Future<_ColdStartSelection> _finalizeColdStartDefaults(
    Set<String> discovered,
  ) async {
    final candidates = discovered
        .where((pubkey) => !_mutedPubkeys.contains(pubkey))
        .map((pubkey) => _records[pubkey])
        .whereType<CoordinatorRecord>()
        .toList(growable: false);
    if (candidates.isEmpty) {
      return const _ColdStartSelection(
        candidatePubkeys: {},
        enabledPubkeys: {},
      );
    }

    candidates.sort(_compareColdStartAge);
    final candidatePubkeys = candidates
        .take(_coldStartCandidatePoolSize)
        .map((record) => record.pubkeyHex)
        .toList(growable: false);
    _setColdStartState(
      CoordinatorColdStartPhase.checkingHealth,
      discovered: discovered,
      candidates: candidatePubkeys.toSet(),
    );
    await Future.wait(
      candidatePubkeys.map(
        (pubkey) => probeHealth(pubkey, refreshRelayList: false),
      ),
    );

    final refreshedCandidates = candidatePubkeys
        .map((pubkey) => _records[pubkey])
        .whereType<CoordinatorRecord>()
        .toList(growable: false);
    refreshedCandidates.sort(_compareColdStartSelection);
    final enabledPubkeys = refreshedCandidates
        .where((record) => record.responsive == true)
        .take(_coldStartDefaultEnabledCount)
        .map((record) => record.pubkeyHex)
        .toSet();

    if (enabledPubkeys.isEmpty) {
      refreshedCandidates.sort(_compareColdStartAge);
      enabledPubkeys.addAll(
        refreshedCandidates
            .take(_coldStartDefaultEnabledCount)
            .map((record) => record.pubkeyHex),
      );
    }

    _setColdStartState(
      CoordinatorColdStartPhase.finalizing,
      discovered: discovered,
      candidates: candidatePubkeys.toSet(),
      enabledPubkeys: enabledPubkeys,
    );
    for (final record in candidates) {
      _records[record.pubkeyHex] = record.copyWith(
        enabled: enabledPubkeys.contains(record.pubkeyHex),
      );
    }
    await store.save(_records.values.toList());
    _emit();
    return _ColdStartSelection(
      candidatePubkeys: candidatePubkeys.toSet(),
      enabledPubkeys: enabledPubkeys,
    );
  }

  static int _compareColdStartAge(CoordinatorRecord a, CoordinatorRecord b) {
    final aObserved = a.oldestObservedEventAt;
    final bObserved = b.oldestObservedEventAt;
    if (aObserved != null && bObserved != null) {
      final byObserved = aObserved.compareTo(bObserved);
      if (byObserved != 0) return byObserved;
    } else if (aObserved != null) {
      return -1;
    } else if (bObserved != null) {
      return 1;
    }
    final aFirst = a.firstSeenAt;
    final bFirst = b.firstSeenAt;
    if (aFirst != null && bFirst != null) {
      final byFirst = aFirst.compareTo(bFirst);
      if (byFirst != 0) return byFirst;
    }
    return a.pubkeyHex.compareTo(b.pubkeyHex);
  }

  static int _compareColdStartSelection(
    CoordinatorRecord a,
    CoordinatorRecord b,
  ) {
    final aHealthy = a.responsive == true ? 1 : 0;
    final bHealthy = b.responsive == true ? 1 : 0;
    final byHealth = bHealthy.compareTo(aHealthy);
    if (byHealth != 0) return byHealth;
    final byDistinct = b.networkDistinctCounterpartyCount.compareTo(
      a.networkDistinctCounterpartyCount,
    );
    if (byDistinct != 0) return byDistinct;
    final byVolume = b.networkFinishedVolumeSats.compareTo(
      a.networkFinishedVolumeSats,
    );
    if (byVolume != 0) return byVolume;
    final byCount = b.networkFinishedCount.compareTo(a.networkFinishedCount);
    if (byCount != 0) return byCount;
    return _compareColdStartAge(a, b);
  }

  /// Fetch newest NIP-65 relay list for [hex] via NDK user-relay-list
  /// resolution. Returns advertised relay URLs, or `null` when none is found.
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

  /// Refresh [hex] relay list from coordinator's own NIP-65 publication.
  /// Keeps existing/fallback relays when no NIP-65 list is found.
  Future<void> _refreshRelayList(String hex) async {
    final existing = _records[hex];
    if (existing == null) return;
    final relayList = await _fetchRelayList(hex);
    if (relayList == null) return;
    final sameRelays = existing.relays.length == relayList.length &&
        existing.relays.toSet().containsAll(relayList);
    if (sameRelays && existing.relayListFromNip65) {
      return;
    }
    _records[hex] = existing.copyWith(
      relays: relayList,
      relayListFromNip65: true,
    );
    _schedulePersist();
    _emit();
  }

  /// Refresh [hex] relay list from its NIP-65 event found on discovery relays.
  ///
  /// This avoids full user-relay-list resolution when details screen requests a
  /// fast, single-coordinator refresh.
  Future<void> _refreshRelayListFromDiscovery(
    String hex, {
    Duration timeout = const Duration(seconds: 3),
  }) async {
    final existing = _records[hex];
    if (existing == null) return;

    Nip01Event? newest;
    try {
      final response = ndk.requests.query(
        name: 'coordinator-single-nip65',
        filter: Filter(
          kinds: [kKindRelayList],
          authors: [hex],
        ),
        explicitRelays: relays,
        cacheRead: false,
      );
      await for (final event in response.stream.timeout(
        timeout,
        onTimeout: (sink) => sink.close(),
      )) {
        if (event.pubKey != hex) continue;
        if (newest == null || event.createdAt > newest.createdAt) {
          newest = event;
        }
      }
    } catch (_) {
      return;
    }

    if (newest == null) return;

    final relayList = <String>{};
    for (final tag in newest.tags) {
      if (tag.length >= 2 && tag[0] == 'r') {
        final url = normalizeRelayUrl(tag[1]);
        if (url.isNotEmpty) relayList.add(url);
      }
    }
    if (relayList.isEmpty) return;

    final next = relayList.toList(growable: false);
    final sameRelays = existing.relays.length == next.length &&
        existing.relays.toSet().containsAll(next);
    if (sameRelays && existing.relayListFromNip65) {
      return;
    }

    _records[hex] = existing.copyWith(
      relays: next,
      relayListFromNip65: true,
    );
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
        return Nip19.decode(trimmed).toLowerCase();
      } catch (_) {
        return trimmed.toLowerCase();
      }
    }
    return trimmed.toLowerCase();
  }

  static DateTime? _earliest(DateTime? a, DateTime? b) {
    if (a == null) return b;
    if (b == null) return a;
    return a.isBefore(b) ? a : b;
  }

  void _setColdStartState(
    CoordinatorColdStartPhase phase, {
    Set<String> discovered = const {},
    Set<String> candidates = const {},
    Set<String> enabledPubkeys = const {},
    CoordinatorColdStartOrigin origin = CoordinatorColdStartOrigin.onboarding,
  }) {
    if (phase == CoordinatorColdStartPhase.loadingMuteList) {
      _coldStartDismissed = false;
    }
    if (_coldStartDismissed) {
      return;
    }
    final records = _sorted(
      _records.values
          .where((r) => !_mutedPubkeys.contains(r.pubkeyHex))
          .where((r) => r.paymentSystem == activePaymentSystemId)
          .toList(growable: false),
    );
    _coldStartState = CoordinatorColdStartState(
      origin: origin,
      phase: phase,
      discoveredCount: discovered.length,
      candidateCount: candidates.length,
      enabledCount: enabledPubkeys.length,
      records: records
          .take(8)
          .map(
            (record) => CoordinatorColdStartRecord(
              pubkeyHex: record.pubkeyHex,
              name: record.name,
              responsive: record.responsive,
              enabled: record.enabled || enabledPubkeys.contains(record.pubkeyHex),
              candidate: candidates.contains(record.pubkeyHex),
            ),
          )
          .toList(growable: false),
    );
    if (!_coldStart.isClosed) {
      _coldStart.add(_coldStartState);
    }
  }

  void _clearColdStartState() {
    _coldStartState = null;
    if (!_coldStart.isClosed) {
      _coldStart.add(null);
    }
  }

  void dismissColdStartState() {
    _coldStartDismissed = true;
    _clearColdStartState();
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

class _FinishedOfferStats {
  final int count;
  final int distinctCounterpartyCount;
  final int volumeSats;

  const _FinishedOfferStats({
    required this.count,
    required this.distinctCounterpartyCount,
    required this.volumeSats,
  });
}

class _ColdStartSelection {
  final Set<String> candidatePubkeys;
  final Set<String> enabledPubkeys;

  const _ColdStartSelection({
    required this.candidatePubkeys,
    required this.enabledPubkeys,
  });
}

class CoordinatorColdStartState {
  final CoordinatorColdStartOrigin origin;
  final CoordinatorColdStartPhase phase;
  final int discoveredCount;
  final int candidateCount;
  final int enabledCount;
  final List<CoordinatorColdStartRecord> records;

  const CoordinatorColdStartState({
    required this.origin,
    required this.phase,
    required this.discoveredCount,
    required this.candidateCount,
    required this.enabledCount,
    required this.records,
  });
}

class CoordinatorColdStartRecord {
  final String pubkeyHex;
  final String name;
  final bool? responsive;
  final bool enabled;
  final bool candidate;

  const CoordinatorColdStartRecord({
    required this.pubkeyHex,
    required this.name,
    required this.responsive,
    required this.enabled,
    required this.candidate,
  });
}
