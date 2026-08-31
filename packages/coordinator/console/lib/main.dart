import 'dart:async';
import 'dart:typed_data';

import 'package:bitblik_core/core.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ndk/ndk.dart';
import 'package:ndk_flutter/l10n/app_localizations.dart';
import 'package:ndk_flutter/ndk_flutter.dart';

import 'src/coordinator_session.dart';
import 'src/dispute_case_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final ndk = Ndk(
    NdkConfig(
      cache: MemCacheManager(),
      eventVerifier: Bip340EventVerifier(),
      // Do not connect before NdkFlutter restores a signing account below.
      // Explicit relay requests made by CoordinatorSession open the required
      // sockets after that account is available.
      bootstrapRelays: const [],
      logLevel: LogLevel.warning,
    ),
  );
  final ndkFlutter = NdkFlutter(ndk: ndk);
  await ndkFlutter.restoreAccountsState();
  final session = CoordinatorSession(ndkFlutter: ndkFlutter);
  await session.restoreActiveCoordinator();
  await session.refreshCoordinatorProfiles();
  runApp(CoordinatorConsoleApp(session: session));
}

class CoordinatorConsoleApp extends StatelessWidget {
  final CoordinatorSession session;

  const CoordinatorConsoleApp({super.key, required this.session});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitBlik Coordinator Console',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: CoordinatorConsoleHome(session: session),
    );
  }
}

class CoordinatorConsoleHome extends StatefulWidget {
  final CoordinatorSession session;

  const CoordinatorConsoleHome({super.key, required this.session});

  @override
  State<CoordinatorConsoleHome> createState() => _CoordinatorConsoleHomeState();
}

