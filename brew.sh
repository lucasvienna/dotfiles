#!/usr/bin/env bash

# This script comes from Mathias Bynens with slight modifications made by lucasfcosta and me
# https://github.com/mathiasbynens/dotfiles/blob/bb6c76e410bf7b1693edfe60239461fc9205ec02/brew.sh

# Mute annoying env hints during automated install
HOMEBREW_NO_ENV_HINTS=1

echo "Installing brew formulae..."

# Tap any casks we'll need later
brew tap derailed/k9s

# Make sure we’re using the latest Homebrew.
brew update

# Upgrade any already-installed formulae.
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)


# -------------------------------
# CLI Tools
# -------------------------------
# Install GNU core utilities (those that come with macOS are outdated).
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GNU `find`, `locate`, `updatedb`, `xargs`, `sed`. All `g`-prefixed.
brew install findutils gnu-sed

# Install more recent versions of some macOS tools.
brew install grep openssh cmake

# Install stow for handling symlinks
brew install stow

# Install `wget` and `curl`.
brew install wget curl

# Install GnuPG to enable PGP-signing commits.
# Also install pinentry so it works with Source Tree
brew install gnupg pinentry-mac

# Better CLI tools
brew install fzf fd ripgrep

# silver searcher, enhances fzf
brew install the_silver_searcher

# This is needed for fzf to know how to ignore files listed in .gitignore
# and know how to show hidden files
# It is also a good CLI tool
brew install ag

# Btw I use vim
brew install neovim


# -------------------------------
# Programming languages
# -------------------------------
brew install flutter go python


# -------------------------------
# Containerisation Tools
# -------------------------------
brew install --cask orbstack
brew install kubectl helm derailed/k9s/k9s


# -------------------------------
# Flutter
# -------------------------------
brew install gradle
# Unused for the moment, keep commented out
# brew install --HEAD usbmuxd
# brew link usbmuxd
# brew install --HEAD libimobiledevice
# brew install ideviceinstaller ios-deploy cocoapods
# brew install fastlane

# -------------------------------
# Miscelaneous Tools
# -------------------------------
brew install git lazygit
brew install prettyping bat tree ssh-copy-id
brew install mas


# -------------------------------
# Casks
# -------------------------------

# Dev utilities
brew install --cask jetbrains-toolbox
brew install --cask ghostty warp
brew install --cask sublime-merge sublime-text

# Apps & Productivity
brew install --cask arc
brew install --cask alfred
brew install --cask obsidian
brew install --cask 1password
brew install 1password-cli

# Communication
brew install --cask discord signal

# -------------------------------
# Post-Install
# -------------------------------
# Remove outdated versions from the cellar.
brew cleanup


# -------------------------------
# macOS App Store
# -------------------------------

# Browser Extensions
mas install 1569813296  # 1Password for Safari
mas install 6504861501  # Ghostery Privacy Ad Blocker
mas install 1573461917  # SponsorBlock
mas install 1458969831  # JSON Peep

# Productivity Apps
mas install 409183694   # Keynote
mas install 409203825   # Numbers
mas install 409201541   # Pages

# Utilities
mas install 1534275760  # LanguageTool
mas install 441258766   # Magnet

# Communication
mas install 310633997   # WhatsApp

# Media Editing
mas install 634148309   # Logic Pro
mas install 424389933   # Final Cut Pro

# Development Tools
mas install 640199958   # Developer
mas install 899247664   # TestFlight
mas install 497799835   # Xcode