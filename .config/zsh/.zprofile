# shellcheck shell=bash

# This file runs once at login.

# Set up a few standard directories based on:
#   https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Explicitly set the temp directory
export TMPDIR="/tmp"

# Add all local binaries to the system path and make sure they are first.
export PATH="$HOME/bin:$HOME/.local/bin:$HOME/.local/bin/local:$PATH"

# Confiure Mise (programming language run-time manager).
export PATH="${XDG_DATA_HOME}/mise/shims:${PATH}"

# Configure GPG.
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

# Add colors to the less and man commands.
export LESS=-R
LESS_TERMCAP_ue="$(printf '%b' '[0m')"
export LESS_TERMCAP_ue
export LESS_TERMCAP_mb=$'\e[1;31mm'   # begin blinking
export LESS_TERMCAP_md=$'\e[1;36m'    # begin bold
export LESS_TERMCAP_us=$'\e[1;332m'   # begin underline
export LESS_TERMCAP_so=$'\e[1;44;33m' # begin standout-mode - info box
export LESS_TERMCAP_me=$'\e[0m'       # end mode
export LESS_TERMCAP_ue=$'\e[0m'       # end underline
export LESS_TERMCAP_se=$'\e[0m'       # end standout-mode

# Configure delta (diffs) defaults.
# https://dandavison.github.io/delta/environment-variables.html
export DELTA_FEATURES="diff-so-fancy"

# Default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Default programs to run.
export EDITOR="nvim"
export DIFFPROG="nvim -d"

# tell homebrew to shut up
export HOMEBREW_NO_ENV_HINTS=1

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# ruby gems
export PATH="$HOME/.gem/bin:$PATH"

# brew kegs that we want to replace the system tools with
export PATH="/usr/local/opt/curl/bin:$PATH"               # curl
export PATH="/usr/local/opt/ruby/bin:$PATH"               # ruby
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" # sed
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"    # grep, egrep, fgrep

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Load local settings if they exist.
# shellcheck disable=SC1091
if [ -f "${XDG_CONFIG_HOME}/zsh/.zprofile.local" ]; then . "${XDG_CONFIG_HOME}/zsh/.zprofile.local"; fi
