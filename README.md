# BitBlik

Peer-to-peer BLIK/Lightning exchange over Nostr. Makers fund a Lightning hold invoice; takers pay in BLIK; the coordinator settles atomically.

## Packages

| Package | Path | Description |
| ------- | ---- | ----------- |
| **core** | [`packages/core`](packages/core) | Shared models, protocol codec, RPC client, Nostr event kinds and constants. Used by all other packages. |
| **coordinator** | [`packages/coordinator`](packages/coordinator) | Server-side coordinator: manages offer lifecycle, hold invoices, BLIK flow, and Nostr RPC endpoints. |
| **cli** | [`packages/cli`](packages/cli) | Command-line interface for interacting with the protocol. Create and manage offers, retrieve BLIK codes, confirm payments, and sync local state. |
| **app** | [`packages/app`](packages/app) | Flutter app (mobile, web, desktop) for interacting with the protocol. Browse and manage offers, submit BLIK codes, and track payment status. |

## Protocol

Communication between clients and coordinators uses encrypted Nostr direct messages (NIP-44). Offers are published as parameterised replaceable events (kind 38383). RPC requests are kind 25195, responses 25196, status updates 25197.

