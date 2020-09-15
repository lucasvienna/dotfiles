#!/usr/bin/env bash

# This script comes from Mathias Bynens with slight modifications made by lucasfcosta and me
# https://github.com/mathiasbynens/dotfiles/blob/bb6c76e410bf7b1693edfe60239461fc9205ec02/brew.sh

echo "Installing packages..."


# Make sure we have the necessary keys and repos
curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -
echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list

# Make sure we’re using the latest software.
sudo apt update

# Upgrade any already-installed packages.
sudo apt upgrade -y


# -------------------------------
# CLI Tools
# -------------------------------
# Install GNU core utilities
sudo apt install -y coreutils

# Install GNU `find`, `locate`, `updatedb`, `xargs`, `sed`. All `g`-prefixed.
sudo apt install -y findutils

# Install more recent versions of some tools.
sudo apt install -y grep openssl cmake

# Install stow for handling symlinks
sudo apt install -y stow

# Install `wget` and `curl`.
sudo apt install -y wget curl

# Install GnuPG to enable PGP-signing commits.
# Also install pinentry so it works with Source Tree
sudo apt install -y gnupg pinentry-curses

# tmux - terminal multiplexer
sudo apt install -y tmux

# silver searcher, enhances fzf
sudo apt install -y silversearcher-ag

# God bless the best text editor on earth
# Change the user's life forever
sudo apt install -y neovim


# -------------------------------
# Programming languages
# -------------------------------
sudo apt install -y golang-go python3


# -------------------------------
# Miscelaneous Tools
# -------------------------------
sudo apt install -y git git-flow
sudo apt install -y prettyping
sudo apt install -y tree
sudo apt install --no-install-recommends -y yarn


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
