import 'package:meta/meta.dart';
import 'package:ndk/ndk.dart';

import '../payment/payment_system.dart';

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
  final List<String> outgoingPaymentTypes;

  /// The market id this coordinator serves (e.g. `blik`, `mbway`, `sk`). One
  /// deployment = one market. Older coordinators that don't advertise it fall
  /// back to the method derived from [currencies].
  final String paymentSystem;

  /// The bank ids this coordinator serves within a bank-scoped market (SK ATM:
  /// a subset of `tatrabanka`, `slsp`, `vub`). Empty for bank-agnostic markets
  /// or when the coordinator serves all of the market's banks.
  final List<String> banks;

  final String? nostrNpub;
  final String? version;
  final String? icon;
  final String? termsOfUsageNaddr;

  /// Community/notification channel links this coordinator advertises, keyed by
  /// messenger id (`telegram`, `matrix`, `simplex`, `signal`, ...). Empty when
  /// the coordinator doesn't advertise any; the app then falls back to its
  /// bundled defaults for the payment system.
  final Map<String, String> channelLinks;

  /// Bank-scoped community/notification channel links, `bankId → (messenger →
  /// url)`. Lets takers subscribe only to the banks they hold. Falls back to
  /// [channelLinks] (market-wide) for any bank/messenger not listed here — see
  /// [channelLink]. Empty for bank-agnostic markets.
  final Map<String, Map<String, String>> bankChannelLinks;

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
    this.outgoingPaymentTypes = const ['bolt11'],
    required this.paymentSystem,
    required this.nostrNpub,
    this.banks = const [],
    this.version,
    this.icon,
    this.termsOfUsageNaddr,
    this.channelLinks = const {},
    this.bankChannelLinks = const {},
  });

  /// The channel link for [messenger], preferring the [bankId]-scoped link when
  /// one is advertised, else the market-wide [channelLinks] entry, else null.
  String? channelLink(String messenger, {String? bankId}) {
    if (bankId != null) {
      final scoped = bankChannelLinks[bankId]?[messenger];
      if (scoped != null && scoped.isNotEmpty) return scoped;
    }
    final wide = channelLinks[messenger];
    return (wide != null && wide.isNotEmpty) ? wide : null;
  }

  /// Known messenger ids advertised via group links, in display order.
  static const List<String> messengerIds = [
    'telegram',
    'matrix',
    'simplex',
    'signal',
  ];

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
      maxPremiumPercent: (json['max_premium_percent'] as num?)?.toDouble() ?? 0,
      currencies: (json['currencies'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      outgoingPaymentTypes: (json['outgoing_payment_types'] as List?)
              ?.whereType<String>()
              .toList() ??
          const ['bolt11'],
      paymentSystem: (json['payment_system'] as String?) ??
          _defaultMethodId(json['currencies']),
      banks: _parseBanks(json['banks']),
      nostrNpub: json['nostr_npub'] as String?,
      version: json['version'] as String?,
      icon: json['icon'] as String?,
      termsOfUsageNaddr: json['terms_of_usage_naddr'] as String?,
      channelLinks: _parseChannelLinks(json['channel_links']),
      bankChannelLinks: _parseBankChannelLinks(json['bank_channel_links']),
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
      'outgoing_payment_types': outgoingPaymentTypes,
      'payment_system': paymentSystem,
      if (banks.isNotEmpty) 'banks': banks,
      'nostr_npub': nostrNpub,
      if (version != null) 'version': version,
      if (icon != null) 'icon': icon,
      if (termsOfUsageNaddr != null) 'terms_of_usage_naddr': termsOfUsageNaddr,
      if (channelLinks.isNotEmpty) 'channel_links': channelLinks,
      if (bankChannelLinks.isNotEmpty) 'bank_channel_links': bankChannelLinks,
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

    final currencies = (tags['currencies'] ?? '')
        .split(',')
        .map((c) => c.trim())
        .where((c) => c.isNotEmpty)
        .toList();

    final banks = (tags['banks'] ?? '')
        .split(',')
        .map((b) => b.trim())
        .where((b) => b.isNotEmpty)
        .toList();

    // Bank-scoped channel links ride suffixed tags:
    // `<messenger>_channel_link_<bankId>`. Split on the marker so the market-
    // wide `<messenger>_channel_link` tags (no suffix) are left to the block
    // below. Older parsers match only `endsWith('_channel_link')` and ignore
    // these, preserving forward compatibility.
    const marker = '_channel_link_';
    final bankChannelLinks = <String, Map<String, String>>{};
    for (final entry in tags.entries) {
      final idx = entry.key.indexOf(marker);
      if (idx <= 0 || entry.value.isEmpty) continue;
      final messenger = entry.key.substring(0, idx);
      final bankId = entry.key.substring(idx + marker.length);
      if (messenger.isEmpty || bankId.isEmpty) continue;
      (bankChannelLinks[bankId] ??= <String, String>{})[messenger] =
          entry.value;
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
      reservationSeconds: int.tryParse(tags['reservation_seconds'] ?? '0') ?? 0,
      currencies: currencies,
      outgoingPaymentTypes: (tags['outgoing_payment_types'] ?? 'bolt11')
          .split(',')
          .map((value) => value.trim())
          .where((value) => value.isNotEmpty)
          .toList(),
      paymentSystem:
          _emptyToNull(tags['payment_system']) ?? _defaultMethodId(currencies),
      banks: banks,
      version: _emptyToNull(tags['version']),
      nostrNpub: Nip19.encodePubKey(event.pubKey),
      termsOfUsageNaddr: _emptyToNull(tags['terms_of_usage_naddr']),
      channelLinks: {
        for (final entry in tags.entries)
          if (entry.key.endsWith('_channel_link') && entry.value.isNotEmpty)
            entry.key.substring(0, entry.key.length - '_channel_link'.length):
                entry.value,
      },
      bankChannelLinks: bankChannelLinks,
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
      ['outgoing_payment_types', outgoingPaymentTypes.join(',')],
      ['payment_system', paymentSystem],
      if (banks.isNotEmpty) ['banks', banks.join(',')],
      ['version', version ?? ''],
      ['terms_of_usage_naddr', termsOfUsageNaddr ?? ''],
      for (final entry in channelLinks.entries)
        if (entry.value.isNotEmpty) ['${entry.key}_channel_link', entry.value],
      for (final bank in bankChannelLinks.entries)
        for (final link in bank.value.entries)
          if (link.value.isNotEmpty)
            ['${link.key}_channel_link_${bank.key}', link.value],
    ];
  }

  /// Parse the RPC `channel_links` JSON value into a sanitized string map.
  static Map<String, String> _parseChannelLinks(dynamic raw) {
    if (raw is! Map) return const {};
    final out = <String, String>{};
    raw.forEach((k, v) {
      if (k is String && v is String && v.isNotEmpty) out[k] = v;
    });
    return out;
  }

  /// Parse the RPC `banks` value (JSON list or comma string) into a clean list.
  static List<String> _parseBanks(dynamic raw) {
    if (raw is List) {
      return [
        for (final b in raw)
          if (b is String && b.trim().isNotEmpty) b.trim(),
      ];
    }
    if (raw is String) {
      return raw
          .split(',')
          .map((b) => b.trim())
          .where((b) => b.isNotEmpty)
          .toList();
    }
    return const [];
  }

  /// Parse the RPC `bank_channel_links` nested value into `bankId → (messenger
  /// → url)`, dropping empty entries.
  static Map<String, Map<String, String>> _parseBankChannelLinks(dynamic raw) {
    if (raw is! Map) return const {};
    final out = <String, Map<String, String>>{};
    raw.forEach((bankId, links) {
      if (bankId is! String || bankId.isEmpty) return;
      final parsed = _parseChannelLinks(links);
      if (parsed.isNotEmpty) out[bankId] = parsed;
    });
    return out;
  }

  static String? _emptyToNull(String? v) => v == null || v.isEmpty ? null : v;

  /// Derive a payment method id from a legacy `currencies` value when a
  /// coordinator doesn't advertise `payment_system`. Falls back to [kBlik].
  static String _defaultMethodId(dynamic currencies) {
    if (currencies is List && currencies.isNotEmpty) {
      final first = currencies.first;
      if (first is String) {
        return paymentSystemForCurrency(first)?.id ?? kBlik.id;
      }
    }
    return kBlik.id;
  }
}
