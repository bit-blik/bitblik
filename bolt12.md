# BOLT12 outgoing payout support

## Goal

Allow the coordinator to pay BOLT12 offers for outgoing payments while
preserving the existing BOLT11 behavior and naming wherever practical.

The supported outgoing uses are:

- paying the taker after the maker payment is confirmed;
- refunding the maker through the existing dispute-refund path.

The app should generate or collect the best payout invoice/offer supported by
the user's receiving wallet without asking ordinary users to choose between
BOLT11 and BOLT12.

This plan builds on [ldk-server.md](./ldk-server.md) for the ldk-server backend.

## Decisions

- BOLT12 is for outgoing coordinator payments only.
- Maker funding remains a BOLT11 hold invoice.
- BOLT11 invoices and BOLT12 offers use distinct service methods, result types,
  validators, and wire parameters. `payInvoice` remains BOLT11-only;
  BOLT12 uses dedicated `decodeOffer`, `payOffer`, and
  `reconcileOutgoingOffer` methods.
- `taker_invoice` and `maker_invoice` remain BOLT11-only wire parameters. Add
  `taker_offer` and `maker_offer` for BOLT12 and enforce that exactly one format
  is supplied for each payout.
- Reuse the existing `offers.taker_invoice` and
  `offers.maker_refund_invoice` database columns as persistence slots for the
  selected encoded value. This storage compatibility must not leak back into
  overloaded service methods or wire fields.
- BOLT11 continues to work on every existing backend.
- BOLT12 is used only when the active coordinator backend advertises support.
- The initial BitBlik wire protocol carries a raw `lno...` offer. BIP-321 is
  handled at wallet/backend boundaries rather than replacing BitBlik's current
  fields.
- A payment is successful because the backend reports `SUCCEEDED`/`settled`,
  not because a preimage happens to be present.
- An indeterminate BOLT12 payment must not be retried automatically until it
  has been reconciled. Reusable offers otherwise make double payment possible.

## Why maker funding stays BOLT11

BitBlik's maker deposit is escrow. The coordinator creates an invoice for a
known payment hash and later chooses to claim it with the preimage or fail it.

Current ldk-server `Bolt12Receive` creates an ordinary BOLT12 offer through
ldk-node's `bolt12_payment().receive(...)`. It does not accept a
coordinator-selected payment hash and is not a hold-payment API. ldk-server's
`PaymentClaimable` documentation explicitly limits that event to
`Bolt11ReceiveForHash` payments.

Using ordinary BOLT12 receive for maker funding would auto-settle the payment
and change BitBlik's escrow/trust model. It is therefore out of scope even when
the coordinator backend is ldk-server or NWC.

## Separate types with compatible storage

For service and protocol code, keep the encodings distinct:

```text
BOLT11 invoice = `lnbc...`, `lntb...`, etc.
BOLT12 offer   = `lno...`
```

A BOLT12 invoice is created during the offer/invoice-request exchange between
the payer and recipient nodes. BitBlik users and the coordinator normally
provide the BOLT12 offer, not that transient invoice.

UI text may say “Lightning invoice or offer” or simply “Receive Lightning
payment.” The app should carry a typed invoice-or-offer result internally and
send the matching wire parameter.

The existing offer-table columns are a persistence exception only. On write,
store either the BOLT11 invoice or BOLT12 offer in the existing text column. On
read, inspect the prefix and hydrate exactly one typed domain field. Never pass
that raw persisted string directly to a payment method without classifying and
validating it first.

## Compatibility matrix

| Backend | BOLT11 hold funding | BOLT11 outgoing | BOLT12 outgoing |
| --- | --- | --- | --- |
| LND | yes | yes | no |
| ldk-server | yes | yes | yes |
| NWC | yes, through the hold extension | yes | only when NWC-321 support is advertised and safely recoverable |

Expose the active backend's payout support through coordinator information:

