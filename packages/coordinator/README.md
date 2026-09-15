# Bitblik coordinator

## External Requirements

For running a bitblik coordinator you will need a Lightning node.

Dispute communication, evidence/Blossom configuration, console operation, and
the adjudication runbook are documented in
[`docs/dispute-operations.md`](../../docs/dispute-operations.md). By default,
encrypted picture evidence uses an existing coordinator kind-10063 Blossom
list when available. If none exists, `BLOSSOM_SERVERS` is published as a
fallback, or nostr.download and blossom.jumble.social when that setting is empty. An existing
kind-10063 list always takes precedence over environment configuration.
Supported payment backends are NWC, ldk-server, and LND. When several are
configured, coordinator tries them in that order and falls through when a
backend cannot connect.

## Setup

### 1. Copy docker-compose.example.yml to docker-compose.yml

### 2. Generate a new nostr keypair for the coordinator.

You can use any number of local tools for that, for example: :
- install `go install https://github.com/fiatjaf/nak`
- ```nak encode nsec `nak key generate` ```

Then copy the nsec to the `NOSTR_PRIVATE_KEY` field in the `docker-compose.yml`

### 3. Setup connection to your Lightning node

Choose one or configure several for fallback:
####  LND

Copy your `admin.macaroon` and `tls.cert` files from your LND.

#### NWC

generate a new NWC connection with supported permission `make_hold_invoice` and paste it to the `NWC_URI` field in the `docker-compose.yml`

#### ldk-server

Copy `tls.crt` from the ldk-server data/configuration directory and copy its
64-character lowercase API-key text. Configure:

```yaml
environment:
  LDK_SERVER_HOST: ldk-server
  LDK_SERVER_PORT: 3536
  LDK_SERVER_CERT_PATH: /app/ldk-server-tls.crt
  LDK_SERVER_API_KEY: <64-character-lowercase-api-key>
volumes:
  - ./ldk-server-tls.crt:/app/ldk-server-tls.crt:ro
```

`LDK_SERVER_HOST` must match a DNS name or IP address in certificate SAN. With
Docker networking, use service DNS name only when certificate includes it.
Keep coordinator and ldk-server clocks synchronized: signed requests permit
only 60 seconds of clock skew at pinned API revision.

ldk-server claimable events have a major availability limitation. They use a
bounded live broadcast stream without replay. ldk-server also silently skips
events when its subscriber falls behind. If coordinator is stopped,
disconnected, or lagged when `PaymentClaimable` occurs, it cannot distinguish
funded hold invoice from unpaid invoice through `GetPaymentDetails`; both are
`PENDING`. Coordinator conservatively reports `OPEN`, so funded offer may never
be published and incoming HTLC eventually times out. Monitor stream
disconnect/reconnect logs and keep connection stable.

Only coordinator should settle or cancel its ldk-server hold invoices. Local
operations are serialized, but pinned server API provides no atomic guard
against another process settling while coordinator cancels.

Run opt-in integration coverage against two funded, connected regtest/signet
ldk-server nodes:

```bash
LDK_SERVER_INTEGRATION=1 \
LDK_SERVER_INTEGRATION_RECEIVER_HOST=receiver.example \
LDK_SERVER_INTEGRATION_RECEIVER_PORT=3536 \
LDK_SERVER_INTEGRATION_RECEIVER_CERT_PATH=/path/to/receiver/tls.crt \
LDK_SERVER_INTEGRATION_RECEIVER_API_KEY=<receiver-api-key> \
LDK_SERVER_INTEGRATION_PAYER_HOST=payer.example \
LDK_SERVER_INTEGRATION_PAYER_PORT=3536 \
LDK_SERVER_INTEGRATION_PAYER_CERT_PATH=/path/to/payer/tls.crt \
LDK_SERVER_INTEGRATION_PAYER_API_KEY=<payer-api-key> \
dart test test/ldk_server_integration_test.dart
```

