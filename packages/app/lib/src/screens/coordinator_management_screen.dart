import 'package:bitblik_core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';
import '../widgets/relay_dots.dart';
import 'coordinator_console_access_screen.dart';
import 'coordinator_details_screen.dart';

class CoordinatorManagementScreen extends ConsumerStatefulWidget {
  const CoordinatorManagementScreen({super.key});

  static const routeName = '/coordinators';

  @override
  ConsumerState<CoordinatorManagementScreen> createState() =>
      _CoordinatorManagementScreenState();
}

class _CoordinatorManagementScreenState
    extends ConsumerState<CoordinatorManagementScreen> {
  final TextEditingController _addNpubController = TextEditingController();
  bool _saving = false;

  @override
  void dispose() {
    _addNpubController.dispose();
    super.dispose();
  }

  Future<void> _toggleEnable(String pubkey, bool enabled) async {
    final t = Translations.of(context);
    setState(() => _saving = true);
    try {
      final apiService = ref.read(apiServiceProvider);
      await apiService.setCoordinatorEnabled(pubkey, enabled);
      ref.invalidate(availableOffersProvider);
      ref.invalidate(successfulOffersStatsProvider);

      if (enabled) {
        // Show a pending state immediately, then probe; the registry streams
        // the online/offline result to the list on completion.
        apiService.coordinatorRegistry.markProbing(pubkey);
        unawaitedProbe(apiService.checkCoordinatorHealth(pubkey));
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              enabled
                  ? t.coordinator.management.coordinatorEnabled
                  : t.coordinator.management.coordinatorDisabled,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${t.coordinator.management.error}: ${e.toString()}'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _addCustomCoordinator(String npub) async {
    final t = Translations.of(context);
    final trimmed = npub.trim();
    if (trimmed.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(t.coordinator.management.pleaseEnterNpub)),
      );
      return;
    }

    setState(() => _saving = true);
    try {
      final apiService = ref.read(apiServiceProvider);
      final record = await apiService.addManualCoordinator(trimmed);
      _addNpubController.clear();
      unawaitedProbe(apiService.checkCoordinatorHealth(record.pubkeyHex));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.coordinator.management.coordinatorAdded)),
        );
      }
    } on CoordinatorInfoUnavailable {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              t.coordinator.management.coordinatorAddInfoUnavailable,
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${t.coordinator.management.error}: ${e.toString()}'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _removeCoordinator(String pubkey) async {
    final t = Translations.of(context);
    setState(() => _saving = true);
    try {
      final apiService = ref.read(apiServiceProvider);
      await apiService.removeCoordinator(pubkey);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.coordinator.management.coordinatorRemoved)),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${t.coordinator.management.error}: ${e.toString()}'),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  static void unawaitedProbe(Future<void> future) {
    // Fire-and-forget. Errors are surfaced to logs by the registry layer.
    future.ignore();
  }

  Future<void> _refreshDiscovery() async {
    final registry = await ref.read(coordinatorRegistryProvider.future);
    final enabledBefore =
        registry.enabled.map((record) => record.pubkeyHex).toSet();
    registry.showColdStartState(
      CoordinatorColdStartPhase.loadingMuteList,
      enabledPubkeys: enabledBefore,
      origin: CoordinatorColdStartOrigin.settings,
    );
    try {
      registry.showColdStartState(
        CoordinatorColdStartPhase.discovering,
        enabledPubkeys: enabledBefore,
        origin: CoordinatorColdStartOrigin.settings,
      );
      await registry.discover();
      final discovered = registry.all.map((record) => record.pubkeyHex).toSet();
      final enabledAfterDiscovery =
          registry.enabled.map((record) => record.pubkeyHex).toSet();
      registry.showColdStartState(
        CoordinatorColdStartPhase.checkingHealth,
        discovered: discovered,
        enabledPubkeys: enabledAfterDiscovery,
        origin: CoordinatorColdStartOrigin.settings,
      );
      await registry.probeAllListed();
      registry.showColdStartState(
        CoordinatorColdStartPhase.completed,
        discovered: discovered,
        enabledPubkeys:
            registry.enabled.map((record) => record.pubkeyHex).toSet(),
        origin: CoordinatorColdStartOrigin.settings,
      );
    } catch (_) {
      registry.dismissColdStartState();
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    // Only show coordinators serving the user's selected payment method.
    final method = ref.watch(selectedPaymentSystemProvider);
    final coordinatorsAsync = ref
        .watch(discoveredCoordinatorsProvider)
        .whenData(
          (records) => records
              .where((r) => r.paymentSystem == method.id)
              .toList(growable: false),
        );

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                t.coordinator.management.availableCoordinators,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            IconButton(
              tooltip: t.settings.coordinatorConsole.title,
              icon: const Icon(Icons.terminal),
              onPressed: () {
                if (kIsWeb) {
                  context.go(CoordinatorConsoleAccessScreen.routeName);
                } else {
                  context.push(CoordinatorConsoleAccessScreen.routeName);
                }
              },
            ),
          ],
        ),
        actions: [
          // Discovery relay status (relays used to find coordinators).
          // Tap for the same relay-detail overlay as the top-bar dots.
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Center(
              child: RelayDots(
                relays: ref.watch(discoveryRelaysProvider),
                size: 7,
                showCount: true,
                overlayTitle: t.relays.discoveryRelays,
              ),
            ),
          ),
        ],
      ),

      body: GestureDetector(
        onTap: () {
          // Dismiss keyboard when tapping outside of text field
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),
              Expanded(
                child: coordinatorsAsync.when(
                  loading:
                      () => const Center(child: CircularProgressIndicator()),
                  error:
                      (err, stack) => Center(
                        child: Text(
                          '${t.coordinator.management.error}: ${err.toString()}',
                        ),
                      ),
                  data: (coordinators) {
                    if (coordinators.isEmpty) {
                      return RefreshIndicator(
                        onRefresh: _refreshDiscovery,
                        child: SingleChildScrollView(
                          physics: const AlwaysScrollableScrollPhysics(),
                          child: SizedBox(
                            height: MediaQuery.of(context).size.height - 200,
                            child: Center(
                              child: Text(
                                t.coordinator.management.noCoordinators,
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                    return RefreshIndicator(
                      onRefresh: _refreshDiscovery,
                      child: ListView.separated(
                        itemCount: coordinators.length,
                        separatorBuilder:
                            (_, index) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final c = coordinators[index];
                          final pubkey = c.pubkeyHex;
                          final isDisabled = !c.enabled;

                          final logo = buildCoordinatorLogo(
                            c.icon,
                            size: 40,
                            revealLogo: c.enabled,
                          );

                          // Tappable info area (logo + name + status + metrics)
                          // takes all available width so long names fit.
                          final info = InkWell(
                            onTap:
                                () => openCoordinatorDetails(context, pubkey),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 8.0,
                              ),
                              child: Row(
                                children: [
                                  logo,
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          c.name,
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              Theme.of(
                                                context,
                                              ).textTheme.titleMedium,
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            Icon(
                                              c.responsive == true
                                                  ? Icons.circle
                                                  : c.responsive == false
                                                  ? Icons.circle_outlined
                                                  : Icons.help_outline,
                                              size: 12,
                                              color:
                                                  c.responsive == true
                                                      ? Colors.green
                                                      : Colors.grey,
                                            ),
                                            const SizedBox(width: 6),
                                            Text(
                                              c.responsive == true
                                                  ? t
                                                      .coordinator
                                                      .management
                                                      .online
                                                  : t
                                                      .coordinator
                                                      .management
                                                      .unknownOffline,
                                              style:
                                                  Theme.of(
                                                    context,
                                                  ).textTheme.bodySmall,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        _ScoreMetricsRow(record: c),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );

                          // Full-width row: info (expanded) + compact controls
                          // + a chevron that drills into coordinator details.
                          return Row(
                            children: [
                              Expanded(
                                child:
                                    isDisabled
                                        ? Opacity(opacity: 0.4, child: info)
                                        : info,
                              ),
                              Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                  value: c.enabled,
                                  onChanged:
                                      _saving
                                          ? null
                                          : (val) => _toggleEnable(pubkey, val),
                                ),
                              ),
                              if (c.manualAdded)
                                IconButton(
                                  visualDensity: VisualDensity.compact,
                                  icon: const Icon(Icons.delete_outline),
                                  tooltip: t.coordinator.management.remove,
                                  onPressed:
                                      _saving
                                          ? null
                                          : () => _removeCoordinator(pubkey),
                                ),
                              IconButton(
                                visualDensity: VisualDensity.compact,
                                icon: const Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                ),
                                tooltip: t.coordinator.details.title,
                                onPressed:
                                    () =>
                                        openCoordinatorDetails(context, pubkey),
                              ),
                            ],
                          );
                        },
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _addNpubController,
                      decoration: InputDecoration(
                        labelText: t.coordinator.management.addCustomWhitelist,
                        hintText:
                            t.coordinator.management.addCustomWhitelistHint,
                        border: const OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed:
                        _saving
                            ? null
                            : () =>
                                _addCustomCoordinator(_addNpubController.text),
                    child:
                        _saving
                            ? const SizedBox(
                              width: 16,
                              height: 16,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                            : Text(t.coordinator.management.add),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget buildCoordinatorLogo(
  String? icon, {
  required double size,
  required bool revealLogo,
}) {
  if (!revealLogo || icon == null || icon.isEmpty) {
    return Icon(Icons.account_circle, size: size, color: Colors.grey);
  }
  if (icon.startsWith('http')) {
    return CachedNetworkImage(
      imageUrl: icon,
      placeholder:
          (context, url) => SizedBox(
            width: size,
            height: size,
            child: const CircularProgressIndicator(strokeWidth: 2),
          ),
      errorWidget:
          (context, url, error) =>
              Icon(Icons.account_circle, size: size, color: Colors.grey),
      width: size,
      height: size,
      fit: BoxFit.cover,
    );
  }
  return Image.asset(
    icon,
    width: size,
    height: size,
    errorBuilder:
        (_, error, stackTrace) =>
            Icon(Icons.account_circle, size: size, color: Colors.grey),
  );
}

/// Compact breakdown of the four ranking signals fed into
/// [CoordinatorRecord.score]. Tooltips show the formula for each chip so
/// users can reason about why one coordinator sits above another.
class _ScoreMetricsRow extends StatelessWidget {
  const _ScoreMetricsRow({required this.record});

  final CoordinatorRecord record;

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final r = record;
    return Wrap(
      spacing: 10,
      runSpacing: 2,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        _MetricChip(
          icon: Icons.person_outline,
          label: t.coordinator.management.metricYourOffers,
          value: r.localFinishedCount.toString(),
          tooltip: t.coordinator.management.metricYourOffersTooltip,
        ),
        _MetricChip(
          icon: Icons.public,
          label: t.coordinator.management.metricNetworkOffers,
          value: r.networkFinishedCount.toString(),
          tooltip: t.coordinator.management.metricNetworkOffersTooltip,
        ),
      ],
    );
  }
}

class _MetricChip extends StatelessWidget {
  const _MetricChip({
    required this.icon,
    required this.label,
    required this.value,
    required this.tooltip,
  });

  final IconData icon;
  final String label;
  final String value;
  final String tooltip;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: tooltip,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: Colors.grey),
          const SizedBox(width: 3),
          Text(
            '$label: ',
            style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
          Text(
            value,
            style: theme.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
