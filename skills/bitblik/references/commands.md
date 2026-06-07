# Commands Reference

## Discover Coordinators

```bash
bitblik coordinators list --json
bitblik coordinators list --health --json   # probe liveness
```

Output fields: `pubkey`, `name`, `currencies`, `minAmountSats`, `maxAmountSats`, `makerFee`, `takerFee`, `version`, `responsive`

---

## Create Offer (Maker)

```bash
bitblik offer create --fiat 100 --coordinator <npub|hex> --json
bitblik offer create --fiat 100 --coordinator <npub|hex> --currency PLN --json
```

Returns: `holdInvoice` (Lightning hold invoice to pay), `paymentHash`, `amountSats`, `fiatAmount`

Offer saved locally after creation. Coordinator activates once hold invoice is paid.

**Guard:** Rejected if an active offer already exists for the same coordinator. Cancel or finish it first.

---

## Cancel Offer

```bash
bitblik offer cancel
bitblik offer cancel --offer <id>
bitblik offer cancel --offer <id> --coordinator <npub|hex>   # fast path, skip local store
```

Valid from `created` or `funded` status only. Coordinator voids the hold invoice.

**Local-only offers** (ID is a payment hash, not a UUID): sync with coordinator first via `get_my_active_offer` before sending RPC. If coordinator has no matching offer, marks cancelled locally without RPC.

---

## List Local Offers

```bash
bitblik offer list --json               # active offers only
bitblik offer list --finished --json    # include terminal offers
```

Shows locally cached state. Run `offer sync` first to refresh.

---

## List Public Offers (relay view)

```bash
bitblik offer list --coordinator <npub|hex> --json
```

Queries live Nostr relay broadcasts from that coordinator. Shows all public offers (all makers), not just yours. Status resolution is coarser than local store (NIP-69 mapping).

---

## Sync Offer Status

```bash
bitblik offer sync
```

Calls `get_my_active_offer` RPC once per coordinator. Updates the single active offer returned. Run before `get-blik` or `cancel` when local state may be stale.

---

## Get BLIK Code (Polling — use for agents)

```bash
bitblik offer get-blik --no-wait --json
```

**Exit codes:**
- `0` — BLIK code retrieved. Output: `{"ready": true, "blik_code": "123456", ...}`
- `2` — Not ready yet. Output: `{"ready": false, "status": "<current_status>", ...}`
- `1` — Error

**Agent polling loop:**

```bash
while true; do
  result=$(bitblik offer get-blik --no-wait --json)
  code=$?
  if [ $code -eq 0 ]; then
    echo "$result"   # contains blik_code
    break
  elif [ $code -eq 2 ]; then
    sleep 15
  else
    echo "Error: $result" >&2
    break
  fi
done
```

With specific offer or coordinator:

```bash
bitblik offer get-blik --no-wait --json --offer <payment_hash>
bitblik offer get-blik --no-wait --json --offer <id> --coordinator <npub|hex>
```

> **Without `--no-wait`** (blocking): waits indefinitely via Nostr subscription. Use only in interactive terminals, not agent loops.

---

## Confirm Payment

```bash
bitblik offer confirm-payment
bitblik offer confirm-payment --offer <id> --coordinator <npub|hex>
```

Call after successfully entering BLIK code in banking app. Coordinator settles hold invoice and pays taker.

---

## Mark BLIK Invalid

```bash
bitblik offer mark-blik-invalid
bitblik offer mark-blik-invalid --offer <id>
bitblik offer mark-blik-invalid --offer <id> --coordinator <npub|hex>
```

Call when the received BLIK code did not work at the bank terminal. Coordinator notifies the taker and re-lists the offer for a new taker.

Eligible local statuses: `blikSentToMaker`, `expiredSentBlik`, `takerCharged`, `conflict`. `expiredBlik` means the maker never fetched the BLIK code, so confirmation is rejected by the coordinator and the offer auto re-lists to `funded` after 60s.

---

## Open Dispute

```bash
bitblik offer open-dispute
bitblik offer open-dispute --offer <id>
bitblik offer open-dispute --offer <id> --coordinator <npub|hex>
```

Call when the taker raised a conflict (taker claims BLIK charged but maker reported it invalid). Coordinator mediates between both parties.

Eligible local status: `conflict`. Coordinator is the final authority.
