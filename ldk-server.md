# ldk-server coordinator payment backend

## Goal

Add `ldk-server` as a third coordinator `PaymentService` backend, alongside NWC
and LND. The integration uses ldk-server's TLS gRPC API for hold-invoice
creation, invoice lifecycle events, settlement, cancellation, and outgoing
payments.

This is an implementation plan, not a protocol change. The existing
coordinator flow and `PaymentService` interface remain the source of truth.

## Accepted limitation

For this first version, we explicitly accept that ldk-server does not persist or
replay its gRPC `PaymentClaimable` notification.

ldk-node internally keeps a claimable event until ldk-server handles it, but
ldk-server publishes that event to a bounded, non-replayable gRPC broadcast
stream and then marks the ldk-node event handled. Its persisted payment record
does not distinguish these two states:

- invoice exists but no HTLC has been accepted yet;
- an HTLC is claimable and the node can settle or fail it.

Both appear as `PENDING` through `GetPaymentDetails`. Therefore this backend
must never interpret a generic `PENDING` payment as coordinator `ACCEPTED`.
`ACCEPTED` is known only after observing the live `PaymentClaimable` event in
the current process.

If the coordinator is stopped, disconnected, or too slow at the wrong moment,
it can miss that event. After reconnecting it will see only `PENDING`, keep the
invoice at `OPEN`, and not publish the offer. The incoming HTLC will eventually
time out unless another actor settles or fails it. This is an accepted
availability risk for the initial integration; it must be prominently
documented for operators.

No ldk-server or ldk-node changes are in scope for this version.

## Source API and compatibility baseline

The gRPC definitions should be copied from the sibling ldk-server repository:

```text
../ldk-server/ldk-server-grpc/src/proto/
  api.proto
  error.proto
  events.proto
  types.proto
```

The API examined for this plan is ldk-server commit
`7f3276a2b7d45469ba2520751d00df7f0596ca9e`. Record this revision next to the
vendored protos so future updates can be reviewed as deliberate API upgrades.

At this revision, BOLT11 payment IDs are the payment hash bytes for both
incoming and outgoing payments. The backend may therefore query BOLT11 payment
state with `GetPaymentDetails(payment_id: paymentHash)`.

## Architecture

Implement one new service without changing coordinator business logic:

```text
CoordinatorService
       |
       v
PaymentService interface
       |
       +-- NwcService
       +-- LndService
       +-- LdkServerService -- TLS + signed gRPC --> ldk-server --> ldk-node
```

The new implementation should live at:

```text
packages/coordinator/lib/src/services/ldk_server_service.dart
```

Generated Dart bindings should live under:

```text
packages/coordinator/lib/src/generated/ldk_server/
```

`LdkServerService` owns one gRPC channel, one generated client, and one shared
`SubscribeEvents` connection. Per-payment subscriptions filter a broadcast
Dart stream instead of opening a separate server stream for every invoice.

## Configuration and backend selection

Add these environment variables:

| Variable | Required | Meaning |
| --- | --- | --- |
| `LDK_SERVER_HOST` | yes, to enable | Hostname used for the TLS gRPC connection |
| `LDK_SERVER_PORT` | no | gRPC port; default `3536` |
| `LDK_SERVER_CERT_PATH` | yes | Path to the pinned ldk-server TLS certificate |
| `LDK_SERVER_API_KEY` | yes | ldk-server API key as its 64-character lowercase hex text |

The API key is used as UTF-8 text when constructing the HMAC key. It must not
be hex-decoded first.

Preserve the current configuration behavior and add ldk-server to the fallback
chain:

1. Try NWC when `NWC_URI` is configured.
2. Try ldk-server when all required `LDK_SERVER_*` values are configured.
3. Try LND when `LND_HOST` is configured.
4. Otherwise report that no payment backend is available.

If a configured backend cannot connect, log the failure without secrets and
continue to the next configured backend. If multiple backends are configured,
log which one was selected. Report the selected type as `ldk-server` through
the existing backend status output.

This ordering preserves NWC-first behavior and existing NWC-to-LND fallback
while allowing ldk-server to be introduced without removing an LND fallback.

Update:

- `packages/coordinator/bin/server.dart`
- `packages/coordinator/lib/src/services/coordinator_service.dart`
- `packages/coordinator/README.md`
- `packages/coordinator/docker-compose.example.yml`

The Docker example must mount the TLS certificate read-only. Never log the API
key, authorization header, HMAC, preimage, or raw signed request.

