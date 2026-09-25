#!/usr/bin/env bash
# Build nsite from exact filesystem artifact served by packages/app/Dockerfile.
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
flavor=bitblik
release_tag="${GITHUB_REF_NAME:-$(git -C "$repo_root" rev-parse --short HEAD)}"
relays="${NSITE_RELAYS:-wss://relay.nsite.lol}"
# Current BitBlik root-manifest server hints. Override after validating a
# flavor's manifest with `nsyte status`; all are needed for historical blobs.
servers="${NSITE_SERVERS:-https://blossom.primal.net,https://cdn.hzrd149.com,https://cdn.sovbit.host,https://cdn.nostrcheck.me,https://nostr.download}"
secret="${NSITE_SECRET:-}"
pubkey="${NSITE_PUBKEY:-}"
dry_run=false
prompt_secret=false

usage() {
  cat <<'EOF'
Usage: packages/app/tool/publish_nsite.sh [options]

Build Docker Flutter artifact, then update existing root nsite paths under
/app only. Existing paths outside /app are retained in the root manifest.
The signing credential must match the selected flavor's target pubkey.
Result: https://<npub>.nsite.lol/app/

  --flavor NAME       bitblik, bitway, bittwint, veksli (default: bitblik)
  --release-tag TAG   local Docker tag suffix (default: current Git ref)
  --secret VALUE      nsec, nbunksec, bunker URL, or hex key
  --pubkey VALUE      override target pubkey (must match signing credential)
  --prompt-secret     ask once for signing credential
  --relays URLS       comma-separated relay URLs
  --servers URLS      comma-separated Blossom server URLs
  --dry-run           preview each /app path update; no upload/publish
  -h, --help          show help

Environment: NSITE_SECRET, optional NSITE_PUBKEY, NSITE_RELAYS, NSITE_SERVERS.
For CI, store `nsyte ci` generated nbunksec in a masked secret.
EOF
}

while (($#)); do
  case "$1" in
    --flavor) flavor="$2"; shift 2 ;;
    --release-tag) release_tag="$2"; shift 2 ;;
    --secret) secret="$2"; shift 2 ;;
    --pubkey) pubkey="$2"; shift 2 ;;
    --prompt-secret) prompt_secret=true; shift ;;
    --relays) relays="$2"; shift 2 ;;
    --servers) servers="$2"; shift 2 ;;
    --dry-run) dry_run=true; shift ;;
    -h|--help) usage; exit 0 ;;
    *) printf 'Unknown option: %s\n' "$1" >&2; usage >&2; exit 2 ;;
  esac
done

case "$flavor" in
  bitblik)
    flutter_target=lib/main_bitblik.dart
    : "${pubkey:=npub1k3g092rlzvn7nftz3jte9pkx63zp705nh78r6hjpjm55fjg7r2cqx8stj3}"
    ;;
  bitway)
    flutter_target=lib/main_bitway.dart
    : "${pubkey:=npub180nj93uqjvvjksryaxaz8fk9gxwwtg06gxlkd5csrj6rqfg3phhs09n5s9}"
    ;;
  bittwint) flutter_target=lib/main_bittwint.dart ;;
  veksli) flutter_target=lib/main_veksli.dart ;;
  *) printf 'Unsupported flavor: %s\n' "$flavor" >&2; exit 2 ;;
esac

command -v docker >/dev/null || { echo 'docker is required' >&2; exit 1; }
command -v nsyte >/dev/null || { echo 'nsyte is required; see https://nsite.run/' >&2; exit 1; }
command -v jq >/dev/null || { echo 'jq is required' >&2; exit 1; }
command -v nak >/dev/null || { echo 'nak is required' >&2; exit 1; }
command -v sha256sum >/dev/null || { echo 'sha256sum is required' >&2; exit 1; }
[[ -n "$pubkey" ]] || { echo "No nsite pubkey configured for flavor '$flavor'; set NSITE_PUBKEY or pass --pubkey." >&2; exit 2; }
if [[ -z "$secret" ]] && $prompt_secret; then
  # Reuse exactly this credential for preflight and every upload. Asking again
  # inside each nsyte process could switch identities after validation.
  IFS= read -r -s -p 'Signing credential: ' secret </dev/tty
  printf '\n' >/dev/tty
fi
if [[ -z "$secret" ]]; then
  echo 'Set NSITE_SECRET, pass --secret, or use --prompt-secret.' >&2
  exit 2
fi