```json
{
  "outgoing_payment_types": ["bolt11", "bolt12"]
}
```

This optional field is backward compatible:

- absence means BOLT11 only;
- old apps continue submitting BOLT11;
- new apps generate BOLT12 only when `bolt12` is advertised;
- a coordinator using LND advertises only `bolt11` and rejects
  `taker_offer`/`maker_offer` before a flow transition commits.

## Separate payment-service APIs

Keep `PaymentService.payInvoice` strictly BOLT11. Rename its reconciliation
method so the format is equally explicit, then expose BOLT12 through a separate
interface implemented only by capable backends:

```dart
abstract class PaymentService {
  Future<PayInvoiceResult> payInvoice({
    required String invoice,
    int? amountSat,
    int? feeLimitSat,
    String? paymentAttemptId,
  });

  Future<PayInvoiceResult?> reconcileOutgoingInvoice({
    required String invoice,
    String? paymentAttemptId,
    String? paymentId,
  });
}

abstract interface class Bolt12PaymentService {
  bool get isBolt12Available;

  Future<Bolt12OfferInfo> decodeOffer({required String offer});

  Future<PayOfferResult> payOffer({
    required String offer,
    required int amountSat,
    int? feeLimitSat,
    required String paymentAttemptId,
  });

  Future<PayOfferResult?> reconcileOutgoingOffer({
    required String offer,
    required String paymentAttemptId,
    String? paymentId,
  });
}
```

`payInvoice` must reject non-BOLT11 input. `payOffer` must reject non-BOLT12
input. Both paths may share private retry/status utilities, but their public
types and validation cannot be overloaded.

Backend values are:

- `LndService` implements only `PaymentService`;
- `LdkServerService` implements `PaymentService` and
  `Bolt12PaymentService`, with `isBolt12Available == true` for a compatible API
  revision;
- `NwcService` implements both interfaces, but `isBolt12Available` is computed
  during `connect` and remains false when the wallet does not advertise the
  required NWC-321 methods or recovery.

Coordinator dispatch must first select the typed invoice or offer stored on the
domain object, then call only its matching service method. BOLT12 is advertised
only when the backend implements `Bolt12PaymentService` and
`isBolt12Available` is true.

## Dedicated invoice and offer inspection

Continue using the existing BOLT11 decoder for invoices. Add a separate BOLT12
offer parser/model:

```dart
class Bolt12OfferInfo {
  final String normalized;
  final String offerId;
  final String network;
  final int? amountMsat;
  final bool isExpired;
  final bool isVariableAmount;
}
```

Suggested location:

```text
packages/coordinator/lib/src/services/bolt12_offer_parser.dart
```

The BOLT12 parser should:

- recognize `lno` case-insensitively and reject BOLT11 input;
- remove a `lightning:` prefix only when its payload is `lno`;
- optionally extract `lno` from a BIP-321 URI received from an app/wallet;
- normalize BOLT12 continuation markers/whitespace according to BOLT12;
- validate checksums/signatures/features through a maintained Lightning
  library rather than a hand-written partial parser;
- return amount, network/chains, expiry, quantity, and offer ID;
- reject malformed or unsupported strings before committing a flow transition.

The implementation should select and pin a Dart-compatible BOLT12 parsing
library. If no sufficiently complete maintained Dart parser is available, put a
small decoder adapter behind the interface and use ldk-server `DecodeOffer` for
that backend, but do not enable NWC BOLT12 until equivalent local validation is
available.

## Validation rules

Keep `_validateTakerInvoiceAmount` and `require_maker_refund_invoice`
BOLT11-only. Add dedicated `_validateTakerOfferAmount` and maker-refund offer
validation for `taker_offer`/`maker_offer`.

For both BOLT11 and BOLT12:

- require the coordinator's Bitcoin network;
- require a positive expected payout;
- reject expired invoices/offers;
- reject unknown required features;
- reject unsupported/non-Lightning payment instructions;
- perform validation before a state transition containing a payout is
  committed.