## Protobuf generation

Vendor all four canonical proto files in:

```text
packages/coordinator/protos/ldk_server/
```

Generate protobuf and gRPC Dart bindings with `protoc --dart_out=grpc`. Add a
small reproducible generation script under `packages/coordinator/tool/` and
document the required `protoc` and Dart protobuf plugin versions. Generated
files should be committed, matching the existing LND binding approach.

Add `crypto` as a direct coordinator dependency for SHA-256 and HMAC-SHA256.
The coordinator already depends on `grpc`, `protobuf`, and `fixnum`.

## TLS and request authentication

Use a secure `ClientChannel` whose trusted root is the certificate loaded from
`LDK_SERVER_CERT_PATH`. Do not provide an insecure/plaintext mode. The
configured hostname must match the certificate identity; deployment docs
should call this out when ldk-server runs under Docker DNS.

Every RPC, including `SubscribeEvents`, requires this metadata:

```text
x-auth: HMAC <unix_timestamp>:<hmac_hex>
```

The signature is:

```text
HMAC-SHA256(
  key = UTF8(LDK_SERVER_API_KEY),
  message = uint64_be(unix_timestamp) || grpc_framed_request
)
```

For an uncompressed unary request, construct `grpc_framed_request` as:

```text
0x00 || uint32_be(protobuf_length) || protobuf_bytes
```

The empty request used by `SubscribeEvents` is therefore five zero bytes after
the timestamp prefix. Generate the metadata immediately before each call.
ldk-server accepts only a small clock skew (currently 60 seconds), so auth
errors should mention checking host clock synchronization without exposing
credentials.

Implement this as a helper that accepts the exact generated request message and
returns `CallOptions`. Give it an injectable clock so deterministic test
vectors can verify the bytes and signature. Avoid a generic interceptor unless
it can reliably sign the exact serialized request body.

## PaymentService method mapping

### `connect` and `disconnect`

`connect` should:

1. validate configuration and load the pinned certificate;
2. create the secure gRPC channel and generated client;
3. call `GetNodeInfo` as an authenticated health check;
4. start and confirm the shared `SubscribeEvents` listener;
5. only then report the backend ready.

Starting the event listener before serving invoice requests minimizes the
window in which a claimable event could be missed.

On a transient event-stream failure, keep the local broadcast controller open
and reconnect with bounded exponential backoff. Log each disconnection and
successful resubscription. Do not forward a transient stream error or close to
per-invoice listeners: current coordinator error handling removes pending
offers when their invoice stream errors.

`disconnect` should deliberately stop reconnect attempts, cancel the event
subscription, close the channel, and then close the local controller.

### `createHoldInvoice`

Call `Bolt11ReceiveForHash` with:

- `amount_msat = amountSats * 1000`;
- direct invoice description set to `memo`;
- `expiry_secs = 86400`, matching the current coordinator hold-invoice
  expectation;
- the coordinator-generated 32-byte payment hash.

Return the BOLT11 invoice from the response and the requested hash. Validate all
hashes as exactly 32 bytes and normalize public hexadecimal values to lowercase.

### `subscribeToInvoiceUpdates`

Filter the one shared gRPC event stream by payment hash and map events as
follows:

| ldk-server event | Coordinator status | Local action |
| --- | --- | --- |
| `PaymentClaimable` | `ACCEPTED` | remember hash as claimable and emit update |
| `PaymentReceived` | `SETTLED` | forget claimable hash and emit update |

Manual `Bolt11FailForHash` does not reliably produce an invoice-specific
`PaymentFailed` event for this purpose. The initiating cancellation path should
emit/update its local terminal result and verify it with payment lookup.

Maintain a process-local set of hashes for which `PaymentClaimable` was seen.
This makes a later lookup in the same process return `ACCEPTED` while the
persisted ldk-node state remains `PENDING`. It is intentionally not persisted:
persisting only this client-side observation would introduce recovery and
atomicity semantics that this accepted-risk version is not designed to
guarantee.

Ignore unrelated event types. A malformed event should be logged and skipped,
not terminate the shared stream.

### `lookupInvoice`

Call `GetPaymentDetails` using the payment hash bytes as `payment_id` and map:

| ldk-server payment status | Coordinator status |
| --- | --- |
| `PENDING`, hash seen claimable in this process | `ACCEPTED` |
| `PENDING`, otherwise | `OPEN` |
| `SUCCEEDED` | `SETTLED` |
| `FAILED` | `CANCELED` |
| missing/invalid/unrecognized | `UNKNOWN` or existing not-found semantics |

