# Lucas Vienna's Dotfiles

<!--toc:start-->

- [Lucas Vienna's Dotfiles](#lucas-viennas-dotfiles)
  - [Quick start](#quick-start)
    - [Prerequisites](#prerequisites)
    - [Re-running the installer](#re-running-the-installer)
    - [Try it first (Docker)](#try-it-first-docker)
  - [What's included](#whats-included)
  - [Themes](#themes)
    - [Included themes](#included-themes)
    - [Licensed themes](#licensed-themes)
  - [Maintenance](#maintenance)
  - [Customization](#customization)
    - [Method 1: install-config (recommended)](#method-1-install-config-recommended)
    - [Method 2: local overrides](#method-2-local-overrides)
    - [Method 3: fork and branch](#method-3-fork-and-branch)
  - [WSL 2 notes](#wsl-2-notes)
  - [Project structure](#project-structure)
  - [Documentation](#documentation)
  - [License](#license)
  - [Author](#author)
  - [Acknowledgments](#acknowledgments)
  <!--toc:end-->

One script that takes a fresh macOS, Debian, Ubuntu, Arch (including CachyOS)
or WSL 2 machine and sets up zsh, tmux, Neovim, a set of CLI tools and a
system-wide theme.

## Quick start

```bash
bash <(curl -fsSL https://raw.githubusercontent.com/lucasvienna/dotfiles/main/bootstrap)
```

`bootstrap` is the only thing you run by hand. It is idempotent and does, in
order:

1. Detects the OS (macOS, Debian, Ubuntu, Arch, WSL 2).
2. Installs what the installer itself needs. On macOS that is Homebrew and a
   current Bash, since the system Bash is 3.2. On Linux it is sudo, git, less
   and nano.
3. Asks where to clone the repo (default `~/dotfiles`), clones it, and copies
   `install-config.example` to `install-config`.
4. Offers to open `install-config` so you can review the package lists before
   anything else gets installed.
5. Hands off to `./install`.

`./install` moves any existing config aside as `<name>.bak` before symlinking
over it. Nothing is deleted and an existing backup is never overwritten.

### Prerequisites

`curl`. macOS and Arch ship it. Minimal Debian and Ubuntu images do not:

```bash
apt-get update && apt-get install -y curl
```

### Re-running the installer

Once the repo is cloned you never need `bootstrap` again:

```bash
cd ~/dotfiles
./install                          # full install
./install --skip-system-packages   # everything except package installs
./install --symlinks               # only re-stow symlinks, then healthcheck
./install --help                   # all flags
```

### Try it first (Docker)

Run the installer against a throwaway container, from a checkout of this repo:

```bash
docker container run --rm -it -e "IN_CONTAINER=1" -v "${PWD}:/app" -w /app debian:stable-slim bash

# Inside the container:
apt-get update && apt-get install -y curl \
  && ./bootstrap --local \
  && zsh -c ". ~/.config/zsh/.zprofile && . ~/.config/zsh/.zshrc; zsh -i"
```

`--local` copies the mounted checkout into the dotfiles path instead of
cloning from GitHub, so uncommitted changes get tested too. It only works from
a checkout, not through the curl one-liner.

## What's included

- Zsh with Oh-My-Zsh, starship, fzf-tab, autosuggestions and syntax
  highlighting.
- Tmux with TPM.
- Neovim on LazyVim, with LSP configured.
- CLI tools: ripgrep, fd, fzf, btop, bottom, lazygit, delta, gh, ghq, zoxide,
  yq, jq and more. The full lists live in `_install/packages/`.
- Language runtimes through Mise: Node, Deno, Go and Python by default, plus
  pnpm and aube. See `_install/mise_languages`.
- SSH and GPG key generation, and Git commit signing.
- One command to switch the theme of every app at once.

Tools come from whichever package manager keeps up on that platform. Debian
gets core packages from APT and the CLI tools from Mise, because APT lags.
macOS uses Homebrew. Arch uses pacman plus the AUR and has no Mise tool layer,
since the repos are already current.

## Themes

```bash
dot-theme-set --list             # list themes
dot-theme-set tokyonight-moon    # set one
dot-theme-set                    # pick a random one
```

One run updates Neovim, tmux, fzf, btop, bottom, Alacritty, Ghostty and gitui.
Alacritty repaints on its own because it imports the theme file and has
`live_config_reload` on. btop and Ghostty reload on a signal. `btm` has no
reload mechanism, so `dot-theme-set` tells you to restart it when one is
running.

### Included themes

- **Kanagawa Wave**: Ink-blue base, warm off-white text, muted but distinct hues
- **Tokyonight Night**: Darkest tokyonight variant, highest contrast
- **Tokyonight Moon**: Slightly lighter tokyonight, excellent for recordings
- **Catppuccin Mocha**: Darkest catppuccin flavour
- **Catppuccin Macchiato**: Soft pastels on a medium-dark base
- **Dracula Pro**: Modern dark theme with vibrant accents — *licensed, fetched
  on demand*

### Licensed themes

Dracula PRO is paid, so its colours are not in this repo. `themes/dracula-pro/`
is git-ignored and rendered on demand from the templates in
`_themes/dracula-pro/`, which hold structure but no colours:

```bash
dot-theme-fetch              # render dracula-pro
dot-theme-fetch --list       # what can be fetched
dot-theme-set dracula-pro    # then apply it
```

This needs membership of the `dracula-pro` GitHub org and an authenticated
`gh`. Colours come from that org's `palette` repo. The alacritty and ghostty
themes are fetched verbatim from the org rather than templated, since the
official files carry more detail. Applying the theme before fetching it makes
`dot-theme-set` point you at `dot-theme-fetch`.

## Maintenance

```bash
cd "${DOTFILES_PATH}"

./install                    # update everything (packages, configs, plugins)
./install --skip-system-packages
./install --pull             # pull latest changes without installing
./install --update           # pull, then install

./install --diff-config      # your install-config vs install-config.example
./install --diff             # local changes vs origin
./install --new-commits      # commits on origin you don't have yet
./install --changelog        # commit list on origin
./install --local-files      # browse every git-ignored config and local script

./install --debug            # environment and system info for bug reports
```

## Customization

### Method 1: install-config (recommended)

`bootstrap` copies `install-config.example` to `install-config` for you. The
file is git-ignored, so edits survive updates:

```bash
# Add packages (per platform)
export BREW_PACKAGES_EXTRAS="package1 package2"
export APT_PACKAGES_EXTRAS="package1 package2"
export PACMAN_PACKAGES_EXTRAS="package1 package2"
export AUR_PACKAGES_EXTRAS="package1 package2"

# Arch only: pin an AUR helper. Empty auto-detects paru, then yay, then
# shelly, and builds paru from the AUR if none are installed.
export AUR_HELPER="shelly"

# Add language runtimes
export MISE_LANGUAGES_EXTRAS["ruby"]="ruby@3.4"

# Pre-fill your git config
export YOUR_NAME="Your Name"
export YOUR_EMAIL="your@email.com"
```

### Method 2: local overrides

Each main config sources a git-ignored `.local` sibling. The files live in the
repo and are stowed like everything else, so `~/.config/zsh/.zshrc.local` is a
symlink back into `${DOTFILES_PATH}`:

- `.config/zsh/.zprofile.local`, environment for every shell (PATH, exports)
- `.config/zsh/.zshrc.local`, interactive shell additions
- `.config/zsh/.aliases.local`, aliases
- `.config/git/config.local`, git user, signing key
- `.config/ghostty/config.local`, per-machine Ghostty settings
- `.config/alacritty/local.toml`, per-machine font, size and window title
- `.local/bin/local/`, scripts that stay on this machine. It is on `PATH`.

### Method 3: fork and branch

```bash
git checkout -b my-customizations
# make changes
git commit -am "Personalize setup"

# later, pull upstream updates
git pull origin main
git rebase main
```

## WSL 2 notes

On WSL the installer also:

- Symlinks `etc/wsl.conf` to `/etc/wsl.conf`. It enables systemd and mounts
  Windows drives with `metadata`, so Linux permissions work on `/mnt/c`.
- Copies `wsl/.wslconfig` to your Windows user directory. It caps the VM at
  16 GB of memory.
- Downloads and unzips the Nerd Font, then prints the steps to install it
  through Explorer. Windows renders the terminal font, and the installer
  cannot write to the Windows font store.

Both files are read at VM start, so after the first install run this from
PowerShell and reopen your terminal:

```powershell
wsl --shutdown
```

Clipboard sharing needs no setup. WSLg exposes a Wayland display, and
`clip-copy` uses `wl-copy` when it finds one.

## Project structure

```
bootstrap          # first run: installs prerequisites, clones, execs ./install
install            # installer, re-entrant, see ./install --help
install-config     # your overrides (git-ignored, copied from .example)
mas.sh             # macOS App Store apps

_install/          # installer data, kept apart from install's logic
├── env            # shared helpers, OS and AUR helper detection
├── packages/      # per-OS package lists: debian, darwin, arch
├── mise_languages # language runtimes
├── completions    # zsh completion generators
└── symlinks       # stow rules

.config/           # stowed into ~/.config
├── alacritty/     # alacritty.toml imports base + theme + local
├── bottom/        # base.toml, merged with the theme's styles at theme-set time
├── btop/
├── fastfetch/
├── fzf/
├── ghostty/
├── git/           # delta, SSH signing
├── nvim/          # LazyVim
├── starship/
├── tmux/          # TPM
└── zsh/           # Oh-My-Zsh, plus .zshrc.arch on Arch

.local/bin/        # stowed into ~/.local/bin
├── dot-theme-set / dot-theme-fetch   # theme switcher, licensed theme renderer
├── clip-copy / clip-paste            # clipboard across Wayland, X11 and macOS
├── gl / gd / gbd                     # fzf git log, git diff, bulk branch delete
├── ghq-org                           # clone every repo of a GitHub org with ghq
├── dtags                             # list a Docker Hub image's tags
├── rcurl                             # curl with retries and timeouts
├── myip / ppjson / specs / outdated  # small cross-platform utilities
├── mkscript                          # new script from a template
└── update-omz-plugins                # clone or pull the custom zsh plugins

themes/            # one directory per theme, one file per app
_themes/           # templates for licensed themes (structure, no colours)
etc/wsl.conf       # linked to /etc/wsl.conf on WSL
wsl/.wslconfig     # copied to the Windows user directory on WSL
```

## Documentation

[CLAUDE.md](./CLAUDE.md) covers the architecture in detail: install phases,
the theme system, how completions are generated, and the platform quirks the
installer works around.

## License

MIT.

## Author

Lucas Vienna, developer and DevOps engineer. These dotfiles run on every
machine I work on. Issues and PRs are welcome.

## Acknowledgments

This repository is a fork of
[Nick Janetakis' dotfiles](https://github.com/nickjj/dotfiles). The install
script's structure and many of the scripts in `.local/bin` are his. His blog
posts and videos walk through the original configuration if you want the
reasoning behind it.
