#!/usr/bin/env bash

# This has been shamelessly copied from mathiasbynens/dotfiles and edited a bit
# https://github.com/mathiasbynens/dotfiles/blob/b22c32290e1518c0f228afba254ee6a3f6ab6d7a/bootstrap.sh

cd $(dirname "${BASH_SOURCE}");

git pull origin master

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

function zshPlugs() {
  if [ -d "$ZSH/custom/plugins/zsh-syntax-highlighting" ]
  then
    echo "zsh-syntax-highlighting is already installed, skipping..."
  else
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
  fi

  if [ -d "$ZSH/custom/plugins/zsh-autosuggestions" ]
  then
    echo "zsh-autosuggestions is already installed, skipping..."
  else
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
  fi
}

function doIt() {
  # install vim-plug
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  # install oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" "" --unattended

  # link dotfiles
  stow tmux
  stow nvim
  stow zsh
  stow git

  # install nvim plugins and python addon
  pip3 install --user --upgrade neovim
  nvim +PlugClean! +qall
  nvim +silent +PlugInstall +qall
  python3 ~/.config/nvim/plugged/YouCompleteMe/install.py

  # install tpm
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

  # get them sweet oh-my-zsh plugins going
  zshPlugs

  # launch the spaceship
  spaceship
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  doIt
  ./brew.sh
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt
    ./brew.sh
  fi;
fi;

unset doIt
unset spaceship
