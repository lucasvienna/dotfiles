#!/usr/bin/env bash

# This has been shamelessly copied from mathiasbynens/dotfiles and edited a bit
# https://github.com/mathiasbynens/dotfiles/blob/b22c32290e1518c0f228afba254ee6a3f6ab6d7a/bootstrap.sh

cd "$(dirname "${BASH_SOURCE}")" || exit

git pull origin master

function spaceship() {
  # This installs the spaceship theme for zsh
  # https://github.com/denysdovhan/spaceship-prompt
  if [ -d "$ZSH/custom/themes/spaceship-prompt" ]; then
    echo "spaceship-prompt is already installed, skipping..."
  else
    git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH/custom/themes/spaceship-prompt"
    ln -s "$ZSH/custom/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH/custom/themes/spaceship.zsh-theme"
  fi
}

function stowit() {
  usr=$1
  app=$2
  # -v verbose
  # -R recursive
  # -t target
  stow -v -R -t ${usr} ${app}
}

function doIt() {
  # install homebrew
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  # install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

  ./brew.sh

  # link dotfiles
  stowit ~ git
  stowit ~ tmux
  stowit ~ nvim
  stowit ~ zsh

  # install nvim plugins and python addon
  pip3 install --user --upgrade neovim
  nvim --headless '+Lazy install' +qall

  # install tpm
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # launch the spaceship
  spaceship
}

if [[ "$1" == "--force" ]] || [[ "$1" == "-f" ]]; then
  doIt
  ./brew.sh
else
  read -p -r "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
    ./brew.sh
  fi
fi

unset doIt
unset spaceship
