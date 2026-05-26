---
name: bitblik
description: Peer-to-peer BLIK/Lightning exchange CLI — create maker offers, retrieve BLIK codes from takers, confirm payments. Operates via Nostr coordinator network.
license: MIT
metadata:
  author: bitblik
  version: "0.6.0"
---

# BitBlik Agent Skill

P2P exchange: Lightning sats → BLIK fiat code. Maker-side CLI over Nostr.

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
coordinators list → offer create → pay hold invoice → get-blik (poll) → confirm-payment
```

## Maker Commands at a Glance

| Command | When to use |
|---------|-------------|
| `offer create` | Start exchange — returns hold invoice to pay |
| `offer cancel` | Abort before taker takes (created/funded) |
| `offer get-blik` | Poll for BLIK code after taker reserves |
| `offer confirm-payment` | After entering BLIK in payment terminal |
| `offer mark-blik-invalid` | BLIK code didn't work at terminal |
| `offer open-dispute` | Taker raised conflict after invalid-BLIK report |
| `offer sync` | Refresh local status from coordinator |
| `offer list` | Show local offers |
