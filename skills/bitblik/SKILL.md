---
name: bitblik
description: Peer-to-peer fiat/Lightning exchange CLI (BLIK, MB WAY, TWINT, Slovak cardless ATM) — create maker offers, retrieve payment codes from takers, confirm payments. Operates via Nostr coordinator network.
license: MIT
metadata:
  author: bitblik
  version: "0.6.0"
---

# BitBlik Agent Skill

P2P exchange: Lightning sats → a fiat payment code. Maker-side CLI over Nostr.
One binary per market: `bitblik` (BLIK/PL), `bitway` (MB WAY/PT), `bittwint`
(TWINT/CH), `bitvyber` (Slovak cardless ATM/SK). The Slovak market is
bank-scoped — `offer create` needs `--bank <tatrabanka|slsp|vub>`.

## Quick Reference

| Topic | Reference |
|-------|-----------|
| Install binary (Linux/macOS/Windows) | [references/installation.md](references/installation.md) |
| Happy-path workflow & status lifecycle | [references/workflow.md](references/workflow.md) |
| All commands with examples | [references/commands.md](references/commands.md) |
| Agent step-by-step task guide | [references/agent-task.md](references/agent-task.md) |
| CLI flags table | [references/flags.md](references/flags.md) |
| State, expiry, edge cases | [references/notes.md](references/notes.md) |

## One-Line Summary

```
coordinators list → offer create → pay hold invoice → get-code (poll) → confirm-payment
```

## Maker Commands at a Glance

| Command | When to use |
|---------|-------------|
| `offer create` | Start exchange — returns hold invoice to pay |
| `offer cancel` | Abort before taker takes (created/funded) |
| `offer get-code` | Poll for BLIK code after taker reserves |
| `offer confirm-payment` | After entering BLIK in payment terminal |
| `offer mark-code-invalid` | BLIK code didn't work at terminal |
| `offer open-dispute` | Taker raised conflict after invalid-BLIK report |
| `offer sync` | Refresh local status from coordinator |
| `offer list` | Show local offers |
