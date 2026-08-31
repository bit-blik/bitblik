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
Currently supported are LND or a NWC connection with `make_hold_invoice` capability.

## Setup

### 1. Copy docker-compose.example.yml to docker-compose.yml

### 2. Generate a new nostr keypair for the coordinator.

You can use any number of local tools for that, for example: :
- install `go install https://github.com/fiatjaf/nak`
- ```nak encode nsec `nak key generate` ```

Then copy the nsec to the `NOSTR_PRIVATE_KEY` field in the `docker-compose.yml`

### 3. Setup connection to your Lightning node

you have two options:
####  LND

Copy your `admin.macaroon` and `tls.cert` files from your LND.

#### NWC

generate a new NWC connection with supported permission `make_hold_invoice` and paste it to the `NWC_URI` field in the `docker-compose.yml`

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
