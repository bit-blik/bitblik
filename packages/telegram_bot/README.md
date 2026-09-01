# BitBlik Telegram bot

One central Telegram bot announces public funded offers from every discovered
coordinator in one payment system. It replaces the per-coordinator Telegram
bot permissions formerly needed for a generic group.

The service:

- discovers coordinators and their NIP-65 relays from the selected payment
  system's project identity;
- subscribes to public kind-38383 offers filtered by the market's `y` tag;
- resolves each coordinator's kind-0 display name, falling back to the name
  announced in kind 15125, and includes it in offer posts;
- prints the monitored coordinator identities at startup and logs funded,
  finished, and canceled/expired offer transitions;
- follows that identity's NIP-51 mute list and removes messages belonging to a
  newly muted coordinator;
- rate-limits only the coordinator pubkey producing offers too quickly;
- strikes a message when the offer becomes `canceled` and deletes it when the
  offer becomes `success` (`takerPaid`);
- persists Telegram message IDs and last-seen Nostr event timestamps so those
  edits survive restarts and relay replays.

## Run

Create a bot with BotFather, add it to the destination group, and configure the
group's numeric chat ID. A normal group only needs permission to send messages;
a Telegram channel requires the central bot to be allowed to post.

```sh
export PAYMENT_SYSTEM=blik
export TELEGRAM_BOT_TOKEN=123456:secret
export TELEGRAM_CHAT_IDS=-1001234567890
export STATE_FILE=./telegram_bot_state.json
dart run bin/server.dart
```

The server automatically reads `.env` from its current working directory.
Process environment variables override values from the file, so the same
binary works unchanged in Docker and CI.

For a direct host run, keep `STATE_FILE` on a user-writable path such as
`./telegram_bot_state.json`. The Docker image uses its writable `/data` volume.

See [`.env.example`](.env.example) for all settings. `PAYMENT_SYSTEM` accepts
`blik`, `mbway`, `twint`, or `sk`. Multiple comma-separated chat IDs are
supported. The bot reads the selected system's canonical project Nostr
identity from `bitblik_core` for discovery and muting.

CI publishes one generic image under `ghcr.io/<owner>/telegram-bot`. Set
`PAYMENT_SYSTEM` when starting the container to select the market; the image is
identical for `blik`, `mbway`, `twint`, and `sk`.

After the central service is live, remove the shared generic group from each
coordinator's `TELEGRAM_CHAT_ID` setting to avoid duplicate announcements.
Coordinator-specific or bank-specific destinations can remain configured.

## Memory bounds

The bot does not cache discovery query results. It rotates its long-lived Nostr
offer subscription every 15 minutes, releasing NDK's per-subscription replay
and event-id tracking, and refreshes coordinator discovery every five minutes.
Offer records, including short-lived terminal tombstones needed for replay
deduplication, are retained for at most 48 hours and the state is capped at
2,000 records. Failed Telegram lifecycle operations are retried during
discovery refreshes but cannot make the state grow beyond those bounds.

The limits can be tuned with `DISCOVERY_REFRESH_SECONDS`,
`SUBSCRIPTION_ROTATION_SECONDS`, `OFFER_STATE_RETENTION_SECONDS`, and
`MAX_TRACKED_OFFERS`. The
[`docker-compose.example.yml`](docker-compose.example.yml) service also applies
a 192 MiB hard limit and a 64 MiB reservation. The limit is a final safety
boundary, not a substitute for the bounded retention above; deploy the new
image and restart the existing container once to release the heap accumulated
by the old build.
