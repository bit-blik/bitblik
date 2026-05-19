import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
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
      // Invert the logic: enabled means NOT blacklisted
      await apiService.toggleBlacklist(pubkey, !enabled);
      // Refresh the list without invalidating (preserves current state)
      await ref.read(discoveredCoordinatorsProvider.notifier).refreshList();

      // Trigger health check in background if coordinator is now enabled
      if (enabled) {
        ref
            .read(discoveredCoordinatorsProvider.notifier)
            .checkCoordinatorHealthAndRefresh(pubkey);
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

  Future<void> _addCustomWhitelist(String npub) async {
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
      await apiService.addCustomWhitelist(trimmed);
      _addNpubController.clear();
      // Refresh the list without invalidating (preserves current state)
      await ref.read(discoveredCoordinatorsProvider.notifier).refreshList();

      // Get the normalized pubkey for health check
      String normalizedPubkey;
      try {
        if (trimmed.startsWith('npub')) {
          normalizedPubkey = Nip19.decode(trimmed);
        } else {
          normalizedPubkey = trimmed;
        }
      } catch (_) {
        normalizedPubkey = trimmed;
      }

      // Trigger health check in background for the newly added coordinator
      ref
          .read(discoveredCoordinatorsProvider.notifier)
          .checkCoordinatorHealthAndRefresh(normalizedPubkey);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(t.coordinator.management.coordinatorAdded)),
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

  Future<void> _removeCustomWhitelist(String pubkey) async {
    final t = Translations.of(context);
    setState(() => _saving = true);
    try {
      final apiService = ref.read(apiServiceProvider);
      await apiService.removeCustomWhitelist(pubkey);
      // Refresh the list without invalidating (preserves current state)
      await ref.read(discoveredCoordinatorsProvider.notifier).refreshList();
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

  @override
  Widget build(BuildContext context) {
    final t = Translations.of(context);
    final coordinatorsAsync = ref.watch(discoveredCoordinatorsProvider);
    final apiService = ref.read(apiServiceProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(t.coordinator.management.availableCoordinators),
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => context.pop(),
        // ),
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
              // Text(t.coordinator.management.availableCoordinators, style: const TextStyle(fontWeight: FontWeight.bold)),
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
                        onRefresh:
                            () =>
                                ref
                                    .read(
                                      discoveredCoordinatorsProvider.notifier,
                                    )
                                    .refreshDiscovery(),
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
                      onRefresh:
                          () =>
                              ref
                                  .read(discoveredCoordinatorsProvider.notifier)
                                  .refreshDiscovery(),
                      child: ListView.separated(
                        itemCount: coordinators.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) {
                          final c = coordinators[index];
                          final pubkey = c.pubkey;
                          final isDefault = apiService.isDefaultWhitelisted(
                            pubkey,
                          );
                          final isBlack = apiService.isBlacklisted(pubkey);

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
                            subtitle: Row(
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
                                      : t.coordinator.management.unknownOffline,
                                ),
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
                                  isBlack
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
                              if (isDefault) ...[
                                const SizedBox(width: 8),
                                Text(
                                  t.coordinator.management.enable,
                                  style: const TextStyle(fontSize: 12),
                                ),
                                Switch(
                                  value:
                                      !isBlack, // Inverted: true when NOT blacklisted (enabled)
                                  onChanged:
                                      _saving
                                          ? null
                                          : (val) => _toggleEnable(pubkey, val),
                                ),
                              ] else if (apiService
                                  .customWhitelistedCoordinators
                                  .contains(pubkey)) ...[
                                IconButton(
                                  icon: const Icon(Icons.delete_outline),
                                  tooltip: t.coordinator.management.remove,
                                  onPressed:
                                      _saving
                                          ? null
                                          : () =>
                                              _removeCustomWhitelist(pubkey),
                                ),
                              ],
                            ],
                          );

                          // Combine main content and trailing section
                          return Row(
                            children: [
                              Expanded(
                                child:
                                    isDefault && isBlack
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
                            : () =>
                                _addCustomWhitelist(_addNpubController.text),
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
