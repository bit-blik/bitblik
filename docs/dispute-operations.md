# Dispute communication and adjudication

BitBlik keeps financial state changes on its authenticated RPC and YAML state
machine. Human messages never trigger a transition. A dispute has two private
NIP-17 conversations: maker/coordinator and taker/coordinator. There is no
three-party room, and one participant is not given the other participant's
pubkey.

## Protocol

- Human text uses NIP-17 kind-14 rumors, NIP-44 v2, NIP-59 seals, and persistent
  kind-1059 gift wraps. A separately encrypted sender copy provides history.
- Encrypted rumor tags bind the message to
  `38383:<coordinator-pubkey>:<offer-id>` and a deterministic internal case id.
  Gift-wrap metadata does not expose those values or the real sender.
- Clients publish a kind-10050 inbox list. Coordinators publish their working
  relays as their kind-10050 list. Relay access supports NIP-42 authentication.
- Evidence is limited client-side to decoded, single-frame JPEG/PNG images (12
  MiB input and 20 megapixels in v1). It is re-encoded to remove EXIF, location,
  comments, and profiles, then encrypted locally using AES-256-GCM with a fresh
  CSPRNG key and nonce.
- Only ciphertext is uploaded. The coordinator's ordered Blossom servers are
  resolved from its standard kind-10063 event. The encrypted kind-15 rumor is
  the only place containing the URL, MIME type, size, ciphertext/original
  hashes, key, and nonce.
- Download verifies the encrypted SHA-256 and AES-GCM authentication before
  decoding the image. Decrypted preview bytes remain in memory and are released
  when the preview closes.

Relay and Blossom operators can observe IP addresses, timing, and ciphertext
sizes. Deleting events or blobs is best-effort and cannot guarantee deletion
from replicas, caches, or backups.

## Coordinator configuration

Set an ordered, operator-selected list; BitBlik has no hard-coded Blossom host:

```dotenv
BLOSSOM_SERVERS=https://blossom.example,https://backup-blossom.example
LIGHTNING_NETWORK=mainnet
```

At startup the coordinator publishes `BLOSSOM_SERVERS` as kind 10063. With an
empty list, chat still works but evidence uploads are disabled. The existing
`NOSTR_RELAYS` list is used for the coordinator's kind-10050 DM inbox.

Database startup adds `maker_refund_invoice` and the unique
`maker_refund_payment_hash` metadata needed for restart-safe maker payouts, plus
the existing `offer_state_history` audit trail. Deploy the coordinator before
the updated apps. Older clients continue using the previous offer happy path;
they simply do not expose the new dispute conversation or structured invoice
action.

## Coordinator console

Run the native Flutter package in `packages/coordinator/console`. Login and
multi-account switching use NDK Flutter's `NLogin` and `NSwitchAccount` backed
by the NDK Accounts use case. The active signer pubkey must exactly equal the
active coordinator signer pubkey. NIP-55 and NIP-46 are preferred; direct nsec login
is available for operator-controlled devices.

The queue is derived from public kind-38383 events with `s=dispute`. Full
details are fetched through the existing signed `get_offer_details` RPC. There
is no unauthenticated admin HTTP API and no private list/detail RPC. Only an RPC
whose signed author is the running coordinator can execute either ruling.

## Adjudication runbook

1. Select the matching coordinator account and open a dispute from the public
   queue.
2. Check the backend state, offer history, amounts, and both independent lanes.
   Request clearer evidence if necessary. Do not copy evidence between lanes
   unless the participant explicitly authorizes disclosure outside BitBlik.
3. Review the confirmation screen: recipient, sats, backend, and irreversible
   ruling. A maker-favor decision commits `refundingMaker`; it does
   not require or start a payout yet.
4. The maker then chooses the configured receiving wallet, another receiving
   wallet, adds a wallet, or pastes the exact-amount BOLT11 in the structured app
   form. An invoice pasted into chat is not accepted. The coordinator validates
   network, amount, expiry, payment hash, and hold-invoice non-reuse before
   entering `payingMaker`.
5. Submit the ruling once. Duplicate/concurrent decisions are rejected by
   database compare-and-set. The committed `payingMaker` or `payingTaker`
   state is the durable work claim; payout retries resume safely after restart.
6. A definitive maker-refund failure returns to
   `refundingMaker`, allowing a fresh wallet/invoice. Repair backend
   outages rather than manually changing state or paying outside the
   coordinator; outgoing-payment reconciliation protects resumed attempts.

Audit history records the signed actor, decision transition, timestamps,
amounts, and non-secret facts. It never stores chat plaintext, evidence URLs or
keys, invoices, preimages, or image bytes.

## Retention

After resolution, conversation history is read-only. BitBlik does not copy chat
plaintext or file keys into the coordinator database. Encrypted gift wraps and
encrypted blobs remain subject to relay/Blossom retention; v1 performs no
automatic remote deletion. Local NDK caches may retain encrypted wraps until
app data is cleared. State/audit history follows the operator's offer-database
and backup retention policy. Operators should document that duration in their
terms and delete expired database/backups under their normal policy.

Merchant-refund cases for already completed online offers are intentionally not
part of this version and will be implemented separately.