For BOLT12 v1 support:

- accept bitcoin-denominated fixed offers whose amount matches the expected
  payout;
- accept variable-amount offers and always send the exact expected amount;
- reject fiat-denominated BOLT12 offers;
- allow no quantity or quantity `1` only;
- reject an offer requiring a different quantity;
- never interpret `offer_id` as a unique payment ID.

Preserve the existing BitBlik amount tolerances unless product policy changes
them separately. For a variable offer, the coordinator-supplied amount must be
exactly the calculated taker payout/refund amount.

## Separate payment result types

Keep `PayInvoiceResult` for BOLT11 and add `PayOfferResult` for BOLT12. Both use
the shared `PaymentStatus` enum, but they remain distinct public result types.
BOLT12/NWC may report a settled transaction without returning a preimage, so
the BOLT12 result must use explicit status:

```dart
class PayOfferResult {
  final PaymentStatus status;
  final String? paymentId;
  final String? paymentPreimage;
  final String? payerProof;
  final String? paymentError;
  final int? feeSat;

  bool get isSuccess => status == PaymentStatus.SUCCEEDED;
}
```

`PayInvoiceResult` should also gain explicit `PaymentStatus` so coordinator
orchestration can handle both result types consistently, while retaining its
BOLT11-specific preimage fields. A pending or unknown result must not be
represented as a generic error that triggers an immediate new payment attempt.

The payment ID is backend-scoped:

- BOLT11 commonly uses the payment hash;
- ldk-server BOLT12 uses the returned ldk-node `PaymentId`;
- NWC-321 uses the returned wallet `transaction_id`.

`paymentPreimage` and `payerProof` are optional evidence. Do not log either
secret/proof at normal log levels.

## Durable outgoing payment attempts

The existing reconciliation assumes the BOLT11 invoice itself identifies one
payment. A BOLT12 offer is reusable, so reconciliation requires a separate
per-attempt identifier.

Create an `outgoing_payment_attempts` table before enabling BOLT12:

```text
id                       UUID PRIMARY KEY
offer_id                 UUID NOT NULL
purpose                  TEXT NOT NULL  # taker_payout | maker_refund
generation               INTEGER NOT NULL
payment_type             TEXT NOT NULL  # bolt11 | bolt12
bolt11_invoice           TEXT
bolt12_offer             TEXT
expected_amount_sats     BIGINT NOT NULL
fee_limit_sats           BIGINT
backend_type             TEXT NOT NULL
backend_payment_id       TEXT
state                    TEXT NOT NULL  # prepared|submitted|pending|succeeded|failed|unknown
payment_hash             TEXT
preimage                 TEXT
payer_proof              TEXT
fee_paid_sats            BIGINT
failure_reason           TEXT
created_at               TIMESTAMPTZ NOT NULL
updated_at               TIMESTAMPTZ NOT NULL
settled_at               TIMESTAMPTZ
```

Add a uniqueness constraint on `(offer_id, purpose, generation)` and a check
constraint requiring exactly one of `bolt11_invoice` or `bolt12_offer` to be
non-null and consistent with `payment_type`. A replacement invoice/offer after
a definitive failure increments `generation` and creates a new attempt.

The coordinator payout sequence becomes:

```text
persist PREPARED attempt
        |
        v
reconcile same attempt
        |
        +-- already settled -> finalize BitBlik payout
        |
        +-- pending/unknown -> wait; never create another attempt
        |
        +-- absent/failed -> submit once
                              |
                              v
                    persist backend payment ID
                              |
                              v
                    poll/events/reconcile terminal state
```

The attempt row must be committed before calling the payment backend. Resume
the same attempt after restart whenever the flow is in `payingTaker`, the
refund state, or the payout-failed recovery path.