The conservative `PENDING -> OPEN` default is mandatory. It prevents ordinary
unpaid invoices from being mistaken for funded offers.

### `settleInvoice`

1. Decode and validate the 32-byte preimage.
2. Derive `payment_hash = SHA256(preimage)` locally.
3. Call `Bolt11ClaimForHash` with both values. Omit
   `claimable_amount_msat`; ldk-server then permits claiming the complete
   claimable payment.
4. Poll `GetPaymentDetails(payment_hash)` until it is `SUCCEEDED`, fails, or a
   bounded timeout expires.
5. Return success only after observing `SUCCEEDED`.

The final poll is required because the current claim RPC can return successfully
even if no matching live claimable HTLC was found. A successful RPC response by
itself is not proof of settlement.

Use the existing settlement action's reconciliation behavior as an additional
safety net: if the call throws after settlement, `lookupInvoice` can still
confirm `SETTLED`.

### `cancelInvoice`

Call `Bolt11FailForHash(payment_hash)`, then verify the payment becomes
`FAILED`. Map that state to `CANCELED` and remove the hash from the process-local
claimable set.

If the RPC reports an error or the invoice is already absent, reconcile with
`GetPaymentDetails` and preserve the existing `CancelInvoiceResult` distinction
between a successful cancellation and an already missing/terminal invoice.
Do not treat a still-`PENDING` result as canceled.

### `payInvoice`

Decode the BOLT11 invoice with `DecodeInvoice` before sending. This provides the
payment hash for reconciliation and allows validation that a zero-amount invoice
has an explicit `amountSat`.

Call `Bolt11Send` with:

- the invoice;
- optional `amount_msat = amountSat * 1000` for a zero-amount invoice;
- route parameters when a fee limit is requested.

When setting `max_total_routing_fee_msat = feeLimitSat * 1000`, also populate
safe ldk-node defaults for the other route configuration fields:

```text
max_total_cltv_expiry_delta = 1008
max_path_count = 10
max_channel_saturation_power_of_half = 2
```

ldk-server passes explicitly supplied scalar zero values through to ldk-node,
so a partially populated route configuration would accidentally disable useful
defaults.

`Bolt11Send` returns a payment ID before the payment is necessarily terminal.
Poll `GetPaymentDetails` by that returned ID until:

- `SUCCEEDED`: return preimage and fee, converting msat to sat consistently
  with the existing backends;
- `FAILED`: return the provider failure as `paymentError`;
- timeout: return an indeterminate/pending payment error so the coordinator
  invokes reconciliation rather than sending again blindly.

### `reconcileOutgoingPayment`

1. Call `DecodeInvoice` to obtain its payment hash.
2. Call `GetPaymentDetails(payment_id: paymentHash)`.
3. Return a successful prior payment only for `SUCCEEDED` with a usable
   preimage.
4. Return no successful prior payment for `PENDING`, `FAILED`, or not found.

This preserves the coordinator's existing before-and-after-send reconciliation
flow and reduces duplicate-payment risk after transport failures.

## State model

```text
create invoice
     |
     v
OPEN / ldk PENDING
     |
     | live PaymentClaimable received
     v
ACCEPTED / ldk still PENDING
     |                         |
     | Bolt11ClaimForHash      | Bolt11FailForHash
     v                         v
SETTLED / SUCCEEDED       CANCELED / FAILED
```

On restart or after a missed event, both `OPEN` and `ACCEPTED` collapse back to
the observable ldk-server state `PENDING`. The backend must choose `OPEN` in
that ambiguous case.

## Error handling and observability

Use the existing `PaymentService` result and exception conventions so callers
do not need ldk-server-specific branches. Translate gRPC status errors into
messages that retain the operation and status code but omit sensitive metadata.

Log at least:

- backend connection and selected endpoint;
- event-stream connected, disconnected, lagged, and reconnected states;
- payment status transitions keyed by payment-hash prefix only;
- `PaymentClaimable.claim_deadline`, when present;
- settlement/cancellation confirmation timeouts;
- auth failures with a clock-synchronization hint.

If the coordinator already exposes compatible metrics, add counters for event
stream disconnects/reconnects and a gauge/timestamp for the last received event.
Metrics are useful observability, not a substitute for replay or recovery.

## Tests

### Unit tests

Add focused tests for:

