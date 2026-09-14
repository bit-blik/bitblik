# BitBlik

Peer-to-peer BLIK/Lightning exchange over Nostr. Makers fund a Lightning hold invoice; takers pay in BLIK; the coordinator settles atomically.

## Packages

| Package | Path | Description |
| ------- | ---- | ----------- |
| **core** | [`packages/core`](packages/core) | Shared models, protocol codec, RPC client, Nostr event kinds and constants. Used by all other packages. |
| **coordinator** | [`packages/coordinator`](packages/coordinator) | Server-side coordinator: manages offer lifecycle, hold invoices, BLIK flow, and Nostr RPC endpoints. |
| **coordinator console** | [`packages/app/lib/src/coordinator_console`](packages/app/lib/src/coordinator_console) | Coordinator dispute queue, private conversations, evidence review, and adjudication UI embedded in the BitBlik app. |
| **cli** | [`packages/cli`](packages/cli) | Command-line interface for interacting with the protocol. Create and manage offers, retrieve BLIK codes, confirm payments, and sync local state. |
| **app** | [`packages/app`](packages/app) | Flutter app (mobile, web, desktop) for interacting with the protocol. Browse and manage offers, submit BLIK codes, and track payment status. |
| **telegram bot** | [`packages/telegram_bot`](packages/telegram_bot) | Central Telegram notifier for every non-muted coordinator in a payment system, with per-pubkey flood control and offer lifecycle edits. |

## Protocol

Transactional communication uses the existing authenticated NIP-44 RPC protocol: requests are kind 25195, responses 25196, and status updates 25197. Human dispute communication uses NIP-17/NIP-44 v2/NIP-59 gift wraps with kind-14 text and kind-15 encrypted-file rumors. Offers are parameterised replaceable kind-38383 events. See [dispute operations](docs/dispute-operations.md).
