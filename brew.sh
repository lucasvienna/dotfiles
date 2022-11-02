#!/usr/bin/env bash

# This script comes from Mathias Bynens with slight modifications made by lucasfcosta and me
# https://github.com/mathiasbynens/dotfiles/blob/bb6c76e410bf7b1693edfe60239461fc9205ec02/brew.sh

echo "Installing packages..."


# Make sure we’re using the latest software.
sudo apt update

# Upgrade any already-installed packages.
sudo apt upgrade -y


# -------------------------------
# CLI Tools
# -------------------------------
sudo apt install -y \
# Install GNU core utilities
  coreutils \ 

# Install GNU `find`, `locate`, `updatedb`, `xargs`, `sed`. All `g`-prefixed.
  findutils \

# Install more recent versions of some tools.
  grep openssl cmake \

# Install stow for handling symlinks
  stow \

# Install `wget` and `curl`.
  wget curl \

# Install GnuPG to enable PGP-signing commits.
# Also install pinentry so it works with Source Tree
  gnupg pinentry-curses \

# tmux - terminal multiplexer
  tmux \

# silver searcher, enhances fzf
  silversearcher-ag \

# God bless the best text editor on earth
# Change the user's life forever
  neovim


# -------------------------------
# Miscelaneous Tools
# -------------------------------
sudo apt install -y \
  git \
  git-flow \
  prettyping \
  tree \
  zsh
