#!/usr/bin/env bash

OS_TYPE="$(uname | tr "[:upper:]" "[:lower:]")"

if [ "$OS_TYPE" != "darwin" ]; then
  echo "This script is only meant for macOS (darwin)! Exiting..."
  exit 1
fi

if ! command -v "mas" 1>/dev/null; then
  echo "mas needs to be installed for this script. Run './install' before trying again."
  printf ">> https://github.com/mas-cli/mas\n\n"
  exit 1
fi

# -------------------------------
# macOS App Store
# -------------------------------

echo "Installing macOS App Store applications..."

# Browser Extensions
mas install 1569813296 # 1Password for Safari
mas install 6504861501 # Ghostery Privacy Ad Blocker
mas install 1573461917 # SponsorBlock
mas install 1458969831 # JSON Peep

# Productivity Apps
mas install 409183694 # Keynote
mas install 409203825 # Numbers
mas install 409201541 # Pages

# Utilities
mas install 1534275760 # LanguageTool
mas install 441258766  # Magnet
mas install 1527619437 # maccy

# Communication
mas install 310633997 # WhatsApp

# Media Editing
mas install 634148309 # Logic Pro
mas install 424389933 # Final Cut Pro

# Development Tools
mas install 640199958 # Developer
mas install 899247664 # TestFlight
mas install 497799835 # Xcode

echo
echo "Finished installing AppStore applications"

