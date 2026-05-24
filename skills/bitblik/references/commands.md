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

Returns: `holdInvoice` (Lightning invoice to pay), `paymentHash`, `amountSats`, `fiatAmount`

Offer saved locally after creation. Coordinator activates once hold invoice is paid.

---

## List Local Offers

```bash
bitblik offer list --json               # active offers only
bitblik offer list --finished --json    # include terminal offers
```

---

## List Public Offers (Taker view)

```bash
bitblik offer list --coordinator <npub|hex> --json
```

---

## Sync Offer Status

```bash
bitblik offer sync
```

Refreshes local offer status from coordinator via RPC. Call before checking status if you need current state.

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
bitblik offer confirm-payment --json
bitblik offer confirm-payment --offer <id> --coordinator <npub|hex>
```

Call after successfully entering BLIK code in banking app. Coordinator settles hold invoice and pays taker.
