# Bitblik app

## App updates

The footer uses NDK's version widget and green download badge. The badge appears
only when a real update is available; clicking it opens the NDK update dialog.
Release discovery uses the installed build's app identifier and the `main`
channel on `wss://relay.zapstore.dev`.

On platforms using external downloads, the download link follows the payment
system selected inside the app: MB WAY opens `https://bitway.me`; all other
systems, including BLIK, TWINT, and Slovensko, open `https://bitblik.app`.
Native package updates stay tied to the installed flavor.