image="bitblik-nsite:${flavor}-${release_tag}"
tmp_root="${TMPDIR:-/tmp}"
# nsyte resolves relative source paths against its working directory. Never let
# a relative TMPDIR turn a release stage into a repository subdirectory.
[[ "$tmp_root" == /* ]] || tmp_root=/tmp
stage_dir="$(mktemp -d "$tmp_root/bitblik-nsite.XXXXXX")"
nsyte_config="$stage_dir.nsite-config.json"
container=""
cleanup() {
  [[ -z "$container" ]] || docker rm -f "$container" >/dev/null 2>&1 || true
  rm -rf "$stage_dir"
  rm -f "$nsyte_config"
}
trap cleanup EXIT

jq -n --arg relays "$relays" --arg servers "$servers" \
  '{relays: ($relays | split(",")), servers: ($servers | split(","))}' > "$nsyte_config"

expected_pubkey="$(nak decode --pubkey "$pubkey")"
[[ "$expected_pubkey" =~ ^[0-9a-f]{64}$ ]] || {
  echo 'Could not decode the target public key.' >&2
  exit 1
}
echo "Checking signing identity for $flavor ($pubkey)..."
# put resolves raw keys and NIP-46 credentials through the same signer used
# for publication. Its dry-run writes an unsigned manifest with that pubkey
# without uploading a blob or publishing a site event. Fail closed if nsyte
# cannot resolve an existing root manifest or changes its preview format.
preview_dir="$stage_dir/identity-check"
if ! nsyte put --config "$nsyte_config" "${BASH_SOURCE[0]}" /app/index.html \
  --sec "$secret" --dry-run --dry-run-output "$preview_dir" \
  > "$stage_dir/identity-check.log" 2>&1; then
  cat "$stage_dir/identity-check.log" >&2
  echo 'Signing identity check failed; nothing built or uploaded.' >&2
  exit 1
fi
signer_pubkey="$(jq -er '
  select(.kind == 15128 and (.tags | type == "array")) |
  .pubkey | select(type == "string" and test("^[0-9a-f]{64}$"))
' "$preview_dir/put-manifest-15128.json")" || {
  echo 'No valid signing identity in nsyte preview; refusing to publish.' >&2
  exit 1
}
if [[ "$signer_pubkey" != "$expected_pubkey" ]]; then
  printf 'Signing key mismatch for %s.\nExpected: %s\nActual:   %s\n' \
    "$flavor" "$expected_pubkey" "$signer_pubkey" >&2
  echo 'Use the credential for the selected target. Nothing built or uploaded.' >&2
  exit 1
fi

echo "Building Docker artifact: $image"
docker build --file "$repo_root/packages/app/Dockerfile" --tag "$image" \
  --build-arg "APP_FLAVOR=$flavor" \
  --build-arg "FLUTTER_TARGET=$flutter_target" \
  --build-arg BUILD_MODE=release \
  --build-arg WEB_BASE_HREF=/app/ \
  "$repo_root"

container="$(docker create "$image")"
mkdir -p "$stage_dir/app"
docker cp "$container:/usr/share/nginx/html/." "$stage_dir/app/"
docker rm "$container" >/dev/null
container=""

echo "Fetching current root manifest: $pubkey"
IFS=',' read -r -a relay_list <<< "$relays"
manifest="$(nak --quiet req -k 15128 -a "$pubkey" --limit 1 "${relay_list[@]}")"
[[ -n "$manifest" ]] || { echo 'Could not fetch existing root manifest.' >&2; exit 1; }
declare -A existing_hashes=()
while IFS=$'\t' read -r path hash; do
  existing_hashes["$path"]="$hash"
done < <(jq -r '.tags[] | select(.[0] == "path") | "\(.[1])\t\(.[2])"' <<< "$manifest")

echo 'Updating changed root manifest paths: /app/*'
created_at="$(date +%s)"
file_index=0
updated=0
while IFS= read -r -d '' file; do
  remote_path="/${file#"$stage_dir"/}"
  local_hash="$(sha256sum "$file" | cut -d ' ' -f 1)"
  if [[ "${existing_hashes[$remote_path]:-}" == "$local_hash" ]]; then
    continue
  fi
  put=(nsyte put --config "$nsyte_config" "$file" "$remote_path")
  # Root manifests are replaceable. Monotonic timestamps make each sequential
  # /app update win over previous one, even when calls finish inside one second.
  put+=(--created-at "$((created_at + file_index))")
  put+=(--sec "$secret")
  if $dry_run; then
    put+=(--dry-run --dry-run-show-kinds 15128)
  fi
  "${put[@]}"
  ((file_index += 1))
  ((updated += 1))
done < <(find "$stage_dir/app" -type f -print0 | sort -z)

echo "Updated $updated changed /app file(s)."