Only a definitive `FAILED` state permits a new attempt or replacement invoice.
A timeout, disconnect, or missing response produces `PENDING`/`UNKNOWN` and
keeps the flow in recoverable work rather than paying again.

## ldk-server implementation

### Decode and submit

For an `lno` offer passed to `payOffer`:

1. Call `DecodeOffer`.
2. Apply the network, expiry, amount, currency, feature, and quantity rules.
3. Generate a compact opaque payer note from `paymentAttemptId`, for example
   `BitBlik payout <short-token>`.
4. Call `Bolt12Send` with the offer, payer note, and route configuration.
5. For a variable offer, set `amount_msat = expectedAmountSats * 1000`.
6. For a matching fixed-amount offer, omit `amount_msat`.
7. Leave quantity unset for the initial implementation.
8. Persist the returned `payment_id` immediately.

When a fee limit is supplied, use the complete safe route-parameter defaults
already specified in `ldk-server.md`; do not populate only the fee field and
leave the other scalar values at zero.

Do not call `UnifiedSend` with an arbitrary user-provided URI. At the examined
ldk-server revision it can fall back from BOLT12 to BOLT11 and ultimately to an
on-chain payment. BitBlik should select one validated Lightning instruction and
call `Bolt12Send` or `Bolt11Send` directly.

### Completion and reconciliation

After `Bolt12Send`, track `GetPaymentDetails(payment_id)` and/or
`PaymentSuccessful`/`PaymentFailed` events until terminal:

- ldk-node `SUCCEEDED` -> `PaymentStatus.SUCCEEDED`;
- ldk-node `FAILED` -> `PaymentStatus.FAILED`;
- ldk-node `PENDING` -> `PaymentStatus.PENDING`;
- timeout/transport uncertainty -> `PaymentStatus.UNKNOWN`.

For BOLT12, `Payment.kind.bolt12_offer.hash` and `preimage` are optional. A
persisted `SUCCEEDED` status is enough to finalize the payout.

If the `Bolt12Send` response is lost before its payment ID can be persisted,
page through `ListPayments` and find an outgoing BOLT12 payment matching:

- the opaque payer note/attempt token;
- the decoded offer ID;
- the exact amount;
- the attempt time window.

Persist the discovered payment ID and continue normal lookup. The payer note is
visible to the recipient, so it must contain no offer UUID, Nostr pubkey, BLIK
code, or other identifying data beyond a random short token.

A future ldk-server query by client-supplied payment reference would be safer
and more efficient than paginated scanning, but it is not required for the
first ldk-server implementation.

## NWC implementation

The NWC repository currently defines draft NWC-321 `pay` and `receive` methods
for BIP-321 Lightning instructions. Treat it as a versioned optional capability,
not an assumed part of NIP-47.

### Capability gating

Expose the NWC-backed `Bolt12PaymentService` as available only when all of the
following are true:

- the NWC info event/get-info response advertises the NWC-321 extension and
  `pay` method;
- the NDK version used by the coordinator supports that request/response;
- the wallet provides a reliable way to reconcile the returned
  `transaction_id` after restart;
- unknown-result behavior has passed the integration tests below.

If any requirement is missing, continue supporting BOLT11 through
`pay_invoice`, advertise only `bolt11`, and reject `taker_offer`/`maker_offer`
before committing the payout transition.

### Pay mapping

For BOLT12:

1. Wrap the validated raw offer as `bitcoin:?lno=<encoded-offer>` internally.
2. Call NWC-321 `pay`.
3. Always supply the exact expected amount in msat. The wallet must reject a
   conflict with a fixed offer amount.
4. Supply the opaque attempt token as `payer_note`.
5. Optionally include it in NWC metadata when supported, but do not assume the
   wallet persists arbitrary metadata.
6. Persist `transaction_id`, `state`, selected instruction type, amount, fees,
   and optional proof fields.

Keep the existing NWC `pay_invoice` path unchanged for BOLT11.

