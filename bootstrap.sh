#!/usr/bin/env bash

# This has been shamelessly copied from mathiasbynens/dotfiles and edited a bit
# https://github.com/mathiasbynens/dotfiles/blob/b22c32290e1518c0f228afba254ee6a3f6ab6d7a/bootstrap.sh

cd $(dirname "${BASH_SOURCE}");

git pull origin master;

function spaceship() {
  # This installs the spaceship theme for zsh
  # https://github.com/denysdovhan/spaceship-prompt
  if [ -d "$ZSH/custom/themes/spaceship-prompt" ]
  then
    echo "spaceship-prompt is already installed, skipping..."
  else
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH/custom/themes/spaceship-prompt"
    ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/custom/themes/spaceship.zsh-theme"
  fi
}

function doIt() {
  stow tmux;
  stow nvim;
  stow zsh;
  stow git;
  spaceship;
}

function italicTerm() {
  tic -x terminfo/xterm-256color-italic.terminfo;
  tic -x terminfo/tmux-256color.terminfo;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
    italicTerm;
  fi;
fi;

unset doIt;
