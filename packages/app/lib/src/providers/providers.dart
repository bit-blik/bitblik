import 'dart:async'; // For Stream.periodic

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/entities.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:ndk/shared/logger/logger.dart';

import 'package:bitblik_core/core.dart';
// ignore_for_file: depend_on_referenced_packages
import '../services/api_service_nostr.dart';
import '../services/key_service.dart'; // Import KeyService
import '../services/offer_db_service.dart';

final keyServiceProvider = Provider<KeyService>((ref) {
  final service = KeyService();
  return service;
});

// Provider for the default wallet (NWC wallet)
final defaultWalletProvider =
    StateNotifierProvider<DefaultWalletNotifier, Wallet?>(
      (ref) => DefaultWalletNotifier(ref),
    );

class DefaultWalletNotifier extends StateNotifier<Wallet?> {
  final Ref _ref;

  DefaultWalletNotifier(this._ref) : super(null) {
    _loadWallet();
  }

  void _loadWallet() {
    final ndk = _ref.read(ndkProvider);
    if (ndk == null) {
      state = null;
      return;
    }
    state = ndk.wallets.defaultWalletForSending;
  }

  /// Call this method after adding or removing a wallet to refresh the state
  void refresh() {
    _loadWallet();
  }
}

// Provider for wallet balances - streams list of WalletBalance updates for a specific wallet
// IMPORTANT: This provider calls getBalancesStream which initializes the stream and immediately
// fetches the current balance from NWC, then continues listening for updates
final walletBalancesProvider =
    StreamProvider.family<List<WalletBalance>, String>((ref, walletId) async* {
      final ndk = ref.watch(ndkProvider);
      if (ndk == null) {
        yield [];
        return;
      }

      await for (final balances in ndk.wallets.getBalancesStream(walletId)) {
        yield balances;
      }
    });

/// Provider to explicitly trigger balance stream initialization for a specific wallet
/// Use this to ensure the balance stream is initialized and emitting values
final walletBalanceInitProvider = Provider.family<void, String>((
  ref,
  walletId,
) {
  final ndk = ref.watch(ndkProvider);

  if (ndk != null) {
    // Calling getBalance initializes the internal balance stream for this wallet
    // This ensures the stream starts emitting values
    ndk.wallets.getBalance(walletId, "sat");
  }
});

final apiServiceProvider = Provider<ApiServiceNostr>((ref) {
  final keyService = ref.watch(keyServiceProvider);
  final apiService = ApiServiceNostr(keyService);
  ref.onDispose(() {
    apiService.dispose();
  });
  return apiService;
});

final initializedApiServiceProvider = FutureProvider<ApiServiceNostr>((
  ref,
) async {
  final apiService = ref.watch(apiServiceProvider);
  await apiService.init();
  return apiService;
});

/// Provider exposing the live [CoordinatorRegistry]. Kicks one-shot
/// discovery + stale-only health probes in the background on first
/// build; never blocks subscribers.
final coordinatorRegistryProvider =
    FutureProvider<CoordinatorRegistry>((ref) async {
  final apiService = await ref.watch(initializedApiServiceProvider.future);
  final registry = apiService.coordinatorRegistry;

  // Kick discovery + probes in background. Hydrated cache means
  // subscribers already see the previously-known list.
  unawaited(() async {
    try {
      await registry.discover();
      await registry.probeAllEnabled();
      // Best-effort: refresh network usage counts to seed scoring.
      unawaited(registry.fetchNetworkFinishedCounts());
    } catch (e) {
      Logger.log.e(() => 'Initial coordinator discovery failed: $e');
    }
  }());

  // Periodic refresh — same 10min cadence as before.
  final timer = Timer.periodic(const Duration(seconds: 600), (_) async {
    try {
      await registry.discover();
      await registry.probeAllEnabled();
    } catch (e) {
      Logger.log.e(() => 'Periodic coordinator refresh failed: $e');
    }
  });
  ref.onDispose(timer.cancel);

  return registry;
});

