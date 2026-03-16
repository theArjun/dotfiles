# 🎯 Dotfiles Repository

A comprehensive dotfiles configuration repository for macOS development environments. This repo contains configurations for shell, terminal emulators, text editors, tmux, and various development tools, with a focus on productivity and developer experience.

## 📋 Table of Contents

- [Quick Start](#quick-start)
- [Repository Structure](#repository-structure)
- [Installation](#installation)
- [Configuration Details](#configuration-details)
- [Custom Functions & Aliases](#custom-functions--aliases)
- [Scripts](#scripts)
- [Tools & Dependencies](#tools--dependencies)
- [Updating](#updating)
- [Contributing](#contributing)

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/thearjun/dotfiles.git
cd dotfiles

# Run the symlinker to set up all configurations
./symlinker.sh

# Install all dependencies
brew bundle

# Reload shell
exec zsh
```

## 📁 Repository Structure

```
dotfiles/
├── config/
│   ├── alacritty/          # Alacritty terminal emulator config
│   ├── ghostty/            # Ghostty terminal emulator config
│   ├── lazygit/            # Lazygit git UI config
│   └── starship.toml       # Starship prompt config
├── scripts/
│   ├── start_tmux.sh       # Auto-start tmux on shell launch
│   ├── tmux_sessionizer.sh # Create/navigate tmux sessions
│   ├── nepali_date.sh      # Display current Nepali date
│   └── nepse.sh            # Fetch Nepal Stock Exchange data
├── tmuxinator/
│   ├── README.md           # Tmuxinator project templates guide
│   └── *.yml               # Project-specific session configs
├── Brewfile                # Homebrew dependencies
├── zshrc                   # Zsh shell configuration
├── zsh_aliases.zsh         # Custom shell aliases
├── zsh_functions.zsh       # Custom shell functions
├── tmux.conf               # Tmux configuration
├── gitconfig               # Git global configuration
├── ideavimrc               # IdeaVim plugin config for JetBrains IDEs
├── symlinker.sh            # Installation script
└── author.sh               # Script for git author setup
```

## 🔧 Installation

### Prerequisites

- macOS (Monterey or later)
- Homebrew installed
- Git configured

### Step 1: Clone Repository

```bash
git clone https://github.com/thearjun/dotfiles.git ~/workspace/misc/dotfiles
cd ~/workspace/misc/dotfiles
```

### Step 2: Run Symlinker

The symlinker creates symbolic links from the dotfiles to their expected locations:

```bash
./symlinker.sh
```

This will set up:
- `~/.zshrc` → Shell configuration
- `~/.config/alacritty/alacritty.toml` → Alacritty config
- `~/.config/lazygit/config.yml` → Lazygit config
- `~Library/Application Support/com.mitchellh.ghostty/config` → Ghostty config
- `~/.config/starship.toml` → Starship prompt config
- `~/.config/tmuxinator/` → Tmuxinator templates
- `~/.tmux.conf` → Tmux configuration
- `~/.gitconfig` → Git configuration
- `~/.ideavimrc` → IdeaVim configuration
- `~/.zsh_aliases.zsh` → Aliases
- `~/.zsh_functions.zsh` → Custom functions
- `~/.secrets/` → Secrets directory (if present)

### Step 3: Install Dependencies

Install all tools and languages defined in the Brewfile:

```bash
brew bundle
```

This installs:
- **Languages**: Node.js, Python 3.11, Rust, Go, Dart, Java
- **Development Tools**: neovim, git-delta, lazygit, fzf, ripgrep, bat
- **Shell Tools**: zoxide, direnv, starship, tmux, zsh
- **Utilities**: httpie, htop, duf, eza, tldr, tree
- **Databases**: PostgreSQL 14, Redis
- **And many more...**

### Step 4: Setup Secrets (Optional)

If you have sensitive environment variables:

```bash
./secrets/envvars.zsh
```

## 📝 Configuration Details

### Shell Configuration (Zsh)

**zshrc** - Main shell configuration file:
- Auto-starts tmux on terminal launch
- Sets up comprehensive PATH for all development tools
- Sources aliases and functions
- Configures shell history and completion

**zsh_aliases.zsh** - Custom command shortcuts for common tasks

**zsh_functions.zsh** - Utility functions for development workflows

### Terminal Emulators

#### Alacritty
GPU-accelerated terminal emulator with Catppuccin Mocha color scheme.
- Located: `config/alacritty/alacritty.toml`
- Symlinked to: `~/.config/alacritty/alacritty.toml`

#### Ghostty
Modern terminal emulator with improved performance.
- Located: `config/ghostty/config`
- Symlinked to: `~/Library/Application Support/com.mitchellh.ghostty/config`
- Features:
  - Font: 0xProto Nerd Font (18pt)
  - Catppuccin Mocha color scheme
  - Auto-tmux startup
  - Custom keybindings:
    - `Ctrl+Shift+F` - Toggle fullscreen
    - `Ctrl++` - Increase font size
    - `Ctrl+-` - Decrease font size
    - `Ctrl+Shift+T` - New window

### Tmux Configuration

**tmux.conf** - Tmux session and window management:
- Low-latency key handling and deep scrollback
- Vim-aware pane navigation
- Fast pane/window/session movement
- Popup-driven git workflows
- Automatic session restore with Continuum/Resurrect
- Catppuccin status bar with current branch context

#### Tmux Shortcuts

> Prefix is `Ctrl+Space`

##### Panes

| Shortcut | Action |
|---|---|
| `Prefix + \|` | Split pane horizontally |
| `Prefix + -` | Split pane vertically |
| `Ctrl+h/j/k/l` | Navigate panes (vim-aware) |
| `Prefix + h/j/k/l` | Resize pane |
| `Prefix + H/J/K/L` | Swap pane position |
| `Prefix + z` | Toggle pane zoom |
| `Prefix + m` | Toggle synchronized panes |
| `Prefix + Tab` | Jump to last pane |
| `Prefix + Space` | Cycle pane layouts |

##### Windows

| Shortcut | Action |
|---|---|
| `Prefix + c` | New window |
| `Prefix + n / p` | Next / previous window |
| `Prefix + Enter` | Jump to last window |
| `Prefix + w` | Window tree / chooser |
| `Prefix + ,` | Rename window |
| `Prefix + R` | Renumber windows |

##### Sessions & Popups

| Shortcut | Action |
|---|---|
| `Prefix + s` | Session tree / chooser |
| `Prefix + S` | Rename session |
| `Prefix + g` | LazyGit popup |
| `Prefix + b` | Git branch switcher (fzf) |
| `Prefix + P` | GitHub PR list/checkout (fzf) |
| `Prefix + I` | GitHub issue list + create branch (fzf) |
| `Prefix + t` | `tmux-sessionx` popup for sessions, windows, zoxide, tmuxinator |

##### Misc

| Shortcut | Action |
|---|---|
| `Prefix + r` | Reload tmux config |
| `v` (copy mode) | Begin selection |
| `y` (copy mode) | Copy to clipboard |

#### Tmux Productivity Defaults

- `escape-time` set to `0` for snappier prefix and Vim transitions
- `history-limit` increased to `100000` for long terminal scrollback
- `focus-events` enabled so modern terminals/editors react correctly
- Windows renumber automatically after close
- Pane/session state auto-saves every 15 minutes and restores on restart

**tmuxinator/** - Pre-configured project session templates:
- `soudan.yml` - Backend development setup
- Additional project configs can be added

See [tmuxinator/README.md](tmuxinator/README.md) for usage instructions.

### Prompt (Starship)

**config/starship.toml** - Fast, minimal, and infinitely customizable prompt:
- Git status indicators
- Command execution time
- Language version indicators
- Clean, modern aesthetic

### Version Control (Git)

**gitconfig** - Global Git configuration:
- Custom aliases and settings
- GPG signing setup (if configured)
- Color output and UI improvements

### IDE Configuration

**ideavimrc** - IdeaVim plugin configuration for JetBrains IDEs:
- Vim keybindings in IntelliJ, PyCharm, WebStorm, etc.
- Custom maps and settings
- Plugins configuration

### Lazygit

**config/lazygit/config.yml** - Git UI client configuration:
- Keybinding customizations
- Display preferences
- Integration with git workflows

## 🛠️ Custom Functions & Aliases

### Python Development

```bash
pips <package>      # Install package and add to requirements.txt
pipdev <package>    # Install package and add to requirements-dev.txt
format <file>       # Run black, isort, and flake8 on file
pyclear             # Remove all __pycache__ directories
checkv <package>    # Check Python package version against PyPI
```

### Git Workflows

```bash
pr                  # List PRs with fzf preview and checkout
br                  # Browse recent branches with git diff preview
gitignore           # Generate .gitignore from toptal.com/developers/gitignore
syncall             # Commit and push all changes with timestamp
```

### Git Aliases

Common git shortcuts defined in `gitconfig`:
- `st` - status
- `co` - checkout
- `br` - branch
- `ci` - commit
- `log-oneline` - Pretty one-line log
- And more...

## 📜 Scripts

### start_tmux.sh
Auto-starts tmux when opening a new terminal session:
- Attaches to default session if it exists
- Creates new default session if not
- Only runs in interactive shells

**Usage**: Automatically invoked via `zshrc` on shell startup

### nepali_date.sh
Display current date in Nepali calendar format.

### nepse.sh
Fetch Nepal Stock Exchange (NEPSE) data and indices.

## 📦 Tools & Dependencies

The Brewfile installs ~70+ tools and utilities. Key categories:

### Development Environments
- **Node.js** - JavaScript runtime
- **Python 3.11** - Python interpreter
- **Rust** - Systems programming
- **Go** - Go language
- **Java** (OpenJDK 17) - Java development
- **Dart** - Dart language

### Text Editors & IDEs
- **Neovim** - Modern Vim-based editor
- **JetBrains Toolbox** - IntelliJ, PyCharm, etc.
- **VS Code** - With Python, Remote SSH, Copilot extensions

### Development Tools
- **Git** with delta (diff viewer), lazygit (UI)
- **fzf** - Fuzzy finder
- **ripgrep** - Fast search
- **bat** - Cat with syntax highlighting
- **tmux** - Terminal multiplexer
- **tmuxinator** - tmux session manager

### Databases & Services
- **PostgreSQL 14** - SQL database
- **Redis** - In-memory data store
- **Ngrok** - Tunneling service

### Utilities
- **starship** - Prompt
- **zoxide** - Smart directory jumper
- **direnv** - Environment loader
- **htop** - System monitor
- **duf** - Disk usage
- **eza** - Modern ls replacement
- **tldr** - Command documentation

## 🔄 Updating

### Update All Homebrew Packages

```bash
brew update
brew upgrade
brew bundle
```

### Update Dotfiles from GitHub

```bash
cd ~/workspace/misc/dotfiles
git pull origin main
./symlinker.sh  # Re-run if new configs added
```

### Update Individual Components

```bash
# Update shell config
source ~/.zshrc

# Update git config
git config --global -l

# Update tmux config
tmux source ~/.tmux.conf
```

## 🚨 Troubleshooting

### Symlinks not working
- Ensure you're in the dotfiles directory
- Run `./symlinker.sh` again
- Check that target directories exist

### Shell changes not taking effect
```bash
# Force reload zshrc
exec zsh
```

### Tmux issues
```bash
# Kill all tmux sessions
tmux kill-server

# Start fresh
tmux new-session -s default
```

### Git config conflicts
```bash
# View current config
git config --global -l

# Set author
git config --global user.name "Your Name"
git config --global user.email "your@email.com"
```

## 📚 Resources

- [Zsh Documentation](https://www.zsh.org/)
- [Tmux Documentation](https://github.com/tmux/tmux/wiki)
- [Neovim Documentation](https://neovim.io/doc/user/)
- [Starship Prompt](https://starship.rs/)
- [Ghostty](https://ghostty.org/)
- [Lazygit](https://github.com/jesseduffield/lazygit)
- [Tmuxinator](https://github.com/tmuxinator/tmuxinator)

## 📄 License

These dotfiles are personal configurations. Feel free to fork and customize for your own use.

## 🤝 Contributing

This is a personal dotfiles repository, but feel free to:
- Fork it for your own use
- Submit issues or suggestions
- Create pull requests with improvements

---

**Last Updated**: 2026-03-04

For questions or suggestions, please open an issue or contact the maintainer.
