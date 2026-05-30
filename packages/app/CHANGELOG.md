## [0.6.0] - 2026-05-30

- feat: new category field: shop/atm/online
- feat: my offers list
- feat: coordinator list sorted by most used (locally & globally)
- feat: choose wallet for paying if default has no balance/budget
- feat: finished orders filter by coordinator
- fix: BLIK code split into 2 lines on small screens
- fix: ios keyboard during takerPaymentFailed doesn't hide on un-focus

## [0.5.1] - 2026-04-02

- fix: wallet initialization
- fix: NWC cached permissions to improve UX
- feat: Alby Go NWC connect available on iOS

## [0.5.0] - 2026-04-01
- multiple wallets support
- cashu wallet
- taker receive to any wallet that supports it, like NWC or cashu, not just LNURL
- better privacy since lnurl is no longer sent to the coordinator, just the invoice

## [0.4.6] - 2026-01-24
- fix: numeric keyboard not hiding on un-focus
- fix: apple app links support

## [0.4.5] - 2025-12-15
- add relay connection indicator in app bar 
- improve relay connection handling
- connect wallet popup with Alby Go 1-click connection
- NWC connection QR scanner screen


## [0.4.4] - 2025-12-13
### Fixed
- fix reconnect to relays when app goes to background

## [0.4.3]
- 🇮🇹 italian translation
- improve FAQ
- don't check coordinator health immediately, assume healthy

## [0.4.0]
- initial NWC wallet support
- fix offer's list state update bug

## [0.3.0]

- use nostr relays & websockets for client/coordinator communication
- backup/restore private keys
- multi coordinators
- Telegram & Signal notifications support
- new design/graphics UI/UX
