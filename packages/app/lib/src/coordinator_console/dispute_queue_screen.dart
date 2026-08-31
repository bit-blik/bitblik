import 'dart:async';
import 'dart:typed_data';

import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

import 'coordinator_session.dart';
import 'dispute_case_repository.dart';
import 'dispute_read_store.dart';

class DisputeQueueScreen extends StatefulWidget {
  final CoordinatorSession session;
  final bool allowAccountManagement;
  final VoidCallback? onManageAccounts;
  final Future<void> Function()? onLogout;

  const DisputeQueueScreen({
    super.key,
    required this.session,
    this.allowAccountManagement = true,
    this.onManageAccounts,
    this.onLogout,
  });

  @override
  State<DisputeQueueScreen> createState() => _DisputeQueueScreenState();
}

class _DisputeQueueScreenState extends State<DisputeQueueScreen> {
  late final DisputeCaseRepository repository;
  late final _DisputeUnreadTracker unreadTracker;
  late Future<List<Offer>> cases;
  String query = '';
  String? accountError;
  Account? removingAccount;

  @override
  void initState() {
    super.initState();
    repository = DisputeCaseRepository(session: widget.session);
    unreadTracker = _DisputeUnreadTracker(
      session: widget.session,
      communication: repository.communication,
    );
    cases = _loadCases();
  }

  @override
  void dispose() {
    unreadTracker.dispose();
    super.dispose();
  }

  Future<List<Offer>> _loadCases() async {
    final loaded = await repository.listDisputes();
    await unreadTracker.ready;
    if (mounted) unreadTracker.updateOffers(loaded);
    return loaded;
  }

  void refresh() {
    if (!mounted) return;
    final nextCases = _loadCases();
    setState(() {
      cases = nextCases;
    });
  }

  Future<void> runAccountAction(Future<void> Function() action) async {
    try {
      await action();
    } catch (exception) {
      if (mounted) setState(() => accountError = exception.toString());
    }
  }

