import 'dart:async';
import 'dart:typed_data';

import 'package:bitblik_core/core.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndk/ndk.dart';

import '../../i18n/gen/strings.g.dart';
import '../providers/providers.dart';

/// The end-user side of one private participant/coordinator dispute lane.
/// Financial instructions remain structured RPCs rendered separately from the
/// conversation; message text is never interpreted as an action.
class DisputeConversationCard extends ConsumerStatefulWidget {
  final Offer offer;
  final DisputeCommunicationService? communication;

  /// Coordinator-owned relays explicitly supplied for the legacy NIP-04
  /// compatibility channel. An empty list keeps the privacy downgrade off.
  final Iterable<String> legacyRendezvousRelays;

  const DisputeConversationCard({
    super.key,
    required this.offer,
    this.communication,
    this.legacyRendezvousRelays = const <String>[],
  });

  @override
  ConsumerState<DisputeConversationCard> createState() =>
      _DisputeConversationCardState();
}

class _DisputeConversationCardState
    extends ConsumerState<DisputeConversationCard> {
  final messageController = TextEditingController();
  final scrollController = ScrollController();
  final messages = <_ConversationMessage>[];
  String? myPubkey;
  bool loadingMessages = true;
  bool busy = false;
  bool legacyMode = false;
  String? error;
  StreamSubscription<Nip17Message>? dmInboxEvents;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  @override
  void didUpdateWidget(covariant DisputeConversationCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.offer.id != widget.offer.id ||
        oldWidget.offer.statusRaw != widget.offer.statusRaw) {
      unawaited(_stopDmInboxListener());
      legacyMode = false;
      _initialize();
    }
  }

  @override
  void dispose() {
    unawaited(_stopDmInboxListener());
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<void> _initialize() async {
    try {
      // The public key is stored independently from NDK's account registry.
      // Do not start a NIP-17 load in the window where the app service has
      // created NDK but has not yet registered its signing account.
      if (widget.communication == null) {
        await ref.read(initializedApiServiceProvider.future);
      }
      final storedPubkey = await ref.read(publicKeyProvider.future);
      final account = _communication.ndk.accounts.getLoggedAccount();
      final signerPubkey = account?.pubkey;
      if (!mounted) return;
      if (storedPubkey == null ||
          signerPubkey == null ||
          !account!.signer.canSign() ||
          storedPubkey.toLowerCase() != signerPubkey.toLowerCase()) {
        setState(() {
          myPubkey = null;
          messages.clear();
          loadingMessages = false;
          error = Translations.of(context).disputeChat.errors.accountNotReady;
        });
        return;
      }
      setState(() {
        myPubkey = signerPubkey;
        error = null;
        messages.clear();
        loadingMessages = true;
      });
      await _replaceMessages(forceRefresh: true);
      await _startDmInboxListener(account);
    } catch (exception) {
      if (!mounted) return;
      Logger.log.e(() => '[DisputeChat] Initialization failed: $exception');
      setState(() {
        myPubkey = null;
        messages.clear();
        loadingMessages = false;
        error = Translations.of(context).disputeChat.errors.operationFailed;
      });
    }
  }

  DisputeCommunicationService get _communication {
    final injected = widget.communication;
    if (injected != null) return injected;
    final ndk = ref.read(ndkProvider);
    if (ndk == null) {
      throw StateError(
        Translations.of(context).disputeChat.errors.nostrNotInitialized,
      );
    }
    return DisputeCommunicationService(ndk: ndk);
  }

  Iterable<String> get _legacyRendezvousRelays {
    final explicit = widget.legacyRendezvousRelays
        .map((relay) => relay.trim())
        .where((relay) => relay.isNotEmpty)
        .toList(growable: false);
    if (explicit.isNotEmpty) return explicit;

    // Do not fall back to discovery relays. A legacy peer can only be expected
    // to meet us on relays already associated with this exact coordinator.
    return ref
            .read(
              coordinatorRecordByPubkeyProvider(widget.offer.coordinatorPubkey),
            )
            ?.relays ??
        const <String>[];
  }

  Iterable<String> get _nip17RelayDiscoveryRelays => <String>{
    ...kDiscoveryRelays,
    ..._legacyRendezvousRelays,
  };

  Future<void> _startDmInboxListener(Account account) async {
    // Injected communication is used by widget tests and callers that own
    // their own transport lifecycle.
    if (widget.communication != null) return;
    await _stopDmInboxListener();
    final api = ref.read(apiServiceProvider);
    await api.ensureDmInboxReady();
    if (!mounted) return;
    dmInboxEvents = api.dmMessages.listen(
      (message) {
        _handleDmInboxMessage(message, account.pubkey);
      },
      onError: (Object exception) {
        if (mounted && myPubkey == account.pubkey) {
          Logger.log.e(
            () => '[DisputeChat] Inbox subscription failed: $exception',
          );
          setState(() {
            error =
                Translations.of(context).disputeChat.errors.subscriptionFailed;
          });
        }
      },
    );
    for (final message in api.dmMessageSnapshot) {
      _handleDmInboxMessage(message, account.pubkey);
    }
  }

  void _handleDmInboxMessage(Nip17Message message, String accountPubkey) {
    try {
      if (!mounted || myPubkey != accountPubkey) return;
      if (!_communication.isMessageForCase(
        offer: widget.offer,
        myPubkey: accountPubkey,
        message: message,
      )) {
        return;
      }
      _appendMessages([_ConversationMessage.fromNip17(message)]);
    } catch (exception) {
      if (!mounted || myPubkey != accountPubkey) return;
      Logger.log.e(() => '[DisputeChat] Message decryption failed: $exception');
      setState(() {
        error = Translations.of(context).disputeChat.errors.decryptFailed;
      });
    }
  }

  Future<void> _stopDmInboxListener() async {
    await dmInboxEvents?.cancel();
    dmInboxEvents = null;
  }

  Future<List<_ConversationMessage>> _load({bool forceRefresh = false}) async {
    final pubkey = myPubkey;
    if (pubkey == null) return const [];
    if (legacyMode) {
      final legacy = await _communication.loadLegacyMessages(
        offer: widget.offer,
        myPubkey: pubkey,
        legacyRendezvousRelays: _legacyRendezvousRelays,
        forceRefresh: forceRefresh,
        includeUnbound: true,
      );
      return legacy
          .map(_ConversationMessage.fromLegacy)
          .toList(growable: false);
    }
    final nip17 = await _communication.loadMessagesSnapshot(
      offer: widget.offer,
      myPubkey: pubkey,
    );
    return nip17.map(_ConversationMessage.fromNip17).toList(growable: false);
  }

  void _refresh() => unawaited(_replaceMessages(forceRefresh: true));

  Future<void> _replaceMessages({required bool forceRefresh}) async {
    final initialLoad = loadingMessages;
    try {
      final loaded = await _load(forceRefresh: forceRefresh);
      if (!mounted) return;
      setState(() {
        messages
          ..clear()
          ..addAll(loaded);
        loadingMessages = false;
        error = null;
      });
      _scrollToBottom(immediate: initialLoad);
    } catch (exception) {
      if (!mounted) return;
      Logger.log.e(() => '[DisputeChat] Message loading failed: $exception');
      setState(() {
        loadingMessages = false;
        error = Translations.of(context).disputeChat.errors.operationFailed;
      });
    }
  }

  Future<void> _appendLatestMessages() async {
    final loaded = await _load(forceRefresh: false);
    _appendMessages(loaded);
  }

  void _appendMessages(Iterable<_ConversationMessage> incoming) {
    if (!mounted) return;
    final ids = messages.map((message) => message.id).toSet();
    final additions = incoming
        .where((message) => ids.add(message.id))
        .toList(growable: false);
    if (additions.isEmpty) return;
    setState(() {
      messages.addAll(additions);
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      loadingMessages = false;
      error = null;
    });
    _scrollToBottom();
  }

  void _scrollToBottom({bool immediate = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !scrollController.hasClients) return;
      if (immediate) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
        return;
      }
      scrollController.animateTo(
        scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
      );
    });
  }

  Future<void> _run(Future<void> Function() action) async {
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await action();
    } catch (exception) {
      if (mounted) {
        Logger.log.e(() => '[DisputeChat] Operation failed: $exception');
        setState(() {
          error = Translations.of(context).disputeChat.errors.operationFailed;
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          busy = false;
        });
      }
    }
  }

  Future<void> _sendMessage() async {
    final content = messageController.text.trim();
    final pubkey = myPubkey;
    if (content.isEmpty || pubkey == null) return;
    await _run(() async {
      final transport = await _communication.sendText(
        offer: widget.offer,
        myPubkey: pubkey,
        content: content,
        recipientDmRelayDiscoveryRelays: _nip17RelayDiscoveryRelays,
        legacyRendezvousRelays: _legacyRendezvousRelays,
      );
      if (transport == DisputeTextTransport.legacyNip04 && mounted) {
        setState(() {
          legacyMode = true;
        });
      }
      messageController.clear();
      await _appendLatestMessages();
    });
  }

  Future<void> _attachEvidence() async {
    if (legacyMode) {
      throw StateError(
        Translations.of(context).disputeChat.errors.attachmentsRequireNip17,
      );
    }
    final pubkey = myPubkey;
    if (pubkey == null) return;
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    await _run(() async {
      await _communication.sendEvidence(
        offer: widget.offer,
        myPubkey: pubkey,
        imageBytes: bytes,
        recipientDmRelayDiscoveryRelays: _nip17RelayDiscoveryRelays,
      );
      await _appendLatestMessages();
    });
  }

  Future<void> _previewEvidence(Nip17Message message) async {
    final pubkey = myPubkey;
    if (pubkey == null) return;
    Uint8List? bytes;
    await _run(() async {
      bytes = await _communication.downloadEvidence(
        offer: widget.offer,
        myPubkey: pubkey,
        message: message,
      );
    });
    if (!mounted || bytes == null) return;
    await showDialog<void>(
      context: context,
      builder:
          (context) =>
              Dialog(child: InteractiveViewer(child: Image.memory(bytes!))),
    );
  }

  @override
  Widget build(BuildContext context) {
    final strings = Translations.of(context).disputeChat;
    // Keep the offer-specific relay source reactive. Sending/loading reads this
    // same provider through [_legacyRendezvousRelays].
    final coordinator = ref.watch(
      coordinatorRecordByPubkeyProvider(widget.offer.coordinatorPubkey),
    );
    final coordinatorNpub =
        coordinator?.info?.nostrNpub ??
        Nip19.encodePubKey(widget.offer.coordinatorPubkey);
    final coordinatorIcon =
        coordinator?.profilePicture ?? coordinator?.info?.icon;
    final writable = widget.offer.statusRaw == OfferStatus.dispute.name;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                _CoordinatorLogo(icon: coordinatorIcon),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        legacyMode
                            ? strings.legacyChannel
                            : strings.privateConversation,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      Text(
                        coordinatorNpub,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                if (!loadingMessages)
                  Chip(
                    visualDensity: VisualDensity.compact,
                    backgroundColor:
                        legacyMode
                            ? Colors.amber.shade200
                            : Colors.green.shade200,
                    label: Text(legacyMode ? 'NIP-04' : 'NIP-17'),
                  ),
                IconButton(
                  tooltip: strings.tooltips.refresh,
                  onPressed: busy ? null : _refresh,
                  icon: const Icon(Icons.refresh),
                ),
              ],
            ),
            if (!legacyMode) Text(strings.privacyNotice),
            const SizedBox(height: 12),
            SizedBox(
              height: 260,
              child:
                  loadingMessages
                      ? const Center(child: CircularProgressIndicator())
                      : messages.isEmpty
                      ? Center(child: Text(strings.noMessages))
                      : ListView.builder(
                        controller: scrollController,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          final file = message.fileMetadata;
                          return Align(
                            alignment:
                                message.isOutgoing
                                    ? Alignment.centerRight
                                    : Alignment.centerLeft,
                            child: Card(
                              color:
                                  message.isOutgoing
                                      ? Theme.of(
                                        context,
                                      ).colorScheme.primaryContainer
                                      : null,
                              child:
                                  file == null
                                      ? Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(message.content),
                                      )
                                      : TextButton.icon(
                                        onPressed:
                                            busy
                                                ? null
                                                : () => _previewEvidence(
                                                  message.nip17Message!,
                                                ),
                                        icon: const Icon(Icons.image),
                                        label: Text(
                                          '${file.mimeType} · ${file.dimensions ?? ''}',
                                        ),
                                      ),
                            ),
                          );
                        },
                      ),
            ),
            if (writable) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  if (!legacyMode)
                    IconButton(
                      tooltip: strings.tooltips.attachEvidence,
                      onPressed: busy ? null : _attachEvidence,
                      icon: const Icon(Icons.attach_file),
                    ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      enabled: !busy,
                      decoration: InputDecoration(hintText: strings.replyHint),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  IconButton(
                    tooltip: strings.tooltips.send,
                    onPressed: busy ? null : _sendMessage,
                    icon: const Icon(Icons.send),
                  ),
                ],
              ),
            ] else
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(strings.readOnly),
              ),
            if (busy) const LinearProgressIndicator(),
            if (error != null)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(error!, style: const TextStyle(color: Colors.red)),
              ),
          ],
        ),
      ),
    );
  }
}

