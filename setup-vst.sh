#!/usr/bin/env bash

set -euo pipefail

# --- CONFIG ---
WINEPREFIX="${HOME}/.wine-vst"
VST2_DIR="${WINEPREFIX}/drive_c/Program Files/VSTPlugins"
VST3_DIR="${WINEPREFIX}/drive_c/Program Files/Common Files/VST3"

echo "Installing dependencies..."
sudo dnf install -y wine winetricks curl unzip patchelf

# --- CREATE WINE PREFIX ---

echo "Creating Wine prefix at $WINEPREFIX..."
export WINEPREFIX
winecfg -v win10

echo "Installing corefonts, vcrun2019, dxvk..."
winetricks -q corefonts vcrun2019 dxvk

# --- INSTALL YABRIDGE ---

YABRIDGE_VERSION="5.1.1"
TMPDIR="$(mktemp -d)"
echo "Downloading yabridge $YABRIDGE_VERSION..."
#  "https://github.com/robbert-vdh/yabridge/releases/download/5.1.1/yabridge-5.1.1.tar.gz" 
curl -L "https://github.com/robbert-vdh/yabridge/releases/download/${YABRIDGE_VERSION}/yabridge-${YABRIDGE_VERSION}.tar.gz" | tar xz -C "$TMPDIR"

YABRIDGECTL_PATH="$(find "$TMPDIR" -name yabridgectl -type f | head -n1)"

if [[ ! -f "$YABRIDGECTL_PATH" ]]; then
  echo "❌ Could not find yabridgectl after extracting. Structure may have changed."
  exit 1
fi

echo "Installing yabridgectl to /usr/local/bin..."
sudo install -Dm755 "$YABRIDGECTL_PATH" /usr/local/bin/yabridgectl

# Install bridge libraries
echo "Installing yabridge chainloaders..."
sudo install -Dm755 "$TMPDIR/yabridge/libyabridge-chainloader-vst2.so" /usr/lib/libyabridge-chainloader-vst2.so
sudo install -Dm755 "$TMPDIR/yabridge/libyabridge-chainloader-vst3.so" /usr/lib/libyabridge-chainloader-vst3.so

sudo install -Dm755 "$TMPDIR/yabridge/libyabridge-vst2.so" /usr/lib/libyabridge-vst2.so
sudo install -Dm755 "$TMPDIR/yabridge/libyabridge-vst3.so" /usr/lib/libyabridge-vst3.so

mkdir -p ~/.local/share/yabridge/

install -m755 "$TMPDIR/yabridge/yabridge-host.exe" ~/.local/share/yabridge/yabridge-host.exe
install -m755 "$TMPDIR/yabridge/yabridge-host.exe.so" ~/.local/share/yabridge/yabridge-host.exe.so
install -m755 "$TMPDIR/yabridge/yabridge-host-32.exe.so" ~/.local/share/yabridge/yabridge-host-32.exe.so


echo "Setting up plugin directories..."
mkdir -p "${VST2_DIR}" "${VST3_DIR}"

yabridgectl add "${VST2_DIR}"
yabridgectl add "${VST3_DIR}"
yabridgectl sync

echo "✅ Setup complete!"
echo "➡️ Install plugins using: WINEPREFIX=${WINEPREFIX} wine setup.exe"
echo "➡️ Then run: yabridgectl sync"
