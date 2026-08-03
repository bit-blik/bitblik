import 'dart:async'; // For Stream.periodic
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ndk/entities.dart';
import 'package:ndk_flutter/ndk_flutter.dart';
import 'package:ndk/shared/logger/logger.dart';

import 'package:bitblik_core/core.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
// ignore_for_file: depend_on_referenced_packages
import '../services/api_service_nostr.dart';
import '../services/key_service.dart'; // Import KeyService
import '../services/nfc_lnurl_service.dart';
import '../services/relay_reconnect_gate.dart';
import '../utils/offer_status_label.dart';
import '../services/notification_service.dart';
import '../services/offer_db_service.dart';
import '../../i18n/gen/strings.g.dart';
import '../settings/app_preferences.dart';
import '../config/build_flavor.dart';
import '../utils/bitcoin_display.dart';

final keyServiceProvider = Provider<KeyService>((ref) {
  final service = KeyService();
  return service;
});

final nfcLnurlServiceProvider = Provider<NfcLnurlService>((ref) {
  final service = NfcLnurlService();
  ref.onDispose(service.dispose);
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
/// discovery refresh timer in the background on first build; never blocks
/// subscribers.
final coordinatorRegistryProvider = FutureProvider<CoordinatorRegistry>((
  ref,
) async {
  final apiService = await ref.watch(initializedApiServiceProvider.future);
  final registry = apiService.coordinatorRegistry;

  // Point discovery at the active payment system's project identity before the
  // first sweep (Bitblik vs Bitway), so the initial discovery already resolves
  // the right market's relays + coordinators. Later switches are handled by
  // [discoveryIdentityInitializer].
  final initialMethod = ref.read(selectedPaymentSystemProvider);
  registry.setDiscoveryContext(
    hex: initialMethod.discoveryPubkeyHex,
    paymentSystemId: initialMethod.id,
  );

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

/// Starts the first discovery sweep only after the app has had a chance to
/// subscribe to [coordinatorColdStartProvider], avoiding a startup race where
/// release builds can emit and clear the cold-start state before the overlay is
/// listening.
final coordinatorDiscoveryBootstrapProvider = FutureProvider<void>((ref) async {
  final registry = await ref.watch(coordinatorRegistryProvider.future);
  try {
    await registry.discover();
    await registry.probeAllEnabled();
    // Best-effort: refresh network usage counts to seed scoring.
    unawaited(registry.fetchNetworkFinishedCounts());
    // Best-effort: count the user's own successful offers per coordinator.
    unawaited(_refreshLocalFinishedCounts(ref, registry));
  } catch (e) {
    Logger.log.e(() => 'Initial coordinator discovery failed: $e');
  }
});

/// Count the user's own successful (takerPaid) offers per coordinator and feed
/// them to the registry so the "your offers" metric reflects real data.
Future<void> _refreshLocalFinishedCounts(
  Ref ref,
  CoordinatorRegistry registry,
) async {
  try {
    final pubkey = ref.read(keyServiceProvider).publicKeyHex;
    if (pubkey == null) return;
    final counts = await OfferDbService().countFinishedByCoordinator(pubkey);
    registry.updateLocalFinishedCounts(counts);
  } catch (e) {
    Logger.log.w(() => 'Failed to refresh local finished counts: $e');
  }
}

/// Stream of coordinator records (enabled + disabled) sorted by reliability.
/// Settings UI watches this directly.
final discoveredCoordinatorsProvider = StreamProvider<List<CoordinatorRecord>>((
  ref,
) async* {
  final registry = await ref.watch(coordinatorRegistryProvider.future);
  // Keep discovery pointed at the active market's identity; re-points + re-runs
  // discovery on market switches (the registry then emits the new set).
  ref.watch(discoveryIdentityInitializer);
  yield registry.all;
  yield* registry.changes;
});

final coordinatorColdStartProvider = StreamProvider<CoordinatorColdStartState?>(
  (ref) async* {
    final registry = await ref.watch(coordinatorRegistryProvider.future);
    yield registry.coldStartState;
    yield* registry.coldStartChanges;
  },
);

/// Enabled-only view for the maker create-offer flow, restricted to the active
/// payment method so a PL user never creates an offer on a PT coordinator (and
/// vice versa). Records pending discovery (no `info` yet) are excluded.
final enabledCoordinatorsProvider =
    Provider<AsyncValue<List<CoordinatorRecord>>>((ref) {
      final async = ref.watch(discoveredCoordinatorsProvider);
      final method = ref.watch(selectedPaymentSystemProvider);
      return async.whenData(
        (records) => records
            .where((r) => r.enabled && r.paymentSystem == method.id)
            .toList(growable: false),
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

/// Live [CoordinatorRecord] lookup by pubkey (hex). Tracks registry changes so
/// the details screen reflects relay/health updates. Returns null until the
/// coordinator is known.
final coordinatorRecordByPubkeyProvider =
    Provider.family<CoordinatorRecord?, String>((ref, pubkey) {
      final async = ref.watch(discoveredCoordinatorsProvider);
      return async.maybeWhen(
        data: (records) {
          for (final r in records) {
            if (r.pubkeyHex == pubkey) return r;
          }
          return null;
        },
        orElse: () => null,
      );
    });

/// Debug-only helper that resolves which relays served the latest cached
/// coordinator kind-15125 event for [pubkey], using cache provenance instead of
/// the deprecated `event.sources`.
final coordinatorInfoEventSourcesProvider =
    FutureProvider.family<List<String>, String>((ref, pubkey) async {
      final ndk = ref.watch(ndkProvider);
      if (ndk == null) return const [];

      final events = await ndk.config.cache.loadEvents(
        pubKeys: [pubkey],
        kinds: [kKindCoordinatorInfo],
        limit: 1,
      );
      if (events.isEmpty) return const [];

      final sources = await ndk.config.cache.loadEventSources(events.first.id);
      final out =
          sources.map(normalizeRelayUrl).where((u) => u.isNotEmpty).toSet()
            ..remove('');
      final list = out.toList()..sort();
      return list;
    });

/// Helper provider for the takerCharged auto-confirm duration of a coordinator.
/// Returns Duration based on the coordinator's
/// `takerChargedAutoConfirmSeconds`, or null if coordinator info unavailable.
final coordinatorTakerChargedAutoConfirmDurationProvider =
    Provider.family<Duration?, String>((ref, coordinatorPubkey) {
      // Prefer the live registry record so a freshly published info event
      // (e.g. after the coordinator restarts with a new
      // TAKER_CHARGED_AUTO_CONFIRM_SECONDS) updates the value immediately,
      // instead of being pinned to a stale persisted/cached copy.
      final record = ref.watch(
        coordinatorRecordByPubkeyProvider(coordinatorPubkey),
      );
      if (record?.info != null) {
        return Duration(seconds: record!.info!.takerChargedAutoConfirmSeconds);
      }
      final coordinatorInfoAsync = ref.watch(
        coordinatorInfoByPubkeyProvider(coordinatorPubkey),
      );
      return coordinatorInfoAsync.maybeWhen(
        data:
            (info) =>
                info != null
                    ? Duration(seconds: info.takerChargedAutoConfirmSeconds)
                    : null,
        orElse: () => null,
      );
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

// Initializes the Nostr offer subscription, scoping the `#y` filter to the
// active payment system's wire tag. Re-runs (re-subscribes with the new tag)
// when the user switches payment systems, so the offers list and the new-offer
// notifications derived from it follow the selected market.
final offersSubscriptionInitializer = FutureProvider<void>((ref) async {
  final apiService = await ref.watch(initializedApiServiceProvider.future);
  final method = ref.watch(selectedPaymentSystemProvider);
  await apiService.startOfferSubscription(platformTag: method.platformTag);
});

// Keeps coordinator discovery pointed at the active payment system's project
// identity (Bitblik for BLIK, Bitway for MB WAY). Re-points the registry and
// re-runs discovery whenever the user switches markets, so each market resolves
// its own discovery relays + coordinator set. The initial identity is set in
// [coordinatorRegistryProvider]; this only reacts to later switches.
final discoveryIdentityInitializer = FutureProvider<void>((ref) async {
  final registry = await ref.watch(coordinatorRegistryProvider.future);
  final method = ref.watch(selectedPaymentSystemProvider);
  if (registry.discoveryPubkeyHex == method.discoveryPubkeyHex &&
      registry.activePaymentSystemId == method.id) {
    return;
  }
  registry.setDiscoveryContext(
    hex: method.discoveryPubkeyHex,
    paymentSystemId: method.id,
  );
  await registry.discover();
  await registry.probeAllEnabled();
});

Future<List<Offer>> refreshAvailableOffersCache(
  ApiServiceNostr apiService,
  PaymentSystem method,
) async {
  final currentOffers = List<Offer>.from(apiService.knownOffers);
  final enabledCoordinatorPubkeys =
      apiService.discoveredCoordinators
          .where((record) => record.enabled)
          .map((record) => record.pubkeyHex)
          .toSet();
  if (currentOffers.isEmpty) {
    return List<Offer>.from(
      apiService.knownOffers
          .where(
            (offer) =>
                enabledCoordinatorPubkeys.contains(offer.coordinatorPubkey) &&
                offer.fiatCurrency == method.currency,
          )
          .toList()
          .reversed,
    );
  }

  final refreshedOffers = await Future.wait(
    currentOffers.map((offer) async {
      try {
        return await apiService.getOffer(offer.id);
      } catch (e) {
        Logger.log.w(
          () =>
              '[availableOffers] failed refreshing public offer ${offer.id}: $e',
        );
        return offer;
      }
    }),
  );

  final activeOffers =
      refreshedOffers
          .whereType<Offer>()
          .where(
            (offer) =>
                enabledCoordinatorPubkeys.contains(offer.coordinatorPubkey) &&
                offer.fiatCurrency == method.currency &&
                (offer.status == OfferStatus.funded ||
                    offer.status == OfferStatus.reserved),
          )
          .toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  return List<Offer>.from(activeOffers.reversed);
}

// Provider for real-time list of available offers from Nostr subscription
final availableOffersProvider = StreamProvider<List<Offer>>((ref) async* {
  // Depend on single global initializer
  await ref.watch(offersSubscriptionInitializer.future);
  final apiService = ref.watch(apiServiceProvider);
  final method = ref.watch(selectedPaymentSystemProvider);
  final discoveredCoordinators = ref.watch(discoveredCoordinatorsProvider);
  final enabledCoordinatorPubkeys = discoveredCoordinators.maybeWhen(
    data:
        (records) =>
            records
                .where((record) => record.enabled)
                .map((record) => record.pubkeyHex)
                .toSet(),
    orElse:
        () =>
            apiService.discoveredCoordinators
                .where((record) => record.enabled)
                .map((record) => record.pubkeyHex)
                .toSet(),
  );
  // Emit the latest cached snapshot immediately so pull-to-refresh and
  // provider rebuilds don't hang waiting for a future live event.
  final initialOffers =
      apiService.knownOffers
          .where(
            (offer) =>
                enabledCoordinatorPubkeys.contains(offer.coordinatorPubkey) &&
                offer.fiatCurrency == method.currency &&
                (offer.status == OfferStatus.funded ||
                    offer.status == OfferStatus.reserved),
          )
          .toList()
        ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
  yield List<Offer>.from(initialOffers.reversed);
  await for (final _ in apiService.offersStream) {
    final visibleOffers =
        apiService.knownOffers
            .where(
              (candidate) =>
                  enabledCoordinatorPubkeys.contains(
                    candidate.coordinatorPubkey,
                  ) &&
                  candidate.fiatCurrency == method.currency &&
                  (candidate.status == OfferStatus.funded ||
                      candidate.status == OfferStatus.reserved),
            )
            .toList()
          ..sort((a, b) => a.createdAt.compareTo(b.createdAt));
    yield List<Offer>.from(visibleOffers.reversed);
  }
});

// Provider to hold the currently selected/active offer (if any)
final activeOfferProvider = StateNotifierProvider<ActiveOfferNotifier, Offer?>(
  (ref) => ActiveOfferNotifier(ref),
);

class ActiveOfferNotifier extends StateNotifier<Offer?> {
  ActiveOfferNotifier(this._ref) : super(null) {
    _init();
  }

  final Ref _ref;

  /// Reconcile is driven by relay connectivity so it never runs against a
  /// dead connection. This subscription fires on every connect/reconnect.
  StreamSubscription<bool>? _connectivitySub;

  /// Guards against overlapping reconcile passes when connectivity events
  /// arrive in quick succession.
  bool _reconcileInFlight = false;

  /// Window used by boot-time reconciliation. An offer older than this is
  /// assumed to be definitively cancelled — coordinator hold invoice
  /// would have expired by then.
  static const Duration _cancelledLookbackWindow = Duration(hours: 24);

  bool _isTakerOnlyOfferForUser(Offer offer, String? myPubkey) {
    return myPubkey != null &&
        offer.takerPubkey == myPubkey &&
        offer.makerPubkey != myPubkey;
  }

  bool _userParticipatesInOffer(Offer offer, String? myPubkey) {
    return myPubkey != null &&
        (offer.makerPubkey == myPubkey || offer.takerPubkey == myPubkey);
  }

  Future<void> _promoteMostRecentActiveOffer() async {
    final myPubkey = _ref.read(keyServiceProvider).publicKeyHex;
    final nextActive = await OfferDbService().getActiveOffer(
      userPubkey: myPubkey,
    );
    if (nextActive != null) {
      Logger.log.i(
        () =>
            '[ActiveOfferNotifier] promoted fallback active offer ${nextActive.id} (${nextActive.status.name})',
      );
    } else {
      Logger.log.d(
        () => '[ActiveOfferNotifier] no fallback active offer available',
      );
    }
    state = nextActive;
  }

  Future<void> _init() async {
    await _loadActiveOffer();
    await _listenForRelayConnectivity();
  }

  /// Load the locally-active offer for immediate UI. Network reconciliation is
  /// NOT triggered here — it is driven by relay connectivity (see
  /// [_listenForRelayConnectivity]) so it never runs against a connection that
  /// isn't up yet (the boot-time timeout that used to strand offers).
  Future<void> _loadActiveOffer() async {
    final myPubkey = _ref.read(keyServiceProvider).publicKeyHex;
    state = await OfferDbService().getActiveOffer(userPubkey: myPubkey);
  }

  /// Reconcile local offers against the coordinator on every relay
  /// connect/reconnect: app boot once relays are up, network restore, and the
  /// app returning from background on mobile.
  Future<void> _listenForRelayConnectivity() async {
    try {
      final apiService = await _ref.read(initializedApiServiceProvider.future);
      _connectivitySub = apiService.relayConnectionState.listen((connected) {
        if (connected) unawaited(_reconcileAll());
      });
    } catch (e) {
      Logger.log.w(
        () =>
            '[ActiveOfferNotifier] failed to subscribe to relay connectivity: $e',
      );
    }
  }

  /// On-demand sync of the in-memory active offer against the coordinator.
  /// Used by flow-driven screens when a yaml state deadline passes without a
  /// pushed status update (missed relay event): the coordinator has advanced
  /// the state server-side, so fetch and apply it.
  Future<void> reconcileActiveOfferNow() async {
    final active = state;
    if (active == null ||
        OfferDbService.terminalStatuses.contains(active.status)) {
      return;
    }
    await _reconcileActiveOfferIfNeeded(active);
  }

  /// Revive wrongly/locally-cancelled offers and sync the active one. Guarded
  /// so overlapping connectivity events don't run it concurrently.
  Future<void> _reconcileAll() async {
    if (_reconcileInFlight) return;
    _reconcileInFlight = true;
    try {
      // listRecentCancelled is a single indexed query — cheap.
      await _reconcileCancelledOffersIfNeeded();
      final myPubkey = _ref.read(keyServiceProvider).publicKeyHex;
      final active =
          state ?? await OfferDbService().getActiveOffer(userPubkey: myPubkey);
      if (active != null &&
          !OfferDbService.terminalStatuses.contains(active.status)) {
        await _reconcileActiveOfferIfNeeded(active);
      }
      await _reconcileTrackedUserOffersIfNeeded(activeOfferId: state?.id);
    } catch (e) {
      Logger.log.w(() => '[ActiveOfferNotifier] reconcileAll failed: $e');
    } finally {
      _reconcileInFlight = false;
    }
  }

  Future<void> _reconcileTrackedUserOffersIfNeeded({
    String? activeOfferId,
  }) async {
    final myPubkey = _ref.read(keyServiceProvider).publicKeyHex;
    if (myPubkey == null || myPubkey.isEmpty) return;

    final db = OfferDbService();
    final offers = await db.listOffers(userPubkey: myPubkey);
    if (offers.isEmpty) return;

    final apiService = await _ref.read(initializedApiServiceProvider.future);
    var changed = false;

    for (final localOffer in offers) {
      if (OfferDbService.terminalStatuses.contains(localOffer.status)) continue;
      if (activeOfferId != null && localOffer.id == activeOfferId) continue;

      try {
        final remote = await apiService.getOfferDetails(
          localOffer,
          localOffer.coordinatorPubkey,
          strict: true,
        );

        if (remote == null) {
          if (_isTakerOnlyOfferForUser(localOffer, myPubkey)) {
            Logger.log.i(
              () =>
                  '[ActiveOfferNotifier] deleting stale taker offer ${localOffer.id} (${localOffer.status.name}); coordinator no longer reports user participation',
            );
            await db.deleteOfferById(localOffer.id);
            changed = true;
          }
          continue;
        }

        final hydrated = Offer.fromJson(remote);
        if (_isTakerOnlyOfferForUser(localOffer, myPubkey) &&
            !_userParticipatesInOffer(hydrated, myPubkey)) {
          Logger.log.i(
            () =>
                '[ActiveOfferNotifier] deleting relisted taker offer ${localOffer.id}; coordinator cleared local user ownership',
          );
          await db.deleteOfferById(localOffer.id);
          changed = true;
          continue;
        }
        if (hydrated.id != localOffer.id) {
          await db.deleteOfferById(localOffer.id);
        }
        await db.upsertOffer(hydrated);
        changed = true;
      } catch (e) {
        Logger.log.w(
          () =>
              '[ActiveOfferNotifier] reconcile tracked offer ${localOffer.id} failed: $e',
        );
      }
    }

    if (changed) {
      _ref.invalidate(myOffersProvider);
    }
  }

  /// Boot-time sanity check for the locally-active offer.
  ///
  /// When the app was offline while the coordinator cancelled or expired the
  /// offer, the local DB still holds the stale non-terminal status (e.g.
  /// `funded`). This method fetches exact offer from coordinator and
  /// reconciles:
  ///   - Remote is null → offer no longer exists on coordinator; mark cancelled.
  ///   - Remote has a terminal status → update local DB and clear in-memory state.
  ///   - Remote has a different non-terminal status → sync local to coordinator.
  ///   - Remote matches local → no action.
  Future<void> _reconcileActiveOfferIfNeeded(Offer localOffer) async {
    try {
      final apiService = await _ref.read(initializedApiServiceProvider.future);
      final myPubkey = _ref.read(keyServiceProvider).publicKeyHex;
      Logger.log.i(
        () =>
            '[ActiveOfferNotifier] reconciling active offer ${localOffer.id} (local status=${localOffer.status.name})',
      );

      Map<String, dynamic>? remote;
      try {
        remote = await apiService.getOfferDetails(
          localOffer,
          localOffer.coordinatorPubkey,
          strict: true,
        );
      } catch (e) {
        // Transient failure (timeout, relays not yet connected). Do NOT treat
        // as a missing offer — leave local state untouched and retry later.
        Logger.log.w(
          () =>
              '[ActiveOfferNotifier] getOfferDetails failed during active-offer reconciliation: $e',
        );
        return;
      }

      if (remote == null) {
        if (_isTakerOnlyOfferForUser(localOffer, myPubkey)) {
          Logger.log.i(
            () =>
                '[ActiveOfferNotifier] coordinator no longer reports taker-owned offer ${localOffer.id}; deleting local row',
          );
          await OfferDbService().deleteOfferById(localOffer.id);
          if (state?.id == localOffer.id) {
            await _promoteMostRecentActiveOffer();
          }
        } else {
          // Coordinator has no active offer for this user — treat as cancelled.
          Logger.log.i(
            () =>
                '[ActiveOfferNotifier] coordinator reports no active offer; marking local ${localOffer.id} cancelled',
          );
          final cancelled = localOffer.copyWith(status: OfferStatus.cancelled);
          await OfferDbService().upsertOffer(cancelled);
          // Only clear if this offer is still the in-memory active one.
          if (state?.id == localOffer.id) state = null;
        }
        return;
      }

      final hydrated = Offer.fromJson(remote);
      if (_isTakerOnlyOfferForUser(localOffer, myPubkey) &&
          !_userParticipatesInOffer(hydrated, myPubkey)) {
        Logger.log.i(
          () =>
              '[ActiveOfferNotifier] coordinator relisted taker offer ${localOffer.id}; removing stale local active row',
        );
        await OfferDbService().deleteOfferById(localOffer.id);
        if (state?.id == localOffer.id) {
          await _promoteMostRecentActiveOffer();
        }
        return;
      }

      final remoteId = remote['id']?.toString();
      final remoteStatusRaw = remote['status']?.toString();
      if (remoteId == null || remoteStatusRaw == null) return;

      OfferStatus remoteStatus;
      try {
        remoteStatus = OfferStatus.values.byName(remoteStatusRaw);
      } catch (_) {
        remoteStatus = OfferStatus.unknown;
      }

      // If coordinator reports a different offer id, this local offer is stale.
      final sameOffer =
          remoteId == localOffer.id ||
          (localOffer.holdInvoicePaymentHash != null &&
              localOffer.holdInvoicePaymentHash ==
                  remote['payment_hash']?.toString());

      if (!sameOffer) {
        Logger.log.i(
          () =>
              '[ActiveOfferNotifier] coordinator active offer ($remoteId) differs from local (${localOffer.id}); marking local cancelled',
        );
        final cancelled = localOffer.copyWith(status: OfferStatus.cancelled);
        await OfferDbService().upsertOffer(cancelled);
        if (state?.id == localOffer.id) state = null;
        return;
      }

      // Compare raw wire states: generic (yaml-driven) flow states such as
      // `invalidTwint` all parse to the enum's `unknown`, so an enum compare
      // would miss transitions between them (and copyWith without statusRaw
      // would overwrite the real state with the literal 'unknown').
      if (remoteStatusRaw == localOffer.statusRaw) return; // Already in sync.

      Logger.log.i(
        () =>
            '[ActiveOfferNotifier] syncing active offer $remoteId: local=${localOffer.statusRaw} -> remote=$remoteStatusRaw',
      );
      final updated = localOffer.copyWith(
        id: remoteId,
        status: remoteStatus,
        statusRaw: remoteStatusRaw,
        // Keep the yaml-timeout countdown bases in sync (from_field:
        // updated_at default, code_received_at, and reserved_at).
        updatedAt: hydrated.updatedAt,
        blikReceivedAt: hydrated.blikReceivedAt,
        reservedAt: hydrated.reservedAt,
      );
      await OfferDbService().upsertOffer(updated);

      if (OfferDbService.terminalStatuses.contains(remoteStatus) &&
          remoteStatus != OfferStatus.takerPaid) {
        // takerPaid is kept in state so the payment-process screen can show
        // success — applyStatusUpdate handles it without auto-promoting.
        if (state?.id == localOffer.id) state = null;
      } else {
        if (state?.id == localOffer.id) state = updated;
      }
    } catch (e) {
      Logger.log.e(
        () => '[ActiveOfferNotifier] active-offer reconciliation failed: $e',
      );
    }
  }

  /// Boot-time recovery: for every locally-cancelled offer within
  /// [_cancelledLookbackWindow], ask coordinator for each exact offer. If
  /// coordinator reports same offer with non-terminal status, revive it.
  Future<void> _reconcileCancelledOffersIfNeeded() async {
    try {
      final cancelled = await OfferDbService().listRecentCancelled(
        _cancelledLookbackWindow,
      );
      if (cancelled.isEmpty) return;

      final apiService = await _ref.read(initializedApiServiceProvider.future);

      Logger.log.i(
        () =>
            '[ActiveOfferNotifier] reconciling ${cancelled.length} cancelled offers via getOfferDetails',
      );

      for (final localOffer in cancelled) {
        try {
          final remote = await apiService.getOfferDetails(
            localOffer,
            localOffer.coordinatorPubkey,
          );
          if (remote == null) continue;

          final remoteId = remote['id']?.toString();
          if (remoteId == null) continue;

          final remoteStatusRaw = remote['status']?.toString() ?? '';
          if (remoteStatusRaw.isEmpty) continue;
          OfferStatus remoteStatus;
          try {
            remoteStatus = OfferStatus.values.byName(remoteStatusRaw);
          } catch (_) {
            // Generic (yaml-driven) flow state — legit, kept via statusRaw.
            remoteStatus = OfferStatus.unknown;
          }
          if (OfferDbService.terminalStatuses.contains(remoteStatus)) {
            continue;
          }

          final revived = localOffer.copyWith(
            id: remoteId,
            status: remoteStatus,
            statusRaw: remoteStatusRaw,
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
                '[ActiveOfferNotifier] reconciliation failed for ${localOffer.id}: $e',
          );
        }
      }
    } catch (e) {
      Logger.log.e(
        () => '[ActiveOfferNotifier] cancelled-offer reconciliation failed: $e',
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
      Logger.log.d(
        () =>
            '[ActiveOfferNotifier] Clearing in-memory active offer (history preserved)',
      );
    }
    state = offer;
  }

  /// Cancel the currently active offer, with a coordinator pre-check.
  ///
  /// A `created` offer normally only exists in the local DB — the coordinator
  /// learns about an offer once the maker pays the hold invoice (`funded`). We
  /// cannot trust local status alone though: if the maker paid but we missed
  /// the `funded` update, local still shows `created` while the coordinator
  /// holds a live offer. So we ask the coordinator instead of guessing.
  ///
  /// Flow:
  ///   1. Ask the coordinator for this exact offer.
  ///   2. Stale-`created`: local says `created` but the coordinator has the
  ///      same offer live (`funded`+, non-terminal). Sync to the coordinator
  ///      status and throw [OfferAlreadyFundedException] so the caller
  ///      redirects into the funded flow instead of cancelling.
  ///   3. Send `cancel_offer` only when the coordinator actually knows this
  ///      offer (any funded+ local offer, or a `created` offer the coordinator
  ///      returned). A `created` offer the coordinator never saw is cancelled
  ///      purely locally — no RPC, nothing to cancel remotely.
  ///   4. Mark the local row `cancelled`. The row stays so a later status
  ///      update can revive it.
  Future<void> cancelActiveOffer() async {
    final current = state;
    if (current == null) return;

    final apiService = await _ref.read(initializedApiServiceProvider.future);

    // Generic (yaml-driven) flows start at `funded` and never use `created`,
    // so this is only true for older pre-payment offers. Compare the raw
    // status string, not the enum, so generic flow states are handled correctly.
    final isLocalOnly = current.statusRaw == OfferStatus.created.name;

    Map<String, dynamic>? coordinatorOffer;
    try {
      coordinatorOffer = await apiService.getOfferDetails(
        current,
        current.coordinatorPubkey,
      );
    } catch (e) {
      Logger.log.w(
        () => '[ActiveOfferNotifier] getOfferDetails failed during cancel: $e',
      );
    }

    final remoteId = coordinatorOffer?['id']?.toString();
    final remoteStatusRaw = coordinatorOffer?['status']?.toString();
    OfferStatus? remoteStatus;
    if (remoteStatusRaw != null) {
      try {
        remoteStatus = OfferStatus.values.byName(remoteStatusRaw);
      } catch (_) {
        remoteStatus = OfferStatus.unknown;
      }
    }
    final sameOffer =
        remoteId != null &&
        (remoteId == current.id ||
            current.holdInvoicePaymentHash != null &&
                remoteId == current.holdInvoicePaymentHash);

    // Stale-`created`: coordinator already funded this offer while local state
    // still says `created`. Persist the coordinator status and redirect into
    // the funded flow instead of cancelling from the pre-funding path.
    if (isLocalOnly &&
        sameOffer &&
        remoteStatus != null &&
        remoteStatusRaw != null &&
        remoteStatus.index >= OfferStatus.funded.index &&
        !OfferDbService.terminalStatuses.contains(remoteStatus)) {
      final updated = current.copyWith(
        id: remoteId,
        status: remoteStatus,
        statusRaw: remoteStatusRaw,
      );
      await OfferDbService().upsertOffer(updated);
      state = updated;
      throw OfferAlreadyFundedException(remoteStatus);
    }

    // Cancel on the coordinator only when it knows this offer. A funded+ local
    // offer was always published; a `created` offer only if the coordinator
    // returned this same offer. Otherwise it never left the device — cancelling
    // it remotely would hit the coordinator for an offer it has no record of.
    if (!isLocalOnly || sameOffer) {
      // Prefer the coordinator UUID; local id may be a payment hash or the
      // older "empty" placeholder which the coordinator rejects.
      final cancelId = remoteId ?? current.id;
      try {
        await apiService.cancelOffer(cancelId, current.coordinatorPubkey);
      } catch (e) {
        Logger.log.w(() => '[ActiveOfferNotifier] cancel_offer RPC failed: $e');
      }
    }

    final cancelled = current.copyWith(status: OfferStatus.cancelled);
    await OfferDbService().upsertOffer(cancelled);
    // Cancellation is an explicit exit from this trade. Do not promote an
    // older active row here: the current flow screen would immediately redraw
    // that offer (for example an old dispute), making it look as though the
    // offer just cancelled had entered that state.
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
      // Preserve the verbatim wire status so generic (yaml-driven) flows keep
      // their real state (e.g. `invalidTwint`/`expiredTwint`) even though the
      // OfferStatus enum parses them to `unknown`. Flow-driven navigation keys
      // on statusRaw. For older offers this equals status.name.
      statusRaw: update.status,
      reservedAt: update.reservedAt,
      // Anchor the BLIK confirmation countdown to the coordinator's
      // blik_received_at when present. copyWith treats null as "keep", so an
      // older coordinator that omits it leaves the local value intact instead
      // of resetting the 2-min timer on the blikSentToMaker transition.
      blikReceivedAt: update.blikReceivedAt?.toLocal(),
      updatedAt: update.timestamp.toLocal(),
    );
    // When matched by paymentHash the coordinator UUID differs from local id;
    // delete the old row so upsert doesn't leave a duplicate.
    if (existing.id != updated.id) {
      await db.deleteOfferById(existing.id);
    }
    await db.upsertOffer(updated);

    final myPubkey = _ref.read(keyServiceProvider).publicKeyHex;
    final takerLostOwnershipOnRelist =
        _isTakerOnlyOfferForUser(existing, myPubkey) &&
        newStatus == OfferStatus.funded;

    if (takerLostOwnershipOnRelist) {
      try {
        final apiService = await _ref.read(
          initializedApiServiceProvider.future,
        );
        final remote = await apiService.getOfferDetails(
          updated,
          updated.coordinatorPubkey,
        );

        if (remote == null) {
          Logger.log.i(
            () =>
                '[ActiveOfferNotifier] removing relisted taker offer ${updated.id}; coordinator no longer reports this user as a participant',
          );
          await db.deleteOfferById(updated.id);
          final currentState = state;
          final isCurrent =
              currentState != null &&
              (currentState.id == updated.id ||
                  (currentState.holdInvoicePaymentHash != null &&
                      currentState.holdInvoicePaymentHash ==
                          updated.holdInvoicePaymentHash));
          if (isCurrent) {
            state = null;
            _ref.read(appLifecycleProvider)._updateForegroundService();
          }
          return;
        }

        final hydratedRemote = Offer.fromJson(remote);
        if (!_userParticipatesInOffer(hydratedRemote, myPubkey)) {
          Logger.log.i(
            () =>
                '[ActiveOfferNotifier] removing relisted taker offer ${updated.id}; coordinator cleared local user ownership',
          );
          await db.deleteOfferById(updated.id);
          final currentState = state;
          final isCurrent =
              currentState != null &&
              (currentState.id == updated.id ||
                  (currentState.holdInvoicePaymentHash != null &&
                      currentState.holdInvoicePaymentHash ==
                          updated.holdInvoicePaymentHash));
          if (isCurrent) {
            state = null;
            _ref.read(appLifecycleProvider)._updateForegroundService();
          }
          _ref.invalidate(myOffersProvider);
          return;
        }
      } catch (e) {
        Logger.log.w(
          () =>
              '[ActiveOfferNotifier] failed ownership check for relisted taker offer ${updated.id}: $e',
        );
      }
    }

    final shouldHydrateCompletedOffer =
        newStatus == OfferStatus.makerConfirmed ||
        newStatus == OfferStatus.settled ||
        newStatus == OfferStatus.takerPaid;
    Offer hydrated = updated;
    if (shouldHydrateCompletedOffer) {
      try {
        final apiService = await _ref.read(
          initializedApiServiceProvider.future,
        );
        final remote = await apiService.getOfferDetails(
          updated,
          updated.coordinatorPubkey,
        );
        if (remote != null) {
          hydrated = Offer.fromJson(remote);
          await db.upsertOffer(hydrated);
        }
      } catch (e) {
        Logger.log.w(
          () =>
              '[ActiveOfferNotifier] failed hydrating completed offer ${updated.id}: $e',
        );
      }
    }

    if (existing.status == OfferStatus.blikSentToMaker &&
        newStatus != OfferStatus.blikSentToMaker) {
      NotificationService().cancelBlikReminder();
    }
    _maybeNotify(hydrated, newStatus);

    final currentState = state;
    final isCurrent =
        currentState != null &&
        (currentState.id == hydrated.id ||
            (currentState.holdInvoicePaymentHash != null &&
                currentState.holdInvoicePaymentHash ==
                    hydrated.holdInvoicePaymentHash));

    if (isCurrent) {
      if (newStatus == OfferStatus.takerPaid) {
        // Keep the takerPaid offer in state so the payment-process and
        // payment-failed screens can observe the success transition. The
        // screen is responsible for clearing active offer when the user
        // taps Done. Auto-promoting here would set state=null before any
        // listener sees takerPaid, causing the dialog to stay stuck forever.
        state = hydrated;
        _ref.read(appLifecycleProvider)._updateForegroundService();
      } else if (OfferDbService.terminalStatuses.contains(newStatus)) {
        if (newStatus == OfferStatus.cancelled) {
          // A cancelled offer exits to home. Promoting another persisted offer
          // while the flow screen is mounted can visually turn this offer into
          // an unrelated older dispute.
          state = null;
        } else {
          await _promoteMostRecentActiveOffer();
        }
        _ref.read(appLifecycleProvider)._updateForegroundService();
      } else {
        state = hydrated;
      }
      return;
    }

    // Revival: in-memory state is null/different but a previously
    // cancelled offer just received a non-terminal update from the
    // coordinator. Restore it as the active offer.
    if (existing.status == OfferStatus.cancelled &&
        !OfferDbService.terminalStatuses.contains(newStatus)) {
      Logger.log.i(
        () =>
            '[ActiveOfferNotifier] reviving cancelled offer ${hydrated.id} -> ${newStatus.name}',
      );
      state = hydrated;
    }
  }

  void _maybeNotify(Offer offer, OfferStatus newStatus) {
    final lifecycle = _ref.read(appLifecycleProvider).currentState;
    if (lifecycle == AppLifecycleState.resumed ||
        lifecycle == AppLifecycleState.inactive)
      return;
    final myPubkey = _ref.read(keyServiceProvider).publicKeyHex;
    if (myPubkey == null) return;
    final isMaker = offer.makerPubkey == myPubkey;
    final isTaker = offer.takerPubkey == myPubkey;
    final strings = t.offerNotifications;
    final code = offerCodeLabel(offer);
    switch (newStatus) {
      case OfferStatus.funded:
        if (isMaker) {
          NotificationService().show(
            1,
            strings.funded.title,
            strings.funded.body,
          );
        }
      case OfferStatus.reserved:
        if (isMaker) {
          NotificationService().show(
            2,
            strings.reserved.title,
            strings.reserved.body,
          );
        }
      case OfferStatus.blikSentToMaker:
        if (isMaker) {
          NotificationService().show(
            3,
            strings.blikReady.title(code: code),
            strings.blikReady.body(code: code),
          );
        }
      case OfferStatus.takerCharged:
        if (isMaker) {
          NotificationService().show(
            4,
            strings.takerCharged.title(code: code),
            strings.takerCharged.body(code: code),
          );
        }
      case OfferStatus.invalidBlik:
        if (isTaker) {
          NotificationService().show(
            5,
            strings.invalidBlik.title(code: code),
            strings.invalidBlik.body(code: code),
          );
        }
      case OfferStatus.takerPaid:
        if (isTaker) {
          NotificationService().show(
            6,
            strings.takerPaid.title,
            strings.takerPaid.body,
          );
        }
      default:
        break;
    }
  }

  /// Force a database reset (useful for development when schema changes are made)
  Future<void> resetDatabase() async {
    await OfferDbService().resetDatabase();
    state = null;
  }

  @override
  void dispose() {
    _connectivitySub?.cancel();
    super.dispose();
  }
}

/// All offers in the local DB (history). Re-fetches when the active
/// offer changes (covers create / cancel / status update) so the list
/// stays current without manual invalidation.
final myOffersProvider = FutureProvider<List<Offer>>((ref) async {
  ref.watch(activeOfferProvider);
  final myPubkey = ref.watch(keyServiceProvider).publicKeyHex;
  return OfferDbService().listOffers(userPubkey: myPubkey);
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
          // Do NOT gate on OfferStatus enum parsing: generic (yaml-driven)
          // flow states (e.g. `invalidTwint`, `expiredTwint`, `takerCharged`)
          // have no enum value — dropping them here left flow screens frozen
          // on a stale state. applyStatusUpdate handles unknown statuses via
          // statusRaw.
          Logger.log.d(
            () =>
                "Offer ${current.id} status updated to: ${statusUpdate.status}. Updating active offer provider.",
          );
          activeOfferNotifier.applyStatusUpdate(statusUpdate);
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
  // Ensure the API service is fully initialized. getOffer queries _relayUrls
  // directly, so the coordinator registry is not needed here — don't await it.
  final apiService = await ref.watch(initializedApiServiceProvider.future);
  return apiService.getOffer(offerId);
});

// Provider for fetching successful offers statistics
final successfulOffersStatsProvider = FutureProvider<Map<String, dynamic>>((
  ref,
) async {
  // Wait for API service to be fully initialized
  final apiService = await ref.watch(initializedApiServiceProvider.future);
  // Scope stats to the selected payment system's coordinators.
  final selectedSystem = ref.watch(selectedPaymentSystemProvider);
  // Re-run when the *set of enabled coordinators* for this payment system
  // changes (so disabled coordinators drop out immediately), but NOT on every
  // registry tick. Each run fans out one RPC per coordinator; reacting to
  // health-probe / profile / finished-count emits would loop endlessly.
  // `select` collapses to a value-equal String so unrelated emits are ignored.
  ref.watch(
    discoveredCoordinatorsProvider.select(
      (async) => async.maybeWhen(
        data:
            (records) => (records
                    .where(
                      (r) => r.enabled && r.paymentSystem == selectedSystem.id,
                    )
                    .map((r) => r.pubkeyHex)
                    .toList()
                  ..sort())
                .join(','),
        orElse: () => '',
      ),
    ),
  );

  // Snapshot the registry once — do not subscribe to its change stream
  // here. This provider issues N RPCs per refresh; reacting to every
  // registry tick would amplify traffic.
  final registry = await ref.watch(coordinatorRegistryProvider.future);
  Logger.log.d(
    () =>
        '📊 Stats Provider: ${registry.enabled.length} coordinators for stats',
  );

  return apiService.getSuccessfulOffersStats(
    paymentSystemId: selectedSystem.id,
  );
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

// Wallet ID used to pay the most recent hold invoice.
// Null = default wallet was used (or no payment yet).
// Written by MakerPayInvoiceScreen, read by MakerWaitTakerScreen on cancel.
final lastPaymentWalletIdProvider = StateProvider<String?>((ref) => null);

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

  /// Raw map of ALL NDK relays (coordinator, discovery, NWC). Consumers filter
  /// to the subset they care about (coordinator relays for the top bar,
  /// discovery relays for the management screen).
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

/// The live discovery relays — Bitblik's profile NIP-65 relays resolved by the
/// registry (fallback: hardcoded bootstrap). Reactive to registry changes.
final discoveryRelaysProvider = Provider<List<String>>((ref) {
  final async = ref.watch(discoveredCoordinatorsProvider);
  return async.maybeWhen(
    data: (_) {
      try {
        return ref.read(apiServiceProvider).coordinatorRegistry.relays;
      } catch (_) {
        return kDiscoveryRelays;
      }
    },
    orElse: () => kDiscoveryRelays,
  );
});

/// Relays declared by enabled coordinators and confirmed from their own
/// NIP-65 lists, normalized and deduped. Discovery fallback relays are
/// intentionally excluded so top-bar relay chips only show coordinator-owned
/// relays. Reactive to registry changes via [discoveredCoordinatorsProvider].
final coordinatorRelaysInUseProvider = Provider<Set<String>>((ref) {
  final async = ref.watch(discoveredCoordinatorsProvider);
  final activeMethod = ref.watch(selectedPaymentSystemProvider);
  return async.maybeWhen(
    data: (records) {
      final out = <String>{};
      for (final r in records.where(
        (r) => r.enabled && r.paymentSystem == activeMethod.id,
      )) {
        if (r.relayListFromNip65 && r.relays.isNotEmpty) {
          out.addAll(r.relays.map(normalizeRelayUrl));
        }
      }
      return out;
    },
    orElse: () => <String>{},
  );
});

/// Offer ID set when "Take Offer" notification action is tapped.
/// OfferDetailsScreen reads this and auto-triggers the take if conditions are met.
final pendingAutoTakeOfferIdProvider = StateProvider<String?>((ref) => null);

const _kNewOfferNotificationsKey = 'new_offer_notifications';

final newOfferNotificationsProvider =
    StateNotifierProvider<NewOfferNotificationsNotifier, bool>(
      (ref) => NewOfferNotificationsNotifier(),
    );

class NewOfferNotificationsNotifier extends StateNotifier<bool> {
  NewOfferNotificationsNotifier() : super(false) {
    _load();
  }

  Future<void> _load() async {
    final prefs = SharedPreferencesAsync();
    state = await prefs.getBool(_kNewOfferNotificationsKey) ?? false;
  }

  Future<void> set(bool value) async {
    state = value;
    await SharedPreferencesAsync().setBool(_kNewOfferNotificationsKey, value);
  }
}

final bitcoinDisplayUnitProvider =
    StateNotifierProvider<BitcoinDisplayUnitNotifier, BitcoinDisplayUnit>(
      (ref) => BitcoinDisplayUnitNotifier(),
    );

class BitcoinDisplayUnitNotifier extends StateNotifier<BitcoinDisplayUnit> {
  BitcoinDisplayUnitNotifier() : super(BitcoinDisplayUnit.sats) {
    _load();
  }

  Future<void> _load() async {
    final settings = await AppPreferencesStore.loadDisplay();
    state = settings.bitcoinDisplayUnit;
  }

  Future<void> set(BitcoinDisplayUnit value) async {
    state = value;
    await AppPreferencesStore.saveDisplay(
      DisplayPreferences(bitcoinDisplayUnit: value),
    );
  }
}

/// Active payment method (country/payment-system) selected by the user. Drives
/// code-length validation, the confirmation countdown, currency labels, and the
/// filtering of coordinators/offers shown in the app. Defaults to BLIK.
final selectedPaymentSystemProvider =
    StateNotifierProvider<SelectedPaymentSystemNotifier, PaymentSystem>(
      (ref) => SelectedPaymentSystemNotifier(),
    );

/// Whether the first-launch market/country picker is the active screen.
/// Overridden in `main()` from
/// [AppPreferencesStore.ensureMarketSelectedOrDetect] — true only when no
/// market could be auto-detected from the device country (no IP / unsupported).
/// The `false` default keeps tests and non-`main` entrypoints on the normal
/// home route. When true, the router starts at the onboarding screen and the
/// coordinator cold-start overlay is suppressed (so it doesn't pop over the
/// picker). The onboarding screen flips this to `false` once the user picks a
/// market, after which discovery + overlay behave normally.
final needsMarketOnboardingProvider = StateProvider<bool>((ref) => false);

class SelectedPaymentSystemNotifier extends StateNotifier<PaymentSystem> {
  /// [initial] seeds the state synchronously (used at startup with the saved
  /// market preloaded in main), so discovery targets the right market from the
  /// first sweep. When null, falls back to the build default and loads the saved
  /// preference asynchronously.
  SelectedPaymentSystemNotifier([PaymentSystem? initial])
    : super(initial ?? paymentSystemById(buildDefaultPaymentSystemId)) {
    if (initial == null) _load();
  }

  Future<void> _load() async {
    state = await AppPreferencesStore.loadSelectedPaymentSystem();
  }

  Future<void> set(PaymentSystem value) async {
    state = value;
    await AppPreferencesStore.saveSelectedPaymentSystem(value);
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
  StreamSubscription<Offer>? _newOfferSub;
  StreamSubscription<List<ConnectivityResult>>? _connectivityMonitorSub;
  Set<String> _seenOfferIds = {};
  bool _relayReconnectInFlight = false;
  bool _lastNetworkReachable = true;

  AppLifecycleState get currentState => _currentState;

  void initialize() {
    WidgetsBinding.instance.addObserver(this);
    if (!kIsWeb) {
      unawaited(_startNetworkConnectivityMonitoring());
      if (Platform.isAndroid || Platform.isIOS) {
        _initMobileMonitoring();
      } else {
        _initDesktopMonitoring();
      }
    }
  }

  void _initMobileMonitoring() {
    final enabled = _ref.read(newOfferNotificationsProvider);
    if (enabled) {
      _updateForegroundService();
      unawaited(_startNewOfferMonitoring());
    }
    _ref.listen<bool>(newOfferNotificationsProvider, (_, enabled) {
      _updateForegroundService();
      if (enabled) {
        unawaited(_startNewOfferMonitoring());
      } else {
        _stopNewOfferMonitoring();
      }
    });
  }

  void _initDesktopMonitoring() {
    if (_ref.read(newOfferNotificationsProvider)) {
      unawaited(_startNewOfferMonitoring());
    }
    _ref.listen<bool>(newOfferNotificationsProvider, (_, enabled) {
      if (enabled) {
        unawaited(_startNewOfferMonitoring());
      } else {
        _stopNewOfferMonitoring();
      }
    });
  }

  void _updateForegroundService() {
    if (kIsWeb || !Platform.isAndroid) return;
    final offer = _ref.read(activeOfferProvider);
    final settingEnabled = _ref.read(newOfferNotificationsProvider);
    final hasActiveOffer =
        offer != null &&
        !OfferDbService.terminalStatuses.contains(offer.status);
    if (hasActiveOffer || settingEnabled) {
      final strings = t.offerNotifications;
      NotificationService().startOfferForegroundService(
        strings.activeService.title,
        strings.activeService.body(
          app: _ref.read(selectedPaymentSystemProvider).brandName,
        ),
      );
    } else {
      NotificationService().stopOfferForegroundService();
    }
  }

  void dispose() {
    _newOfferSub?.cancel();
    _connectivityMonitorSub?.cancel();
    WidgetsBinding.instance.removeObserver(this);
  }

  Future<void> _startNetworkConnectivityMonitoring() async {
    final connectivity = Connectivity();
    try {
      _lastNetworkReachable = _hasNetwork(
        await connectivity.checkConnectivity(),
      );
    } catch (e) {
      Logger.log.w(
        () => '[AppLifecycleNotifier] failed to read initial connectivity: $e',
      );
    }

    _connectivityMonitorSub = connectivity.onConnectivityChanged.listen((
      results,
    ) {
      final hasNetwork = _hasNetwork(results);
      final regainedNetwork = !_lastNetworkReachable && hasNetwork;
      _lastNetworkReachable = hasNetwork;

      if (regainedNetwork) {
        unawaited(
          _restoreCoordinatorRelayConnectivity(reason: 'network restored'),
        );
      }
    });
  }

  bool _hasNetwork(List<ConnectivityResult> results) =>
      results.any((result) => result != ConnectivityResult.none);

  Future<void> _restoreCoordinatorRelayConnectivity({
    required String reason,
  }) async {
    if (_relayReconnectInFlight) return;
    _relayReconnectInFlight = true;

    try {
      final apiService = await _ref.read(initializedApiServiceProvider.future);
      final ndk = apiService.ndk;
      if (ndk == null) return;

      Logger.log.i(
        () => '[AppLifecycleNotifier] forcing relay reconnect: $reason',
      );
      if (kIsWeb) {
        // iOS PWA: backgrounding silently kills the sockets while the transport
        // still reports itself Connected (zombie), so tryReconnect() alone would
        // skip them. Hard-reset every transport first, then reconnect. The gate
        // also blocks in-flight sends (see NostrService.sendRequest) until this
        // settles, so we never publish onto a dead socket on foreground.
        await RelayReconnectGate.instance.forceReconnect(ndk);
      } else {
        await ndk.connectivity.tryReconnect();
      }

      // Refresh coordinator-derived state after transport recovery so the
      // app rehydrates its custom Bitblik layer, not just the raw sockets.
      await apiService.coordinatorRegistry.discover();
      await apiService.coordinatorRegistry.probeAllEnabled();
    } catch (e) {
      Logger.log.w(
        () =>
            '[AppLifecycleNotifier] failed restoring coordinator relays after $reason: $e',
      );
    } finally {
      _relayReconnectInFlight = false;
    }
  }

  Future<void> _startNewOfferMonitoring() async {
    _newOfferSub?.cancel();
    // Ensure the Nostr offer subscription is running even if user never visited
    // the offers screen (offersSubscriptionInitializer is lazy).
    await _ref.read(offersSubscriptionInitializer.future);
    // Snapshot currently known offer IDs so we only notify for truly new ones.
    _seenOfferIds =
        _ref.read(apiServiceProvider).knownOffers.map((o) => o.id).toSet();
    final apiService = _ref.read(apiServiceProvider);
    _newOfferSub = apiService.offersStream.listen((offer) async {
      // Public-event consistency trigger: the coordinator re-broadcasts the
      // NIP-69 order on every state change. If the event concerns OUR active
      // offer and its (coarse) status disagrees with the local state — e.g.
      // it flipped back to pending/funded because the maker relisted and we
      // were dropped as taker, and the targeted push was missed — pull
      // coordinator truth. The reconcile is authoritative and idempotent; the
      // public event is only the trigger.
      final active = _ref.read(activeOfferProvider);
      if (active != null &&
          offer.id == active.id &&
          offer.statusRaw != active.statusRaw) {
        unawaited(
          _ref.read(activeOfferProvider.notifier).reconcileActiveOfferNow(),
        );
      }
      if (offer.status != OfferStatus.funded) return;
      if (!apiService.isEnabled(offer.coordinatorPubkey)) return;
      if (_seenOfferIds.contains(offer.id)) return;
      _seenOfferIds.add(offer.id);
      final localOffer = await OfferDbService().getOfferById(offer.id);
      if (localOffer != null) return;
      // Race: offer funded on coordinator before kind-20033 reconciles local ID.
      // If we have a 'created' active offer on same coordinator it's ours.
      final activeOffer = _ref.read(activeOfferProvider);
      if (activeOffer != null &&
          activeOffer.status == OfferStatus.created &&
          activeOffer.coordinatorPubkey == offer.coordinatorPubkey) {
        return;
      }
      // On mobile suppress notification while app is in foreground
      if (!kIsWeb && (Platform.isAndroid || Platform.isIOS)) {
        if (_currentState == AppLifecycleState.resumed ||
            _currentState == AppLifecycleState.inactive) {
          return;
        }
      }
      final strings = t.offerNotifications;
      final locale =
          LocaleSettings.instance.currentLocale.flutterLocale.toString();
      final numFmt = NumberFormat.decimalPatternDigits(
        locale: locale,
        decimalDigits: 2,
      );
      final bitcoinDisplayUnit = await AppPreferencesStore.loadDisplay().then(
        (settings) => settings.bitcoinDisplayUnit,
      );
      final formattedAmount = numFmt.format(offer.fiatAmount);
      final formattedSats = formatBitcoinAmountForLocale(
        locale,
        bitcoinDisplayUnit,
        offer.amountSats,
      );
      final categoryStr = switch (offer.category) {
        OfferCategory.shop => strings.categories.shop,
        OfferCategory.atm => strings.categories.atm,
        OfferCategory.online => strings.categories.online,
        null => '',
      };
      var body = strings.newOffer.body(
        amount: formattedAmount,
        currency: offer.fiatCurrency,
        sats: formattedSats,
      );
      if (categoryStr.isNotEmpty) body += ' · $categoryStr';
      if (offer.premiumPercent > 0) {
        final premiumStr = offer.premiumPercent
            .toStringAsFixed(1)
            .replaceAll(RegExp(r'\.0$'), '');
        body += ' · ${strings.newOffer.premiumSuffix(percent: premiumStr)}';
      }
      NotificationService().showNewOffer(
        id: 20,
        title: strings.newOffer.title,
        body: body,
        payload: 'offer:${offer.id}',
      );
    });
  }

  void _stopNewOfferMonitoring() {
    _newOfferSub?.cancel();
    _newOfferSub = null;
    _seenOfferIds = {};
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    _currentState = state;

    switch (state) {
      case AppLifecycleState.resumed:
        unawaited(_restoreCoordinatorRelayConnectivity(reason: 'app resumed'));
        NotificationService().cancelBlikReminder();
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        final offer = _ref.read(activeOfferProvider);
        final hasActiveOffer =
            offer != null &&
            !OfferDbService.terminalStatuses.contains(offer.status);
        if (hasActiveOffer && offer.status == OfferStatus.blikSentToMaker) {
          final strings = t.offerNotifications;
          final code = offerCodeLabel(offer);
          NotificationService().scheduleBlikReminder(
            strings.blikPendingReminder.title(code: code),
            strings.blikPendingReminder.body(code: code),
          );
        }
        break;
      case AppLifecycleState.detached:
        break;
      case AppLifecycleState.hidden:
        break;
    }
  }
}
