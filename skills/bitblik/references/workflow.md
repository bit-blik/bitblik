# Workflow Overview

BitBlik is a maker-side CLI. Full happy path:

```
1. coordinators list        → find a coordinator
2. offer create             → create offer, get hold invoice to pay
3. [user pays hold invoice in Lightning wallet]
4. offer get-blik --no-wait → poll until taker submits BLIK code
5. [user enters BLIK code in banking app within 120s]
6. offer confirm-payment    → confirm BLIK succeeded, coordinator settles
```

## Offer Status Lifecycle

```
created → funded → reserved → blikReceived → blikSentToMaker → makerConfirmed → settled → takerPaid
```

**Expiry branches:**

- `funded` → `expired` (no taker within window)
- `reserved` → `funded` (taker timeout, re-listed)
- `blikReceived` → `expiredBlik` (maker never retrieved BLIK)
- `blikSentToMaker` → `expiredSentBlik` (maker retrieved BLIK but didn't confirm)

**Invalid BLIK branch:**

```
blikSentToMaker → [mark-blik-invalid] → invalidBlik
  → taker accepts  → re-listed (back to funded/reserved)
  → taker disputes → conflict → [open-dispute] → dispute
                              → [confirm-payment] → makerConfirmed → settled
```

**Cancellation:** `created` or `funded` → `cancelled` via `offer cancel`

## Terminal Statuses

`takerPaid`, `cancelled`, `expired` — no further action possible locally.

`expiredBlik`, `expiredSentBlik`, `dispute`, `settled`, `takerPaymentFailed` — effectively terminal; coordinator may take further action.
