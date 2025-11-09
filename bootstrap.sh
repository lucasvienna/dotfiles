#!/usr/bin/env bash

# This has been initially copied from mathiasbynens/dotfiles and edited quite heavily
# https://github.com/mathiasbynens/dotfiles/blob/b22c32290e1518c0f228afba254ee6a3f6ab6d7a/bootstrap.sh

cd "$(dirname "${BASH_SOURCE}")" || exit

install_brew() {
  # install homebrew
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -f "/opt/homebrew/bin/brew" ]; then
    # Apple Silicon mac
    eval "$(/opt/homebrew/bin/brew shellenv)" \
      && brew install bash \
      && bash
  elif [ -f "/usr/local/bin/brew" ]; then
    # Intel mac
    eval "$(/usr/local/bin/brew shellenv)" \
    && brew install bash \
    && bash
  fi
}

install_brew