### NWC retry limitation

The current NWC-321 draft returns a `transaction_id` but does not define a
caller-supplied idempotency key or guaranteed replay semantics. If the response
is lost before BitBlik learns the transaction ID, a reusable offer alone cannot
identify which payment attempt may have completed.

Therefore:

- never retry automatically after an indeterminate NWC BOLT12 result;
- keep the attempt `UNKNOWN` and reconcile through the wallet's transaction
  lookup/history/notifications when correlation is authoritative;
- do not map `UNKNOWN` to `FAILED` merely because a timeout elapsed;
- keep NWC BOLT12 disabled for wallet implementations that cannot close this
  recovery gap.

The preferred NWC specification hardening is either a caller-supplied
idempotency key with lookup support or a requirement that replaying the same
NWC request event returns the original transaction.

## LND behavior

LND remains BOLT11-only:

- it implements `PaymentService`, not `Bolt12PaymentService`;
- `payInvoice` accepts only a validated BOLT11 invoice;
- coordinator discovery advertises only `bolt11`;
- existing BOLT11 send/track behavior is unchanged.

Do not attempt to convert a BOLT12 offer into a BOLT11 invoice in the
coordinator. The invoice-request exchange belongs in a BOLT12-capable wallet or
node.

## BitBlik protocol and model changes

Use mutually exclusive wire parameters:

| Purpose | BOLT11 | BOLT12 |
| --- | --- | --- |
| Taker payout | `taker_invoice` | `taker_offer` |
| Maker dispute refund | `maker_invoice` | `maker_offer` |

Rules:

- `taker_invoice` and `maker_invoice` accept BOLT11 only;
- `taker_offer` and `maker_offer` accept `lno` only;
- legacy `bolt11` remains a BOLT11-only alias where currently accepted;
- reject requests containing both formats for the same payout;
- reject a value whose encoding does not match its parameter;
- serialize the matching explicit key back to clients rather than returning an
  `lno` under an `*_invoice` key.

Represent the distinction in the `Offer` domain model with mutually exclusive
fields, for example:

```dart
final String? takerInvoice;      // BOLT11 only
final String? takerOffer;        // BOLT12 lno only
final String? makerRefundInvoice;
final String? makerRefundOffer;
```

Reuse the existing database columns without adding parallel offer-table
columns:

| Offer domain field | Existing persisted column |
| --- | --- |
| `takerInvoice` / `takerOffer` | `offers.taker_invoice` |
| `makerRefundInvoice` / `makerRefundOffer` | `offers.maker_refund_invoice` |

The database mapper writes the one non-null typed field. When reading an
existing text value, it classifies `lno` as the offer field and BOLT11 prefixes
as the invoice field. Any other prefix is invalid persisted data and must not
reach a backend. The `outgoing_payment_attempts.payment_type` and its one-of
columns preserve the explicit format for payout recovery.

This deliberately limits field reuse to the offer database record. Service
methods, RPC parameters, domain fields, validation, and attempt records remain
separate.

Add the capability list to `CoordinatorInfo` and its Nostr serialization. The
app must consult it before generating a payout invoice or offer. The
coordinator remains authoritative and revalidates every supplied value through
the matching parser.

Do not expose backend payment IDs or payer proofs in public offer events.

## App behavior

The default flow should remain one action from the user's perspective:

```text
user chooses receiving wallet
          |
          v
app asks wallet for payout invoice/offer
          |
          +-- coordinator + wallet support BOLT12 -> submit lno
          |
          +-- otherwise -> submit BOLT11
```

Use separate typed app results and extraction functions, for example:

```dart
sealed class ReceivingPayment {}
class ReceivingInvoice extends ReceivingPayment { final String invoice; }
class ReceivingOffer extends ReceivingPayment { final String offer; }
```

Keep `extractBolt11Invoice` BOLT11-only and add `extractBolt12Offer`. A small
capability-aware caller may inspect a BIP-321 wallet response and return one of
the two typed results, but it must not collapse them back into an untyped
string.

