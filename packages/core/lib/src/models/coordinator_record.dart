import 'dart:math' as math;

import 'package:meta/meta.dart';

import 'coordinator_info.dart';

/// Persisted, in-memory view of a single coordinator.
///
/// Replaces the per-package `DiscoveredCoordinator` (app) and
/// `CoordinatorListItem` (cli). Encapsulates discovery metadata, the
/// user's enable/disable choice, health-probe history, and reliability
/// counters used for ranking.
@immutable
class CoordinatorRecord {
  final String pubkeyHex;
  final CoordinatorInfo? info;
  final DateTime? lastSeen;
  final DateTime? firstSeenAt;
  final DateTime? oldestObservedEventAt;

  /// User-visible flag. False = user has disabled this coordinator.
  /// New records default to true.
  final bool enabled;

  /// True if the user explicitly added this coordinator (via the
  /// "add custom" flow). Drives the management screen's delete button.
  final bool manualAdded;

  /// Relays this coordinator actively uses, from its NIP-65 (kind
  /// [kKindRelayList]) event. Falls back to the discovery relays the
  /// coordinator's info event was seen on when no NIP-65 is published. Empty
  /// only until discovery has run. All per-coordinator communication (RPC,
  /// offers, status) is routed to these.
  final List<String> relays;

  /// True when [relays] were resolved from coordinator's own NIP-65 relay
  /// list. False means [relays] currently come from fallback sources (for
  /// example discovery relay `event.sources`).
  final bool relayListFromNip65;

  /// DEBUG-ONLY: raw relays that actually served this coordinator's
  /// kind-15125 info event on the most recent live query (from
  /// `Nip01Event.sources`). Empty when the record was hydrated from disk
  /// without a live re-fetch. Surfaced in the details screen under
  /// `kDebugMode` to diagnose where a 15125 is coming from.
  final List<String> discoverySources;

  /// Display name/picture from the coordinator's kind-0 profile metadata event,
  /// when published. Preferred over the kind-15125 info `name`/`icon`.
  final String? profileName;
  final String? profilePicture;

  /// null = never probed, true = last probe succeeded, false = last probe failed.
  final bool? responsive;
  final DateTime? lastHealthCheck;
  final int successfulProbes;
  final int failedProbes;

  /// Count of successful (`#s=success`) public offers signed by this
  /// coordinator within the last `networkFinishedWindow` (see [CoordinatorRegistry]).
  final int networkFinishedCount;
  final int networkDistinctCounterpartyCount;
  final int networkFinishedVolumeSats;

  /// Count of this user's own finished offers attributed to this coordinator.
  /// Currently optional/auxiliary — populated when the maker history flow runs.
  final int localFinishedCount;
  final DateTime? lastFinishedCountUpdate;

  const CoordinatorRecord({
    required this.pubkeyHex,
    this.info,
    this.lastSeen,
    this.firstSeenAt,
    this.oldestObservedEventAt,
    this.enabled = true,
    this.manualAdded = false,
    this.relays = const [],
    this.relayListFromNip65 = false,
    this.discoverySources = const [],
    this.profileName,
    this.profilePicture,
    this.responsive,
    this.lastHealthCheck,
    this.successfulProbes = 0,
    this.failedProbes = 0,
    this.networkFinishedCount = 0,
    this.networkDistinctCounterpartyCount = 0,
    this.networkFinishedVolumeSats = 0,
    this.localFinishedCount = 0,
    this.lastFinishedCountUpdate,
  });

  // Convenience accessors for UI code — fall back to safe defaults when
  // `info` is absent (e.g. for migrated legacy entries pending re-discovery).
  String get pubkey => pubkeyHex;
  String get name => profileName ?? info?.name ?? pubkeyHex;
  String? get icon => profilePicture ?? info?.icon;
  int get minAmountSats => info?.minAmountSats ?? 0;
  int get maxAmountSats => info?.maxAmountSats ?? 0;
  double get makerFee => info?.makerFee ?? 0.0;
  double get takerFee => info?.takerFee ?? 0.0;
  double get maxPremium => info?.maxPremiumPercent ?? 0.0;
  int get reservationSeconds => info?.reservationSeconds ?? 0;
  List<String> get currencies => info?.currencies ?? const [];
  String? get paymentSystem => info?.paymentSystem;
  String get version => info?.version ?? '';
  String? get termsOfUsageNaddr => info?.termsOfUsageNaddr;
  Map<String, String> get channelLinks => info?.channelLinks ?? const {};

  /// True once this coordinator's relay set is known (NIP-65 or fallback).
  bool get hasRelays => relays.isNotEmpty;

  CoordinatorInfo? toCoordinatorInfo() => info;

  /// Composite reliability score (higher = better).
  ///
  /// responsive tier dominates; within tier we mix personal usage, network
  /// success breadth/value, observed tenure, and probe success ratio.
  double get score {
    final responsiveTier = responsive == true ? 1000.0 : 0.0;
    final personal = math.min(localFinishedCount, 50) * 20.0;
    final breadth = math.min(networkDistinctCounterpartyCount, 100) * 4.0;
    final volume = math.log((networkFinishedVolumeSats / 1000) + 1) * 6.0;
    final totalProbes = successfulProbes + failedProbes;
    final ratio = totalProbes == 0 ? 0.5 : successfulProbes / totalProbes;
    final probeScore = ratio * 10.0;
    final observedAgeDays = oldestObservedEventAt == null
        ? 0
        : DateTime.now().difference(oldestObservedEventAt!).inDays;
    final ageScore = math.min(observedAgeDays, 365) * 0.05;
    return responsiveTier + personal + breadth + volume + probeScore + ageScore;
  }

