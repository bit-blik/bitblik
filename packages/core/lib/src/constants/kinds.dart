/// Nostr event kinds used by the Bitblik protocol.
///
/// Top-level constants — import via `package:bitblik_core/core.dart` and
/// reference directly (e.g. `kKindCoordinatorInfo`). Single source of truth;
/// do not redeclare in app, coordinator, or cli.

/// Replaceable event published by coordinators advertising their metadata
/// (name, fees, limits, supported currencies, etc.).
const int kKindCoordinatorInfo = 15125;

/// Ephemeral NIP-44 encrypted request from client to coordinator
/// (NIP-47 style RPC envelope).
const int kKindCoordinatorRequest = 25195;

/// Ephemeral NIP-44 encrypted response from coordinator to client.
const int kKindCoordinatorResponse = 25196;

/// Ephemeral offer status update notification from coordinator.
const int kKindOfferStatusUpdate = 25197;

/// Parameterized replaceable public offer listing (P2P trade marker).
const int kKindOffer = 38383;

/// NIP-65 relay list metadata. Coordinators publish this to advertise the
/// relays they actively use; clients read it to route all per-coordinator
/// communication. Tags are `["r", "wss://relay", ("read"|"write")?]`.
const int kKindRelayList = 10002;
