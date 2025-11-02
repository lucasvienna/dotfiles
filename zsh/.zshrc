# If you come from bash you might have to change your $PATH.
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# Put programs on `/etc/paths.d/` in the PATH
# eval `/usr/libexec/path_helper -s`

# Path to your oh-my-zsh installation.
export ZSH="/Users/vienna/.oh-my-zsh"

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

# Which plugins would you like to load? Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  plugins=(
    git
    rust
    volta
    vscode
    sublime
    sublime-merge
    zsh-autosuggestions
    zsh-syntax-highlighting
  )
else
  plugins=(
    git
    rust
    volta
    vscode
    sublime
    sublime-merge
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

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of actie aliases, run `alias`.
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# ruby gems
export PATH="$HOME/.gem/bin:$PATH"

# rust
export PATH="$HOME/.cargo/bin:$PATH"

# brew kegs that we want to replace the system tools with
export PATH="/usr/local/opt/curl/bin:$PATH"               # curl
export PATH="/usr/local/opt/ruby/bin:$PATH"               # ruby
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" # sed
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"    # grep, egrep, fgrep

# fnm
eval "$(fnm env --use-on-cd --version-file-strategy=recursive --resolve-engines --shell zsh)"
