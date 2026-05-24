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

`created` → `funded` → `reserved` → `blikReceived` → `blikSentToMaker` → `makerConfirmed` → `settled`

Terminal statuses: `expired`, `cancelled`, `expiredBlik`, `takerPaid`
