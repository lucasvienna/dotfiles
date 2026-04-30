# shellcheck shell=bash

# This file runs once at login.

# Set up a few standard directories based on the XDG Base Directory specification:
#   https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_CONFIG_HOME="${HOME}/.config"
export XDG_CACHE_HOME="${HOME}/.cache"
export XDG_DATA_HOME="${HOME}/.local/share"
export XDG_STATE_HOME="${HOME}/.local/state"

# Add all local binaries to the system path and make sure they are first.
export PATH="${HOME}/.local/bin:${HOME}/.local/bin/local:${PATH}"

# Confiure Mise (programming language run-time manager).
export PATH="${XDG_DATA_HOME}/mise/shims:${PATH}"

# Configure GPG
export GNUPGHOME="${XDG_CONFIG_HOME}/gnupg"

# Add colors to the less command.
export LESS=-R
export LESS_TERMCAP_mb=$'\e[1;31m'    # begin blinking
export LESS_TERMCAP_md=$'\e[1;36m'    # begin bold
export LESS_TERMCAP_us=$'\e[1;32m'    # begin underline
export LESS_TERMCAP_so=$'\e[1;30;44m' # begin standout-mode - info box
export LESS_TERMCAP_me=$'\e[0m'       # end mode
export LESS_TERMCAP_ue=$'\e[0m'       # end underline
export LESS_TERMCAP_se=$'\e[0m'       # end standout-mode

# Use bat to colorize man pages.
export MANROFFOPT="-c"
export MANPAGER="sh -c 'col -bx | bat --language man --plain'"

# Configure delta (diffs) defaults.
# https://dandavison.github.io/delta/environment-variables.html
export DELTA_FEATURES="diff-so-fancy"

# Default languages
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Default programs to run.
export EDITOR="nvim"
export VISUAL="zed"
export DIFFPROG="nvim -d"

# Homebrew customisation
export HOMEBREW_NO_ENV_HINTS=1
export HOMEBREW_NO_ANALYTICS=1

# tell some programs not to track
export DO_NOT_TRACK=1

# rust
export PATH="${HOME}/.cargo/bin:${PATH}"

# Added by OrbStack: command-line tools and integration
# This won't be added again if you remove it.
source ~/.orbstack/shell/init.zsh 2>/dev/null || :

# Load local settings if they exist.
# shellcheck disable=SC1091
if [ -f "${XDG_CONFIG_HOME}/zsh/.zprofile.local" ]; then . "${XDG_CONFIG_HOME}/zsh/.zprofile.local"; fi
