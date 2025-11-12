#!/usr/bin/env bash
set -euo pipefail

OS_TYPE="$(uname | tr "[:upper:]" "[:lower:]")"

if [ "$OS_TYPE" != "darwin" ]; then
  echo "This script is only meant for macOS (darwin)! Exiting..."
  exit 1
fi

if ! command -v "mas" &>/dev/null; then
  echo "mas needs to be installed for this script. Run './install' before trying again."
  printf ">> https://github.com/mas-cli/mas\n\n"
  exit 1
fi

# -------------------------------
# macOS App Store
# -------------------------------

echo "Installing macOS App Store applications..."

# Array of app IDs to install
declare -A apps=(
  # Browser Extensions
  [1569813296]="1Password for Safari"
  [6504861501]="Ghostery Privacy Ad Blocker"
  [1573461917]="SponsorBlock"
  [1458969831]="JSON Peep"

  # Productivity Apps
  [409183694]="Keynote"
  [409203825]="Numbers"
  [409201541]="Pages"

  # Utilities
  [1534275760]="LanguageTool"
  [441258766]="Magnet"
  [1527619437]="maccy"

  # Communication
  [310633997]="WhatsApp"

  # Media Editing
  [634148309]="Logic Pro"
  [424389933]="Final Cut Pro"

  # Development Tools
  [640199958]="Developer"
  [899247664]="TestFlight"
  [497799835]="Xcode"
)

failed_apps=()

for app_id in "${!apps[@]}"; do
  app_name="${apps[$app_id]}"
  echo "Processing: ${app_name} (${app_id})..."

  # Check if app is already installed
  if mas list | grep -q "^${app_id}"; then
    echo "  ✓ Already installed, skipping"
    continue
  fi

  # Try to install; use 'get' first for free apps not yet "purchased"
  if ! mas install "${app_id}" 2>/dev/null; then
    echo "  → Not yet in library, attempting to get (free apps only)..."
    if ! mas get "${app_id}" 2>/dev/null; then
      echo "  ✗ Failed to install ${app_name}"
      echo "    This app may need to be manually purchased/downloaded from the App Store first"
      failed_apps+=("${app_name} (${app_id})")
    fi
  fi
done

echo
if [ ${#failed_apps[@]} -eq 0 ]; then
  echo "✓ Finished installing all App Store applications"
else
  echo "⚠ Finished with some failures:"
  printf '  - %s\n' "${failed_apps[@]}"
  echo
  echo "Please manually purchase/download these apps in the App Store, then re-run this script."
  exit 1
fi