When the coordinator advertises BOLT12 and the wallet response contains both,
prefer `ReceivingOffer` and submit `taker_offer`. Otherwise return
`ReceivingInvoice` and submit `taker_invoice`. If the coordinator does not
advertise the new capability field, request and submit BOLT11 for backward
compatibility.

The app currently has duplicated invoice extraction in the shared flow helper
and the BLIK submission screen. Consolidate the BOLT11 extraction and add the
parallel BOLT12 extraction in one tested module so both generic and BLIK flows
choose and serialize the same typed format.

For NWC-321 `receive`, request the exact expected payout amount. This gives the
wallet the opportunity to return a per-trade fixed BOLT12 offer. Per-trade
offers are preferred for privacy and simpler support, but a manually supplied
valid variable offer is also accepted.

Update user-facing copy only where necessary:

- “Invoice” may remain in compact established UI locations;
- input/help/error text should say “Lightning invoice or offer” when the user
  can paste either;
- do not ask users to understand invoice requests, payment IDs, or payer
  proofs;
- on unsupported coordinators, explain that this coordinator currently
  requires a BOLT11 invoice and offer a one-tap regeneration path.

The payout-failed screen should generate or accept a replacement using the same
capability-aware helper. A replacement is allowed only after the previous
attempt is definitively failed.

## Coordinator flow and recovery changes

Keep the current YAML states, but stop using invoice-named actions as if they
also represented offers. Existing BOLT11 actions remain BOLT11-only. Add
explicit offer validation/write actions or replace the format-specific action
pair with a neutral orchestration action that delegates to separate typed
handlers.

The recommended action layout is:

- `accept_taker_payout`: enforce exactly one of `taker_invoice` or
  `taker_offer`, then delegate to the matching typed writer;
- `resolve_taker_payout`: call `_validateTakerInvoiceAmount` or
  `_validateTakerOfferAmount` based on the explicit field;
- `update_taker_payout`: apply the same one-of and typed validation rules to a
  replacement;
- `require_maker_refund_payout`: enforce exactly one of `maker_invoice` or
  `maker_offer` and delegate to its typed validator;
- `send_payment` and `refund_maker`: dispatch to the typed payment primitive
  after loading the persisted domain field and attempt row.

Retain old RPC event names where protocol compatibility requires them; the
change concerns parameters and internal actions, not the public transition
event names.

Split `_attemptTakerPayment` into BOLT11 and BOLT12 paths, such as
`_attemptTakerInvoicePayment` and `_attemptTakerOfferPayment`. The first calls
`payInvoice`/`reconcileOutgoingInvoice`; the second calls
`payOffer`/`reconcileOutgoingOffer`. They may share private attempt-state
helpers, but neither accepts the other format.

`send_payment` and `refund_maker` should load or create the durable attempt,
select the typed path, and pass its ID/payment ID to the appropriate interface.
They must finalize the flow only on explicit `SUCCEEDED`.

State handling:

| Payment result | Flow behavior |
| --- | --- |
| `SUCCEEDED` | write fees/proof metadata and advance to paid |
| `FAILED` | use existing payout-failed transition/replacement flow |
| `PENDING` | retain committed payout work and schedule reconciliation |
| `UNKNOWN` | retain committed payout work, alert/monitor, never resend automatically |

Startup recovery should resume every nonterminal outgoing attempt, not only
look up a string from offers in the payout-failed state. Existing BOLT11
reconciliation continues to work through the same attempt records.

## Security and privacy

- Never pass arbitrary BIP-321 input to a backend capable of on-chain fallback.
- Never pay more than the coordinator-calculated payout/refund amount.
- Never infer success from presence/absence of a preimage alone.
- Never retry a reusable offer while an earlier attempt is pending or unknown.
- Never use `offer_id` as a unique payment-attempt identifier.
- Keep attempt tokens random and unlinkable to public BitBlik identifiers.
- Do not log invoice strings, offers, preimages, payer proofs, authorization
  metadata, or complete payment IDs at normal levels.
