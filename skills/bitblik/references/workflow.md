# Workflow Overview

BitBlik is a maker-side CLI. Each binary serves one market — `bitblik` (BLIK/PL),
`bitway` (MB WAY/PT), `bittwint` (TWINT/CH), `bitvyber` (Slovak cardless ATM/SK).
Full happy path (BLIK example):

```
1. coordinators list        → find a coordinator
2. offer create             → create offer, get hold invoice to pay
                              (bank-scoped markets: add --bank <tatrabanka|slsp|vub>)
3. [user pays hold invoice in Lightning wallet]
4. offer get-code --no-wait → poll until taker submits the code
5. [user enters the code in banking app / at the ATM within its validity window]
6. offer confirm-payment    → confirm success, coordinator settles
```

**Code validity is per market (and per bank):** BLIK ~120s, MB WAY 30 min,
TWINT 5 min, Slovak ATM per bank — Tatra banka 20 min, Slovenská sporiteľňa
15 min, VÚB 3 min. `get-code` output states the window and (for SK) the bank.

## Offer Status Lifecycle

```
created → funded → reserved → blikReceived → blikSentToMaker → makerConfirmed → settled → takerPaid
```

**Expiry branches:**

- `funded` → `expired` (no taker within window)
- `reserved` → `funded` (taker timeout, re-listed)
- `blikReceived` → `expiredBlik` (maker never retrieved BLIK; auto re-lists to `funded` after 60s)
- `blikSentToMaker` → `expiredSentBlik` (maker retrieved BLIK but didn't confirm)

**Invalid BLIK branch:**

```
blikSentToMaker → [mark-code-invalid] → invalidBlik
  → taker accepts  → re-listed (back to funded/reserved)
  → taker disputes → conflict → [open-dispute] → dispute
                              → [confirm-payment] → makerConfirmed → settled
```

**Cancellation:** `created` or `funded` → `cancelled` via `offer cancel`

## Terminal Statuses

`takerPaid`, `cancelled`, `expired` — no further action possible locally.

`expiredBlik`, `expiredSentBlik`, `dispute`, `settled`, `takerPaymentFailed` — effectively terminal; coordinator may take further action.
