#!/usr/bin/env bash
set -euo pipefail

# Install Homebrew
echo "Installing Homebrew..."
if ! NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"; then
  echo "Error: Homebrew installation failed" >&2
  exit 1
fi

# Detect Homebrew installation path
if [ -f "/opt/homebrew/bin/brew" ]; then
  BREW_PREFIX="/opt/homebrew"
elif [ -f "/usr/local/bin/brew" ]; then
  BREW_PREFIX="/usr/local"
else
  echo "Error: Homebrew binary not found after installation" >&2
  exit 1
fi

# Initialize brew environment and install bash
echo "Installing latest bash..."
eval "$("${BREW_PREFIX}/bin/brew" shellenv)"
brew install bash

echo "Switching to Homebrew bash for bootstrapping..."
exec "${BREW_PREFIX}/bin/bash" "$@"