- Bound payment-history reconciliation by backend, direction, offer ID, amount,
  payer note, and time window.
- Validate network/chains before the backend performs an invoice request.

## Tests

### Shared coordinator tests

- format detection for mainnet/testnet/signet/regtest BOLT11 and `lno`;
- `lightning:` normalization and BIP-321 `lno` extraction;
- malformed strings and mixed-case/continuation handling;
- fixed BOLT12 amount validation;
- variable BOLT12 exact-amount behavior;
- expiry, chain, unsupported feature, fiat amount, and quantity rejection;
- legacy BOLT11 validation remains unchanged;
- `PayInvoiceResult.isSuccess` follows explicit status without requiring a
  preimage;
- capability serialization and old-client/old-coordinator fallback;
- LND-backed coordinator rejects `lno` before flow commit;
- BOLT11 service methods reject `lno` and BOLT12 service methods reject
  BOLT11;
- `taker_invoice`/`maker_invoice` accept only BOLT11;
- `taker_offer`/`maker_offer` accept only BOLT12;
- supplying both formats is rejected;
- offer-table persistence maps either typed field into the existing column and
  hydrates the correct typed field on read.

### Durable attempt tests

Exercise crashes/timeouts at each boundary:

- after `PREPARED` is committed but before send;
- after the backend begins send but before returning a payment ID;
- after payment ID return but before it is persisted;
- after the backend settles but before BitBlik marks the offer paid;
- during restart recovery with `PENDING`;
- during restart recovery with `UNKNOWN`;
- replacement after definitive `FAILED`;
- refusal to replace/retry while a prior attempt is not terminal.

Verify that each scenario produces at most one Lightning payment.

### ldk-server tests

- `DecodeOffer` request and every validation mapping;
- fixed offer calls `Bolt12Send` without `amount_msat`;
- variable offer sends the exact `amount_msat`;
- quantity remains unset;
- payer note contains only the opaque attempt token;
- complete fee route parameters are populated;
- returned PaymentId is persisted and queried;
- `PaymentSuccessful` without a preimage still succeeds;
- `PaymentFailed` is terminal;
- response-loss recovery through paginated `ListPayments`;
- ambiguous or multiple history matches remain `UNKNOWN` and never resend;
- `UnifiedSend` is never used for a user payout.

### NWC tests

- capability is disabled without advertised NWC-321 `pay`;
- raw `lno` is wrapped into a BIP-321 URI correctly;
- exact amount, payer note, and metadata mapping;
- `settled` succeeds without a preimage;
- `transaction_id` is persisted and reconciled;
- pending response schedules lookup rather than retry;
- timeout before transaction ID remains `UNKNOWN`;
- wallets without authoritative recovery do not advertise BOLT12 to clients;
- existing `pay_invoice` BOLT11 behavior remains intact.

### App tests

- BOLT12 is preferred when app wallet and coordinator both support it;
- BOLT11 is used when either side lacks BOLT12;
- NWC-321/BIP-321 receive responses extract `lno` correctly;
- shared helper behavior is identical in generic and BLIK flows;
- manual `lno` paste and QR scan;
- payout replacement respects coordinator capabilities;
- user-facing unsupported-format errors provide a BOLT11 fallback action.

### Integration tests

With ldk-server:

1. taker wallet creates a fixed BOLT12 offer;
2. the app submits it as `taker_offer`, and the coordinator persists it in the
   existing `offers.taker_invoice` database column;
3. coordinator pays it with `Bolt12Send`;
4. payment reaches `SUCCEEDED` and the offer reaches `takerPaid`;
5. restart between send and final flow write reconciles without a second
   payment;
