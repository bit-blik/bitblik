import 'package:bitblik_core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/shared/nips/nip19/nip19.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';

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

      if (enabled) {
        // Background probe; registry streams update on completion.
        unawaitedProbe(apiService.checkCoordinatorHealth(pubkey));
      }

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              enabled
                  ? t.coordinator.management.coordinatorUnblacklisted
                  : t.coordinator.management.coordinatorBlacklisted,
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
    await registry.discover();
    await registry.probeAllListed();
  }

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final coordinatorsAsync = ref.watch(discoveredCoordinatorsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.coordinator.management.availableCoordinators),
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
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final c = coordinators[index];
                          final pubkey = c.pubkeyHex;
                          final isDisabled = !c.enabled;

                          // Build the main content (title and subtitle)
                          final mainContent = ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                            ),
                            leading:
                                c.icon != null && c.icon!.isNotEmpty
                                    ? CachedNetworkImage(
                                      imageUrl: c.icon!,
                                      placeholder:
                                          (context, url) => const SizedBox(
                                            width: 40,
                                            height: 40,
                                            child: CircularProgressIndicator(
                                              strokeWidth: 2,
                                            ),
                                          ),
                                      errorWidget:
                                          (context, url, error) => const Icon(
                                            Icons.account_circle,
                                            size: 40,
                                            color: Colors.grey,
                                          ),
                                      width: 40,
                                      height: 40,
                                      fit: BoxFit.cover,
                                    )
                                    : const Icon(
                                      Icons.account_circle,
                                      size: 40,
                                      color: Colors.grey,
                                    ),
                            title: Text(
                              c.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
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
                                          ? t.coordinator.management.online
                                          : t.coordinator.management
                                              .unknownOffline,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                _ScoreMetricsRow(record: c),
                              ],
                            ),
                            trailing: IconButton(
                              tooltip:
                                  t.coordinator.management.openNostrProfile,
                              icon: Image.asset(
                                'assets/nostr.png',
                                width: 24,
                                height: 24,
                              ),
                              onPressed:
                                  isDisabled
                                      ? null
                                      : () async {
                                        final url =
                                            'https://njump.to/${Nip19.encodePubKey(pubkey)}';
                                        await launchUrl(
                                          Uri.parse(url),
                                          mode: LaunchMode.externalApplication,
                                        );
                                      },
                            ),
                          );

                          // Build the trailing section with switch/delete button
                          final trailingSection = Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const SizedBox(width: 8),
                              Text(
                                t.coordinator.management.enable,
                                style: const TextStyle(fontSize: 12),
                              ),
                              Switch(
                                value: c.enabled,
                                onChanged:
                                    _saving
                                        ? null
                                        : (val) => _toggleEnable(pubkey, val),
                              ),
                              if (c.manualAdded)
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  tooltip: t.coordinator.management.remove,
                                  onPressed:
                                      _saving
                                          ? null
                                          : () => _removeCoordinator(pubkey),
                                ),
                            ],
                          );

                          // Combine main content and trailing section
                          return Row(
                            children: [
                              Expanded(
                                child:
                                    isDisabled
                                        ? Opacity(
                                          opacity: 0.4,
                                          child: IgnorePointer(
                                            child: mainContent,
                                          ),
                                        )
                                        : mainContent,
                              ),
                              trailingSection,
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
                            : () => _addCustomCoordinator(
                              _addNpubController.text,
                            ),
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
