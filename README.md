# Lucas Vienna's Dotfiles

<!--toc:start-->

- [Lucas Vienna's Dotfiles](#lucas-viennas-dotfiles)
  - [What's Included](#whats-included)
  - [Quick Start](#quick-start)
    - [Prerequisites](#prerequisites)
    - [Installation](#installation)
    - [Try It First (Docker)](#try-it-first-docker)
  - [Themes](#themes)
    - [Included Themes](#included-themes)
  - [Maintenance](#maintenance)
  - [Customization](#customization)
    - [Method 1: Configuration File (Recommended)](#method-1-configuration-file-recommended)
    - [Method 2: Local Overrides](#method-2-local-overrides)
    - [Method 3: Fork & Branch](#method-3-fork-branch)
  - [WSL 2 Notes](#wsl-2-notes)
  - [Project Structure](#project-structure)
  - [Requirements](#requirements)
  - [Documentation](#documentation)
  - [License](#license)
  - [Author](#author)
  - [Acknowledgments](#acknowledgments)
  <!--toc:end-->

A comprehensive developer environment setup that gets you from zero to
productive in minutes. These dotfiles automate the installation and
configuration of modern development tools across macOS, Debian, Ubuntu, and
WSL 2.

## What's Included

**One command installs and configures:**

- **Shell**: Zsh with Oh-My-Zsh, custom plugins, and productivity aliases
- **Terminal Multiplexer**: Tmux with sensible defaults and TPM plugin manager
- **Editor**: Neovim with LazyVim framework, LSP support, and custom
  configurations
- **Modern CLI Tools**: ripgrep, fd, fzf, btop, lazygit, delta, and more
- **Development**: Node, Python, Go, Rust, Bun via Mise runtime manager
- **Security**: SSH/GPG key generation and Git commit signing
- **Theming**: System-wide theme switching across all applications

**Platform Support:** macOS, Debian, Ubuntu, WSL 2

## Quick Start

### Prerequisites

You'll need `curl` and Bash 4+ installed:

**Debian/Ubuntu:**

```bash
apt-get update && apt-get install -y curl
```

**macOS (Apple Silicon):**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
  && eval "$(/opt/homebrew/bin/brew shellenv)" \
  && brew install bash \
  && bash
```

**macOS (Intel):**

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)" \
  && eval "$(/usr/local/bin/brew shellenv)" \
  && brew install bash \
  && bash
```

### Installation

Run this one-liner to bootstrap your entire development environment:

```bash
BOOTSTRAP=1 bash <(curl -sS https://raw.githubusercontent.com/lucasvienna/dotfiles/master/install)
```

The script is idempotent and safe to run multiple times. It will:

1. Prompt before overwriting existing configs
2. Let you review package lists before installation
3. Allow you to choose the installation directory
4. Set up everything in ~5 minutes

**Skip system packages** (if you want to handle them manually):

```bash
BOOTSTRAP=1 bash <(curl -sS https://raw.githubusercontent.com/lucasvienna/dotfiles/master/install) --skip-system-packages
```

### Try It First (Docker)

Test drive without touching your system:

```bash
docker container run --rm -it -e "IN_CONTAINER=1" -v "${PWD}:/app" -w /app debian:stable-slim bash

# Inside the container:
apt-get update && apt-get install -y curl \
  && bash <(curl -sS https://raw.githubusercontent.com/lucasvienna/dotfiles/master/install) \
  && zsh -c ". ~/.config/zsh/.zprofile && . ~/.config/zsh/.zshrc; zsh -i"
```

## Themes

Switch between included themes with a single command:

```bash
# List available themes
dot-theme-set --list

# Set a specific theme
dot-theme-set tokyonight-moon

# Random theme
dot-theme-set
```

Themes update automatically across Neovim, tmux, fzf, btop, Ghostty, and gitui.

### Included Themes

- **Tokyonight Moon**: High contrast, excellent for recordings
- **Gruvbox Dark**: Warm colors, easy on the eyes
- **Dracula Pro**: Modern dark theme with vibrant accents

Add your own themes by creating a new directory in `themes/` with configs for
each app.

## Maintenance

Once installed, manage your dotfiles with these commands:

```bash
cd "${DOTFILES_PATH}"

# Update everything (packages, configs, plugins)
./install

# Update configs only (skip packages)
./install --skip-system-packages

# Pull latest changes without installing
./install --pull

# Pull and install in one command
./install --update

# Compare your config with the example
./install --diff-config

# Preview incoming changes
./install --diff

# View available updates
./install --new-commits
```

## Customization

### Method 1: Configuration File (Recommended)

Copy `install-config.example` to `install-config` and customize:

```bash
# Add extra packages
export BREW_PACKAGES_EXTRAS="package1 package2"

# Add programming languages
export MISE_LANGUAGES_EXTRAS["ruby"]="ruby@3.4"

# Pre-fill your git config
export YOUR_NAME="Your Name"
export YOUR_EMAIL="your@email.com"
```

The `install-config` file is git-ignored, so your customizations persist across
updates.

### Method 2: Local Overrides

These files are sourced but never tracked:

- `.config/zsh/.zshrc.local` - Shell customizations
- `.config/zsh/.aliases.local` - Custom aliases
- `.config/git/config.local` - Git configuration

### Method 3: Fork & Branch

For major customizations:

```bash
git checkout -b my-customizations
# Make your changes
git commit -am "Personalize setup"

# Merge upstream updates
git pull origin main
git rebase main
```

## WSL 2 Notes

The install script automatically:

- Configures `/etc/wsl.conf` for optimal performance
- Copies `.wslconfig` to your Windows user directory
- Sets up clipboard sharing via WSLg

After installation, restart WSL from PowerShell:

```powershell
wsl --shutdown
```

Note: Systemd is intentionally disabled to avoid the 10-15 second startup delay.

## Project Structure

```
.config/           # Application configurations
├── nvim/          # Neovim (LazyVim)
├── tmux/          # Tmux with TPM
├── zsh/           # Zsh with Oh-My-Zsh
├── git/           # Git with delta, signing
├── ghostty/       # Terminal emulator
├── fzf/           # Fuzzy finder
└── btop/          # System monitor

.local/bin/        # Custom scripts
├── dot-theme-set  # Theme switcher
├── clip-copy      # Cross-platform clipboard
├── clip-paste     # Clipboard utilities
└── mkscript       # Script generator

themes/            # System-wide themes
install            # Main installation script
install-config     # Your customizations (git-ignored)
```

## Requirements

- **Zsh** 5.0+
- **Tmux** 3.1+
- **Neovim** 0.11+
- **Git** 2.0+

The install script handles all dependencies automatically.

## Documentation

For detailed information about the architecture, customization options, and
troubleshooting, check out [CLAUDE.md](./CLAUDE.md).

## License

MIT - Feel free to use any part of this configuration.

## Author

**Lucas Vienna** Developer & DevOps Engineer

These dotfiles power my daily development workflow across multiple machines and
environments. They're battle-tested through years of professional development
work.

Questions? Issues? Feel free to open an issue or submit a PR.

## Acknowledgments

This repository is a fork of
[Nick Janetakis' dotfiles](https://github.com/nickjj/dotfiles). Huge thanks to
Nick for creating such a comprehensive and well-documented foundation that made
this setup possible. His original work includes excellent blog posts and videos
about the various configurations if you want to dive deeper into the
implementation details.