  CoordinatorRecord copyWith({
    CoordinatorInfo? info,
    DateTime? lastSeen,
    DateTime? firstSeenAt,
    DateTime? oldestObservedEventAt,
    bool? enabled,
    bool? manualAdded,
    List<String>? relays,
    bool? relayListFromNip65,
    List<String>? discoverySources,
    String? profileName,
    String? profilePicture,
    Object? responsive = _sentinel,
    DateTime? lastHealthCheck,
    int? successfulProbes,
    int? failedProbes,
    int? networkFinishedCount,
    int? networkDistinctCounterpartyCount,
    int? networkFinishedVolumeSats,
    int? localFinishedCount,
    DateTime? lastFinishedCountUpdate,
  }) {
    return CoordinatorRecord(
      pubkeyHex: pubkeyHex,
      info: info ?? this.info,
      lastSeen: lastSeen ?? this.lastSeen,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      oldestObservedEventAt: oldestObservedEventAt ?? this.oldestObservedEventAt,
      enabled: enabled ?? this.enabled,
      manualAdded: manualAdded ?? this.manualAdded,
      relays: relays ?? this.relays,
      relayListFromNip65: relayListFromNip65 ?? this.relayListFromNip65,
      discoverySources: discoverySources ?? this.discoverySources,
      profileName: profileName ?? this.profileName,
      profilePicture: profilePicture ?? this.profilePicture,
      responsive: identical(responsive, _sentinel)
          ? this.responsive
          : responsive as bool?,
      lastHealthCheck: lastHealthCheck ?? this.lastHealthCheck,
      successfulProbes: successfulProbes ?? this.successfulProbes,
      failedProbes: failedProbes ?? this.failedProbes,
      networkFinishedCount: networkFinishedCount ?? this.networkFinishedCount,
      networkDistinctCounterpartyCount:
          networkDistinctCounterpartyCount ?? this.networkDistinctCounterpartyCount,
      networkFinishedVolumeSats:
          networkFinishedVolumeSats ?? this.networkFinishedVolumeSats,
      localFinishedCount: localFinishedCount ?? this.localFinishedCount,
      lastFinishedCountUpdate:
          lastFinishedCountUpdate ?? this.lastFinishedCountUpdate,
    );
  }

  Map<String, dynamic> toJson() => {
        'pubkey_hex': pubkeyHex,
        if (info != null) 'info': info!.toJson(),
        if (lastSeen != null) 'last_seen': lastSeen!.toIso8601String(),
        if (firstSeenAt != null) 'first_seen_at': firstSeenAt!.toIso8601String(),
        if (oldestObservedEventAt != null)
          'oldest_observed_event_at': oldestObservedEventAt!.toIso8601String(),
        'enabled': enabled,
        'manual_added': manualAdded,
        if (relays.isNotEmpty) 'relays': relays,
        if (relayListFromNip65) 'relay_list_from_nip65': relayListFromNip65,
        if (discoverySources.isNotEmpty)
          'discovery_sources_debug': discoverySources,
        if (profileName != null) 'profile_name': profileName,
        if (profilePicture != null) 'profile_picture': profilePicture,
        if (responsive != null) 'responsive': responsive,
        if (lastHealthCheck != null)
          'last_health_check': lastHealthCheck!.toIso8601String(),
        'successful_probes': successfulProbes,
        'failed_probes': failedProbes,
        'network_finished_count': networkFinishedCount,
        'network_distinct_counterparty_count': networkDistinctCounterpartyCount,
        'network_finished_volume_sats': networkFinishedVolumeSats,
        'local_finished_count': localFinishedCount,
        if (lastFinishedCountUpdate != null)
          'last_finished_count_update':
              lastFinishedCountUpdate!.toIso8601String(),
      };

  factory CoordinatorRecord.fromJson(Map<String, dynamic> json) {
    DateTime? parseDt(Object? v) {
      if (v is String && v.isNotEmpty) {
        return DateTime.tryParse(v);
      }
      return null;
    }

    return CoordinatorRecord(
      pubkeyHex: json['pubkey_hex'] as String,
      info: json['info'] is Map<String, dynamic>
          ? CoordinatorInfo.fromJson(json['info'] as Map<String, dynamic>)
          : null,
      lastSeen: parseDt(json['last_seen']),
      firstSeenAt: parseDt(json['first_seen_at']),
      oldestObservedEventAt: parseDt(json['oldest_observed_event_at']),
      enabled: json['enabled'] as bool? ?? true,
      manualAdded: json['manual_added'] as bool? ?? false,
      relays: (json['relays'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      relayListFromNip65: json['relay_list_from_nip65'] as bool? ?? false,
      discoverySources: (json['discovery_sources_debug'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      profileName: json['profile_name'] as String?,
      profilePicture: json['profile_picture'] as String?,
      responsive: json['responsive'] as bool?,
      lastHealthCheck: parseDt(json['last_health_check']),
      successfulProbes: (json['successful_probes'] as num?)?.toInt() ?? 0,
      failedProbes: (json['failed_probes'] as num?)?.toInt() ?? 0,
      networkFinishedCount:
          (json['network_finished_count'] as num?)?.toInt() ?? 0,
      networkDistinctCounterpartyCount:
          (json['network_distinct_counterparty_count'] as num?)?.toInt() ?? 0,
      networkFinishedVolumeSats:
          (json['network_finished_volume_sats'] as num?)?.toInt() ?? 0,
      localFinishedCount:
          (json['local_finished_count'] as num?)?.toInt() ?? 0,
      lastFinishedCountUpdate: parseDt(json['last_finished_count_update']),
    );
  }
}

const Object _sentinel = Object();
