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

  /// User-visible flag. False = user has disabled this coordinator.
  /// New records default to true.
  final bool enabled;

  /// True if the user explicitly added this coordinator (via the
  /// "add custom" flow). Drives the management screen's delete button.
  final bool manualAdded;

  /// null = never probed, true = last probe succeeded, false = last probe failed.
  final bool? responsive;
  final DateTime? lastHealthCheck;
  final int successfulProbes;
  final int failedProbes;

  /// Count of successful (`#s=success`) public offers signed by this
  /// coordinator within the last `networkFinishedWindow` (see [CoordinatorRegistry]).
  final int networkFinishedCount;

  /// Count of this user's own finished offers attributed to this coordinator.
  /// Currently optional/auxiliary — populated when the maker history flow runs.
  final int localFinishedCount;
  final DateTime? lastFinishedCountUpdate;

  const CoordinatorRecord({
    required this.pubkeyHex,
    this.info,
    this.lastSeen,
    this.firstSeenAt,
    this.enabled = true,
    this.manualAdded = false,
    this.responsive,
    this.lastHealthCheck,
    this.successfulProbes = 0,
    this.failedProbes = 0,
    this.networkFinishedCount = 0,
    this.localFinishedCount = 0,
    this.lastFinishedCountUpdate,
  });

  // Convenience accessors for UI code — fall back to safe defaults when
  // `info` is absent (e.g. for migrated legacy entries pending re-discovery).
  String get pubkey => pubkeyHex;
  String get name => info?.name ?? pubkeyHex;
  String? get icon => info?.icon;
  int get minAmountSats => info?.minAmountSats ?? 0;
  int get maxAmountSats => info?.maxAmountSats ?? 0;
  double get makerFee => info?.makerFee ?? 0.0;
  double get takerFee => info?.takerFee ?? 0.0;
  int get reservationSeconds => info?.reservationSeconds ?? 0;
  List<String> get currencies => info?.currencies ?? const [];
  String get version => info?.version ?? '';
  String? get termsOfUsageNaddr => info?.termsOfUsageNaddr;

  CoordinatorInfo? toCoordinatorInfo() => info;

  /// Composite reliability score (higher = better).
  ///
  /// responsive tier dominates; within tier we mix global usage,
  /// personal usage, and probe success ratio. Tuned for Phase 1; weights
  /// expected to evolve.
  double get score {
    final responsiveTier = responsive == true ? 1000.0 : 0.0;
    final personal = math.min(localFinishedCount, 50) * 20.0;
    final global = math.log(networkFinishedCount + 1) * 5.0;
    final totalProbes = successfulProbes + failedProbes;
    final ratio = totalProbes == 0 ? 0.5 : successfulProbes / totalProbes;
    final probeScore = ratio * 10.0;
    return responsiveTier + personal + global + probeScore;
  }

  CoordinatorRecord copyWith({
    CoordinatorInfo? info,
    DateTime? lastSeen,
    DateTime? firstSeenAt,
    bool? enabled,
    bool? manualAdded,
    Object? responsive = _sentinel,
    DateTime? lastHealthCheck,
    int? successfulProbes,
    int? failedProbes,
    int? networkFinishedCount,
    int? localFinishedCount,
    DateTime? lastFinishedCountUpdate,
  }) {
    return CoordinatorRecord(
      pubkeyHex: pubkeyHex,
      info: info ?? this.info,
      lastSeen: lastSeen ?? this.lastSeen,
      firstSeenAt: firstSeenAt ?? this.firstSeenAt,
      enabled: enabled ?? this.enabled,
      manualAdded: manualAdded ?? this.manualAdded,
      responsive: identical(responsive, _sentinel)
          ? this.responsive
          : responsive as bool?,
      lastHealthCheck: lastHealthCheck ?? this.lastHealthCheck,
      successfulProbes: successfulProbes ?? this.successfulProbes,
      failedProbes: failedProbes ?? this.failedProbes,
      networkFinishedCount: networkFinishedCount ?? this.networkFinishedCount,
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
        'enabled': enabled,
        'manual_added': manualAdded,
        if (responsive != null) 'responsive': responsive,
        if (lastHealthCheck != null)
          'last_health_check': lastHealthCheck!.toIso8601String(),
        'successful_probes': successfulProbes,
        'failed_probes': failedProbes,
        'network_finished_count': networkFinishedCount,
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
      enabled: json['enabled'] as bool? ?? true,
      manualAdded: json['manual_added'] as bool? ?? false,
      responsive: json['responsive'] as bool?,
      lastHealthCheck: parseDt(json['last_health_check']),
      successfulProbes: (json['successful_probes'] as num?)?.toInt() ?? 0,
      failedProbes: (json['failed_probes'] as num?)?.toInt() ?? 0,
      networkFinishedCount:
          (json['network_finished_count'] as num?)?.toInt() ?? 0,
      localFinishedCount:
          (json['local_finished_count'] as num?)?.toInt() ?? 0,
      lastFinishedCountUpdate: parseDt(json['last_finished_count_update']),
    );
  }
}

const Object _sentinel = Object();
