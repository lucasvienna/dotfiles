#!/usr/bin/env bash

# This script comes from Mathias Bynens with slight modifications made by me
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

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`.
brew install gnu-sed

# Install GnuPG to enable PGP-signing commits.
# Also install pinentry so it works with Source Tree
brew install gnupg pinentry-mac

# tmux - terminal multiplexer
brew install tmux

# silver searcher, enhances fzf
brew install the_silver_searcher

# This is needed for fzf to know how to ignore files listed in .gitignore
# and know how to show hidden files
# It is also a good CLI tool
brew install ag

# This is needed for python support on Neovim for YouCompleteMe
# Please see https://github.com/neovim/neovim/issues/1315
brew install python3
pip3 install --user --upgrade neovim

# Programming languages
brew install dart
brew install go

# Install `wget` and `curl`.
brew install wget
brew install curl

# Install more recent versions of some macOS tools.
brew install grep
brew install openssh

# Full suite of docker utilities
brew install docker
brew install docker-compose
brew install docker-machine

# Flutter development package
brew install gradle
brew install --HEAD usbmuxd
brew link usbmuxd
brew install --HEAD libimobiledevice
brew install ideviceinstaller ios-deploy cocoapods

# Install other useful binaries.
brew install git
brew install git-flow
brew install prettyping
brew install tree
brew install ssh-copy-id
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
brew cask install gitkraken
brew cask install alfred

# Browsers
brew cask install google-chrome
brew cask install firefox

# Communication
brew cask install rocket
brew cask install slack
brew cask install skype
brew cask install discord

# -------------------------------
# vIM & neo vIM
# -------------------------------

# Change the user's life forever
# God bless the best text editor on earth
brew install neovim
nvim +PlugClean! +qall
nvim +silent +PlugInstall +qall
python3 ~/.config/nvim/plugged/YouCompleteMe/install.py

# Remove outdated versions from the cellar.
brew cleanup
