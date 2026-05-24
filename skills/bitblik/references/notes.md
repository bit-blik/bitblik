# Notes

- Local state stored in `~/.config/bitblik/offers.db`
- Offers use payment hash as local key until coordinator assigns a UUID after funding; once funded, identified by coordinator's UUID
- Offers expire after **10 minutes** — status changes to `expired`, offer is dead
- Coordinator pubkey required for most commands — get one from `coordinators list`
- Multiple active offers: always pass `--offer <id>` to disambiguate
- Releases: https://github.com/bit-blik/bitblik/releases
