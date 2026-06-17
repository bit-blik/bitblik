/// RPC method names exchanged inside encrypted coordinator request/response
/// events (kinds [kKindCoordinatorRequest] / [kKindCoordinatorResponse]).
///
/// Top-level constants — import via `package:bitblik_core/core.dart` and
/// reference directly (e.g. `kRpcGetInfo`). Single source of truth for the
/// protocol vocabulary.

// Coordinator metadata
const String kRpcGetInfo = 'get_info';

// Offer lifecycle (maker)
const String kRpcInitiateOffer = 'initiate_offer';
const String kRpcCancelOffer = 'cancel_offer';
const String kRpcGetBlik = 'get_blik';
const String kRpcConfirmPayment = 'confirm_payment';
const String kRpcMarkBlikInvalid = 'mark_blik_invalid';
const String kRpcOpenDispute = 'open_dispute';

// Offer lifecycle (taker)
const String kRpcReserveOffer = 'reserve_offer';
const String kRpcSubmitBlik = 'submit_blik';
const String kRpcCancelReservation = 'cancel_reservation';
const String kRpcUpdateTakerInvoice = 'update_taker_invoice';
const String kRpcRetryTakerPayment = 'retry_taker_payment';
const String kRpcMarkBlikCharged = 'mark_blik_charged';

// Queries
const String kRpcGetOfferDetails = 'get_offer_details';

// DEPRECATED: clients now resolve a local-only offer (id == payment hash, no
// UUID yet) via `get_offer_details` with a `payment_hash` param. Coordinator
// handler kept for old clients.
const String kRpcGetMyActiveOffer = 'get_my_active_offer';
// DEPRECATED: clients now count finished offers from their own local DB
// instead of re-fetching from the coordinator. Only old clients still call it.
const String kRpcGetMyFinishedOffers = 'get_my_finished_offers';
// DEPRECATED: clients now compute successful-offer stats client-side from the
// coordinators' public `s=success` offer events (count + reserve/paid timings),
// so this no longer fans out an RPC. Coordinator handler kept for old clients.
const String kRpcGetSuccessfulOffersStats = 'get_successful_offers_stats';
