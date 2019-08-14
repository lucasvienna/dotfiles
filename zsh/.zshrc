# If you come from bash you might have to change your $PATH.
export PATH=$HOME/bin:/usr/local/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
# Put programs on `/etc/paths.d/` in the PATH
eval `/usr/libexec/path_helper -s`

# Path to your oh-my-zsh installation.
export ZSH="/Users/lucas/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="spaceship"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git
  tmux
  golang
  node
  docker
  docker-compose
  zsh-autosuggestions
  zsh-syntax-highlighting
)

source $ZSH/oh-my-zsh.sh

# User configuration

# You may need to manually set your language environment
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# ssh
export SSH_KEY_PATH="~/.ssh/rsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of actie aliases, run `alias`.
if [ -f ~/.zsh_aliases ]; then
    . ~/.zsh_aliases
fi

# n - node version manager
export N_PREFIX="$HOME/n"; [[ :$PATH: == *":$N_PREFIX/bin:"* ]] || PATH+=":$N_PREFIX/bin"  # Added by n-install (see http://git.io/n-install-repo).

# gpg ioctl fix
export GPG_TTY=$(tty)

# Create a JAVA_HOME variable, determined dynamically. Not. It's slow. Set it manually
# export JAVA_HOME=$(/usr/libexec/java_home)
export JAVA_HOME="/Library/Java/JavaVirtualMachines/adoptopenjdk-8.jdk/Contents/Home"
export PATH=$PATH:${JAVA_HOME}/bin

# Set Android_HOME
export ANDROID_HOME=~/Library/Android/sdk
# Add the Android SDK to the ANDROID_HOME variable
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/build-tools/28.0.3
# Set GRADLE_HOME
# The line below is an automated version finder. However, awk takes a fuckload of time to run
# export GRADLE_HOME=$(brew info gradle | grep /usr/local/Cellar/gradle | awk '{print $1}')
# Therefore we manually set the home var to the brew prefix
export GRADLE_HOME="/usr/local/opt/gradle/libexec"
export PATH=$PATH:$GRADLE_HOME/bin

# Set GOPATH and GOROOT
export GOPATH="$HOME/.go"
export GOBIN="$GOPATH/bin"
# Just like gradle, the line below is an automated version finder. It's also slow.
# export GOROOT="$(brew --prefix golang)/libexec"
export GOROOT="/usr/local/opt/go/libexec"
export PATH="$PATH:$GOPATH/bin:$GOROOT/bin"

# app deployment via fastlane
export PATH="$PATH:$HOME/.fastlane/bin"

# flutter SDK
export PATH="$PATH:/usr/local/share/flutter/bin"

# brew kegs that we want to replace the system tools with
export PATH="/usr/local/opt/curl/bin:$PATH"               # curl
export PATH="/usr/local/opt/ruby/bin:$PATH"               # ruby
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH" # sed
export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"    # grep, egrep, fgrep

# keg-ruby gems must also be added to PATH
export PATH="$PATH:/usr/local/lib/ruby/gems/2.6.0/bin"

# Initialize tmux or re-attach to running session
if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
  tmux attach -t macOS || tmux new -s macOS
fi
