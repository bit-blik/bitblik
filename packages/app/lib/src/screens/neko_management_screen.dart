import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/shared/nips/nip19/nip19.dart';
import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';

class NekoManagementScreen extends ConsumerStatefulWidget {
  const NekoManagementScreen({super.key});

  static const routeName = '/neko-management';

  @override
  ConsumerState<NekoManagementScreen> createState() =>
      _NekoManagementScreenState();
}

class _NekoManagementScreenState extends ConsumerState<NekoManagementScreen> {
  String? selectedAction; // null, 'backup', 'restore', 'generate'
  bool isRevealed = false;
  final TextEditingController restoreKeyController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    restoreKeyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final publicKeyAsync = ref.watch(publicKeyProvider);
    final keyService = ref.read(keyServiceProvider);
    final t = Translations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          selectedAction == 'backup'
              ? t.backup.title
              : selectedAction == 'restore'
              ? t.restore.title
              : selectedAction == 'generate'
              ? t.generateNewKey.title
              : t.nekoManagement.title,
        ),
        leading:
            selectedAction != null
                ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      selectedAction = null;
                      isRevealed = false;
                    });
                  },
                )
                : null,
      ),
      body: publicKeyAsync.when(
        data: (publicKey) {
          if (publicKey == null) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Text('No Neko found'),
              ),
            );
          }

          final privateKey = keyService.privateKeyHex;

          return Column(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    // Dismiss keyboard when tapping outside of text field
                    FocusScope.of(context).unfocus();
                  },
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child:
                        selectedAction == null
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Row with avatar and action buttons
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Left side: Avatar and public key
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        // Neko avatar
                                        CachedNetworkImage(
                                          imageUrl:
                                              'https://robohash.org/$publicKey?set=set4',
                                          placeholder:
                                              (context, url) =>
                                                  const CircularProgressIndicator(),
                                          errorWidget:
                                              (context, url, error) =>
                                                  const Icon(Icons.error),
                                          width: 150,
                                          height: 150,
                                        ),
                                        const SizedBox(height: 12),
                                        // Public key with copy icon
                                        Builder(
                                          builder: (context) {
                                            final npub = Nip19.encodePubKey(
                                              publicKey,
                                            );
                                            final displayNpub =
                                                npub.length > 20
                                                    ? '${npub.substring(0, 15)}...${npub.substring(npub.length - 5)}'
                                                    : npub;
                                            return InkWell(
                                              onTap: () {
                                                Clipboard.setData(
                                                  ClipboardData(text: npub),
                                                );
                                                ScaffoldMessenger.of(
                                                  context,
                                                ).showSnackBar(
                                                  SnackBar(
                                                    content: Text(
                                                      t.common.clipboard.copied,
                                                    ),
                                                    duration: const Duration(
                                                      seconds: 2,
                                                    ),
                                                  ),
                                                );
                                              },
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  SelectableText(
                                                    displayNpub,
                                                    style: const TextStyle(
                                                      fontFamily: 'monospace',
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Icon(
                                                    Icons.copy,
                                                    size: 16,
                                                    color: Colors.grey[600],
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 24),
                                    // Right side: Action buttons
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.stretch,
                                        children: [
                                          OutlinedButton.icon(
                                            icon: const Icon(Icons.backup),
                                            label: Text(t.backup.title),
                                            onPressed: () {
                                              setState(() {
                                                selectedAction = 'backup';
                                                isRevealed = false;
                                              });
                                            },
                                          ),
                                          const SizedBox(height: 12),
                                          OutlinedButton.icon(
                                            icon: const Icon(Icons.restore),
                                            label: Text(t.restore.title),
                                            onPressed: () {
                                              setState(() {
                                                selectedAction = 'restore';
                                              });
                                            },
                                          ),
                                          const SizedBox(height: 12),
                                          OutlinedButton.icon(
                                            icon: const Icon(Icons.refresh),
                                            label: Text(t.generateNewKey.title),
                                            onPressed: () {
                                              setState(() {
                                                selectedAction = 'generate';
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 24),
                                // Description - full width
                                Text(
                                  t.nekoInfo.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            )
                            : selectedAction == 'backup' && privateKey != null
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  t.backup.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: SelectableText(
                                    isRevealed
                                        ? Nip19.encodePrivateKey(privateKey)
                                        : '****************************************************************',
                                    style: const TextStyle(
                                      fontFamily: 'monospace',
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  children: [
                                    TextButton.icon(
                                      icon: Icon(
                                        isRevealed
                                            ? Icons.visibility_off
                                            : Icons.visibility,
                                      ),
                                      label: Text(
                                        isRevealed
                                            ? t.common.buttons.hide
                                            : t.common.buttons.reveal,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          isRevealed = !isRevealed;
                                        });
                                      },
                                    ),
                                    TextButton.icon(
                                      icon: const Icon(Icons.copy),
                                      label: Text(t.common.buttons.copy),
                                      onPressed: () {
                                        Clipboard.setData(
                                          ClipboardData(
                                            text: Nip19.encodePrivateKey(
                                              privateKey,
                                            ),
                                          ),
                                        );
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              t.backup.feedback.copied,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            )
                            : selectedAction == 'generating'
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: 16),
                                  Text(
                                    t.generateNewKey.buttons.generate,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            )
                            : selectedAction == 'restoring'
                            ? Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const CircularProgressIndicator(),
                                  const SizedBox(height: 16),
                                  Text(
                                    t.restore.buttons.restore,
                                    style:
                                        Theme.of(context).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            )
                            : selectedAction == 'restore'
                            ? Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Form(
                                  key: formKey,
                                  child: TextFormField(
                                    controller: restoreKeyController,
                                    decoration: InputDecoration(
                                      labelText: t.restore.labels.privateKey,
                                      hintText: 'e.g., nsec1...',
                                      border: const OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null ||
                                          !Nip19.isPrivateKey(value)) {
                                        return t.restore.errors.invalidKey;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 16),
                                ElevatedButton.icon(
                                  icon: const Icon(Icons.restore),
                                  label: Text(t.restore.buttons.restore),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      try {
                                        // Set loading state
                                        setState(() {
                                          selectedAction = 'restoring';
                                        });

                                        String pKey = Nip19.decode(
                                          restoreKeyController.text,
                                        );
                                        await keyService.savePrivateKey(pKey);

                                        // Clear the active offer when restoring
                                        await ref
                                            .read(activeOfferProvider.notifier)
                                            .setActiveOffer(null);

                                        // Invalidate providers
                                        ref.invalidate(keyServiceProvider);
                                        ref.invalidate(apiServiceProvider);
                                        ref.invalidate(
                                          initializedApiServiceProvider,
                                        );
                                        ref.invalidate(publicKeyProvider);
                                        ref.invalidate(
                                          discoveredCoordinatorsProvider,
                                        );

                                        // Re-initialize services
                                        await ref.read(
                                          initializedApiServiceProvider.future,
                                        );

                                        // Get new public key
                                        final newKeyService = ref.read(
                                          keyServiceProvider,
                                        );
                                        final newPubKey =
                                            newKeyService.publicKeyHex;

                                        if (mounted && newPubKey != null) {
                                          setState(() {
                                            selectedAction = null;
                                            restoreKeyController.clear();
                                          });

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                t.restore.feedback.success,
                                              ),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        if (mounted) {
                                          setState(() {
                                            selectedAction = 'restore';
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${t.restore.errors.failed}: ${e.toString()}',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    }
                                  },
                                ),
                              ],
                            )
                            : Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Text(
                                  ref.read(activeOfferProvider) != null
                                      ? t.generateNewKey.errors.activeOffer
                                      : t.generateNewKey.description,
                                  style: Theme.of(context).textTheme.bodyMedium,
                                ),
                                if (ref.read(activeOfferProvider) == null) ...[
                                  const SizedBox(height: 16),
                                  ElevatedButton.icon(
                                    icon: const Icon(Icons.refresh),
                                    label: Text(
                                      t.generateNewKey.buttons.generate,
                                    ),
                                    onPressed: () async {
                                      try {
                                        // Set loading state
                                        setState(() {
                                          selectedAction = 'generating';
                                        });

                                        await keyService.generateNewKeyPair();

                                        // Clear the active offer
                                        await ref
                                            .read(activeOfferProvider.notifier)
                                            .setActiveOffer(null);

                                        // Invalidate providers
                                        ref.invalidate(keyServiceProvider);
                                        ref.invalidate(apiServiceProvider);
                                        ref.invalidate(
                                          initializedApiServiceProvider,
                                        );
                                        ref.invalidate(publicKeyProvider);
                                        ref.invalidate(
                                          discoveredCoordinatorsProvider,
                                        );

                                        // Re-initialize services
                                        await ref.read(
                                          initializedApiServiceProvider.future,
                                        );

                                        // Get new public key
                                        final newKeyService = ref.read(
                                          keyServiceProvider,
                                        );
                                        final newPubKey =
                                            newKeyService.publicKeyHex;

                                        if (mounted && newPubKey != null) {
                                          setState(() {
                                            selectedAction = null;
                                          });

                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                t
                                                    .generateNewKey
                                                    .feedback
                                                    .success,
                                              ),
                                            ),
                                          );
                                        }
                                      } catch (e) {
                                        if (mounted) {
                                          setState(() {
                                            selectedAction = 'generate';
                                          });
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                '${t.generateNewKey.errors.failed}: ${e.toString()}',
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ],
                              ],
                            ),
                  ),
                ),
              ),
              // Backup warning at the bottom - only show when no action is selected
              if (selectedAction == null)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.orange[300]!),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        selectedAction = 'backup';
                        isRevealed = false;
                      });
                    },
                    child: Row(
                      children: [
                        Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.orange[700],
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            t.nekoInfo.backupWarning,
                            style: TextStyle(
                              color: Colors.orange[900],
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.center,
                            softWrap: true,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
        loading:
            () => const Center(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: CircularProgressIndicator(),
              ),
            ),
        error:
            (error, stack) => Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text('Error: ${error.toString()}'),
              ),
            ),
      ),
    );
  }
}
