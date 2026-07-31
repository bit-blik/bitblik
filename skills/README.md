# Skills

Agent skills for Claude Code. Each skill is a self-contained directory with a `SKILL.md` manifest.

## Available Skills

### [bitblik](bitblik/SKILL.md)

> Peer-to-peer BLIK/Lightning exchange CLI — create maker offers, retrieve BLIK codes from takers, confirm payments. Operates via Nostr coordinator network.

**Version:** 0.6.0 · **License:** MIT

#### 🚀 Install with single command

```bash
npx skills add bit-blik/bitblik
```

| Reference | Description |
|-----------|-------------|
| [Installation](bitblik/references/installation.md) | Binary install — Linux (deb/tar.gz), macOS (arm64), Windows (zip) |
| [Workflow](bitblik/references/workflow.md) | Happy-path overview and offer status lifecycle |
| [Commands](bitblik/references/commands.md) | `coordinators list`, `offer create/list/sync/get-code/confirm-payment` |
| [Agent Task](bitblik/references/agent-task.md) | Step-by-step guide for agents running a full maker exchange |
| [Flags](bitblik/references/flags.md) | `--json`, `--no-wait`, `--coordinator`, `--offer`, `--relay`, `--currency`, `--fiat` |
| [Notes](bitblik/references/notes.md) | Local state path, expiry rules, multi-offer disambiguation |

---

## Adding a Skill

1. Create `skills/<name>/` directory
2. Add `SKILL.md` with frontmatter (`name`, `description`, `license`, `metadata`)
3. Add `references/` sub-files for detailed sections
4. Add entry to this README
