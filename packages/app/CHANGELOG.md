## [0.8.3] - 2026-06-22
- feat: discover coordinators onboarding

## [0.8.2]  - 2026-06-19
- fix: make code input flexible to amount of digits
- fix: add mbway instructions for using the code

## [0.8.1]  - 2026-06-18
- fix: extract code with digits amount from pasted text
- fix: remove 10EUR bank note denomination

## [0.8.0] - 2026-06-18
- feat: choice of payment system per country
- feat: support MB WAY for Portugal with 10 digit codes for ATMs
- feat: portuguese translation
- feat: wallets now can send/receive
- fix: notification links are now coordinator specific
- fix: cashu wallet state backup/restore + seed phrase backup
- fix: new expiredBlik timer to auto cancel reservation back to funded
- fix: improve finished offers stats by doing it client-side

## [0.7.0] - 2026-06-04
- feat: premium % option for makers
- feat: nip-65 for dynamic coordinator relay discovery
- feat: use kind 0 metadata for coordinator photo/name
- feat: automatic coordinator selection based on reliability or price
- feat: offer creation preferences for setting defaults
- feat: display preference for currency unit (sats or ₿)
- feat: coordinator details screen

## [0.6.0] - 2026-06-01
- feat: new category field: shop/atm/online
- feat: local notifications for change of status
- feat: optional background service monitoring new offers
- feat: my offers list
- feat: coordinator list sorted by most used (locally & globally)
- feat: choose wallet for paying if default has no balance/budget
- feat: choose wallet for generating new invoice if taker payment failed
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
