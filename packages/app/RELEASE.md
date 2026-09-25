# Release process

- increase app version in `pubspec.yaml` and matching CLI version in
  `../cli/pubspec.yaml` plus `../cli/lib/src/version.dart` (exclude app `+build`
  suffix from CLI version)
- update changelog.md with the new version and all changes since last release

## iOS

- in macos do `flutter build ipa`

- submit to app store connect using transporter or xcode

- submit new version for review in app store connect

- `curl -X GET  https://api.altstore.io/adps/<apd-id>` (get the APD id from app store connect -> iOS History)

- fetch the package from the json field `downloadURL`

- unzip it into bitblik.app web html root / ios/<version-number>

- make sure files in /ios/<version-number>/ are readable by everyone (chmod 644) and that directory is executable (chmod 755)!!!

- add version to https://bitblik.app/.well-known/sources/alt-store-source.json (not the one in git, but in the VPS /ios/...)

## Android

- push new tag to github with the version number
- wait for github action to build the apk and upload it to the releases page
- adjust github release changelog/what's new
- publish to zapstore `SIGN_WITH=<nsec> zsp publish`

## Web

- Docker image uses `packages/app/Dockerfile`; root-hosted deployments keep
  default `WEB_BASE_HREF=/`.

## nsite

Publish Flutter web build to existing nsite root under `/app/`. Script builds
same `packages/app/Dockerfile` artifact as web image, with `WEB_BASE_HREF=/app/`.

### One-time setup

1. Install [`nsyte`](https://nsite.run/), `nak`, `jq`, and `sha256sum`, and
   ensure the Docker daemon runs.
2. Create a restricted NIP-46 CI credential with `nsyte ci`.
3. Store resulting `nbunksec` in secret manager as `NSITE_SECRET`. Never
   commit an `nsec`, hex private key, or `nbunksec`.

### Preview release

Run from repository root. The script checks the signing identity before
building the Docker artifact. Dry run does not upload blobs or publish site
manifests (a remote signer may exchange NIP-46 messages).

```bash
packages/app/tool/publish_nsite.sh --flavor bitblik --dry-run --prompt-secret
```

### Publish release

```bash
NSITE_SECRET='nbunksec1...' \
  packages/app/tool/publish_nsite.sh --flavor bitblik
```

### Flavors and target site

Use `--flavor bitblik`, `bitway`, `bittwint`, or `veksli`. Script reads current
manifest to skip files whose SHA-256 hash is unchanged, then `nsyte put` updates
only changed `/app` paths. BitBlik and BitWay pubkeys come from app config.
For another target, set `NSITE_PUBKEY` or pass `--pubkey`. Use credential
belonging to target flavor's existing nsite identity.

`--flavor` selects the build and expected site identity; it cannot make a
BitBlik signing key publish to BitWay. The script now checks the credential's
resolved pubkey against the target before any build or upload, including in
dry-run mode. A mismatch aborts with the expected and actual public keys.
`--prompt-secret` reads the credential once and reuses it throughout the run.

To publish BitWay from `packages/app`, enter the credential for the BitWay
npub shown in `lib/src/config/build_flavor.dart`:

```bash
tool/publish_nsite.sh --flavor bitway --prompt-secret
```

If an older script was run with the wrong key, it may have uploaded that
flavor to the signing key's site while the intended site stayed unchanged.
Republish each affected flavor with its own matching credential.

### Root-site safety

Script calls `nsyte put` once per Docker artifact file under `/app/*`. Each
call updates only that existing root-manifest path; all other path tags remain
verbatim. Existing landing-page paths, including `/index.html`, `/404.html`,
`/ios/*`, and root assets, are never downloaded, staged, changed, or deleted.
Updates use strictly increasing timestamps so every sequential root manifest
replaces its predecessor deterministically.

Set `NSITE_RELAYS` or `NSITE_SERVERS` for comma-separated infrastructure
overrides. Default servers match current BitBlik root-manifest server hints;
do not narrow this list unless full-root download succeeds. See all options:

```bash
packages/app/tool/publish_nsite.sh --help
```

## post on Nostr
