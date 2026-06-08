import 'package:meta/meta.dart';
import 'package:ndk/ndk.dart';

@immutable
class CoordinatorInfo {
  final String name;
  final int reservationSeconds;
  final double makerFee;
  final double takerFee;
  final int minAmountSats;
  final int maxAmountSats;

  /// Seconds after a hold invoice is created (offer.createdAt) before the
  /// coordinator auto-confirms a `takerCharged` offer and pays the taker.
  /// Configured server-side via `TAKER_CHARGED_AUTO_CONFIRM_SECONDS`. Default
  /// `3600` keeps older coordinators that don't advertise it consistent.
  final int takerChargedAutoConfirmSeconds;

  /// Maximum maker premium (%) this coordinator allows above market price.
  /// `0` means the premium feature is disabled for this coordinator.
  final double maxPremiumPercent;
  final List<String> currencies;
  final String? nostrNpub;
  final String? version;
  final String? icon;
  final String? termsOfUsageNaddr;

  const CoordinatorInfo({
    required this.name,
    required this.reservationSeconds,
    required this.makerFee,
    required this.takerFee,
    required this.minAmountSats,
    required this.maxAmountSats,
    this.takerChargedAutoConfirmSeconds = 3600,
    this.maxPremiumPercent = 0,
    required this.currencies,
    required this.nostrNpub,
    this.version,
    this.icon,
    this.termsOfUsageNaddr,
  });

  factory CoordinatorInfo.fromJson(Map<String, dynamic> json) {
    return CoordinatorInfo(
      name: json['name'] as String,
      reservationSeconds: json['reservation_seconds'] as int,
      makerFee: (json['maker_fee'] as num).toDouble(),
      takerFee: (json['taker_fee'] as num).toDouble(),
      minAmountSats: json['min_amount_sats'] as int,
      maxAmountSats: json['max_amount_sats'] as int,
      takerChargedAutoConfirmSeconds:
          (json['taker_charged_auto_confirm_seconds'] as num?)?.toInt() ?? 3600,
      maxPremiumPercent:
          (json['max_premium_percent'] as num?)?.toDouble() ?? 0,
      currencies: (json['currencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      nostrNpub: json['nostr_npub'] as String?,
      version: json['version'] as String?,
      icon: json['icon'] as String?,
      termsOfUsageNaddr: json['terms_of_usage_naddr'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'reservation_seconds': reservationSeconds,
      'maker_fee': makerFee,
      'taker_fee': takerFee,
      'min_amount_sats': minAmountSats,
      'max_amount_sats': maxAmountSats,
      'taker_charged_auto_confirm_seconds': takerChargedAutoConfirmSeconds,
      'max_premium_percent': maxPremiumPercent,
      'currencies': currencies,
      'nostr_npub': nostrNpub,
      if (version != null) 'version': version,
      if (icon != null) 'icon': icon,
      if (termsOfUsageNaddr != null) 'terms_of_usage_naddr': termsOfUsageNaddr,
    };
  }

  /// Parse a kind [kKindCoordinatorInfo] Nostr event into a [CoordinatorInfo].
  ///
  /// `nostrNpub` is derived from the event author. Missing tags fall back to
  /// safe defaults to keep discovery resilient against partial publishers.
  factory CoordinatorInfo.fromNostrEvent(Nip01Event event) {
    final tags = <String, String>{};
    for (final tag in event.tags) {
      if (tag.length >= 2) tags[tag[0]] = tag[1];
    }

    return CoordinatorInfo(
      name: tags['name'] ?? 'Unknown Coordinator',
      icon: _emptyToNull(tags['icon']),
      minAmountSats: int.tryParse(tags['min_amount_sats'] ?? '0') ?? 0,
      maxAmountSats: int.tryParse(tags['max_amount_sats'] ?? '0') ?? 0,
      takerChargedAutoConfirmSeconds:
          int.tryParse(tags['taker_charged_auto_confirm_seconds'] ?? '') ??
              3600,
      maxPremiumPercent:
          double.tryParse(tags['max_premium_percent'] ?? '0') ?? 0.0,
      makerFee: double.tryParse(tags['maker_fee'] ?? '0') ?? 0.0,
      takerFee: double.tryParse(tags['taker_fee'] ?? '0') ?? 0.0,
      reservationSeconds:
          int.tryParse(tags['reservation_seconds'] ?? '0') ?? 0,
      currencies: (tags['currencies'] ?? '')
          .split(',')
          .map((c) => c.trim())
          .where((c) => c.isNotEmpty)
          .toList(),
      version: _emptyToNull(tags['version']),
      nostrNpub: Nip19.encodePubKey(event.pubKey),
      termsOfUsageNaddr: _emptyToNull(tags['terms_of_usage_naddr']),
    );
  }

  /// Serialize as Nostr tag rows for a kind [kKindCoordinatorInfo] event.
  ///
  /// Round-trips with [CoordinatorInfo.fromNostrEvent]. Empty strings are
  /// emitted for absent optional fields to preserve the historical wire
  /// format produced by the coordinator.
  List<List<String>> toNostrTags() {
    return [
      ['name', name],
      ['icon', icon ?? ''],
      ['min_amount_sats', minAmountSats.toString()],
      ['max_amount_sats', maxAmountSats.toString()],
      [
        'taker_charged_auto_confirm_seconds',
        takerChargedAutoConfirmSeconds.toString()
      ],
      ['max_premium_percent', maxPremiumPercent.toString()],
      ['maker_fee', makerFee.toString()],
      ['taker_fee', takerFee.toString()],
      ['reservation_seconds', reservationSeconds.toString()],
      ['currencies', currencies.join(',')],
      ['version', version ?? ''],
      ['terms_of_usage_naddr', termsOfUsageNaddr ?? ''],
    ];
  }

  static String? _emptyToNull(String? v) =>
      v == null || v.isEmpty ? null : v;
}