- deterministic HMAC vectors, including the five-byte empty streaming request;
- using the API key's textual bytes rather than hex-decoding it;
- timestamp and gRPC frame byte order;
- TLS certificate loading and invalid/missing configuration;
- hash/preimage validation and lowercase normalization;
- sat/msat conversion and overflow checks;
- all request mappings listed above;
- route defaults when a fee limit is supplied;
- one shared event stream serving multiple filtered invoice subscriptions;
- `PaymentClaimable -> ACCEPTED` and `PaymentReceived -> SETTLED`;
- a transient stream disconnect reconnecting without terminating invoice
  listeners;
- `PENDING -> OPEN` unless the process-local claimable set contains the hash;
- clearing the claimable set on settlement and cancellation;
- settlement waiting for `SUCCEEDED` instead of trusting the claim RPC;
- outgoing payment success, failure, timeout, and reconciliation;
- backend selection and fallback order.

Use an injectable generated-client adapter, clock, and retry delay so tests do
not need a real server or real-time sleeps. Keep the public `PaymentService`
interface unchanged, so existing coordinator action tests and mocks should need
minimal changes.

### Integration test

Add an opt-in integration test against a local ldk-server instance on a
regtest/signet-compatible setup. It should cover:

1. authenticated TLS connection;
2. invoice creation for a coordinator-selected payment hash;
3. live claimable event delivery;
4. claim and confirmed settlement;
5. fail and confirmed cancellation;
6. outgoing send and persisted reconciliation after reconnect.

Also include one documented manual failure exercise: disconnect the coordinator
before the claimable event, reconnect it, and confirm that lookup reports
`OPEN` rather than falsely reporting `ACCEPTED`. This demonstrates the accepted
limitation.

## Documentation and deployment notes

Coordinator documentation should include:

- how to locate/copy ldk-server's `tls.crt` and API-key text;
- certificate hostname/SAN and Docker networking requirements;
- the need for synchronized clocks;
- a complete environment and read-only certificate mount example;
- the backend selection/fallback order;
- a conspicuous warning that claimable events are live, bounded, and not
  replayed;
- operational advice to keep the coordinator and stream connection stable and
  monitor disconnects.

The warning should state the consequence precisely: a missed claimable event can
prevent an otherwise funded offer from being published and cannot be recovered
from `GetPaymentDetails` in this version.

## Implementation sequence

1. Vendor and generate the ldk-server protobuf bindings; add the `crypto`
   dependency and reproducible generation script.
2. Implement the request signer and its deterministic tests.
3. Implement secure connection lifecycle and the shared reconnecting event
   stream.
4. Implement inbound invoice create, subscribe, lookup, settle, and cancel
   behavior with unit tests.
5. Implement outgoing send and reconciliation with unit tests.
6. Wire environment parsing, backend selection, status reporting, and fallback
   tests into `CoordinatorService` and `server.dart`.
7. Update README and Docker examples, including the accepted-risk warning.
8. Run coordinator analysis and tests, then execute the opt-in integration test
   against ldk-server.

## Acceptance criteria

- The coordinator can select ldk-server through environment configuration and
  still fall back to the existing backend chain on connection failure.
- All ldk-server calls use pinned TLS and correctly signed gRPC request bodies.
- A live `PaymentClaimable` event creates the same coordinator offer flow as an
  LND/NWC `ACCEPTED` invoice update.
- Hold invoices can be claimed or failed and their terminal state is verified,
  not inferred from an RPC acknowledgement.
- Outgoing invoices can be paid and reconciled without assuming the send RPC is
  terminal.
- Generic ldk-server `PENDING` is never treated as proof that funds are
  claimable.
- Event-stream reconnects do not silently terminate all per-invoice listeners.
- Unit tests cover authentication, state mapping, reconnect behavior, RPC
  mappings, and backend fallback.
- Operator documentation clearly describes the non-persisted claimable-event
  risk accepted by this implementation.

## Future hardening (out of scope)

Eliminating the accepted risk requires an ldk-server API change, not a client
heuristic. A future ldk-server version should expose either:

- a queryable inbound state that distinguishes `OPEN` from `CLAIMABLE`, backed
  by ldk-node's live claimable-payment state; or
- durable event sequence IDs plus replay/acknowledgement semantics so a client
  can resume after its last processed event.

At that point, replace the process-local claimable set with authoritative
server-side recovery and add restart/disconnect recovery tests. Until then, do
not add a `PENDING -> ACCEPTED` shortcut.
