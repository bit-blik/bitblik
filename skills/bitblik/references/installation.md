# Installation

Download pre-compiled binary from GitHub releases. No Dart or runtime required.

## Linux / macOS

```bash
# Detect platform and install
PLATFORM=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$PLATFORM-$ARCH" in
  linux-x86_64)
    if command -v dpkg &>/dev/null; then
      # Debian/Ubuntu — prefer .deb
      curl -fsSL "https://github.com/bit-blik/bitblik/releases/latest/download/bitblik-cli-linux-x64.deb" \
        -o /tmp/bitblik.deb
      sudo dpkg -i /tmp/bitblik.deb
    else
      # Other Linux — tar.gz fallback
      mkdir -p ~/.local
      curl -fsSL "https://github.com/bit-blik/bitblik/releases/latest/download/bitblik-cli-linux-x64.tar.gz" \
        | tar xz -C ~/.local
      chmod +x ~/.local/bin/bitblik
      export PATH="$HOME/.local/bin:$PATH"
    fi
    ;;
  darwin-arm64)
    mkdir -p ~/.local
    curl -fsSL "https://github.com/bit-blik/bitblik/releases/latest/download/bitblik-cli-macos-arm64.tar.gz" \
      | tar xz -C ~/.local
    chmod +x ~/.local/bin/bitblik
    export PATH="$HOME/.local/bin:$PATH"
    ;;
  *)
    echo "Unsupported platform: $PLATFORM-$ARCH (supported: linux-x64, macos-arm64)"
    exit 1
    ;;
esac
```

## Windows (PowerShell)

```powershell
$url = "https://github.com/bit-blik/bitblik/releases/latest/download/bitblik-cli-windows-x64.zip"
Invoke-WebRequest $url -OutFile "$env:TEMP\bitblik.zip"
Expand-Archive "$env:TEMP\bitblik.zip" -DestinationPath "$env:LOCALAPPDATA\bitblik" -Force
$env:PATH += ";$env:LOCALAPPDATA\bitblik\bin"
```

Verify: `bitblik --help`

Releases: https://github.com/bit-blik/bitblik/releases
