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
