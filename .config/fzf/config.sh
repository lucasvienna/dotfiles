export FZF_DEFAULT_COMMAND="rg --files --follow --hidden --glob '!.git'"
export FZF_DEFAULT_OPTS="--highlight-line --info=inline-right --ansi --layout=reverse --border=none"
export FZF_CTRL_T_OPTS="--preview='less {}' --height=100% --bind shift-up:preview-page-up,shift-down:preview-page-down"

# Guarded: theme.sh is a symlink created by dot-theme-set, so it's absent until
# a theme has been applied. Without this, a partial install makes every new
# shell print an error.
# shellcheck disable=SC1091
[ -f "${XDG_CONFIG_HOME}/fzf/theme.sh" ] && . "${XDG_CONFIG_HOME}/fzf/theme.sh"