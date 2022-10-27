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
# Miscelaneous Tools
# -------------------------------
sudo apt install -y git git-flow
sudo apt install -y prettyping
sudo apt install -y tree
sudo apt install -y zsh