/// Stream of coordinator records (enabled + disabled) sorted by reliability.
/// Settings UI watches this directly.
final discoveredCoordinatorsProvider =
    StreamProvider<List<CoordinatorRecord>>((ref) async* {
  final registry = await ref.watch(coordinatorRegistryProvider.future);
  yield registry.all;
  yield* registry.changes;
});

/// Enabled-only view for the maker create-offer flow.
final enabledCoordinatorsProvider =
    Provider<AsyncValue<List<CoordinatorRecord>>>((ref) {
  final async = ref.watch(discoveredCoordinatorsProvider);
  return async.whenData(
    (records) => records.where((r) => r.enabled).toList(growable: false),
  );
});

/// Coordinator info lookup by pubkey — reads through the registry which
/// hydrates from cache on startup, so first call returns instantly for
/// known coordinators.
final coordinatorInfoByPubkeyProvider =
    FutureProvider.family<CoordinatorInfo?, String>((ref, pubkey) async {
  final registry = await ref.watch(coordinatorRegistryProvider.future);
  final cached = registry.infoFor(pubkey);
  if (cached != null) return cached;
  // Subscribing to changes will surface the info as soon as discovery
  // populates it. We poll the snapshot after the first change.
  await ref.watch(discoveredCoordinatorsProvider.future);
  return registry.infoFor(pubkey);
});

/// Helper provider to get reservation duration for a coordinator.
/// Returns Duration based on coordinator's reservationSeconds, or null if coordinator info unavailable.
final coordinatorReservationDurationProvider =
    Provider.family<Duration?, String>((ref, coordinatorPubkey) {
      final coordinatorInfoAsync = ref.watch(
        coordinatorInfoByPubkeyProvider(coordinatorPubkey),
      );
      return coordinatorInfoAsync.maybeWhen(
        data:
            (info) =>
                info != null
                    ? Duration(seconds: info.reservationSeconds)
                    : null,
        orElse: () => null,
      );
    });

// Only initialize the Nostr offer subscription once (global for the app lifetime)
final offersSubscriptionInitializer = FutureProvider<void>((ref) async {
  final apiService = await ref.watch(initializedApiServiceProvider.future);
  await apiService.startOfferSubscription();
});

final offers = <Offer>[];

// Provider for real-time list of available offers from Nostr subscription
final availableOffersProvider = StreamProvider<List<Offer>>((ref) async* {
  // Depend on single global initializer
  await ref.watch(offersSubscriptionInitializer.future);
  final apiService = ref.watch(apiServiceProvider);
  await for (final offer in apiService.offersStream) {
    offers.removeWhere((o) => o.id == offer.id);
    if (offer.status == 'funded' || offer.status == 'reserved') {
      offers.add(offer);
    }
    yield List<Offer>.from(offers.reversed);
  }
});

// Provider to hold the currently selected/active offer (if any)
final activeOfferProvider = StateNotifierProvider<ActiveOfferNotifier, Offer?>(
  (ref) => ActiveOfferNotifier(ref),
);

class ActiveOfferNotifier extends StateNotifier<Offer?> {
  ActiveOfferNotifier(this._ref) : super(null) {
    _loadActiveOffer();
  }

  final Ref _ref;

  /// Window used by boot-time reconciliation. An offer older than this is
  /// assumed to be definitively cancelled — coordinator hold invoice
  /// would have expired by then.
  static const Duration _cancelledLookbackWindow = Duration(hours: 24);

  Future<void> _loadActiveOffer() async {
    final offer = await OfferDbService().getActiveOffer();
    state = offer;
    // Only fire reconciliation when there is actually something to
    // reconcile. listRecentCancelled is a single indexed query — cheap.
    unawaited(_reconcileCancelledOffersIfNeeded());
  }

