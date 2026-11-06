# BitBlik

Peer-to-peer BLIK/Lightning exchange over Nostr. Makers fund a Lightning hold invoice; takers pay in BLIK; the coordinator settles atomically.

> **Disclaimer:** BitBlik is an independent open-source project. It is not affiliated with, endorsed by, or sponsored by Polski Standard Płatności S.A. BLIK is a registered trademark of Polski Standard Płatności S.A., used here only to describe compatibility with BLIK payment codes.

## Umbrel

This repository is an Umbrel Community App Store. In umbrelOS, open **App
Store → Community App Stores**, add
`https://github.com/bit-blik/bitblik`, then install **BitBlik**.

The web client stores its Neko private key in browser storage. Export a Neko
backup before trading. Umbrel backups do not include browser storage, and a
different hostname or browser profile has separate storage.

## Packages

| Package | Path | Description |
| ------- | ---- | ----------- |
| **core** | [`packages/core`](packages/core) | Shared models, protocol codec, RPC client, Nostr event kinds and constants. Used by all other packages. |
| **coordinator** | [`packages/coordinator`](packages/coordinator) | Server-side coordinator: manages offer lifecycle, hold invoices, BLIK flow, and Nostr RPC endpoints. |
| **cli** | [`packages/cli`](packages/cli) | Command-line interface for interacting with the protocol. Create and manage offers, retrieve BLIK codes, confirm payments, and sync local state. |
| **app** | [`packages/app`](packages/app) | Flutter app (mobile, web, desktop) for interacting with the protocol. Browse and manage offers, submit BLIK codes, and track payment status. |
| **telegram bot** | [`packages/telegram_bot`](packages/telegram_bot) | Central Telegram notifier for every non-muted coordinator in a payment system, with per-pubkey flood control and offer lifecycle edits. |

## Protocol

Transactional communication uses the existing authenticated NIP-44 RPC protocol: requests are kind 25195, responses 25196, and status updates 25197. Human dispute communication uses NIP-17/NIP-44 v2/NIP-59 gift wraps with kind-14 text and kind-15 encrypted-file rumors. Offers are parameterised replaceable kind-38383 events. See [dispute operations](docs/dispute-operations.md).
