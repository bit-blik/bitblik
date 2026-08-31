# Dispute DMs: implementation handoff

This records the agreed design and current worktree state so the next agent can continue without rediscovering strategic decisions.

## Product boundaries

- This task covers disputes only. Merchant refunds for completed online offers are deferred.
- Financial actions stay on signed encrypted RPC plus the existing YAML state machine. Chat, attachments, and pasted chat text never trigger a payment or state transition.
- Each offer has exactly two private lanes: maker <-> coordinator and taker <-> coordinator. Never create a group room or reveal the other participant's pubkey.
- Generic Nostr functionality belongs in `../ndk`; BitBlik owns offer membership, case binding, UI, and coordinator policy.
- The coordinator console is native-only. It uses NDK Accounts and NDK Flutter `NLogin`/`NSwitchAccount`; multiple accounts are allowed. The active signer pubkey determines which coordinator is managed. There is no separately typed coordinator key. Direct nsec entry is acceptable on the operator's native device.
- Queue data comes from public coordinator-authored kind-38383 offer events with `s=dispute`, not case list/detail RPCs. Existing signed `get_offer_details` RPC may return details to the running coordinator's signing key although it is not maker/taker. The coordinator service must be deployed/restarted for this to work.
- Only a request signed by the running coordinator may rule using existing `resolve_dispute_refund_maker` / `resolve_dispute_pay_taker` transitions.
- Blossom discovery uses coordinator kind-10063. Do not put Blossom URLs, generic capabilities, or evidence caps in a custom coordinator-info event. Client image limits are policy; a Blossom server may be stricter.

## NIP-17 primary channel

Normal dispute chat is NIP-17: NIP-44 v2 kind-14 text and kind-15 file rumors, NIP-59 seals, and persistent kind-1059 gift wraps. Send separately wrapped recipient and sender copies. Use kind-10050 inbox relay discovery. Subscribe normally on public inbox relays; an NIP-42 account-bound connection is appropriate only after a relay requests authentication, because proactively waiting for a challenge from a relay that does not issue one prevents the subscription from starting.

Bind only the encrypted rumor to `a = 38383:<coordinator-pubkey>:<offer-id>` plus deterministic case id `sha256("bitblik-dispute-v1:<coordinator lower-case>:<offer id>")`. Outer wraps expose only normal recipient `p` tags. Validate wrap/seal signatures, seal/rumor author match, recipient, canonical rumor id, timestamp skew, participant tags, malformed files, and replay/deduplication before display. Validate membership from coordinator/offer state—not rumor tags or UI parameters. Resolved history is read-only and no chat plaintext/file key enters coordinator audit data.

Relevant files:

- `packages/core/lib/src/communication/dispute_communication_service.dart`
- `packages/app/lib/src/widgets/dispute_conversation_card.dart`
- `packages/app/lib/src/coordinator_console/dispute_queue_screen.dart`

## Explicit legacy NIP-04 fallback

The product decision changed from “never use NIP-04” to a constrained compatibility fallback for legacy users with no kind-10050 (and possibly no kind-10002), who may use their existing nsec in an old external Nostr client supporting kind-4 DMs.

Generic support is on NDK branch `feat/legacy-dm-04`, commit `2ac9d4ce5c7e844384cf74dc2644779dfba0bc22` (`feat: add explicit legacy nip04 dms`). BitBlik root overrides, core, and app's NDK Flutter override are pinned to that commit until it merges upstream.

New NDK API in `packages/ndk/lib/domain_layer/usecases/dms/dms.dart`:

- `Dms.sendLegacyNip04Message(...)`
- `Dms.loadLegacyNip04Conversation(...)`
- `Dms.kLegacyNip04MessageKind` / `LegacyNip04Message`

It is intentionally not implicit in `Dms.sendMessage`: callers must choose non-empty explicit rendezvous relays; only kind-4 encrypted text is sent; no arbitrary relay discovery/broadcast occurs; load validates pubkeys, canonical id, signature presence, a single recipient tag, timestamp, and decryption. Never use it for evidence, URLs/keys, invoices, preimages, credentials, RPC, payment commands, or state transitions.

NIP-04 is materially less private: relays see sender, recipient, time, kind, and traffic correlation. It has no gift-wrap anonymity and no sender-history copy. Label the UI **Legacy NIP-04 compatibility channel** with a privacy warning.

### Legacy wiring (implemented)

The NDK primitive and focused tests exist and BitBlik now wires the constrained fallback into both dispute UIs.