  /// Boot-time recovery: for every locally-cancelled offer within
  /// [_cancelledLookbackWindow], ask each coordinator for the user's
  /// current active offer. If the coordinator reports the same id with a
  /// non-terminal status, persist that status and revive the offer.
  Future<void> _reconcileCancelledOffersIfNeeded() async {
    try {
      final cancelled = await OfferDbService()
          .listRecentCancelled(_cancelledLookbackWindow);
      if (cancelled.isEmpty) return;

      final apiService =
          await _ref.read(initializedApiServiceProvider.future);
      final userPubkey = _ref.read(keyServiceProvider).publicKeyHex;
      if (userPubkey == null) return;

      // Group cancelled offers by coordinator for one RPC per coordinator.
      final byCoordinator = <String, List<Offer>>{};
      for (final offer in cancelled) {
        byCoordinator
            .putIfAbsent(offer.coordinatorPubkey, () => [])
            .add(offer);
      }

      Logger.log.i(
        () =>
            '[ActiveOfferNotifier] reconciling ${cancelled.length} cancelled offers across ${byCoordinator.length} coordinators',
      );

      for (final entry in byCoordinator.entries) {
        try {
          final remote = await apiService.getMyActiveOffer(
            userPubkey,
            entry.key,
          );
          if (remote == null) continue;

          final remoteId = remote['id']?.toString();
          if (remoteId == null) continue;

          final localMatch =
              entry.value.where((o) => o.id == remoteId).toList();
          if (localMatch.isEmpty) continue;

          OfferStatus remoteStatus;
          try {
            remoteStatus =
                OfferStatus.values.byName(remote['status']?.toString() ?? '');
          } catch (_) {
            continue;
          }
          if (OfferDbService.terminalStatuses.contains(remoteStatus)) {
            continue;
          }

          final revived = localMatch.first.copyWith(
            id: remoteId,
            status: remoteStatus,
          );
          await OfferDbService().upsertOffer(revived);
          Logger.log.i(
            () =>
                '[ActiveOfferNotifier] revived cancelled offer $remoteId -> ${remoteStatus.name}',
          );

          // Only promote to in-memory active offer when nothing else is
          // active — avoids stomping on a fresh offer the user just made.
          if (state == null) {
            state = revived;
          }
        } catch (e) {
          Logger.log.w(
            () =>
                '[ActiveOfferNotifier] reconciliation failed for coordinator ${entry.key}: $e',
          );
        }
      }
    } catch (e) {
      Logger.log.e(
        () =>
            '[ActiveOfferNotifier] cancelled-offer reconciliation failed: $e',
      );
    }
  }

  Future<void> setActiveOffer(Offer? offer) async {
    if (offer != null) {
      Logger.log.d(
        () => '[ActiveOfferNotifier] Setting active offer: ${offer.id}',
      );
      await OfferDbService().upsertOffer(offer);
    } else {
      Logger.log.d(() => '[ActiveOfferNotifier] Clearing in-memory active offer (history preserved)');
    }
    state = offer;
  }