6. repeat with a variable offer and exact coordinator-supplied amount;
7. repeat the outgoing maker-refund path.

Add NWC integration tests only against implementations that advertise the
draft extension and provide deterministic transaction reconciliation.

## Documentation

Update coordinator and app documentation to explain:

- BOLT12 applies only to outgoing payouts/refunds;
- maker deposits remain BOLT11 hold invoices;
- supported payout formats depend on the coordinator's active backend;
- old apps and coordinators continue using BOLT11;
- NWC BOLT12 is optional and capability-gated while NWC-321 is draft;
- an unknown payment is deliberately not retried automatically to prevent
  duplicate payouts.

Link the implementation to the reviewed versions of:

- BOLT12: <https://github.com/lightning/bolts/blob/master/12-offer-encoding.md>
- BIP-321: <https://github.com/bitcoin/bips/blob/master/bip-0321.mediawiki>
- NWC optional specifications: <https://github.com/nostr-wallet-connect/nwc>
- NWC-321 draft: <https://github.com/nostr-wallet-connect/nwc/blob/main/321.md>

Pin the ldk-server proto revision through the process already specified in
`ldk-server.md`.

## Implementation sequence

1. Add explicit payment status/payment ID fields to `PayInvoiceResult` and
   update existing LND/NWC behavior and tests.
2. Add the `Bolt12PaymentService` interface and coordinator capability
   advertisement.
3. Implement the dedicated BOLT12 offer parser, explicit wire/domain fields,
   one-of validation, and offer-table persistence mapping.
4. Add the durable outgoing payment-attempt table and recovery worker; migrate
   existing BOLT11 payout code onto it first.
5. Implement ldk-server `DecodeOffer`/`Bolt12Send`/lookup/event/history behavior.
6. Update the app's shared receive helper to prefer BOLT12 when both sides
   support it and retain BOLT11 fallback.
7. Update replacement-payment and maker-refund flows to accept `lno`.
8. Add NWC-321 support behind capability and recovery gates when the selected
   NDK/NWC implementations are ready.
9. Run analysis, unit tests, crash-boundary tests, and ldk-server integration
   tests before enabling the advertised capability in production.

## Acceptance criteria

- Maker funding and its hold-invoice lifecycle are completely unchanged.
- Existing BOLT11 clients, protocol fields, databases, and backends remain
  compatible.
- A BOLT12-capable app submits `lno` through `taker_offer` or `maker_offer`,
  while invoice parameters remain BOLT11-only.
- The existing offer database columns store the selected invoice or offer
  without adding parallel offer-table columns.
- `payInvoice` and invoice reconciliation remain BOLT11-only; BOLT12 is handled
  only by the dedicated offer methods and result type.
- The coordinator advertises BOLT12 only when its active backend can pay and
  safely reconcile it.
- Fixed and variable BOLT12 offers are validated and paid for the intended
  amount on the correct network.
- ldk-server BOLT12 payouts survive coordinator restart and response loss
  without automatic duplicate payment.
- NWC BOLT12 remains disabled for wallets with an unresolved unknown-result
  gap.
- A settled BOLT12 payment succeeds even if no preimage is returned.
- `PENDING` and `UNKNOWN` never trigger a second payment attempt.
- Users normally see one “receive payout” action with automatic BOLT12/BOLT11
  selection and fallback.
- Service methods, wire parameters, domain fields, validators, and attempt
  columns do not overload invoice terminology for BOLT12.

## Out of scope

- BOLT12 maker funding or hold invoices;
- changing the escrow/trust model;
- BOLT12 receive on the coordinator;
- LND BOLT12 support;
- arbitrary on-chain or BIP-321 payment fallback;
- exposing BOLT12 invoice-request mechanics to users;
- treating a reusable offer ID as a payment ID;
- enabling NWC BOLT12 before safe transaction reconciliation exists;
- adding parallel BOLT12 payout columns to the existing `offers` table.
