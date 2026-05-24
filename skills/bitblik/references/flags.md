# Common Flags

| Flag | Description |
|------|-------------|
| `--json` | Machine-readable JSON output (always use in agent context) |
| `--no-wait` | Return immediately instead of blocking (use with `offer get-blik`) |
| `--coordinator <npub\|hex>` | Coordinator pubkey — npub1... or 64-char hex |
| `--offer <id>` | Payment hash or coordinator UUID — required if multiple active offers |
| `--relay <url>` | Override Nostr relay URL (repeatable) |
| `--currency <code>` | Fiat currency code, default PLN |
| `--fiat <amount>` | Fiat amount for the offer |