  /// Cancel the currently active offer, with a coordinator pre-check.
  ///
  /// Flow:
  ///   1. Ask the coordinator for the user's active offer.
  ///   2. If the coordinator reports the same offer as already `funded`,
  ///      throw [OfferAlreadyFundedException] without touching local state.
  ///      Caller should redirect into the funded flow.
  ///   3. Otherwise call `cancel_offer` RPC best-effort, mark the local
  ///      row `cancelled`, and clear the in-memory active state. The
  ///      DB row stays so a future status update can revive it.
  Future<void> cancelActiveOffer() async {
    final current = state;
    if (current == null) return;

    final apiService =
        await _ref.read(initializedApiServiceProvider.future);
    final keyService = _ref.read(keyServiceProvider);
    final userPubkey = keyService.publicKeyHex;
    if (userPubkey == null) {
      throw StateError('User pubkey not available');
    }

    Map<String, dynamic>? coordinatorOffer;
    try {
      coordinatorOffer = await apiService.getMyActiveOffer(
        userPubkey,
        current.coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.w(
        () =>
            '[ActiveOfferNotifier] getMyActiveOffer failed during cancel: $e',
      );
    }

    if (coordinatorOffer != null) {
      final remoteId = coordinatorOffer['id']?.toString();
      final remoteStatusRaw = coordinatorOffer['status']?.toString();
      OfferStatus? remoteStatus;
      if (remoteStatusRaw != null) {
        try {
          remoteStatus = OfferStatus.values.byName(remoteStatusRaw);
        } catch (_) {
          remoteStatus = OfferStatus.unknown;
        }
      }

      final sameOffer = remoteId != null &&
          (remoteId == current.id ||
              current.holdInvoicePaymentHash != null &&
                  remoteId == current.holdInvoicePaymentHash);

      if (sameOffer &&
          remoteStatus != null &&
          remoteStatus.index >= OfferStatus.funded.index &&
          !OfferDbService.terminalStatuses.contains(remoteStatus)) {
        // Coordinator already funded this offer (or moved further).
        // Persist whatever the coordinator says, but refuse to cancel locally.
        final updated = current.copyWith(
          id: remoteId,
          status: remoteStatus,
        );
        await OfferDbService().upsertOffer(updated);
        state = updated;
        throw OfferAlreadyFundedException(remoteStatus);
      }
    }

    // Best-effort cancel RPC. Swallow errors — local row still moves to
    // `cancelled` and a later status update can revive it.
    // Use coordinator-provided UUID when available; local id may be a payment
    // hash or the legacy "empty" placeholder which the coordinator rejects.
    final cancelId = coordinatorOffer?['id']?.toString() ?? current.id;
    try {
      await apiService.cancelOffer(cancelId, current.coordinatorPubkey);
    } catch (e) {
      Logger.log.w(
        () => '[ActiveOfferNotifier] cancel_offer RPC failed: $e',
      );
    }

    final cancelled = current.copyWith(status: OfferStatus.cancelled);
    await OfferDbService().upsertOffer(cancelled);
    state = null;
  }

  /// Persist a status update from the coordinator.
  ///
  /// Always updates the DB row matching the update's id (or payment hash).
  /// If that row is also the in-memory active offer, the state mirrors the
  /// change. If the in-memory state is null but the persisted row was
  /// `cancelled` and the update revives it to a non-terminal status, the
  /// offer is restored as the active one ("funded-after-cancel" recovery).
  Future<void> applyStatusUpdate(OfferStatusUpdate update) async {
    OfferStatus newStatus;
    try {
      newStatus = OfferStatus.values.byName(update.status);
    } catch (_) {
      newStatus = OfferStatus.unknown;
    }

    final db = OfferDbService();
    Offer? existing = await db.getOfferById(update.offerId);
    if (existing == null && update.paymentHash.isNotEmpty) {
      existing = await db.getOfferByPaymentHash(update.paymentHash);
    }

    if (existing == null) {
      Logger.log.d(
        () =>
            '[ActiveOfferNotifier] status update for unknown offer ${update.offerId}; ignoring',
      );
      return;
    }

    final updated = existing.copyWith(
      id: update.offerId,
      status: newStatus,
      reservedAt: update.reservedAt,
    );
    // When matched by paymentHash the coordinator UUID differs from local id;
    // delete the old row so upsert doesn't leave a duplicate.
    if (existing.id != updated.id) {
      await db.deleteOfferById(existing.id);
    }
    await db.upsertOffer(updated);

    final currentState = state;
    final isCurrent = currentState != null &&
        (currentState.id == updated.id ||
            (currentState.holdInvoicePaymentHash != null &&
                currentState.holdInvoicePaymentHash ==
                    updated.holdInvoicePaymentHash));

    if (isCurrent) {
      state = updated;
      return;
    }

    // Revival: in-memory state is null/different but a previously
    // cancelled offer just received a non-terminal update from the
    // coordinator. Restore it as the active offer.
    if (existing.status == OfferStatus.cancelled &&
        !OfferDbService.terminalStatuses.contains(newStatus)) {
      Logger.log.i(
        () =>
            '[ActiveOfferNotifier] reviving cancelled offer ${updated.id} -> ${newStatus.name}',
      );
      state = updated;
    }
  }

  /// Force a database reset (useful for development when schema changes are made)
  Future<void> resetDatabase() async {
    await OfferDbService().resetDatabase();
    state = null;
  }
}

/// All offers in the local DB (history). Re-fetches when the active
/// offer changes (covers create / cancel / status update) so the list
/// stays current without manual invalidation.
final myOffersProvider = FutureProvider<List<Offer>>((ref) async {
  ref.watch(activeOfferProvider);
  return OfferDbService().listOffers();
});

class OfferAlreadyFundedException implements Exception {
  final OfferStatus status;
  const OfferAlreadyFundedException(this.status);

