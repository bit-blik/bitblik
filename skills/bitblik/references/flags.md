# Common Flags

| Flag | Description |
|------|-------------|
| `--json` | Machine-readable JSON output (always use in agent context) |
| `--no-wait` | Return immediately instead of blocking (use with `offer get-code`) |
| `--coordinator <npub\|hex>` | Coordinator pubkey — npub1... or 64-char hex |
| `--offer <id>` | Payment hash or coordinator UUID — required if multiple active offers |
| `--relay <url>` | Override Nostr relay URL (repeatable) |
| `--currency <code>` | Fiat currency code, default the market's currency |
| `--fiat <amount>` | Fiat amount for the offer |
| `--bank <id>` | Bank the offer runs on — REQUIRED for bank-scoped markets (Slovakia: `tatrabanka`, `slsp`, `vub`); rejected for bank-agnostic markets (BLIK/MB WAY/TWINT). On `offer list`, filters to that bank. |