  Future<void> showAccounts() async {
    await runAccountAction(widget.session.refreshCoordinatorProfiles);
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Coordinator accounts'),
        content: SizedBox(
          width: 620,
          child: NSwitchAccount(
            ndkFlutter: widget.session.ndkFlutter,
            beforeAccountRemove: (pubkey) {
              removingAccount = widget.session.ndk.accounts.accounts[pubkey];
            },
            onAccountRemove: (_) {
              final account = removingAccount;
              removingAccount = null;
              if (account != null) {
                runAccountAction(() => widget.session.accountRemoved(account));
              }
            },
            onAccountSwitch: (pubkey) {
              Navigator.of(dialogContext).pop();
              runAccountAction(() => widget.session.switchCoordinator(pubkey));
            },
            onAddAccount: () {
              Navigator.of(dialogContext).pop();
              runAccountAction(widget.session.prepareAddCoordinator);
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Text('Disputes · '),
            Flexible(
              child: NName(
                ndkFlutter: widget.session.ndkFlutter,
                pubkey: widget.session.expectedCoordinatorPubkey,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(onPressed: refresh, icon: const Icon(Icons.refresh)),
          if (widget.allowAccountManagement || widget.onManageAccounts != null)
            IconButton(
              tooltip: 'Switch coordinator account',
              icon: NPicture(
                ndkFlutter: widget.session.ndkFlutter,
                pubkey: widget.session.expectedCoordinatorPubkey,
                circleAvatarRadius: 14,
              ),
              onPressed: widget.onManageAccounts ?? showAccounts,
            ),
          IconButton(
            tooltip: 'Remove current account',
            onPressed: () =>
                runAccountAction(widget.onLogout ?? widget.session.logout),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: Column(
        children: [
          if (accountError != null)
            MaterialBanner(
              content: Text(accountError!),
              actions: [
                TextButton(
                  onPressed: () => setState(() => accountError = null),
                  child: const Text('Dismiss'),
                ),
              ],
            ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) => setState(() => query = value.trim()),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search),
                labelText: 'Filter by offer id or status',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Expanded(
            child: AnimatedBuilder(
              animation: unreadTracker,
              builder: (context, _) => FutureBuilder<List<Offer>>(
                future: cases,
                builder: (context, snapshot) {
                  if (snapshot.connectionState != ConnectionState.done) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  final normalizedQuery = query.toLowerCase();
                  final rows = (snapshot.data ?? const []).where((offer) {
                    final status = _disputeListStatus(offer.statusRaw);
                    return offer.id.toLowerCase().contains(normalizedQuery) ||
                        status.label.toLowerCase().contains(normalizedQuery) ||
                        offer.statusRaw.toLowerCase().contains(normalizedQuery);
                  }).toList();
                  if (rows.isEmpty) {
                    return const Center(child: Text('No disputes found.'));
                  }
                  return ListView.builder(
                    itemCount: rows.length,
                    itemBuilder: (context, index) {
                      final offer = rows[index];
                      final unread = unreadTracker.offerCount(offer.id);
                      final status = _disputeListStatus(offer.statusRaw);
                      return ListTile(
                        leading: Icon(status.icon, color: status.color),
                        title: Text(
                          '${offer.amountSats} sats · ${offer.fiatAmount} ${offer.fiatCurrency}',
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              status.label,
                              style: TextStyle(
                                color: status.color,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              'Created: ${_formatLocalDate(offer.createdAt)}',
                            ),
                            Text(
                              offer.id,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        isThreeLine: true,
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            if (unread > 0) ...[
                              Badge.count(count: unread),
                              const SizedBox(width: 8),
                            ],
                            const Icon(Icons.chevron_right),
                          ],
                        ),
                        onTap: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => _DisputeCaseScreen(
                                repository: repository,
                                unreadTracker: unreadTracker,
                                offerId: offer.id,
                              ),
                            ),
                          );
                          refresh();
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DisputeUnreadTracker extends ChangeNotifier {
  final CoordinatorSession session;
  final DisputeCommunicationService communication;
  final DisputeReadStore readStore;
  final Map<String, Offer> _offers = {};
  final Map<String, Set<String>> _messageIdsByLane = {};
  final Set<String> _readMessageIds = {};
  final Set<String> _reportedUnroutableNip17 = {};
  final List<Nip17Message> _pendingNip17 = [];
  final List<LegacyNip04Message> _pendingLegacy = [];
  late final String _coordinatorPubkey;
  late final Future<void> ready;
  Future<void> _pendingReadStateWrite = Future<void>.value();
  late final StreamSubscription<Nip17Message> _nip17Events;
  late final StreamSubscription<LegacyNip04Message> _legacyEvents;

  _DisputeUnreadTracker({
    required this.session,
    required this.communication,
    DisputeReadStore? readStore,
  }) : readStore = readStore ?? const DisputeReadStore() {
    _coordinatorPubkey =
        session.expectedCoordinatorPubkey ??
        session.activeAccount?.pubkey ??
        '';
    ready = _loadReadState();
    _nip17Events = session.dmInboxEvents.listen(_onNip17);
    _legacyEvents = session.legacyInboxEvents.listen(_onLegacy);
    // The coordinator session starts its authenticated inbox before the queue
    // screen is built. Seed messages already decrypted during that catch-up;
    // a stream listener only receives later additions and would otherwise
    // leave the queue badges and lane router unaware of the existing inbox.
    for (final message in session.dmInboxSnapshot) {
      _onNip17(message);
    }
    for (final message in session.legacyInboxSnapshot) {
      _onLegacy(message);
    }
  }

  String _laneKey(String offerId, String participantPubkey) =>
      '$offerId:${participantPubkey.toLowerCase()}';

  Future<void> _loadReadState() async {
    try {
      _readMessageIds.addAll(await readStore.load(_coordinatorPubkey));
    } catch (error) {
      debugPrint('[DisputeChat] Could not restore read state: $error');
    }
  }

  void updateOffers(Iterable<Offer> offers) {
    _offers
      ..clear()
      ..addEntries(offers.map((offer) => MapEntry(offer.id, offer)));
    _drainPending();
  }

  Set<String> laneMessageIds(String offerId, String participantPubkey) =>
      Set.unmodifiable(
        _messageIdsByLane[_laneKey(offerId, participantPubkey)] ?? const {},
      );

  int offerCount(String offerId) => _messageIdsByLane.entries
      .where((entry) => entry.key.startsWith('$offerId:'))
      .fold(0, (total, entry) => total + entry.value.length);

  void markLaneRead(String offerId, String participantPubkey) {
    final displayedIds = _messageIdsByLane.remove(
      _laneKey(offerId, participantPubkey),
    );
    if (displayedIds != null) {
      _readMessageIds.addAll(displayedIds);
      _pendingReadStateWrite = _pendingReadStateWrite.then((_) async {
        try {
          await readStore.save(_coordinatorPubkey, _readMessageIds);
        } catch (error) {
          debugPrint('[DisputeChat] Could not persist read state: $error');
        }
      });
      notifyListeners();
    }
  }

  void _onNip17(Nip17Message message) {
    if (message.isOutgoing) return;
    if (_offers.isEmpty) {
      _pendingNip17.add(message);
      return;
    }
    _recordNip17(message);
  }

  void _onLegacy(LegacyNip04Message message) {
    if (message.isOutgoing) return;
    if (_offers.isEmpty) {
      _pendingLegacy.add(message);
      return;
    }
    _recordLegacy(message);
  }

  void _drainPending() {
    final nip17 = List<Nip17Message>.of(_pendingNip17);
    final legacy = List<LegacyNip04Message>.of(_pendingLegacy);
    _pendingNip17.clear();
    _pendingLegacy.clear();
    for (final message in nip17) {
      _recordNip17(message);
    }
    for (final message in legacy) {
      _recordLegacy(message);
    }
  }

  void _recordNip17(Nip17Message message) {
    final offer = nip17OfferFor(message);
    if (offer == null) {
      if (_reportedUnroutableNip17.add(message.id)) {
        // Keep one actionable diagnostic without logging every unrelated DM
        // in a coordinator's potentially large general-purpose inbox.
        if (_reportedUnroutableNip17.length == 1) {
          debugPrint(
            '[DisputeChat] A decrypted NIP-17 message from '
            '${message.peerPubKey} did not match an available dispute',
          );
        }
      }
      return;
    }
    if (_readMessageIds.contains(message.id)) return;
    final changed = _messageIdsByLane
        .putIfAbsent(_laneKey(offer.id, message.peerPubKey), () => {})
        .add(message.id);
    if (message.id == session.diagnosticLiveRumorId) {
      debugPrint(
        '[DisputeChat] NIP-17 live rumor routed to '
        'offer=${offer.id}, peer=${message.peerPubKey}',
      );
    }
    if (changed) notifyListeners();
  }

  Offer? nip17OfferFor(Nip17Message message) =>
      communication.routeMessageToOffer(
        offers: _offers.values,
        myPubkey: session.expectedCoordinatorPubkey ?? '',
        message: message,
      );

  bool nip17MessageBelongsToLane(
    Offer offer,
    String participantPubkey,
    Nip17Message message,
  ) =>
      message.peerPubKey.toLowerCase() == participantPubkey.toLowerCase() &&
      nip17OfferFor(message)?.id == offer.id;

  void _recordLegacy(LegacyNip04Message message) {
    final offer = legacyOfferFor(message);
    if (offer == null) return;
    if (_readMessageIds.contains(message.id)) return;
    final changed = _messageIdsByLane
        .putIfAbsent(_laneKey(offer.id, message.peerPubKey), () => {})
        .add(message.id);
    if (changed) notifyListeners();
  }

  Offer? legacyOfferFor(LegacyNip04Message message) =>
      communication.routeLegacyMessageToOffer(
        offers: _offers.values,
        myPubkey: session.expectedCoordinatorPubkey ?? '',
        message: message,
      );

  bool legacyMessageBelongsToLane(
    Offer offer,
    String participantPubkey,
    LegacyNip04Message message,
  ) =>
      message.peerPubKey.toLowerCase() == participantPubkey.toLowerCase() &&
      legacyOfferFor(message)?.id == offer.id;

  @override
  void dispose() {
    unawaited(_nip17Events.cancel());
    unawaited(_legacyEvents.cancel());
    super.dispose();
  }
}

({String label, IconData icon, Color color}) _disputeListStatus(String raw) {
  switch (raw) {
    case 'securingDispute':
    case 'dispute':
      return (
        label: 'Awaiting coordinator ruling',
        icon: Icons.gavel,
        color: Colors.orange,
      );
    case 'refundingMaker':
      return (
        label: 'Ruled for maker · awaiting refund invoice',
        icon: Icons.undo,
        color: Colors.teal,
      );
    case 'payingMaker':
      return (
        label: 'Ruled for maker · refund in progress',
        icon: Icons.currency_bitcoin,
        color: Colors.teal,
      );
    case 'cancelled':
      return (
        label: 'Ruled for maker · refunded',
        icon: Icons.check_circle,
        color: Colors.green,
      );
    case 'payingTaker':
      return (
        label: 'Ruled for taker · payout in progress',
        icon: Icons.payments,
        color: Colors.blue,
      );
    case 'takerPaymentFailed':
      return (
        label: 'Ruled for taker · payout failed',
        icon: Icons.error,
        color: Colors.red,
      );
    case 'takerPaid':
      return (
        label: 'Ruled for taker · paid',
        icon: Icons.check_circle,
        color: Colors.green,
      );
    default:
      return (label: 'Handled · $raw', icon: Icons.history, color: Colors.grey);
  }
}

String _formatLocalDate(DateTime value) {
  final local = value.toLocal();
  String two(int part) => part.toString().padLeft(2, '0');
  return '${local.year}-${two(local.month)}-${two(local.day)} '
      '${two(local.hour)}:${two(local.minute)}';
}

String _auditDetails(Map<String, dynamic> entry) {
  final metadata = entry['metadata'];
  if (metadata is! Map) return '';
  const allowed = {
    'decision',
    'decision_recipient',
    'decision_amount_sats',
    'maker_refund_amount_sats',
    'maker_refund_invoice_ready',
  };
  final details = metadata.entries
      .where((entry) => allowed.contains(entry.key) && entry.value != null)
      .map((entry) => '${entry.key}: ${entry.value}')
      .join(' · ');
  return details.isEmpty ? '' : '\n$details';
}

class _DisputeCaseScreen extends StatefulWidget {
  final DisputeCaseRepository repository;
  final _DisputeUnreadTracker unreadTracker;
  final String offerId;

  const _DisputeCaseScreen({
    required this.repository,
    required this.unreadTracker,
    required this.offerId,
  });

  @override
  State<_DisputeCaseScreen> createState() => _DisputeCaseScreenState();
}

class _DisputeCaseScreenState extends State<_DisputeCaseScreen>
    with SingleTickerProviderStateMixin {
  late Future<CoordinatorDisputeCase> dispute;
  late final TabController laneTabController;
  CoordinatorDisputeCase? latestCase;
  bool deciding = false;
  String? decisionStatus;
  int selectedLane = 0;

  @override
  void initState() {
    super.initState();
    laneTabController = TabController(length: 2, vsync: this);
    widget.unreadTracker.addListener(_onUnreadChanged);
    dispute = _fetchCase();
  }

  @override
  void dispose() {
    widget.unreadTracker.removeListener(_onUnreadChanged);
    laneTabController.dispose();
    super.dispose();
  }

  void _onUnreadChanged() {
    if (!mounted) return;
    setState(() {});
  }

  Future<CoordinatorDisputeCase> _fetchCase() async {
    final item = await widget.repository.fetchCase(widget.offerId);
    latestCase = item;
    return item;
  }

  void refresh() {
    if (deciding || !mounted) return;
    final nextDispute = _fetchCase();
    setState(() {
      dispute = nextDispute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dispute ${widget.offerId}'),
        actions: [
          IconButton(
            tooltip: 'Refresh dispute',
            onPressed: deciding ? null : refresh,
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder<CoordinatorDisputeCase>(
        future: dispute,
        initialData: latestCase,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done &&
              !snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError && !snapshot.hasData) {
            return Center(child: Text(snapshot.error.toString()));
          }
          final item = snapshot.requireData;
          final offer = item.offer;
          final takerPubkey = offer.takerPubkey;
          final makerUnreadIds = widget.unreadTracker.laneMessageIds(
            offer.id,
            offer.makerPubkey,
          );
          final takerUnreadIds = takerPubkey == null
              ? const <String>{}
              : widget.unreadTracker.laneMessageIds(offer.id, takerPubkey);
          final makerUnread = makerUnreadIds.length;
          final takerUnread = takerUnreadIds.length;
          final isOpen = offer.statusRaw == OfferStatus.dispute.name;
          final awaitingMakerInvoice =
              offer.statusRaw == OfferStatus.refundingMaker.name;
          final payingMaker = offer.statusRaw == 'payingMaker';
          final makerRuled = awaitingMakerInvoice || payingMaker;
          final caseSummary = isOpen
              ? 'Awaiting coordinator ruling'
              : awaitingMakerInvoice
              ? 'Ruled for maker · awaiting refund invoice'
              : payingMaker
              ? 'Ruled for maker · paying the maker'
              : offer.statusRaw == OfferStatus.payingTaker.name
              ? 'Ruled for taker · paying the taker'
              : 'Decision completed · ${offer.statusRaw}';
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${offer.amountSats} sats · ${offer.fiatAmount} ${offer.fiatCurrency}',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text('State: ${offer.statusRaw}'),
                      Text(
                        caseSummary,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      Text(
                        'Backend: ${item.paymentBackendType} (${item.paymentBackendAvailable ? 'ready' : 'unavailable'})',
                      ),
                      Text(
                        'Maker refund invoice: ${item.makerRefundInvoiceReady ? 'submitted' : 'not submitted'}',
                      ),
                      if (makerRuled)
                        Text(
                          awaitingMakerInvoice
                              ? 'Refund payment: waiting for the maker'
                              : 'Refund payment: in progress',
                        ),
                      if (!isOpen && !makerRuled)
                        const Text('Decision finalized. History is read-only.'),
                      if (takerPubkey == null)
                        const Text(
                          'Taker identity is unavailable; rulings are disabled.',
                        ),
                    ],
                  ),
                ),
              ),
              if (deciding) const LinearProgressIndicator(),
              if (decisionStatus != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(decisionStatus!),
                ),
              const SizedBox(height: 12),
              SizedBox(
                height: 640,
                child: Column(
                  children: [
                    Material(
                      color: Theme.of(context).colorScheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(12),
                      clipBehavior: Clip.antiAlias,
                      child: TabBar(
                        controller: laneTabController,
                        onTap: (index) {
                          setState(() => selectedLane = index);
                        },
                        tabs: [
                          Tab(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                _NekoAvatar(
                                  pubkey: offer.makerPubkey,
                                  size: 30,
                                ),
                                const SizedBox(width: 8),
                                const Text('Maker'),
                                if (makerUnread > 0) ...[
                                  const SizedBox(width: 8),
                                  Badge.count(count: makerUnread),
                                ],
                              ],
                            ),
                          ),
                          Tab(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (takerPubkey != null)
                                  _NekoAvatar(pubkey: takerPubkey, size: 30)
                                else
                                  const CircleAvatar(
                                    radius: 15,
                                    child: Icon(Icons.person_off_outlined),
                                  ),
                                const SizedBox(width: 8),
                                const Text('Taker'),
                                if (takerUnread > 0) ...[
                                  const SizedBox(width: 8),
                                  Badge.count(count: takerUnread),
                                ],
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Expanded(
                      child: IndexedStack(
                        index: selectedLane,
                        sizing: StackFit.expand,
                        children: [
                          _ConversationLane(
                            key: ValueKey(
                              'maker-${widget.offerId}-${offer.makerPubkey}',
                            ),
                            dispute: item,
                            participantPubkey: offer.makerPubkey,
                            repository: widget.repository,
                            unreadTracker: widget.unreadTracker,
                            isActive: selectedLane == 0,
                            unreadMessageIds: makerUnreadIds,
                            onMessagesDisplayed: () => widget.unreadTracker
                                .markLaneRead(offer.id, offer.makerPubkey),
                          ),
                          takerPubkey == null
                              ? const Card(
                                  child: Center(
                                    child: Text('Taker lane unavailable'),
                                  ),
                                )
                              : _ConversationLane(
                                  key: ValueKey(
                                    'taker-${widget.offerId}-$takerPubkey',
                                  ),
                                  dispute: item,
                                  participantPubkey: takerPubkey,
                                  repository: widget.repository,
                                  unreadTracker: widget.unreadTracker,
                                  isActive: selectedLane == 1,
                                  unreadMessageIds: takerUnreadIds,
                                  onMessagesDisplayed: () => widget
                                      .unreadTracker
                                      .markLaneRead(offer.id, takerPubkey),
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              ExpansionTile(
                title: Text('State history (${item.stateHistory.length})'),
                children: [
                  for (final entry in item.stateHistory)
                    ListTile(
                      dense: true,
                      title: Text(
                        '${entry['from_state'] ?? 'created'} → ${entry['to_state']}',
                      ),
                      subtitle: Text(
                        '${entry['trigger_type']} · ${entry['event'] ?? ''} · '
                        '${entry['actor'] ?? 'system'} · ${entry['created_at'] ?? ''}'
                        '${_auditDetails(entry)}',
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: FilledButton.tonalIcon(
                      onPressed: deciding || !isOpen || takerPubkey == null
                          ? null
                          : () =>
                                confirmDecision(context, item, makerWins: true),
                      icon: const Icon(Icons.undo),
                      label: const Text('Rule for maker'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: FilledButton.icon(
                      onPressed:
                          deciding ||
                              !isOpen ||
                              takerPubkey == null ||
                              !item.paymentBackendAvailable
                          ? null
                          : () => confirmDecision(
                              context,
                              item,
                              makerWins: false,
                            ),
                      icon: const Icon(Icons.payments),
                      label: const Text('Rule for taker'),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> confirmDecision(
    BuildContext context,
    CoordinatorDisputeCase item, {
    required bool makerWins,
  }) async {
    final recipient = makerWins ? 'maker' : 'taker';
    final sats = makerWins ? item.makerRefundSats : item.takerPayoutSats;
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Rule for $recipient?'),
        content: Text(
          'Recipient: $recipient\nExact amount: $sats sats\n'
          'Backend: ${item.paymentBackendType}\n'
          '${makerWins ? 'The maker will be asked for a refund invoice after this ruling.' : 'The taker payout starts after this ruling.'}\n\n'
          'This commits an irreversible ruling. Duplicate clicks are idempotently rejected.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Confirm ruling'),
          ),
        ],
      ),
    );
    if (confirmed != true) return;
    setState(() {
      deciding = true;
      decisionStatus = 'Submitting signed coordinator decision…';
    });
    try {
      if (makerWins) {
        await widget.repository.ruleForMaker(item);
      } else {
        await widget.repository.ruleForTaker(item);
      }
      final notification = await widget.repository.notifyRuling(
        item,
        makerWins: makerWins,
      );
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            notification.deliveredToBoth
                ? 'Decision submitted and both participants were notified.'
                : 'Decision committed, but chat notification failed for: '
                      '${notification.failedParticipants.join(', ')}.',
          ),
        ),
      );
      setState(
        () => decisionStatus = notification.deliveredToBoth
            ? 'Decision committed; both participants notified.'
            : 'Decision committed; some chat notifications failed.',
      );
      refresh();
    } catch (error) {
      if (!context.mounted) return;
      final message = error.toString();
      final oldRefundFlow =
          makerWins && message.contains('has not submitted a refund invoice');
      setState(() {
        decisionStatus = oldRefundFlow
            ? 'The coordinator backend is still running the old refund flow. Restart a local server, or rebuild and redeploy its Docker image, then retry.'
            : message.contains('transition')
            ? 'Stale or already-resolved case. Refresh before retrying.'
            : 'Decision failed safely and may be retried.';
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(error.toString())));
    } finally {
      if (mounted) setState(() => deciding = false);
    }
  }
}

class _ConversationLane extends StatefulWidget {
  final CoordinatorDisputeCase dispute;
  final String participantPubkey;
  final DisputeCaseRepository repository;
  final _DisputeUnreadTracker unreadTracker;
  final bool isActive;
  final Set<String> unreadMessageIds;
  final VoidCallback onMessagesDisplayed;

  const _ConversationLane({
    super.key,
    required this.dispute,
    required this.participantPubkey,
    required this.repository,
    required this.unreadTracker,
    required this.isActive,
    required this.unreadMessageIds,
    required this.onMessagesDisplayed,
  });

  @override
  State<_ConversationLane> createState() => _ConversationLaneState();
}

class _ConversationLaneState extends State<_ConversationLane> {
  final controller = TextEditingController();
  final scrollController = ScrollController();
  final messages = <_LaneMessage>[];
  final evidenceBytesByMessageId = <String, Future<Uint8List>>{};
  StreamSubscription<Nip17Message>? dmInboxEvents;
  StreamSubscription<LegacyNip04Message>? legacyInboxEvents;
  bool loading = true;
  Object? loadError;
  bool sending = false;
  bool? usesLegacyNip04;
  bool displayCheckScheduled = false;

  @override
  void initState() {
    super.initState();
    scrollController.addListener(_scheduleDisplayedCheck);
    unawaited(_initializeLane());
  }

  @override
  void didUpdateWidget(covariant _ConversationLane oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive &&
        (!oldWidget.isActive || widget.unreadMessageIds.isNotEmpty)) {
      _scheduleDisplayedCheck();
    }
  }

  Future<void> _initializeLane() async {
    // Attach to the process-wide inbox before doing any relay queries. Those
    // queries can take several seconds and must not delay or lose live DMs.
    dmInboxEvents = widget.repository.session.dmInboxEvents.listen(
      (message) {
        _appendLiveNip17Message(message);
      },
      onError: (Object error) {
        if (mounted) setState(() => loadError = error);
      },
    );
    for (final message in widget.repository.session.dmInboxSnapshot) {
      _appendLiveNip17Message(message);
    }
    legacyInboxEvents = widget.repository.session.legacyInboxEvents.listen(
      _appendLiveLegacyMessage,
      onError: (Object error) {
        if (mounted) setState(() => loadError = error);
      },
    );
    for (final message in widget.repository.session.legacyInboxSnapshot) {
      _appendLiveLegacyMessage(message);
    }
    // The snapshot is enough to render immediately. Historical relay results
    // are merged below so they cannot clear messages received during loading.
    loading = false;
    await _loadInitialMessages(forceScroll: true);
  }

  @override
  void dispose() {
    dmInboxEvents?.cancel();
    legacyInboxEvents?.cancel();
    controller.dispose();
    scrollController.dispose();
    super.dispose();
  }

  Future<List<_LaneMessage>> _loadMessages() async {
    final offer = widget.dispute.offer;
    // This decision belongs to this recipient only. Never show or load the
    // legacy channel for a participant who has published kind-10050 merely
    // because the other participant needs a fallback.
    final recipientDmRelays = await widget.repository.session.ndk.userRelayLists
        .getDmRelays(
          widget.participantPubkey,
          forceRefresh: true,
          discoveryRelays: widget.repository.session.dmRelayDiscoveryRelays,
        );
    final useLegacy = recipientDmRelays == null || recipientDmRelays.isEmpty;
    usesLegacyNip04 = useLegacy;

    // NIP-04 compatibility is listened to alongside NIP-17. External clients
    // may still use kind 4 even when this participant advertises kind 10050.
    final legacyRelays = await _legacyRelaySet();
    final nip17 = await widget.repository.communication
        .loadMessagesSnapshot(
          offer: offer,
          myPubkey: offer.coordinatorPubkey,
          participantPubkey: widget.participantPubkey,
          includeUnbound: true,
        )
        .then(
          (messages) => messages
              .where(
                (message) => widget.unreadTracker.nip17MessageBelongsToLane(
                  offer,
                  widget.participantPubkey,
                  message,
                ),
              )
              .toList(growable: false),
        );
    final legacy = await widget.repository.communication
        .loadLegacyMessages(
          offer: offer,
          myPubkey: offer.coordinatorPubkey,
          participantPubkey: widget.participantPubkey,
          legacyRendezvousRelays: legacyRelays,
          forceRefresh: true,
          includeUnbound: true,
        )
        .then(
          (messages) => messages
              .where(
                (message) => widget.unreadTracker.legacyMessageBelongsToLane(
                  offer,
                  widget.participantPubkey,
                  message,
                ),
              )
              .toList(growable: false),
        );
    return [
      ...nip17.map(_LaneMessage.nip17),
      ...legacy.map(_LaneMessage.legacy),
    ];
  }

  Future<Set<String>> _legacyRelaySet() async {
    final participantRelays = await widget.repository.session.loadUserRelayUrls(
      widget.participantPubkey,
    );
    final relays = {
      ...widget.repository.session.dmRelayDiscoveryRelays,
      ...participantRelays,
    };
    widget.repository.session.ensureLegacyInboxRelays(relays);
    return relays;
  }

  Future<void> _loadInitialMessages({bool forceScroll = false}) async {
    try {
      final loaded = await _loadMessages();
      if (!mounted) return;
      _appendMessages(loaded, forceScroll: forceScroll);
      // _loadMessages also resolves the transport pill. Rebuild even when all
      // history rows were already present in the live-session snapshot.
      setState(() {
        loading = false;
        loadError = null;
      });
      if (forceScroll) _scrollToBottomIfNearEnd(force: true);
    } catch (error) {
      if (!mounted) return;
      setState(() {
        loading = false;
        loadError = error;
      });
    }
  }

  void refresh() => unawaited(_loadInitialMessages());

  void _appendLiveNip17Message(Nip17Message message) {
    if (!widget.unreadTracker.nip17MessageBelongsToLane(
      widget.dispute.offer,
      widget.participantPubkey,
      message,
    )) {
      return;
    }
    _appendMessages([_LaneMessage.nip17(message)]);
  }

  void _appendLiveLegacyMessage(LegacyNip04Message message) {
    if (!widget.unreadTracker.legacyMessageBelongsToLane(
      widget.dispute.offer,
      widget.participantPubkey,
      message,
    )) {
      return;
    }
    if (usesLegacyNip04 != true && mounted) {
      setState(() => usesLegacyNip04 = true);
    }
    _appendMessages([_LaneMessage.legacy(message)]);
  }

  Future<void> _appendLatestMessages() async {
    try {
      _appendMessages(await _loadMessages());
    } catch (error) {
      if (!mounted) return;
      setState(() => loadError = error);
    }
  }

  void _appendMessages(
    Iterable<_LaneMessage> incoming, {
    bool forceScroll = false,
  }) {
    if (!mounted) return;
    final existingIds = messages.map((message) => message.id).toSet();
    final additions = incoming
        .where((message) => existingIds.add(message.id))
        .toList(growable: false);
    if (additions.isEmpty) return;
    final wasNearBottom =
        !scrollController.hasClients ||
        scrollController.position.extentAfter <= 80;
    setState(() {
      messages.addAll(additions);
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      loadError = null;
    });
    _scrollToBottomIfNearEnd(force: forceScroll || wasNearBottom);
  }

  void _scrollToBottomIfNearEnd({bool force = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !scrollController.hasClients) return;
      final position = scrollController.position;
      if (force) {
        scrollController.jumpTo(position.maxScrollExtent);
        _scheduleDisplayedCheck();
        return;
      }
      if (position.extentAfter > 80) {
        _scheduleDisplayedCheck();
        return;
      }
      unawaited(
        scrollController
            .animateTo(
              position.maxScrollExtent,
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
            )
            .then((_) => _scheduleDisplayedCheck()),
      );
    });
  }

  void _scheduleDisplayedCheck() {
    if (displayCheckScheduled) return;
    displayCheckScheduled = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      displayCheckScheduled = false;
      if (!mounted ||
          !widget.isActive ||
          widget.unreadMessageIds.isEmpty ||
          ModalRoute.of(context)?.isCurrent != true ||
          !scrollController.hasClients ||
          scrollController.position.extentAfter > 2) {
        return;
      }
      final renderedIds = messages.map((message) => message.id).toSet();
      if (!widget.unreadMessageIds.every(renderedIds.contains)) return;
      widget.onMessagesDisplayed();
    });
  }

  Future<void> send([String? preset]) async {
    if (!_isOpen) {
      _showReadOnlyMessage();
      return;
    }
    final text = (preset ?? controller.text).trim();
    if (text.isEmpty) return;
    setState(() => sending = true);
    try {
      final legacyRelays = await _legacyRelaySet();
      final transport = usesLegacyNip04 == true
          ? DisputeTextTransport.legacyNip04
          : await widget.repository.communication.sendText(
              offer: widget.dispute.offer,
              myPubkey: widget.dispute.offer.coordinatorPubkey,
              participantPubkey: widget.participantPubkey,
              content: text,
              recipientDmRelayDiscoveryRelays:
                  widget.repository.session.dmRelayDiscoveryRelays,
              legacyRendezvousRelays: legacyRelays,
            );
      if (usesLegacyNip04 == true) {
        await widget.repository.communication.sendLegacyText(
          offer: widget.dispute.offer,
          myPubkey: widget.dispute.offer.coordinatorPubkey,
          participantPubkey: widget.participantPubkey,
          content: text,
          legacyRendezvousRelays: legacyRelays,
        );
      }
      controller.clear();
      await _appendLatestMessages();
      if (transport == DisputeTextTransport.legacyNip04 && mounted) {
        setState(() => usesLegacyNip04 = true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Sent via Legacy NIP-04 compatibility channel.'),
          ),
        );
      }
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Message was not sent: $error')));
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  Future<void> attach() async {
    if (!_isOpen) {
      _showReadOnlyMessage();
      return;
    }
    if (usesLegacyNip04 == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Attachments require the participant’s NIP-17 inbox.'),
        ),
      );
      return;
    }
    final picked = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (picked == null) return;
    final bytes = await picked.readAsBytes();
    setState(() => sending = true);
    try {
      await widget.repository.communication.sendEvidence(
        offer: widget.dispute.offer,
        myPubkey: widget.dispute.offer.coordinatorPubkey,
        participantPubkey: widget.participantPubkey,
        imageBytes: bytes,
        recipientDmRelayDiscoveryRelays:
            widget.repository.session.dmRelayDiscoveryRelays,
        coordinatorBlossomDiscoveryRelays:
            widget.repository.session.dmRelayDiscoveryRelays,
      );
      await _appendLatestMessages();
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Evidence was not sent: $error')));
    } finally {
      if (mounted) setState(() => sending = false);
    }
  }

  bool get _isOpen =>
      widget.dispute.offer.statusRaw == OfferStatus.dispute.name;

  void _showReadOnlyMessage() => ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(content: Text('Resolved dispute history is read-only.')),
  );

  Future<void> preview(Nip17Message message) async {
    Uint8List? bytes;
    try {
      bytes = await _evidenceBytes(message);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Evidence failed: $error')));
      return;
    }
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (context) =>
          Dialog(child: InteractiveViewer(child: Image.memory(bytes!))),
    );
  }

  Future<Uint8List> _evidenceBytes(Nip17Message message) =>
      evidenceBytesByMessageId.putIfAbsent(
        message.id,
        () => widget.repository.communication.downloadEvidence(
          offer: widget.dispute.offer,
          myPubkey: widget.dispute.offer.coordinatorPubkey,
          participantPubkey: widget.participantPubkey,
          message: message,
          coordinatorBlossomDiscoveryRelays:
              widget.repository.session.dmRelayDiscoveryRelays,
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text(
              Nip19.encodePubKey(widget.participantPubkey),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (!loading && usesLegacyNip04 != null)
                  Chip(
                    visualDensity: VisualDensity.compact,
                    backgroundColor: usesLegacyNip04 == true
                        ? Colors.amber.shade200
                        : Colors.green.shade200,
                    label: Text(usesLegacyNip04 == true ? 'NIP-04' : 'NIP-17'),
                  ),
                IconButton(onPressed: refresh, icon: const Icon(Icons.refresh)),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: loading
                ? const Center(child: CircularProgressIndicator())
                : loadError != null
                ? Center(child: Text(loadError.toString()))
                : ListView.builder(
                    controller: scrollController,
                    padding: const EdgeInsets.all(8),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      final row = messages[index];
                      final message = row.nip17;
                      final file = message?.fileMetadata;
                      return Align(
                        alignment: row.isOutgoing
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Card(
                          color: message?.isOutgoing == true
                              ? Theme.of(context).colorScheme.primaryContainer
                              : null,
                          child: message == null
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(row.content),
                                )
                              : file == null
                              ? Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Text(message.content),
                                )
                              : _EvidenceThumbnail(
                                  bytes: _evidenceBytes(message),
                                  onTap: () => preview(message),
                                ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                if (usesLegacyNip04 != true)
                  IconButton(
                    onPressed: sending || !_isOpen ? null : attach,
                    icon: const Icon(Icons.attach_file),
                  ),
                Expanded(
                  child: TextField(
                    controller: controller,
                    enabled: !sending && _isOpen,
                    decoration: const InputDecoration(hintText: 'Reply here'),
                    onSubmitted: (_) => send(),
                  ),
                ),
                PopupMenuButton<String>(
                  enabled: !sending && _isOpen,
                  tooltip: 'Prepared replies',
                  icon: const Icon(Icons.arrow_drop_down_circle_outlined),
                  onSelected: (message) => unawaited(send(message)),
                  itemBuilder: (context) => [
                    for (final reply in _preparedReplies)
                      PopupMenuItem(
                        value: reply.message,
                        child: Text(reply.action),
                      ),
                  ],
                ),
                IconButton(
                  onPressed: sending || !_isOpen ? null : () => send(),
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const _preparedReplies = <({String action, String message})>[
  (
    action: 'Request evidence',
    message: 'Please provide clearer payment evidence.',
  ),
  (
    action: 'Request invoice',
    message:
        'Please submit the exact-amount Lightning payout invoice in BitBlik.',
  ),
];

class _EvidenceThumbnail extends StatelessWidget {
  const _EvidenceThumbnail({required this.bytes, required this.onTap});

  final Future<Uint8List> bytes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => FutureBuilder<Uint8List>(
    future: bytes,
    builder: (context, snapshot) {
      final loaded = snapshot.data;
      return Semantics(
        button: loaded != null,
        image: true,
        child: InkWell(
          onTap: loaded == null ? null : onTap,
          borderRadius: BorderRadius.circular(12),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: SizedBox(
              width: 144,
              height: 96,
              child: loaded != null
                  ? Image.memory(
                      loaded,
                      fit: BoxFit.cover,
                      gaplessPlayback: true,
                    )
                  : snapshot.hasError
                  ? const ColoredBox(
                      color: Colors.black12,
                      child: Center(child: Icon(Icons.broken_image_outlined)),
                    )
                  : const ColoredBox(
                      color: Colors.black12,
                      child: Center(
                        child: SizedBox.square(
                          dimension: 24,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        ),
                      ),
                    ),
            ),
          ),
        ),
      );
    },
  );
}

class _NekoAvatar extends StatelessWidget {
  const _NekoAvatar({required this.pubkey, required this.size});

  final String pubkey;
  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: size,
    height: size,
    child: ClipOval(
      child: Image.network(
        'https://robohash.org/$pubkey?set=set4',
        fit: BoxFit.cover,
        errorBuilder: (_, _, _) =>
            CircleAvatar(child: Icon(Icons.pets, size: size * 0.5)),
      ),
    ),
  );
}

class _LaneMessage {
  final Nip17Message? nip17;
  final LegacyNip04Message? legacy;

  const _LaneMessage.nip17(this.nip17) : legacy = null;
  const _LaneMessage.legacy(this.legacy) : nip17 = null;

  int get createdAt => nip17?.createdAt ?? legacy!.createdAt;
  // Unread tracking uses the stable decrypted rumor id, not the randomized
  // gift-wrap id. Both sides must compare the same id before acknowledging
  // that a newly received message has actually been rendered.
  String get id => nip17?.id ?? legacy!.event.id;
  bool get isOutgoing => nip17?.isOutgoing ?? legacy!.isOutgoing;
  String get content => nip17?.content ?? legacy!.content;
}
