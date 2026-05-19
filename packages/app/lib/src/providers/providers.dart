import 'dart:async'; // For Stream.periodic

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/entities.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:ndk/shared/logger/logger.dart';

import '../models/coordinator_info.dart';
import '../models/offer.dart'; // OfferStatus is in here
// ignore_for_file: depend_on_referenced_packages
import '../services/api_service_nostr.dart';
import '../services/nostr_service.dart'; // Import DiscoveredCoordinator
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

final discoveredCoordinatorsProvider = StateNotifierProvider<
  DiscoveredCoordinatorsNotifier,
  AsyncValue<List<DiscoveredCoordinator>>
>((ref) => DiscoveredCoordinatorsNotifier(ref));

class DiscoveredCoordinatorsNotifier
    extends StateNotifier<AsyncValue<List<DiscoveredCoordinator>>> {
  final Ref _ref;
  Timer? _refreshTimer;

  DiscoveredCoordinatorsNotifier(this._ref)
    : super(const AsyncValue.loading()) {
    _startDiscovery();
  }

  void _startPeriodicRefresh() {
    _refreshTimer = Timer.periodic(const Duration(seconds: 600), (timer) async {
      try {
        // Use initialized API service for periodic refresh
        final apiService = await _ref.read(
          initializedApiServiceProvider.future,
        );
        // await apiService.startCoordinatorDiscovery();
        await _loadCoordinators();
      } catch (e) {
        Logger.log.e(() => 'Error during periodic coordinator refresh: $e');
      }
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }

  Future<void> _loadCoordinators({bool skipHealthChecks = false}) async {
    try {
      // Use initialized API service to ensure KeyService is ready
      final apiService = await _ref.read(initializedApiServiceProvider.future);
      final coordinators = apiService.discoveredCoordinators;

      Logger.log.d(
        () =>
            '🔍 Provider: Loading ${coordinators.length} coordinators for health check',
      );

      // Don't set the state immediately - wait for health checks to complete

      if (!skipHealthChecks) {
        // Perform health checks for all discovered coordinators
        final healthCheckFutures = <Future<void>>[];
        for (final coordinator in coordinators) {
          Logger.log.d(
            () => '🔍 Provider: Starting health check for ${coordinator.name}',
          );
          healthCheckFutures.add(
            apiService.checkCoordinatorHealth(coordinator.pubkey),
          );
        }

        // Wait for all health checks to complete (with timeout)
        try {
          await Future.wait(
            healthCheckFutures,
          ).timeout(const Duration(seconds: 20));
          Logger.log.d(() => '🔍 Provider: All health checks completed');
        } catch (e) {
          Logger.log.w(() => 'Some health checks timed out or failed: $e');
          // Continue anyway - some coordinators may have been checked successfully
        }
      }

      // Now get the updated list with health check results and set the state
      final updatedCoordinators = apiService.discoveredCoordinators;
      Logger.log.d(
        () =>
            '🔍 Provider: Final coordinator list (${updatedCoordinators.length}):',
      );
      for (final coordinator in updatedCoordinators) {
        Logger.log.d(
          () => '  - ${coordinator.name}: responsive=${coordinator.responsive}',
        );
      }

      state = AsyncValue.data(updatedCoordinators);
    } catch (e, stack) {
      Logger.log.e(() => 'Error in _loadCoordinators: $e');
      state = AsyncValue.error(e, stack);
    }
  }

  /// Refresh the coordinator list without going through full discovery
  /// This preserves the current state and just updates the list
  Future<void> refreshList({bool runHealthChecks = false}) async {
    // Only refresh if we have data, otherwise let the normal discovery process handle it
    if (state.hasValue) {
      await _loadCoordinators(skipHealthChecks: !runHealthChecks);
    }
  }

  /// Trigger a full coordinator discovery refresh
  /// This will restart the discovery process and reload the coordinator list
  Future<void> refreshDiscovery() async {
    try {
      Logger.log.i(
        () =>
            '🔍 Provider: Manual refresh triggered, starting coordinator discovery...',
      );

      // Wait for API service to be fully initialized
      final apiService = await _ref.read(initializedApiServiceProvider.future);

      // Trigger discovery
      await apiService.startCoordinatorDiscovery();

      // Reload coordinators with health checks
      await _loadCoordinators(skipHealthChecks: false);
    } catch (e, stack) {
      Logger.log.e(() => 'Error in refreshDiscovery: $e');
      state = AsyncValue.error(e, stack);
    }
  }

  /// Trigger health check for a specific coordinator and update the list when done
  Future<void> checkCoordinatorHealthAndRefresh(
    String coordinatorPubkey,
  ) async {
    if (!state.hasValue) return;

    try {
      final apiService = await _ref.read(initializedApiServiceProvider.future);
      // Run health check in background
      apiService
          .checkCoordinatorHealth(coordinatorPubkey)
          .then((_) {
            // Update the list after health check completes
            refreshList(runHealthChecks: false);
          })
          .catchError((error) {
            Logger.log.w(
              () =>
                  '⚠️ Error during health check for $coordinatorPubkey: $error',
            );
            // Still refresh the list to update status
            refreshList(runHealthChecks: false);
          });
    } catch (e) {
      Logger.log.e(() => 'Error checking coordinator health: $e');
    }
  }

  /// Trigger health checks for multiple coordinators in background and update when done
  Future<void> checkCoordinatorsHealthAndRefresh(
    List<String> coordinatorPubkeys,
  ) async {
    if (!state.hasValue || coordinatorPubkeys.isEmpty) return;

    try {
      final apiService = await _ref.read(initializedApiServiceProvider.future);
      // Run health checks in parallel
      final futures =
          coordinatorPubkeys
              .map(
                (pubkey) => apiService
                    .checkCoordinatorHealth(pubkey)
                    .catchError((error) {
                      Logger.log.w(
                        () =>
                            '⚠️ Error during health check for $pubkey: $error',
                      );
                    }),
              )
              .toList();

      // Wait for all health checks to complete, then refresh
      Future.wait(futures)
          .then((_) {
            // Update the list after all health checks complete
            refreshList(runHealthChecks: false);
          })
          .catchError((error) {
            Logger.log.e(() => 'Error during health checks: $error');
            // Still refresh the list
            refreshList(runHealthChecks: false);
          });
    } catch (e) {
      Logger.log.e(() => 'Error checking coordinators health: $e');
    }
  }

  Future<void> _startDiscovery() async {
    try {
      state = const AsyncValue.loading();
      Logger.log.d(
        () =>
            '🔍 Provider: Starting coordinator discovery, waiting for API service initialization...',
      );

      // Wait for API service to be fully initialized (this ensures KeyService is ready)
      final apiService = await _ref.read(initializedApiServiceProvider.future);
      Logger.log.d(
        () =>
            '🔍 Provider: API service initialized, starting coordinator discovery...',
      );

      await apiService.startCoordinatorDiscovery();

      // After starting discovery, start periodic refresh and load coordinators
      _startPeriodicRefresh();
      await _loadCoordinators(skipHealthChecks: true);
    } catch (e, stack) {
      Logger.log.e(() => 'Error in _startDiscovery: $e');
      state = AsyncValue.error(e, stack);
    }
  }
}

/// Enhanced provider for coordinator info by pubkey that ensures discovery is triggered
/// and coordinator info is available as fast as possible.
///
/// This provider:
/// 1. First checks the cache for immediate access to coordinator info
/// 2. Ensures coordinator discovery is running by watching discoveredCoordinatorsProvider
/// 3. Handles loading, error, and success states properly
/// 4. Provides fallback mechanisms if coordinator is not found after discovery
final coordinatorInfoByPubkeyProvider = AsyncNotifierProvider.family<
  CoordinatorInfoNotifier,
  CoordinatorInfo?,
  String
>(CoordinatorInfoNotifier.new);

/// Notifier that manages coordinator info fetching with proper discovery integration
class CoordinatorInfoNotifier
    extends FamilyAsyncNotifier<CoordinatorInfo?, String> {
  @override
  Future<CoordinatorInfo?> build(String pubkey) async {
    // Wait for API service to be fully initialized (ensures KeyService is ready)
    final apiService = await ref.watch(initializedApiServiceProvider.future);

    // First, try to get coordinator info from cache for immediate access
    var coordinatorInfo = apiService.getCoordinatorInfoByPubkey(pubkey);
    if (coordinatorInfo != null) {
      return coordinatorInfo;
    }

    // If not in cache, ensure discovery is running by watching the discoveredCoordinatorsProvider
    // This triggers coordinator discovery if not already running
    final coordinatorsAsync = ref.watch(discoveredCoordinatorsProvider);

    await coordinatorsAsync.when(
      data: (coordinators) async {
        // Discovery has completed, check again for the coordinator
        coordinatorInfo = apiService.getCoordinatorInfoByPubkey(pubkey);
        if (coordinatorInfo == null) {
          // If still not found, try triggering discovery again and wait briefly
          try {
            await apiService.startCoordinatorDiscovery();
            await Future.delayed(const Duration(milliseconds: 500));
            coordinatorInfo = apiService.getCoordinatorInfoByPubkey(pubkey);
          } catch (e) {
            Logger.log.e(
              () => 'Error during coordinator discovery for $pubkey: $e',
            );
          }
        }
      },
      loading: () async {
        // Discovery is still in progress, wait a moment and try again
        await Future.delayed(const Duration(milliseconds: 200));
        coordinatorInfo = apiService.getCoordinatorInfoByPubkey(pubkey);
      },
      error: (error, stack) async {
        Logger.log.e(() => 'Error in coordinator discovery: $error');
        // Still try to get from cache even if discovery failed
        coordinatorInfo = apiService.getCoordinatorInfoByPubkey(pubkey);
      },
    );

    return coordinatorInfo;
  }

  /// Force refresh coordinator info for this pubkey
  Future<void> refresh() async {
    try {
      final apiService = await ref.read(initializedApiServiceProvider.future);
      await apiService.startCoordinatorDiscovery();
      await Future.delayed(const Duration(milliseconds: 500));
      final coordinatorInfo = apiService.getCoordinatorInfoByPubkey(arg);
      state = AsyncValue.data(coordinatorInfo);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}

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
  (ref) => ActiveOfferNotifier(),
);

class ActiveOfferNotifier extends StateNotifier<Offer?> {
  ActiveOfferNotifier() : super(null) {
    _loadActiveOffer();
  }

  Future<void> _loadActiveOffer() async {
    final offer = await OfferDbService().getActiveOffer();
    state = offer;
  }

  Future<void> setActiveOffer(Offer? offer) async {
    if (offer != null) {
      Logger.log.d(
        () => '[ActiveOfferNotifier] Setting active offer: ${offer.toJson()}',
      );
      await OfferDbService().upsertActiveOffer(offer);
    } else {
      Logger.log.d(() => '[ActiveOfferNotifier] Clearing active offer');
      await OfferDbService().deleteActiveOffer();
    }
    state = offer;
  }

  /// Update only the status of the current offer without triggering the subscription manager.
  /// This method updates the database and state directly to avoid circular dependencies.
  void updateOfferStatus(OfferStatusUpdate update) {
    if (state != null) {
      final updatedOffer = state!.copyWith(
        id: update.offerId,
        status: update.status,
        reservedAt: update.reservedAt,
      );
      // Update DB directly without going through setActiveOffer to avoid triggering listener
      OfferDbService().upsertActiveOffer(updatedOffer);
      // Update state directly - this will trigger UI updates but won't retrigger
      // the subscription manager since we check for ID changes in the listener
      state = updatedOffer;
    }
  }

  /// Force a database reset (useful for development when schema changes are made)
  Future<void> resetDatabase() async {
    await OfferDbService().resetDatabase();
    state = null;
  }
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

  // Wait for discovered coordinators to be available
  final coordinatorsAsync = ref.watch(discoveredCoordinatorsProvider);
  return await coordinatorsAsync.when(
    data: (coordinators) async {
      // Only proceed if we have discovered coordinators
      if (coordinators.isEmpty) {
        Logger.log.d(
          () =>
              'No coordinators discovered yet, returning empty finished offers list',
        );
        return <Offer>[];
      }

      Logger.log.d(
        () =>
            'Found ${coordinators.length} coordinators, loading finished offers',
      );
      // Use initialized API service to ensure KeyService is ready
      final apiService = await ref.read(initializedApiServiceProvider.future);
      // final activeOfferNotifier = ref.read(activeOfferProvider.notifier);
      final offersData = await apiService.getMyFinishedOffers(publicKey);
      final now = DateTime.now().toUtc();

      return offersData.where((offer) {
        if (offer.status == 'takerPaid') {
          final paidAt = offer.takerPaidAt;
          return paidAt != null && now.difference(paidAt.toUtc()).inHours < 24;
        }
        return false;
      }).toList();
    },
    loading: () => <Offer>[], // Return empty list while loading coordinators
    error: (error, stack) {
      Logger.log.e(
        () => 'Error loading coordinators for finished offers: $error',
      );
      return <Offer>[]; // Return empty list on error
    },
  );
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
            activeOfferNotifier.updateOfferStatus(statusUpdate);
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
  // Trigger coordinator discovery
  ref.watch(discoveredCoordinatorsProvider);
  // Then, fetch the specific offer.
  return apiService.getOffer(offerId);
});

// Provider for fetching successful offers statistics
final successfulOffersStatsProvider = FutureProvider<Map<String, dynamic>>((
  ref,
) async {
  // Wait for API service to be fully initialized
  final apiService = await ref.watch(initializedApiServiceProvider.future);

  // Wait for coordinators to be discovered before fetching stats
  final coordinatorsAsync = ref.watch(discoveredCoordinatorsProvider);
  await coordinatorsAsync.when(
    data: (coordinators) async {
      // Coordinators are loaded, we can proceed
      Logger.log.d(
        () =>
            '📊 Stats Provider: Found ${coordinators.length} coordinators for stats',
      );
    },
    loading: () async {
      // Wait a bit for coordinators to load
      Logger.log.d(
        () => '📊 Stats Provider: Waiting for coordinators to be discovered...',
      );
      await Future.delayed(const Duration(seconds: 2));
    },
    error: (error, stack) async {
      Logger.log.e(
        () => '📊 Stats Provider: Error loading coordinators: $error',
      );
    },
  );

  // Now fetch stats from the initialized service
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