class _CoordinatorConsoleHomeState extends State<CoordinatorConsoleHome> {
  bool busy = false;
  String? error;
  Account? removingAccount;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> run(Future<void> Function() action) async {
    setState(() {
      busy = true;
      error = null;
    });
    try {
      await action();
    } catch (exception) {
      if (mounted) setState(() => error = exception.toString());
    } finally {
      if (mounted) setState(() => busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: widget.session,
      builder: (context, _) {
        if (widget.session.isAuthenticated) {
          return DisputeQueueScreen(
            key: ValueKey(widget.session.expectedCoordinatorPubkey),
            session: widget.session,
          );
        }
        return Scaffold(
          appBar: AppBar(title: const Text('BitBlik Coordinator Console')),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 620),
              child: ListView(
                padding: const EdgeInsets.all(24),
                children: [
                  Text(
                    'Log in with a coordinator signer. Its pubkey determines '
                    'the coordinator whose disputes this console manages.',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  if (widget.session.accounts.isNotEmpty) ...[
                    const SizedBox(height: 20),
                    Text(
                      'Coordinator accounts',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 8),
                    NSwitchAccount(
                      ndkFlutter: widget.session.ndkFlutter,
                      beforeAccountRemove: (pubkey) {
                        removingAccount =
                            widget.session.ndk.accounts.accounts[pubkey];
                      },
                      onAccountRemove: (_) {
                        final account = removingAccount;
                        removingAccount = null;
                        if (account != null) {
                          run(() => widget.session.accountRemoved(account));
                        }
                      },
                      onAccountSwitch: (pubkey) =>
                          run(() => widget.session.switchCoordinator(pubkey)),
                    ),
                  ],
                  const SizedBox(height: 24),
                  NLogin(
                    ndkFlutter: widget.session.ndkFlutter,
                    onLoggedIn: () => run(() async {
                      await widget.session.activateLoggedInAccount();
                      await widget.session.refreshCoordinatorProfiles();
                    }),
                    enableAccountCreation: false,
                    enableNip05Login: false,
                    enableNpubLogin: false,
                    enablePubkeyLogin: false,
                    nsecLabelText: 'Coordinator private key (nsec)',
                  ),
                  if (busy) ...[
                    const SizedBox(height: 16),
                    const LinearProgressIndicator(),
                  ],
                  if (error != null) ...[
                    const SizedBox(height: 16),
                    Text(error!, style: const TextStyle(color: Colors.red)),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class DisputeQueueScreen extends StatefulWidget {
  final CoordinatorSession session;

  const DisputeQueueScreen({super.key, required this.session});

  @override
  State<DisputeQueueScreen> createState() => _DisputeQueueScreenState();
}

class _DisputeQueueScreenState extends State<DisputeQueueScreen> {
  late final DisputeCaseRepository repository;
  late Future<List<Offer>> cases;
  final seen = <String>{};
  String query = '';
  String? accountError;
  Account? removingAccount;

  @override
  void initState() {
    super.initState();
    repository = DisputeCaseRepository(session: widget.session);
    cases = repository.listDisputes();
  }

  void refresh() {
    final nextCases = repository.listDisputes();
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
          IconButton(
            tooltip: 'Switch coordinator account',
            icon: NPicture(
              ndkFlutter: widget.session.ndkFlutter,
              pubkey: widget.session.expectedCoordinatorPubkey,
              circleAvatarRadius: 14,
            ),
            onPressed: showAccounts,
          ),
          IconButton(
            tooltip: 'Remove current account',
            onPressed: widget.session.logout,
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
            child: FutureBuilder<List<Offer>>(
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
                    final unread = !seen.contains(offer.id);
                    final status = _disputeListStatus(offer.statusRaw);
                    return ListTile(
                      leading: Icon(
                        unread ? Icons.mark_email_unread : status.icon,
                        color: unread
                            ? Theme.of(context).colorScheme.primary
                            : status.color,
                      ),
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
                          Text('Created: ${_formatLocalDate(offer.createdAt)}'),
                          Text(
                            offer.id,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      isThreeLine: true,
                      trailing: const Icon(Icons.chevron_right),
                      onTap: () async {
                        setState(() => seen.add(offer.id));
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => DisputeCaseScreen(
                              repository: repository,
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
        ],
      ),
    );
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

class DisputeCaseScreen extends StatefulWidget {
  final DisputeCaseRepository repository;
  final String offerId;

  const DisputeCaseScreen({
    super.key,
    required this.repository,
    required this.offerId,
  });

  @override
  State<DisputeCaseScreen> createState() => _DisputeCaseScreenState();
}

class _DisputeCaseScreenState extends State<DisputeCaseScreen> {
  late Future<CoordinatorDisputeCase> dispute;
  CoordinatorDisputeCase? latestCase;
  Timer? refreshTimer;
  bool deciding = false;
  String? decisionStatus;

  @override
  void initState() {
    super.initState();
    dispute = _fetchCase();
    refreshTimer = Timer.periodic(
      const Duration(seconds: 4),
      (_) => unawaited(_refreshQuietly()),
    );
  }

  @override
  void dispose() {
    refreshTimer?.cancel();
    super.dispose();
  }

  Future<CoordinatorDisputeCase> _fetchCase() async {
    final item = await widget.repository.fetchCase(widget.offerId);
    latestCase = item;
    return item;
  }

  Future<void> _refreshQuietly() async {
    if (deciding) return;
    try {
      final item = await widget.repository.fetchCase(widget.offerId);
      if (!mounted) return;
      setState(() {
        latestCase = item;
        dispute = Future.value(item);
      });
    } catch (_) {
      // Keep displaying the last known case during transient relay/RPC errors.
    }
  }

  void refresh() {
    final nextDispute = _fetchCase();
    setState(() {
      dispute = nextDispute;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dispute ${widget.offerId}')),
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
                height: 560,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ConversationLane(
                        title: 'Maker',
                        dispute: item,
                        participantPubkey: offer.makerPubkey,
                        repository: widget.repository,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: takerPubkey == null
                          ? const Card(
                              child: Center(
                                child: Text('Taker lane unavailable'),
                              ),
                            )
                          : ConversationLane(
                              title: 'Taker',
                              dispute: item,
                              participantPubkey: takerPubkey,
                              repository: widget.repository,
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
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Decision submitted.')));
      setState(() => decisionStatus = 'Decision committed; refreshing state…');
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

class ConversationLane extends StatefulWidget {
  final String title;
  final CoordinatorDisputeCase dispute;
  final String participantPubkey;
  final DisputeCaseRepository repository;

  const ConversationLane({
    super.key,
    required this.title,
    required this.dispute,
    required this.participantPubkey,
    required this.repository,
  });

  @override
  State<ConversationLane> createState() => _ConversationLaneState();
}

class _ConversationLaneState extends State<ConversationLane> {
  final controller = TextEditingController();
  final scrollController = ScrollController();
  final messages = <_LaneMessage>[];
  StreamSubscription<Nip17Message>? dmInboxEvents;
  StreamSubscription<LegacyNip04Message>? legacyInboxEvents;
  bool loading = true;
  Object? loadError;
  bool sending = false;
  bool? usesLegacyNip04;

  @override
  void initState() {
    super.initState();
    unawaited(_initializeLane());
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
    final nip17 = await widget.repository.communication.loadMessagesSnapshot(
      offer: offer,
      myPubkey: offer.coordinatorPubkey,
      participantPubkey: widget.participantPubkey,
      includeUnbound: true,
    );
    final legacy = await widget.repository.communication.loadLegacyMessages(
      offer: offer,
      myPubkey: offer.coordinatorPubkey,
      participantPubkey: widget.participantPubkey,
      legacyRendezvousRelays: legacyRelays,
      forceRefresh: true,
      includeUnbound: true,
    );
    if (legacy.isNotEmpty) usesLegacyNip04 = true;
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
    if (!widget.repository.communication.isMessageForCase(
      offer: widget.dispute.offer,
      myPubkey: widget.dispute.offer.coordinatorPubkey,
      participantPubkey: widget.participantPubkey,
      message: message,
      includeUnbound: true,
    )) {
      return;
    }
    _appendMessages([_LaneMessage.nip17(message)]);
  }

  void _appendLiveLegacyMessage(LegacyNip04Message message) {
    final communication = widget.repository.communication;
    if (!communication.isLegacyMessageForCase(
      offer: widget.dispute.offer,
      myPubkey: widget.dispute.offer.coordinatorPubkey,
      participantPubkey: widget.participantPubkey,
      message: message,
      includeUnbound: true,
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
    setState(() {
      messages.addAll(additions);
      messages.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      loadError = null;
    });
    _scrollToBottomIfNearEnd(force: forceScroll);
  }

  void _scrollToBottomIfNearEnd({bool force = false}) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !scrollController.hasClients) return;
      final position = scrollController.position;
      if (force) {
        scrollController.jumpTo(position.maxScrollExtent);
        return;
      }
      if (position.extentAfter > 80) return;
      scrollController.animateTo(
        position.maxScrollExtent,
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
      );
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
      bytes = await widget.repository.communication.downloadEvidence(
        offer: widget.dispute.offer,
        myPubkey: widget.dispute.offer.coordinatorPubkey,
        participantPubkey: widget.participantPubkey,
        message: message,
      );
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

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            leading: _NekoAvatar(pubkey: widget.participantPubkey, size: 40),
            title: Text('${widget.title} lane'),
            subtitle: Text(
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
                              : TextButton.icon(
                                  onPressed: () => preview(message),
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
                        child: Text('${reply.action} · ${reply.language}'),
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

const _preparedReplies = <({String action, String language, String message})>[
  (
    action: 'Request evidence',
    language: 'EN',
    message: 'Please provide clearer payment evidence.',
  ),
  (
    action: 'Request evidence',
    language: 'DE',
    message: 'Bitte stelle einen deutlicheren Zahlungsnachweis bereit.',
  ),
  (
    action: 'Request evidence',
    language: 'FR',
    message: 'Veuillez fournir une preuve de paiement plus claire.',
  ),
  (
    action: 'Request evidence',
    language: 'IT',
    message: 'Fornisci una prova di pagamento più chiara.',
  ),
  (
    action: 'Request evidence',
    language: 'PL',
    message: 'Prześlij wyraźniejszy dowód płatności.',
  ),
  (
    action: 'Request evidence',
    language: 'PT',
    message: 'Envie um comprovativo de pagamento mais claro.',
  ),
  (
    action: 'Request evidence',
    language: 'SK',
    message: 'Poskytnite jasnejší doklad o platbe.',
  ),
  (
    action: 'Request invoice',
    language: 'EN',
    message:
        'Please submit the exact-amount Lightning payout invoice in BitBlik.',
  ),
  (
    action: 'Request invoice',
    language: 'DE',
    message:
        'Bitte reiche die Lightning-Auszahlungsrechnung über den exakten Betrag in BitBlik ein.',
  ),
  (
    action: 'Request invoice',
    language: 'FR',
    message:
        'Veuillez envoyer dans BitBlik la facture Lightning de paiement au montant exact.',
  ),
  (
    action: 'Request invoice',
    language: 'IT',
    message:
        'Invia in BitBlik la fattura Lightning di pagamento con l’importo esatto.',
  ),
  (
    action: 'Request invoice',
    language: 'PL',
    message: 'Prześlij w BitBlik fakturę wypłaty Lightning na dokładną kwotę.',
  ),
  (
    action: 'Request invoice',
    language: 'PT',
    message:
        'Envie no BitBlik a fatura Lightning de pagamento com o valor exato.',
  ),
  (
    action: 'Request invoice',
    language: 'SK',
    message: 'Odošlite v BitBlik Lightning faktúru na výplatu presnej sumy.',
  ),
];

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
  String get id => nip17?.wrappedEvent.id ?? legacy!.event.id;
  bool get isOutgoing => nip17?.isOutgoing ?? legacy!.isOutgoing;
  String get content => nip17?.content ?? legacy!.content;
}
