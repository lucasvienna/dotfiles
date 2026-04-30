# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with
code in this repository.

## Overview

This is Lucas Vienna's dotfiles repository - a comprehensive developer
environment setup that automates installation and configuration across macOS,
Debian, Ubuntu, and WSL 2. The system manages shell configuration (zsh),
terminal multiplexer (tmux), text editor (Neovim), and system-wide theming with
a single install script.

This repository is a fork of
[Nick Janetakis' dotfiles](https://github.com/nickjj/dotfiles) with
customizations and personal preferences.

## Common Commands

### Install Script Operations

```bash
# Run the install script (idempotent, safe to run multiple times)
./install

# Skip system package installation (useful for re-linking configs)
./install --skip-system-packages

# Only regenerate symlinks (fastest way to apply config changes)
./install --symlinks

# Pull latest changes without running install
./install --pull

# Pull latest changes AND run install script
./install --update

# Compare local config to example config (check for new options)
./install --diff-config

# Compare local repo to remote (preview what --update would change)
./install --diff

# Show new commits available upstream
./install --new-commits

# Test locally without git operations (useful in containers)
LOCAL=1 ./install

# Run with pre-answered prompts
YES=1 ./install
```

### Theme Management

```bash
# Switch theme (updates all apps: nvim, tmux, fzf, btop, ghostty, gitui)
dot-theme-set THEME_NAME

# List available themes
dot-theme-set --list

# Random theme
dot-theme-set
```

Available themes:

- `tokyonight-moon` - High contrast, excellent for video recording
- `dracula-pro` - Modern dark theme with vibrant accents

### Development Workflow

```bash
# Navigate to dotfiles directory
cd "${DOTFILES_PATH}"

# Update Oh-My-Zsh plugins
update-omz-plugins

# Create new executable script with template
mkscript SCRIPT_NAME

# Test in Docker without modifying host system
docker container run --rm -it -e "IN_CONTAINER=1" -v "${PWD}:/app" -w /app debian:stable-slim bash
# Then inside container:
apt-get update && apt-get install -y curl && bash <(curl -sS https://raw.githubusercontent.com/lucasvienna/dotfiles/master/install)
```

## Architecture

### Installation System

The installer is split between two top-level entry points and a shared
`_install/` library:

- **`bootstrap`**: First-run script. Detects environment, installs critical
  packages (Homebrew + Bash on macOS, sudo + git on Debian), clones the repo
  to a chosen path, then `exec`s `./install`. Curl-pipe-friendly.
- **`install`**: Orchestrator. Sources `_install/env` for helpers and
  `_install/{packages,mise_languages,symlinks}` for data, runs install phases.
  Re-entrant — safe to re-run after first install.
- **`_install/env`**: Shared library — color codes, `_info`/`_error`/`_skipping`
  helpers, `_run_as_root`/`_package_install`, `detect_env`, `warn_root`,
  `_dotfiles_env` (used by `--debug`).

**Install phases** (`./install`):

1. **Source**: `_install/env`, `install-config`, `_install/packages/${OS}`,
   `_install/mise_languages`, `_install/symlinks`
2. **`detect_env`** + **`warn_root`** + **`update_dotfiles`** (only with --pull/--update)
3. **`check_prereqs`** + **`create_initial_dirs`**
4. **`install_packages`**: APT + Mise (Debian) or Homebrew + casks (macOS)
5. **`clone_dotfiles`**: only if DOTFILES_PATH doesn't already exist
6. **`install_fonts`** (CascadiaCode Nerd Font)
7. **`install_omz`** + **`install_omz_plugins`**
8. **`create_symlinks`**: GNU Stow via `_stowit` wrapper
9. **`configure_{system,home,shell,git}`**: shell aliases, git config.local
10. **`ask_for_{name,email}`** + **`create_{ssh,gpg}_key`**: identity setup
11. **`install_programming_languages`**: Mise languages
12. **`install_{tmux,nvim}_plugins`**: TPM + Lazy
13. **`set_theme`** + **`healthcheck`** + **`completed_message`**

**Key Design Principles**:

- **Idempotent**: Can be run multiple times safely
- **Non-destructive**: Prompts before overwriting existing configs
- **Cross-platform**: Handles macOS, Debian, Ubuntu, WSL 2
- **Customizable**: `install-config` (git-ignored) allows overriding defaults
  without forking. Defaults live in `_install/packages/`, `_install/mise_languages`,
  and `_install/symlinks`.
- **Modular**: Data (package lists, languages, symlinks) is separate from
  logic. `_install/env` can be sourced by any script that needs the helpers.

### Configuration Structure

Follows XDG Base Directory specification:

```
.config/
├── nvim/       # Neovim (LazyVim framework)
├── tmux/       # Tmux with TPM plugins
├── zsh/        # Zsh with Oh-My-Zsh and custom plugins
├── git/        # Git config with delta, SSH signing
├── ghostty/    # Terminal emulator config
├── fzf/        # Fuzzy finder config
└── btop/       # System monitor config

.local/
└── bin/        # Custom scripts (dot-theme-set, clip-copy, mkscript, etc.)
```

**Local Override Pattern**: All configs support `.local` variants (git-ignored)
for user customization:

- `.config/zsh/.zshrc.local`
- `.config/zsh/.zprofile.local`
- `.config/zsh/.aliases.local`
- `.config/git/config.local`

Main configs source these `.local` files, allowing customization without
modifying tracked files.

### Symlink Management (GNU Stow)

Symlinks are defined in `install-config.example` and created via the `_stowit()`
wrapper:

```bash
_stowit -d "${DOTFILES_PATH}/.local" -t "${HOME}/.local/bin" bin
_stowit -d "${DOTFILES_PATH}/.config" -t "${HOME}/.config/nvim" nvim
```

**Stow behavior**:

- Creates symlinks from source directory into target
- `--ignore` regex excludes patterns (e.g., `.local` files)
- `-R` adopts existing files (non-destructive)

Special case: `.zshenv` must be in `$HOME`, so it's linked directly with
`ln -fns`.

### Theme System

**Architecture**: Each theme provides configs for ALL themed apps:

```
themes/tokyonight-moon/
├── btop.theme      # System monitor colors
├── fzf.sh          # Fuzzy finder FZF_DEFAULT_OPTS
├── ghostty         # Terminal emulator theme
├── gitui.ron       # Git UI theme (Rust Object Notation)
├── nvim.lua        # LazyVim colorscheme plugin config
└── tmux.conf       # Status bar colors
```

**How it works**:

1. `dot-theme-set THEME_NAME` sources the install script's `set_theme()`
   function
2. Creates symlinks: `themes/${THEME}/nvim.lua` →
   `.config/nvim/lua/plugins/theme.lua`
3. Apps load theme via symlink: `source ~/.config/fzf/theme.sh`
4. Neovim: Theme Lua file configures LazyVim's colorscheme plugin
5. Tmux/btop: Reload triggered via signals (`killall -SIGUSR2 btop`)

**Adding a new theme**:

1. Copy existing theme directory in `themes/`
2. Rename to new theme name
3. Adjust color values in each file
4. Switch with `dot-theme-set NEW_THEME_NAME`

### Package Management

Three-tier system:

1. **System Packages** (APT/Homebrew):
   - Core tools: git, tmux, curl, stow, gnupg
   - Defined in: `APT_PACKAGES`, `BREW_PACKAGES`, `BREW_CASK_PACKAGES`

2. **Mise Packages** (platform-specific):
   - Modern CLI tools: btop, fd, fzf, jq, kubectl, k9s, lazygit, neovim, ripgrep
   - Defined in: `MISE_PACKAGES_DEBIAN`, `MISE_PACKAGES_MACOS`
   - Installed with: `mise use --global PACKAGE@VERSION`

3. **Mise Languages** (runtime environments):
   - Programming languages: Node, Python, Go, Rust, Bun
   - Defined in: `MISE_LANGUAGES` associative array
   - Example: `MISE_LANGUAGES["python"]="python@3.14"`

**Why Mise?** Modern replacement for nvm, pyenv, rbenv, etc. Manages both tools
and language runtimes.

### Neovim Configuration

Uses **LazyVim** (opinionated Neovim starter):

```
.config/nvim/
├── init.lua           # Entry point (loads lua/config/lazy.lua)
├── lazy-lock.json     # Plugin version lockfile
├── lua/
│   ├── config/
│   │   ├── lazy.lua       # Lazy plugin manager setup
│   │   ├── keymaps.lua    # Custom keybindings
│   │   ├── options.lua    # Vim options
│   │   └── autocmds.lua   # Autocommands
│   └── plugins/           # Plugin configurations (auto-loaded by Lazy)
│       ├── theme.lua      # Symlink to themes/${THEME}/nvim.lua
│       ├── lsp.lua        # LSP configurations
│       └── ...            # Other plugin configs
└── stylua.toml        # Lua code formatter config
```

**Plugin Pattern**: Each file in `lua/plugins/` returns a table that configures
one or more plugins. Lazy auto-loads these.

**Theme Integration**: `lua/plugins/theme.lua` is a symlink that overrides
LazyVim's default colorscheme. When you switch themes, this symlink updates and
Neovim reloads.

### Zsh Configuration

**Load Order**:

1. `.zshenv` (in `$HOME`, symlinked) - Sets `ZDOTDIR=${HOME}/.config/zsh`
2. `.config/zsh/.zprofile` - Login shell initialization (PATH, XDG vars,
   GPG_TTY)
3. `.config/zsh/.zprofile.local` - User additions (git-ignored)
4. `.config/zsh/.zshrc` - Interactive shell setup (Oh-My-Zsh, plugins, aliases)
5. `.config/zsh/.zshrc.local` - User additions (git-ignored)

**Oh-My-Zsh Integration**:

- Framework: Oh-My-Zsh
- Theme: Starship prompt (installed via Mise/Homebrew)
- Custom plugins (in `~/.local/share/zsh/plugins/`):
  - `zsh-autosuggestions` - Fish-like autosuggestions
  - `fast-syntax-highlighting` - Syntax highlighting
  - `fzf-tab` - Replace zsh completion with fzf

**Updating plugins**: `update-omz-plugins` script clones/pulls latest versions.

### Git Configuration

Located in `.config/git/`:

- `config` - Main git config (tracked)
- `config.local` - User-specific overrides (git-ignored)
- `ignore` - Global gitignore patterns
- `allowed_signers` - SSH key signing trust

**Key Features**:

- **Delta**: Enhanced diff viewer with syntax highlighting
- **SSH Signing**: Commits signed with SSH keys (1Password on macOS)
- **Vimdiff**: Merge conflict tool
- **Autosquash/Autostash**: Cleaner rebase workflows
- **Default Branch**: `main`

### WSL 2 Specifics

**Symlinks** (in `SYMLINKS_WSL`):

- Copies `.wslconfig` to Windows user directory (`/mnt/c/Users/%USERNAME%/`)
- Links `wsl.conf` to `/etc/wsl.conf` (requires sudo)

**Key Settings**:

- No systemd (avoids 10-15s startup delay)
- WSLg clipboard sharing (automatic with WSL 2)
- Docker integration via OrbStack or native Docker

**Note**: Reboot or `wsl --shutdown` required after changing `wsl.conf`.

## File Organization

### Scripts in `.local/bin/`

| Script                     | Purpose                                      |
| -------------------------- | -------------------------------------------- |
| `dot-theme-set`            | Switch system-wide theme                     |
| `update-omz-plugins`       | Update Oh-My-Zsh custom plugins              |
| `clip-copy` / `clip-paste` | Cross-platform clipboard (Wayland/macOS/X11) |
| `mkscript`                 | Create executable script with proper shebang |
| `dtags`                    | Directory tag management                     |
| `gl` / `gd` / `gbd`        | fzf-driven git log / diff browsers + bulk branch delete |
| `rcurl`                    | Resilient curl wrapper (retries, timeouts)   |
| `myip` / `ppjson` / `specs` / `outdated` | Cross-platform utilities       |

All use strict Bash mode: `set -o errexit -o pipefail -o nounset`

### Important Files

- `bootstrap` - First-run entry point (detects env, installs deps, clones repo, runs install)
- `install` - Orchestrator (sources `_install/` and `install-config`, runs install phases)
- `install-config.example` - Customization template
- `install-config` - User overrides (git-ignored, created on first run)
- `_install/env` - Shared library: helpers, color codes, `detect_env`, `warn_root`
- `_install/packages/{debian,darwin}` - Default package lists per OS
- `_install/mise_languages` - Default Mise language definitions
- `_install/symlinks` - Default `_stowit` symlink list
- `mas.sh` - macOS App Store app installation

## Customization

### Option 1: Using install-config (Recommended)

Copy `install-config.example` to `install-config` and modify:

```bash
# Custom packages
export BREW_PACKAGES_EXTRAS="package1 package2"
export MISE_LANGUAGES_EXTRAS["ruby"]="ruby@3.4"

# Pre-fill git config
export YOUR_NAME="Your Name"
export YOUR_EMAIL="your@email.com"

# Add custom symlinks
export SYMLINKS_EXTRAS=(
  "ln -fns \"${DOTFILES_PATH}/custom\" \"${HOME}/custom\""
)
```

### Option 2: Local Override Files

Edit these git-ignored files:

- `.config/zsh/.zshrc.local` - Shell aliases, functions, env vars
- `.config/zsh/.zprofile.local` - Login shell additions
- `.config/zsh/.aliases.local` - Custom command aliases
- `.config/git/config.local` - Git user config, signing

### Option 3: Branching (For Heavy Customization)

```bash
cd "${DOTFILES_PATH}"
git checkout -b personalized
# Make changes
git commit -am "Personalize settings"

# Later, pull upstream updates:
git pull origin main
git rebase main
```

## Testing Changes

**Before running on your system**:

```bash
# Test in Docker container (Debian)
docker container run --rm -it -e "IN_CONTAINER=1" -v "${PWD}:/app" -w /app debian:stable-slim bash
apt-get update && apt-get install -y curl
bash <(curl -sS https://raw.githubusercontent.com/lucasvienna/dotfiles/master/install)

# For local testing without git push:
LOCAL=1 ./install
```

**After making changes locally**:

```bash
# Regenerate symlinks only (fastest)
./install --symlinks

# Full install without package updates
./install --skip-system-packages

# Full install with package updates
./install
```

## Common Workflows

### Adding a New Tool

1. Add to appropriate package list in `install-config`:

   ```bash
   export BREW_PACKAGES_EXTRAS="newtool"
   ```

2. Run: `./install` (or `./install --skip-system-packages` if already installed
   manually)

### Adding a Neovim Plugin

1. Create file in `.config/nvim/lua/plugins/myplugin.lua`:

   ```lua
   return {
     "author/plugin-name",
     opts = function()
       -- Configuration here
     end,
   }
   ```

2. Open Neovim - Lazy auto-installs plugins
3. Or manually: `:Lazy sync`

### Creating a Custom Theme

1. Copy existing theme:

   ```bash
   cp -r themes/tokyonight-moon themes/mytheme
   ```

2. Edit color values in each file
3. Switch: `dot-theme-set mytheme`

### Adding a Zsh Alias

Add to `.config/zsh/.aliases.local`:

```bash
alias myalias='command'
```

Reload: `source ~/.config/zsh/.zshrc` or open new terminal.

### Updating Dotfiles

```bash
cd "${DOTFILES_PATH}"

# See what changed upstream
./install --new-commits

# Pull and install updates
./install --update

# Or manually:
git pull origin main
./install
```

## Platform-Specific Notes

### macOS

- Requires Homebrew (installed by install script)
- Requires Bash 4+ (installed by install script)
- Uses OrbStack for Docker (installed via Homebrew Cask)
- Terminal: Ghostty (installed, but macOS Terminal works)
- 1Password for SSH/GPG signing (configured in git)

### Debian/Ubuntu

- Uses APT for system packages
- Mise provides newer tool versions
- X11/Wayland clipboard support via `xclip`

### WSL 2

- Requires WSLg for clipboard sharing
- No systemd (for faster startup)
- Windows paths accessible via `/mnt/c/`
- Config: `wsl.conf` in `/etc/`, `.wslconfig` in Windows user directory
- Reboot after changing configs: `wsl --shutdown` from PowerShell

## Key Environment Variables

Set in `.config/zsh/.zprofile`:

```bash
DOTFILES_PATH="${HOME}/dotfiles"      # Location of this repo
ZDOTDIR="${HOME}/.config/zsh"         # Zsh config directory
XDG_CONFIG_HOME="${HOME}/.config"     # Config directory
XDG_DATA_HOME="${HOME}/.local/share"  # Data directory
XDG_CACHE_HOME="${HOME}/.cache"       # Cache directory
GPG_TTY=$(tty)                        # GPG terminal for signing
```

## Troubleshooting

### Neovim plugins not loading

```bash
# Reinstall plugins
nvim +Lazy sync +qa
```

### Tmux plugins not loading

```bash
# Reinstall plugins (from within tmux)
prefix + I (capital i)
```

### Theme not applying

```bash
# Reapply theme
dot-theme-set THEME_NAME

# If Neovim still shows old theme, close and reopen
# Or from Neovim: :source ~/.config/nvim/init.lua
```

### Clipboard not working in WSL

- Verify WSLg is installed: `wsl.exe --version` (should list WSLg)
- Check `.wslconfig`: Ensure `guiApplications=false` is NOT set
- Paste in Neovim: Use `CTRL+SHIFT+v` instead of `p` for Windows clipboard

### Install script fails on fresh system

**Missing prerequisites**:

- macOS: Bash 3 → Install Bash 4+ via Homebrew first
- Linux: curl → Install with `apt-get install curl`

See "Quick Start" section in README.md for platform-specific one-liners.

## Repository Information

- **Author**: Lucas Vienna
- **License**: MIT
- **Original Author**: Nick Janetakis (this is a fork of his excellent dotfiles)
- **Repository**: <https://github.com/lucasvienna/dotfiles>