  @override
  String toString() =>
      'OfferAlreadyFundedException: coordinator reports status=${status.name}';
}

/// Provider to expose the stored Lightning Address
final lightningAddressProvider = FutureProvider<String?>((ref) async {
  ref.watch(initializedApiServiceProvider);
  final keyService = ref.watch(keyServiceProvider);
  // Ensure KeyService is initialized (which loads keys) before getting address
  return keyService.getLightningAddress();
});

/// Provider that indicates whether any wallet can receive funds.
/// This listens to wallet changes so UI updates immediately after add/remove.
final hasReceivingWalletProvider = StreamProvider<bool>((ref) async* {
  await ref.watch(initializedApiServiceProvider.future);
  final ndk = ref.watch(ndkProvider);
  if (ndk == null) {
    yield false;
    return;
  }

  bool hasReceivingWallet(Iterable<Wallet> wallets) {
    for (final wallet in wallets) {
      if (wallet.canReceive) {
        return true;
      }
    }
    return false;
  }

  final initialWallets = ndk.wallets.getWalletsForUnit('sat');
  yield hasReceivingWallet(initialWallets);

  await for (final wallets in ndk.wallets.walletsStream) {
    yield hasReceivingWallet(wallets);
  }
});

/// Provider for finished (takerPaid, <24h) offers for the current user (taker)
/// This provider waits for discovered coordinators before loading finished offers
final finishedOffersProvider = FutureProvider<List<Offer>>((ref) async {
  final publicKey = await ref.watch(publicKeyProvider.future);
  if (publicKey == null) return [];

  // Snapshot the registry once. Do NOT subscribe to the registry's change
  // stream here: this provider also writes to the registry below
  // (updateLocalFinishedCounts), and a subscription would form a feedback
  // loop that re-fans out one RPC per coordinator on every tick.
  final registry = await ref.watch(coordinatorRegistryProvider.future);
  final coordinators = registry.enabled;
  if (coordinators.isEmpty) {
    Logger.log.d(
      () => 'No coordinators enabled yet, returning empty finished offers list',
    );
    return <Offer>[];
  }

  Logger.log.d(
    () => 'Loading finished offers from ${coordinators.length} coordinators',
  );
  final apiService = await ref.read(initializedApiServiceProvider.future);
  final offersData = await apiService.getMyFinishedOffers(publicKey);

  // Feed personal-finished counts into the registry so they influence
  // coordinator sort order. updateLocalFinishedCounts is now a no-op
  // when values are unchanged, so this is safe to call on every refresh.
  final counts = <String, int>{};
  for (final offer in offersData) {
    if (offer.status == OfferStatus.takerPaid ||
        offer.status == OfferStatus.settled ||
        offer.status == OfferStatus.makerConfirmed) {
      counts[offer.coordinatorPubkey] =
          (counts[offer.coordinatorPubkey] ?? 0) + 1;
    }
  }
  if (counts.isNotEmpty) {
    registry.updateLocalFinishedCounts(counts);
  }

  final now = DateTime.now().toUtc();
  return offersData.where((offer) {
    if (offer.status == OfferStatus.takerPaid) {
      final paidAt = offer.takerPaidAt;
      return paidAt != null && now.difference(paidAt.toUtc()).inHours < 24;
    }
    return false;
  }).toList();
});

/// This provider manages the lifecycle of the offer status subscription.
/// It should be initialized once in the app's lifecycle, for example in main.dart,
/// to ensure it's always running and can react to changes in the active offer.
final offerStatusSubscriptionManagerProvider = Provider<void>((ref) {
  StreamSubscription? statusSubscription;
  String? _currentOfferId;

  ref.listen<Offer?>(activeOfferProvider, (previous, current) {
    // Only react to offer ID changes, not status changes, to avoid circular dependency
    final currentOfferId = current?.id;

    // Check if this is just a status update for the same offer
    final previousOfferId = previous?.id;
    if (currentOfferId != null &&
        currentOfferId == previousOfferId &&
        currentOfferId == _currentOfferId) {
      // Same offer, just status changed - don't restart subscription
      return;
    }

    // Offer ID changed, offer was cleared, or initial setup - update subscription
    _currentOfferId = currentOfferId;
    statusSubscription?.cancel();

    if (current != null) {
      Logger.log.d(
        () =>
            "[SubscriptionManager] Active offer changed to ${current.id}. Starting new status subscription.",
      );
      final apiService = ref.read(apiServiceProvider);
      final keyService = ref.read(keyServiceProvider);
      final activeOfferNotifier = ref.read(activeOfferProvider.notifier);

      final publiKey = keyService.publicKeyHex;
      if (publiKey == null) return;

      // Start the subscription for the new active offer.
      apiService.startOfferStatusSubscription(
        current.coordinatorPubkey,
        publiKey,
      );

      // Listen to the stream for status updates.
      statusSubscription = apiService.offerStatusStream.listen((statusUpdate) {
        // Ensure the update is for the current active offer.
        if (statusUpdate.offerId == current.id ||
            statusUpdate.paymentHash == current.holdInvoicePaymentHash) {
          OfferStatus? newStatus;
          try {
            newStatus = OfferStatus.values.byName(statusUpdate.status);
          } catch (e) {
            Logger.log.e(
              () => "Error parsing status string '${statusUpdate.status}': $e",
            );
          }

          if (newStatus != null) {
            Logger.log.d(
              () =>
                  "Offer ${current.id} status updated to: $newStatus. Updating active offer provider.",
            );
            activeOfferNotifier.applyStatusUpdate(statusUpdate);
          }
        }
      });
    } else {
      Logger.log.d(
        () =>
            "[SubscriptionManager] Active offer cleared. Subscription stopped.",
      );
      _currentOfferId = null;
    }
  }, fireImmediately: true); // fireImmediately to handle initial state
});

// Provider for fetching a single offer's details.
// It's a family provider because it depends on an external parameter (the offer ID).
final offerDetailsProvider = FutureProvider.family<Offer?, String>((
  ref,
  offerId,
) async {
  // First, ensure that the API service is fully initialized.
  final apiService = await ref.watch(initializedApiServiceProvider.future);
  // Ensure registry is built (kicks discovery in background); do not
  // subscribe to its stream — we only need to read the offer once.
  await ref.watch(coordinatorRegistryProvider.future);
  return apiService.getOffer(offerId);
});

// Provider for fetching successful offers statistics
final successfulOffersStatsProvider = FutureProvider<Map<String, dynamic>>((
  ref,
) async {
  // Wait for API service to be fully initialized
  final apiService = await ref.watch(initializedApiServiceProvider.future);

  // Snapshot the registry once — do not subscribe to its change stream
  // here. This provider issues N RPCs per refresh; reacting to every
  // registry tick would amplify traffic.
  final registry = await ref.watch(coordinatorRegistryProvider.future);
  Logger.log.d(
    () =>
        '📊 Stats Provider: ${registry.enabled.length} coordinators for stats',
  );

  return apiService.getSuccessfulOffersStats();
});

// Provider to expose the public key hex.
final publicKeyProvider = FutureProvider<String?>((ref) async {
  final keyService = ref.watch(keyServiceProvider);
  await keyService.init(); // Ensure KeyService is initialized
  return keyService.publicKeyHex; // Return the public key
});

// Provider to hold the generated hold invoice for the Maker
final holdInvoiceProvider = StateProvider<String?>((ref) => null);

// Provider to hold the payment hash for the Maker's offer
final paymentHashProvider = StateProvider<String?>((ref) => null);

// Provider to manage the current role (Maker/Taker) or view state
// enum AppRole { none, maker, taker }

// final appRoleProvider = StateProvider<AppRole>((ref) => AppRole.none);

// Provider to manage loading states for specific actions
final isLoadingProvider = StateProvider<bool>((ref) => false);

// Provider to hold the BLIK code received by the Maker
final receivedBlikCodeProvider = StateProvider<String?>((ref) => null);

// Provider to hold error messages for display in the UI
final errorProvider = StateProvider<String?>((ref) => null);

// Provider to access NDK instance for connectivity management
final ndkProvider = Provider((ref) {
  ref.watch(initializedApiServiceProvider);
  final apiService = ref.watch(apiServiceProvider);
  return apiService.ndk;
});

final ndkFlutterProvider = Provider<NdkFlutter?>((ref) {
  final ndk = ref.watch(ndkProvider);
  if (ndk == null) return null;
  return NdkFlutter(ndk: ndk);
});

/// Connection state enum for relay websocket
enum RelayConnectionState { connected, connecting, reconnecting, disconnected }

/// Relay connectivity data for UI display
class RelayStatus {
  final String url;
  final RelayConnectionState state;

