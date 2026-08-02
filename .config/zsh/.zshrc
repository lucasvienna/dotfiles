# Put programs on `/etc/paths.d/` in the PATH
# eval `/usr/libexec/path_helper -s`

# Path to your oh-my-zsh installation. Distros that package it win: CachyOS
# ships oh-my-zsh-git at /usr/share/oh-my-zsh, so there's no reason to keep a
# second copy in $HOME. Nothing packages it on Debian or macOS, so those fall
# back to the $HOME install that ./install performs.
if [ -d /usr/share/oh-my-zsh ]; then
  export ZSH="/usr/share/oh-my-zsh"
else
  export ZSH="${HOME}/.oh-my-zsh"
fi

# Custom plugins deliberately live outside $ZSH: a packaged $ZSH is root-owned,
# and even in the $HOME case this keeps plugins from being wiped by an OMZ
# reinstall. Managed by `update-omz-plugins`.
export ZSH_CUSTOM="${XDG_DATA_HOME:-${HOME}/.local/share}/zsh/custom"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  ZSH_THEME=""
else
  ZSH_THEME="robbyrussell"
fi

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"
zstyle ':omz:update' mode auto

# make repository status checks for large repositories much, much faster
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  brew
  git
  rust
  kubectl
  helm
  k9s
  terraform
  opentofu
  sublime-merge
  zoxide
  fzf-tab
  zsh-autosuggestions
  fast-syntax-highlighting
  # Must come after fast-syntax-highlighting, per its README.
  zsh-history-substring-search
  starship
)

source $ZSH/oh-my-zsh.sh

# User configuration

# Set per-shell so gpg-agent's pinentry targets the current tty (matters for
# SSH signing, GPG signing, and any prompt that has to attach to the user's
# terminal).
export GPG_TTY=$(tty)

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Enable mise automatic activation
eval "$(mise activate zsh)"

# fzf: load shared opts (FZF_DEFAULT_OPTS / _COMMAND / CTRL_T_OPTS) and the
# native shell integration (CTRL+T file picker, CTRL+R history, ALT+C cd).
# shellcheck disable=SC1091
[ -f "${XDG_CONFIG_HOME}/fzf/config.sh" ] && . "${XDG_CONFIG_HOME}/fzf/config.sh"
command -v fzf >/dev/null 2>&1 && source <(fzf --zsh)

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
[ -f "${XDG_CONFIG_HOME}/zsh/.aliases" ] && . "${XDG_CONFIG_HOME}/zsh/.aliases"

# Substring history search on the arrow keys. This replaces OMZ's default
# up-line-or-beginning-search (prefix match); fzf's CTRL+R is untouched.
# Bind both the terminfo sequences (application mode) and the raw escape
# sequences, since which one the terminal sends depends on its keypad mode.
zmodload zsh/terminfo 2>/dev/null
[ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" history-substring-search-up
[ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" history-substring-search-down
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Jump to any ghq-managed repo. This has to be a function rather than a script
# in .local/bin (like gl/gd/gbd) because it changes the shell's directory,
# which a subprocess can't do for its parent.
ghq-jump() {
  local dir
  dir="$(ghq list --full-path | fzf --prompt='repo> ' --preview 'ls -la {}')" || return
  [ -n "${dir}" ] && cd "${dir}"
}

ghq-jump-widget() {
  ghq-jump
  zle reset-prompt
}

zle -N ghq-jump-widget
bindkey '^G' ghq-jump-widget

# Arch-only config (pacman aliases, pkgfile command-not-found, history tuning).
# Loaded before the .local files so those still get the last word.
# shellcheck disable=SC1091
[ -f /etc/arch-release ] && [ -f "${XDG_CONFIG_HOME}/zsh/.zshrc.arch" ] &&
  . "${XDG_CONFIG_HOME}/zsh/.zshrc.arch"

# Load local settings if they exist.
[ -f "${XDG_CONFIG_HOME}/zsh/.zshrc.local" ] && . "${XDG_CONFIG_HOME}/zsh/.zshrc.local"
if [ -f "${XDG_CONFIG_HOME}/zsh/.aliases.local" ]; then . "${XDG_CONFIG_HOME}/zsh/.aliases.local"; fi
