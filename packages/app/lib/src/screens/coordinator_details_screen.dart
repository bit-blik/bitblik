import 'package:bitblik_core/core.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:ndk/shared/nips/nip19/nip19.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../utils/bitcoin_display.dart';

/// Details for a single coordinator, reachable by tapping its name/logo
/// anywhere in the app. Shows metadata and — crucially — the **relays in use**
/// (its NIP-65 list, or the discovery relays it was seen on as a fallback)
/// with their live connection state.
class CoordinatorDetailsScreen extends ConsumerWidget {
  static const routeName = '/coordinator';

  final String pubkey;

  const CoordinatorDetailsScreen({super.key, required this.pubkey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = Translations.of(context);
    final record = ref.watch(coordinatorRecordByPubkeyProvider(pubkey));
    final connectivity = ref.watch(relayConnectivityProvider);
    final bitcoinDisplayUnit = ref.watch(bitcoinDisplayUnitProvider);

    final name = record?.name ?? t.coordinator.details.title;
    final icon = record?.icon;

    return Scaffold(
      appBar: AppBar(title: Text(t.coordinator.details.title)),
      body: RefreshIndicator(
        onRefresh: () => _refresh(ref),
        child:
            record == null
                ? ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  children: const [
                    SizedBox(height: 200),
                    Center(child: CircularProgressIndicator()),
                  ],
                )
                : ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(16),
                  children: [
                    Row(
                      children: [
                        _logo(icon, 48),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                name,
                                style: Theme.of(context).textTheme.titleLarge
                                    ?.copyWith(fontWeight: FontWeight.w600),
                              ),
                              if (record.version.isNotEmpty)
                                Text(
                                  'v${record.version}',
                                  style: Theme.of(context).textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey),
                                ),
                            ],
                          ),
                        ),
                        _statusChip(context, t, record.responsive),
                      ],
                    ),
                    const SizedBox(height: 16),
                    _infoRow(
                      context,
                      t.coordinator.details.makerFee,
                      '${record.makerFee.toStringAsFixed(2)}%',
                    ),
                    _infoRow(
                      context,
                      t.coordinator.details.takerFee,
                      '${record.takerFee.toStringAsFixed(2)}%',
                    ),
                    _infoRow(
                      context,
                      t.coordinator.details.amountRange,
                      formatBitcoinRange(
                        context,
                        bitcoinDisplayUnit,
                        record.minAmountSats,
                        record.maxAmountSats,
                      ),
                    ),
                    if (record.maxPremium > 0)
                      _infoRow(
                        context,
                        t.coordinator.details.maxPremium,
                        '${record.maxPremium.toStringAsFixed(1).replaceAll(RegExp(r'\\.0$'), '')}%',
                        onInfoTap: () => _showInfoDialog(
                          context,
                          t.coordinator.details.maxPremiumInfoTitle,
                          t.coordinator.details.maxPremiumInfoBody,
                        ),
                      ),
                    if (record.reservationSeconds > 0)
                      _infoRow(
                        context,
                        t.coordinator.details.reservationTime,
                        '${record.reservationSeconds}s',
                      ),
                    if (record.paymentSystem != null)
                      _infoRow(
                        context,
                        t.coordinator.details.paymentSystem,
                        _paymentSystemDisplay(t, record.paymentSystem!),
                      ),
                    if (record.currencies.isNotEmpty)
                      _infoRow(
                        context,
                        t.coordinator.details.currencies,
                        record.currencies.join(', '),
                      ),
                    _infoRow(
                      context,
                      t.coordinator.details.yourOffers,
                      '${record.localFinishedCount}',
                    ),
                    _infoRow(
                      context,
                      t.coordinator.details.successfulOffers,
                      '${record.networkFinishedCount}',
                    ),
                    ..._notificationLinksSection(context, t, record),
                    const Divider(height: 32),

                    // ── Relays in use ────────────────────────────────────────
                    Text(
                      t.coordinator.details.relaysInUse,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      t.coordinator.details.relaysInUseHint,
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                    ),
                    const SizedBox(height: 8),
                    if (record.relays.isEmpty)
                      Text(
                        t.coordinator.details.noRelays,
                        style: const TextStyle(color: Colors.grey),
                      )
                    else
                      ...record.relays.map(
                        (relay) => _relayTile(context, relay, connectivity),
                      ),

                    const SizedBox(height: 24),
                    if (record.info?.nostrNpub != null)
                      OutlinedButton.icon(
                        icon: const Icon(Icons.open_in_new, size: 16),
                        label: Text(t.coordinator.details.openNostrProfile),
                        onPressed: () => _openNjump(record.info!.nostrNpub!),
                      ),
                    if (record.termsOfUsageNaddr != null) ...[
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        icon: const Icon(Icons.description_outlined, size: 16),
                        label: Text(t.coordinator.details.termsOfUsage),
                        onPressed: () => _openNjump(record.termsOfUsageNaddr!),
                      ),
                    ],
                  ],
                ),
      ),
    );
  }

  /// Pull-to-refresh for this coordinator only.
  ///
  /// Fast path: refresh discovery relays, re-fetch this coordinator's
  /// kind-15125 + NIP-65 from discovery relays, then run a bounded-time
  /// `get_info` health probe.
  Future<void> _refresh(WidgetRef ref) async {
    final registry = ref.read(apiServiceProvider).coordinatorRegistry;
    await registry.refreshCoordinator(pubkey);
  }

  /// "🇵🇱 Poland · BLIK" for a coordinator's payment system id, with the
  /// country name localized via its ISO code.
  String _paymentSystemDisplay(Translations t, String id) {
    final ps = paymentSystemById(id);
    final country = t['settings.paymentSystem.countries.${ps.country}'];
    final name = country is String ? country : ps.country;
    return '${ps.flag} $name · ${ps.label}';
  }

  Widget _logo(String? icon, double size) {
    if (icon != null && icon.isNotEmpty) {
      return icon.startsWith('http')
          ? Image.network(
              icon,
              width: size,
              height: size,
              errorBuilder: (_, _, _) => Icon(Icons.account_circle, size: size),
            )
          : Image.asset(icon, width: size, height: size);
    }
    return Icon(Icons.account_circle, size: size);
  }

  Widget _infoRow(
    BuildContext context,
    String label,
    String value, {
    VoidCallback? onInfoTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onInfoTap,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey)),
                if (onInfoTap != null) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.info_outline, size: 16, color: Colors.grey),
                ],
              ],
            ),
          ),
          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statusChip(BuildContext context, Translations t, bool? responsive) {
    final (color, label) = switch (responsive) {
      true => (Colors.green, t.coordinator.details.statusOnline),
      false => (Colors.redAccent, t.coordinator.details.statusOffline),
      null => (Colors.amber, t.coordinator.details.statusUnknown),
    };
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(shape: BoxShape.circle, color: color),
        ),
        const SizedBox(width: 6),
        Text(label, style: TextStyle(color: color, fontSize: 12)),
      ],
    );
  }

  Widget _relayTile(
    BuildContext context,
    String relay,
    Map<String, RelayStatus> connectivity,
  ) {
    final normalized = normalizeRelayUrl(relay);
    RelayStatus? status;
    for (final entry in connectivity.entries) {
      if (normalizeRelayUrl(entry.key) == normalized) {
        status = entry.value;
        break;
      }
    }
    final color = switch (status?.state) {
      RelayConnectionState.connected => Colors.green,
      RelayConnectionState.connecting => Colors.blue,
      RelayConnectionState.reconnecting => Colors.orange,
      RelayConnectionState.disconnected => Colors.red,
      null => Colors.grey,
    };
    final shortUrl = relay.replaceFirst('wss://', '').replaceFirst('ws://', '');
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(shape: BoxShape.circle, color: color),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              shortUrl,
              style: const TextStyle(fontFamily: 'monospace', fontSize: 13),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog(BuildContext context, String title, String body) {
    showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(title),
        content: Text(body),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(MaterialLocalizations.of(dialogContext).okButtonLabel),
          ),
        ],
      ),
    );
  }

  /// Channel/notification links for this coordinator. Only the coordinator's
  /// own advertised links — no bundled defaults, so a coordinator that
  /// advertises none shows no notification section.
  Map<String, String> _resolveChannelLinks(CoordinatorRecord record) {
    return record.channelLinks;
  }

  String _messengerLabel(Translations t, String id) {
    switch (id) {
      case 'telegram':
        return t.home.notifications.telegram;
      case 'matrix':
        return t.home.notifications.matrix;
      case 'simplex':
        return t.home.notifications.simplex;
      case 'signal':
        return t.home.notifications.signal;
      default:
        return id;
    }
  }

  /// "Get notified" section: one tappable icon+label per configured messenger.
  List<Widget> _notificationLinksSection(
    BuildContext context,
    Translations t,
    CoordinatorRecord record,
  ) {
    final links = _resolveChannelLinks(record);
    if (links.isEmpty) return const [];
    return [
      const Divider(height: 32),
      Text(
        t.home.notifications.title,
        style: Theme.of(
          context,
        ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
      ),
      const SizedBox(height: 12),
      Wrap(
        spacing: 20,
        runSpacing: 12,
        children: [
          for (final id in CoordinatorInfo.messengerIds)
            if (links[id] != null && links[id]!.isNotEmpty)
              InkWell(
                onTap: () => launchUrl(
                  Uri.parse(links[id]!),
                  mode: LaunchMode.externalApplication,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 24,
                      height: 24,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/$id.png',
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(_messengerLabel(t, id)),
                    const SizedBox(width: 4),
                    const Icon(Icons.open_in_new, size: 14, color: Colors.grey),
                  ],
                ),
              ),
        ],
      ),
    ];
  }

  Future<void> _openNjump(String idOrAddr) async {
    final url = 'https://njump.to/$idOrAddr';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}

/// Navigate to [CoordinatorDetailsScreen] for [pubkey] (hex). Accepts npub too.
void openCoordinatorDetails(BuildContext context, String pubkey) {
  var hex = pubkey;
  if (pubkey.startsWith('npub')) {
    try {
      hex = Nip19.decode(pubkey);
    } catch (_) {}
  }
  final location = '${CoordinatorDetailsScreen.routeName}/$hex';
  // Pushed (not go) so the back button returns to the originating flow.
  if (kIsWeb) {
    context.go(location);
  } else {
    context.push(location);
  }
}
