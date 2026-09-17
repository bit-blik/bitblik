# Bitblik app

## App links

Native app links accept both root-hosted URLs such as
`https://bitblik.app/offers/<id>` and nsite URLs under `/app/`.
Opening `/app` or `/app/` opens the home screen; `/app/offers/<id>` opens the
offer. The deployment prefix is removed only for native route matching.

Web navigation uses Flutter's HTML base href. For a web deployment under
`/app/`, build with `flutter build web -t lib/main_bitblik.dart --base-href /app/`
and configure the host to serve the app shell for nested routes. Browser routes
then retain `/app/`, including `/app/offers/<id>`.

## App updates

The footer uses NDK's version widget and green download badge. The badge appears
only when a real update is available; clicking it opens the NDK update dialog.
Release discovery uses the installed build's app identifier and the `main`
channel on `wss://relay.zapstore.dev`.

On platforms using external downloads, the download link follows the payment
system selected inside the app: MB WAY opens `https://bitway.me`; all other
systems, including BLIK, TWINT, and Slovensko, open `https://bitblik.app`.
Native package updates stay tied to the installed flavor.

## Funding payment authorization

The maker payment screen checks the signed invoice's exact millisatoshi amount,
payment hash, network and expiry, then compares the coordinator quote against the
independent client estimate captured before the RPC. Valid invoices go directly
to the normal payment controls; there is no extra confirmation screen or WebLN
auto-payment.

The total may differ from the original client estimate by 0.5% (rounded down),
with a minimum tolerance of 5 sats and a maximum of 100 sats. The coordinator
fee is checked separately: 0.5%, minimum 1 sat, capped by the total tolerance;
a zero-fee estimate must remain zero. Fiat amount, currency, premium, maker and
coordinator must match exactly. The invoice must still match the returned quote
exactly, down to the millisatoshi. Wallet routing fees follow the wallet's policy.

Failed checks show an explanation, the client estimate and coordinator quote,
and a cancel action. No payment/export controls or override are offered. Once a
quote passes validation, changed payment details revoke access, even if the new
amount is within tolerance. The original estimate never moves with server data.

The estimate is held locally and bound to its offer ID. It is not reconstructed
from remote or saved offers. After an app restart, an unpaid offer without its
original estimate is blocked with instructions to cancel and create a new one.

The expected network defaults to mainnet. Test builds may set
`--dart-define=LIGHTNING_NETWORK=testnet` (or `signet`/`regtest`); a coordinator
cannot change it through its response. Invoice signer validation does not make
coordinator custody trustless or bind a Lightning node key to a Nostr identity.

Regression coverage: `flutter test test/src/widgets/funding_invoice_gate_test.dart`
and core `dart test test/funding_invoice_test.dart`.
