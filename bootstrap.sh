#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")" || exit

install_brew() {
  # install homebrew
  NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

  if [ -f "/opt/homebrew/bin/brew" ]; then
    # Apple Silicon mac
    eval "$(/opt/homebrew/bin/brew shellenv)" &&
      brew install bash &&
      bash
  elif [ -f "/usr/local/bin/brew" ]; then
    # Intel mac
    eval "$(/usr/local/bin/brew shellenv)" &&
      brew install bash &&
      bash
  fi
}

install_brew
