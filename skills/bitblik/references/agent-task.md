# Agent Task: Run Full Maker Exchange

Step-by-step instructions for an agent executing a complete BitBlik exchange.

```
1. Install bitblik if not present
   → See: references/installation.md

2. Run: bitblik coordinators list --health --json
   → Pick a coordinator that is responsive and supports the required currency/amount

3. Run: bitblik offer create --fiat <amount> --coordinator <pubkey> --json
   → Returns holdInvoice (Lightning hold invoice) + paymentHash
   → Bank-scoped markets (bitvyber/SK): add --bank <tatrabanka|slsp|vub>. The
     amount must be dispensable at that bank's ATM (10/20/50/100 € notes).

4. Pay the hold invoice
   IMPORTANT — hold invoice behavior:
   - If using an agentic Lightning wallet tool, the payment call will likely time out
     or hang. This is NORMAL and EXPECTED for hold invoices — the payment is
     pending on the network until the coordinator settles or cancels it.
   - Do NOT wait for payment success confirmation from the wallet tool.
   - Do NOT retry the payment if it times out — the payment is in flight.

5. Poll: bitblik offer sync  (every 3s, up to 10 minutes)
   → Check status: bitblik offer sync --json
   → Status other than "created" = coordinator confirmed hold invoice received → proceed
   → Status "expired" = offer timed out (10-minute window), must start over

6. Get the BLIK code: Poll every 2s: bitblik offer get-code --no-wait --json
   → Exit 2 + {"ready": false}: not ready, keep polling
   → Exit 0 + {"ready": true, "blik_code": "..."}: got code — show immediately
   → Tell user to enter the code within its validity window (the get-code output
     states it): BLIK ~120s, MB WAY 30 min, TWINT 5 min, Slovak ATM per bank
     (Tatra 20 / SLSP 15 / VÚB 3 min) — at the ATM for SK, in the banking app otherwise
   → If offer reaches status "expired" or "expiredBlik": exchange failed, start over

7. After user confirms BLIK entered: bitblik offer confirm-payment
   → Exchange complete
```