  RelayStatus({required this.url, required this.state});

  bool get isConnected => state == RelayConnectionState.connected;
}

/// Provider that streams relay connectivity status
/// Returns a Map of relay URL to connection status
final relayConnectivityProvider =
    StateNotifierProvider<RelayConnectivityNotifier, Map<String, RelayStatus>>((
      ref,
    ) {
      return RelayConnectivityNotifier(ref);
    });

/// Notifier that manages relay connectivity state
class RelayConnectivityNotifier
    extends StateNotifier<Map<String, RelayStatus>> {
  final Ref _ref;
  StreamSubscription? _subscription;
  bool _initialized = false;

  RelayConnectivityNotifier(this._ref) : super({}) {
    _init();
  }

  Future<void> _init() async {
    if (_initialized) return;

    try {
      // Wait for API service to be fully initialized before accessing NDK
      final apiService = await _ref.read(initializedApiServiceProvider.future);
      final ndk = apiService.ndk;

      if (ndk == null) {
        return;
      }

      // Get initial state from the current global state
      _updateFromRelays(ndk.relays.globalState.relays);

      // Subscribe to the stream for updates
      _subscription = ndk.connectivity.relayConnectivityChanges.listen((
        connectivityMap,
      ) {
        _updateFromRelays(connectivityMap);
      });

      _initialized = true;
    } catch (e) {
      Logger.log.e(() => 'Error initializing relay connectivity: $e');
    }
  }

  void _updateFromRelays(Map<String, dynamic> relays) {
    final result = <String, RelayStatus>{};
    for (final entry in relays.entries) {
      final relayConnectivity = entry.value;
      result[entry.key] = RelayStatus(
        url: relayConnectivity.url,
        state: _determineRelayState(relayConnectivity),
      );
    }
    state = result;
  }

  /// Helper function to determine relay connection state
  RelayConnectionState _determineRelayState(dynamic relayConnectivity) {
    if (relayConnectivity.isConnected) {
      return RelayConnectionState.connected;
    } else if (relayConnectivity.relay.connecting) {
      // If transport exists but not open, and relay is in connecting mode
      if (relayConnectivity.relayTransport != null) {
        // Has transport but not connected = reconnecting
        return RelayConnectionState.reconnecting;
      } else {
        return RelayConnectionState.connecting;
      }
    } else {
      return RelayConnectionState.disconnected;
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}

// Provider for app lifecycle management
final appLifecycleProvider = Provider<AppLifecycleNotifier>((ref) {
  // Pass the ref to the notifier
  final notifier = AppLifecycleNotifier(ref);
  notifier.initialize();
  ref.onDispose(() {
    notifier.dispose();
  });
  return notifier;
});

final nwcWalletAuthCoordinatorProvider = Provider<NwcWalletAuthCoordinator>((
  ref,
) {
  return NwcWalletAuthCoordinator();
});

class WalletProtocolDispatcher {
  Future<bool> Function(String url)? _handler;
  final List<String> _pending = <String>[];

  void attach(Future<bool> Function(String url) handler) {
    _handler = handler;

    if (_pending.isEmpty) return;
    final queued = List<String>.from(_pending);
    _pending.clear();
    for (final url in queued) {
      unawaited(_dispatchNow(url));
    }
  }

  void detach(Future<bool> Function(String url) handler) {
    if (identical(_handler, handler)) {
      _handler = null;
    }
  }

  void dispatch(String url) {
    final handler = _handler;
    if (handler != null) {
      unawaited(_dispatchNow(url));
      return;
    }
    _pending.add(url);
  }

  Future<bool> _dispatchNow(String url) async {
    final handler = _handler;
    if (handler == null) return false;
    try {
      return await handler(url);
    } catch (_) {
      return false;
    }
  }
}

final walletProtocolDispatcherProvider = Provider<WalletProtocolDispatcher>((
  ref,
) {
  return WalletProtocolDispatcher();
});

/// App-level background wallet warmup.
/// Ensures NWC wallets are initialized even if the user never opens /wallet.
final walletWarmupProvider = Provider<void>((ref) {
  StreamSubscription? walletsSubscription;

  void warmupWallets(Iterable<Wallet> wallets) {
    final ndk = ref.read(ndkProvider);
    if (ndk == null) return;

    for (final wallet in wallets) {
      if (wallet.type == WalletType.NWC) {
        try {
          // Triggers NWC capability/balance hydration (uses cache when available).
          ndk.wallets.getBalance(wallet.id, 'sat');
        } catch (e) {
          Logger.log.w(
            () => '⚠️ NWC wallet warmup failed for ${wallet.id}: $e',
          );
        }
      }
    }
  }

  Future<void> startWarmup() async {
    try {
      await ref.read(initializedApiServiceProvider.future);
      final ndk = ref.read(ndkProvider);
      if (ndk == null) return;

      warmupWallets(ndk.wallets.getWalletsForUnit('sat'));

      walletsSubscription = ndk.wallets.walletsStream.listen((wallets) {
        warmupWallets(wallets);
      });
    } catch (e) {
      Logger.log.w(() => '⚠️ Background wallet warmup init failed: $e');
    }
  }

  unawaited(startWarmup());

  ref.onDispose(() {
    walletsSubscription?.cancel();
  });
});

/// Notifier that handles app lifecycle changes and reconnects NDK when app resumes
class AppLifecycleNotifier with WidgetsBindingObserver {
  final Ref _ref;

  AppLifecycleNotifier(this._ref);

  AppLifecycleState _currentState = AppLifecycleState.resumed;

  AppLifecycleState get currentState => _currentState;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
  }

  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState = state;

    switch (state) {
      case AppLifecycleState.resumed:
        final ndkInstance = _ref.read(ndkProvider);
        // faster reconnects
        if (ndkInstance != null) {
          // ndkInstance.connectivity.do();
        }
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