1. Try NIP-17 first. Fall back only for the specific missing-recipient-kind-10050 failure, never for a general send error.
2. The console keeps a coordinator-wide kind-4 subscription on its coordinator/shared compatibility relays and includes the participant's NIP-65 relays when loading history or sending. NIP-04 is listened to alongside NIP-17 because an external client may use kind 4 even when the participant has published kind 10050.
3. NIP-04 cannot use public tags for offer/case binding. Participant-originated BitBlik fallback text retains the encrypted human-readable case reference for coordinator routing. Coordinator replies and external-client messages are plain exact-peer text with no visible case prefix. The whole lane switches to an amber **NIP-04** header pill; individual messages receive no transport suffix or channel warning. A message carrying a reference for another BitBlik dispute is rejected. Confirmed NIP-17 lanes show a green **NIP-17** pill; no pill is shown while transport detection is pending. Ordinary external-client NIP-17 messages omit BitBlik case tags, so the coordinator may display an untagged message only in the exact participant lane; any partial or different explicit case binding is rejected. Never put offer/case/participant metadata into kind-4 tags.
4. Do not present unbound legacy content as case evidence or an authorization signal. It can assist humans only.
5. No attachment control in legacy mode. Evidence remains NIP-17-only.
6. End-user fallback needs a known coordinator relay set; if unavailable, fail clearly rather than guessing.

## Evidence

Evidence is NIP-17-only: decoded single-frame JPEG/PNG (v1: 12 MiB/20 MP), re-encode to remove EXIF/location/comments/profiles, then AES-256-GCM using a fresh CSPRNG key/nonce. Upload ciphertext only to coordinator kind-10063 Blossom servers. Store ciphertext URL, MIME, hashes, key, nonce, size and dimensions solely inside encrypted kind-15 rumor. Verify encrypted SHA-256 and GCM authentication before decode; retain preview bytes in memory and avoid logs.

Relay/Blossom operators still observe IP, timing, ciphertext size. Deletion is best effort and NDK caches/operator backups retain data under their own policies.

## Adjudication and deployment

- A coordinator maker-favor ruling first commits `refundingMaker`. Only then does the maker submit an exact payout invoice by structured signed RPC/UI, never chat. The maker can generate it from the current receiving wallet, another wallet, add a wallet, or paste one manually. Validate network, amount, expiry, payment hash and backend capability before entering `payingMaker`; a definitive refund failure returns to `refundingMaker` for another choice.
- Dispute entry already secures the original hold-invoice funds. Decisions need CAS/idempotency/restart recovery; no duplicate payout.
- Audit history stores actor, decision, timestamps, amounts, transition and non-secret message hashes only—never plaintext chat, image bytes/keys, invoice or preimage.
- “Coordinator has no local record” means the console saw a public offer but the coordinator backend lacks the offer or has not deployed the updated coordinator-signed `get_offer_details` authorization. Public events alone cannot replace backend state.
- Console has no HTTP admin API; it uses active coordinator-signed RPC.

## Current status and verification

Already implemented in the worktree: NIP-17 text/file primitives, kind-10050 publication in NDK `Dms`, encrypted evidence path, public dispute queue, account-derived console login, coordinator signed offer-details access, structured maker invoice path, and maker-only refund action visibility (never render it for a taker).

The app and console now own long-lived kind-1059 inbox subscriptions independent of the conversation widgets. Both publish and read back their kind-10050 lists before declaring the inbox ready, and the console advertises the shared DM-capable relay set instead of its unrelated RPC/NIP-65 set. Incoming wrappers are decrypted once into NDK's validated cache, case-bound, and the already-decrypted message is appended directly to exactly one participant lane with rumor-id deduplication. Each process also retains a rumor-id-keyed inbox snapshot so messages received before a lane mounts are replayed after its initial history load instead of being lost by a broadcast-stream race. Historical rendering still reads cache snapshots. The live path does not re-query the cache and does not issue `dm-conversations` one-shot queries, whose EOSE close previously discarded late relay events.

The authenticated coordinator key is authoritative when the console reconstructs an offer from `get_offer_details`. Coordinator RPC responses stamp that key even when an older database row has an empty `coordinator_pubkey`; otherwise coordinator messages would be emitted with `a = 38383::<offer-id>` and participants' correctly bound messages would fail the console's case filter. Coordinate construction trims identity fields, canonicalizes the hex coordinator key to lower case, and rejects incomplete identities rather than publishing an unusable rumor.

BitBlik legacy fallback wiring now keeps NIP-17-first sending while the console concurrently receives external kind-4 messages. Valid kind-4 events are signature-checked, decrypted once, deduplicated, routed only by the actual participant pubkey, and replayed from a bounded snapshot when a lane mounts. Bound replies retain the encrypted case reference; unbound external-client text is visibly marked as human assistance and cannot become evidence or an authorization signal.

Focused NDK verification passed:

```sh
cd ../ndk/packages/ndk
rtk dart test test/usecases/dms/dms_test.dart
```

This passed 27 tests. It emits known Cashu/no-seed warnings and post-test mock-relay reconnect warnings, without test failures.

Focused BitBlik verification also passes 12 app communication/widget tests, including a cryptographic maker-wrapper-to-coordinator-lane round trip and the regression for async `setState`. Coordinator session tests pass, and focused analysis is clean for app, core, and console.

Before final handoff, run `dart pub get` after the BitBlik NDK pin, then relevant core/coordinator/app/console tests and analyzers. Preserve unrelated dirty files.