Test pays 1000 sats plus routing fee allowance from payer. Nodes must share
network and have route/liquidity between them. To exercise accepted event-loss
limitation manually, disconnect coordinator after invoice creation and before
payment reaches receiver; reconnect and verify `lookupInvoice` reports `OPEN`
for server-side `PENDING`, never `ACCEPTED`.

When metrics exporter is enabled, monitor
`bitblik_ldk_server_event_stream_connected`,
`bitblik_ldk_server_event_stream_disconnects_total`,
`bitblik_ldk_server_event_stream_reconnects_total`, and
`bitblik_ldk_server_last_event_timestamp_seconds`. Stream health cannot detect
events silently dropped by ldk-server's bounded broadcast channel.

Vendored gRPC definitions come from ldk-server revision recorded in
`protos/ldk_server/REVISION`. Regenerate committed Dart bindings with
`tool/generate_ldk_server_protos.sh`; script is tested with libprotoc 3.21.12
and Dart `protoc_plugin` 22.0.1.

### 4. Setup notifications (optional)

TODO

#### Simplex  

- install simplex-chat client in the server
- create a new group
  - TODO
- set the group name 'Bitblik offers' into `SIMPLEX_GROUP`
- make sure `SIMPLEX_CHAT_EXEC: ./simplex-chat` is added also

#### Matrix

#### Signal

How to find out signal group id:
`./signal-cli -u +XXXXXXXX sendSyncRequest`
`./signal-cli listGroups`

#### Telegram

How to find out telegram bot token & chat id:
- create bot with @BotFather
- add the bot to the group and make it admin
- send a message to your group to see the chat id in the response
- get chat id with https://api.telegram.org/bot<your-bot-token>/getUpdates
- configure `TELEGRAM_CHAT_ID` with either a single destination or a comma-separated list to send to multiple groups/channels at once

For the local central notification bot, set `TEST_TELEGRAM_BOT_TOKEN` and
`TEST_TELEGRAM_GROUP_ID` in `packages/coordinator/.env`, then run:

```bash
docker compose --profile telegram-bot up -d --build telegram-bot
```

The container uses `PAYMENT_SYSTEM` from the same `.env`; its mute-list project
identity is resolved from `bitblik_core` for that payment system.

## Memory Profiling

### Runtime snapshots

Set:

- `MEMORY_PROFILING=true`
- `MEMORY_PROFILING_INTERVAL_SECONDS=30`

The coordinator will emit periodic `MEMORY_SNAPSHOT {json}` log lines with:

- process RSS and `/proc` memory fields
- coordinator in-memory structure counts
- flow-owned timer counts
- Nostr relay / subscription / request counters

### Profiling container

For a VM-service-enabled container, build from the repo root:

```bash
docker build -f packages/coordinator/Dockerfile.profile -t coordinator-profile .
```

This exposes:

- `8080` for the app
- `8181` for Dart VM service / DevTools

### get_info benchmark

The benchmark tool supports two modes:

1. Direct coordinator call path:

```bash
dart run tool/get_info_memory_bench.dart --mode=direct --requests=10000 --report-every=500
```

2. Full Nostr RPC path:

```bash
dart run tool/get_info_memory_bench.dart \
  --mode=nostr \
  --coordinator-pubkey=<hex-pubkey> \
  --relays=wss://relay1,wss://relay2 \
  --requests=10000 \
  --report-every=500 \
  --rate=10
```

The tool prints JSON samples with iteration count, elapsed time, and its own RSS.

### One-command run

If the coordinator is already running, you can collect both benchmark modes and
the coordinator snapshots into one timestamped directory with:

```bash
bash tool/run_memory_profile.sh \
  --coordinator-pubkey=<hex-pubkey> \
  --relays=wss://relay1,wss://relay2 \
  --container=coordinator
```

This writes:

- `direct.jsonl`
- `nostr.jsonl`
- `docker_stats.jsonl`
- `coordinator.log`
- `memory_snapshots.log`
- `docker_inspect.json`
- `run_config.json`