class _CoordinatorLogo extends StatelessWidget {
  const _CoordinatorLogo({this.icon});

  final String? icon;

  @override
  Widget build(BuildContext context) {
    final value = icon?.trim();
    if (value == null || value.isEmpty) return _fallback();
    if (value.startsWith('http')) {
      return ClipOval(
        child: CachedNetworkImage(
          imageUrl: value,
          width: 36,
          height: 36,
          fit: BoxFit.cover,
          errorWidget: (_, _, _) => _fallback(),
        ),
      );
    }
    return ClipOval(
      child: Image.asset(
        value,
        width: 36,
        height: 36,
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) => _fallback(),
      ),
    );
  }

  Widget _fallback() =>
      const CircleAvatar(radius: 18, child: Icon(Icons.account_balance_wallet));
}

class _ConversationMessage {
  final String id;
  final int createdAt;
  final String content;
  final bool isOutgoing;
  final Nip17FileMetadata? fileMetadata;
  final Nip17Message? nip17Message;

  const _ConversationMessage._({
    required this.id,
    required this.createdAt,
    required this.content,
    required this.isOutgoing,
    this.fileMetadata,
    this.nip17Message,
  });

  factory _ConversationMessage.fromNip17(Nip17Message message) =>
      _ConversationMessage._(
        id: message.id,
        createdAt: message.createdAt,
        content: message.content,
        isOutgoing: message.isOutgoing,
        fileMetadata: message.fileMetadata,
        nip17Message: message,
      );

  factory _ConversationMessage.fromLegacy(LegacyNip04Message message) =>
      _ConversationMessage._(
        id: message.id,
        createdAt: message.createdAt,
        content: message.content,
        isOutgoing: message.isOutgoing,
      );
}
