import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../i18n/gen/strings.g.dart';
import '../screens/neko_management_screen.dart';

/// Card shown on dispute screens so users can contact the coordinator via Nostr DM.
///
/// Pass the coordinator's [npub]. Hidden automatically when [npub] is null.
class CoordinatorNostrContactCard extends StatelessWidget {
  final String? npub;

  const CoordinatorNostrContactCard({super.key, required this.npub});

  @override
  Widget build(BuildContext context) {
    if (npub == null) return const SizedBox.shrink();

    final strings = t.maker.conflict.nostrContact;
    final truncated = npub!.length > 20
        ? '${npub!.substring(0, 12)}...${npub!.substring(npub!.length - 8)}'
        : npub!;

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Coordinator contact ──────────────────────────────────────
            Row(
              children: [
                Image.asset('assets/nostr.png', width: 20, height: 20),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    strings.title,
                    style: Theme.of(context).textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(strings.description,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      truncated,
                      style: const TextStyle(
                          fontFamily: 'monospace', fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () => _copyNpub(context),
                    borderRadius: BorderRadius.circular(4),
                    child: Padding(
                      padding: const EdgeInsets.all(4),
                      child: Icon(Icons.copy,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.open_in_new, size: 16),
                label: Text(strings.openProfile),
                onPressed: _openProfile,
              ),
            ),

            const Divider(height: 28),

            // ── How to send DMs ──────────────────────────────────────────
            Text(strings.yourIdentityDescription,
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton.icon(
                icon: const Icon(Icons.key, size: 16),
                label: Text(strings.manageNekoKeys),
                onPressed: () =>
                    context.push(NekoManagementScreen.routeName),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _copyNpub(BuildContext context) {
    Clipboard.setData(ClipboardData(text: npub!));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(t.maker.conflict.nostrContact.npubCopied)),
    );
  }

  Future<void> _openProfile() async {
    final url = 'https://njump.to/${npub!}';
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }
}
