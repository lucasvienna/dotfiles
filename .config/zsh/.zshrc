# Put programs on `/etc/paths.d/` in the PATH
# eval `/usr/libexec/path_helper -s`

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  ZSH_THEME="spaceship"
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
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  plugins=(
    git
    rust
    vscode
    sublime
    sublime-merge
    fzf-tab
    zsh-autosuggestions
    fast-syntax-highlighting
  )
else
  plugins=(
    git
    rust
    vscode
    fzf-tab
  )
fi

source $ZSH/oh-my-zsh.sh

# User configuration

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Enable mise automatic activation
eval "$(mise activate zsh)"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
[ -f "${XDG_CONFIG_HOME}/zsh/.aliases" ] && . "${XDG_CONFIG_HOME}/zsh/.aliases"

# Load local settings if they exist.
[ -f "${XDG_CONFIG_HOME}/zsh/.zshrc.local" ] && . "${XDG_CONFIG_HOME}/zsh/.zshrc.local"
if [ -f "${XDG_CONFIG_HOME}/zsh/.aliases.local" ]; then . "${XDG_CONFIG_HOME}/zsh/.aliases.local"; fi

