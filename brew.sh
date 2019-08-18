#!/usr/bin/env bash

# This script comes from Mathias Bynens with slight modifications made by lucasfcosta and me
# https://github.com/mathiasbynens/dotfiles/blob/bb6c76e410bf7b1693edfe60239461fc9205ec02/brew.sh

echo "Installing brew formulae..."

# Tap any casks we'll need later
brew tap dart-lang/dart
brew tap AdoptOpenJDK/openjdk

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

# tmux - terminal multiplexer
brew install tmux

# Enables macOS clipboard interactions from inside tmux
brew install reattach-to-user-namespace

# silver searcher, enhances fzf
brew install the_silver_searcher

# This is needed for fzf to know how to ignore files listed in .gitignore
# and know how to show hidden files
# It is also a good CLI tool
brew install ag

# God bless the best text editor on earth
# Change the user's life forever
brew install neovim


# -------------------------------
# Programming languages
# -------------------------------
brew install dart go python3


# -------------------------------
# Docker Suite
# -------------------------------
brew install docker docker-compose docker-machine


# -------------------------------
# Flutter
# -------------------------------
brew install gradle
brew install --HEAD usbmuxd
brew link usbmuxd
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy cocoapods

# -------------------------------
# Miscelaneous Tools
# -------------------------------
brew install git git-flow
brew install prettyping
brew install ssh-copy-id
brew install tree
brew install yarn --without-node


# -------------------------------
# Casks
# -------------------------------
# Java OpenJDK
brew cask install adoptopenjdk8

# Dev utilities
brew cask install docker
brew cask install fastlane
brew cask install android-studio
brew cask install alfred

# Browsers
brew cask install google-chrome
brew cask install firefox

# Communication
brew cask install slack
brew cask install skype
brew cask install discord

# -------------------------------
# Post-Install
# -------------------------------
# Remove outdated versions from the cellar.
brew cleanup
