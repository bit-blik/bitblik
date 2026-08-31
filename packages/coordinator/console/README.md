# BitBlik Coordinator Console

Native dispute-management application for a BitBlik coordinator. It derives
the open queue from public kind-38383 events, fetches private details through
the existing coordinator-signed RPC, and provides two independent NIP-17
participant lanes, encrypted image evidence, and explicit maker/taker rulings.

Authentication and multi-account switching use NDK Flutter's `NLogin` and
`NSwitchAccount`. The active signer pubkey is the coordinator identity; no
separate coordinator key is entered.

```bash
flutter run -d android
# or
flutter run -d linux
```

Android release builds intentionally require an operator-supplied signing
configuration. See [`docs/dispute-operations.md`](../../../docs/dispute-operations.md)
for deployment and adjudication guidance.
