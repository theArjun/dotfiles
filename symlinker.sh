#!/bin/bash

# Get the current working directory and its parent directory
cwd=$(pwd)
parent_dir=$(dirname "$cwd")

link() {
    ln -sf "$1" "$2"
    echo "  $1 -> $2"
}

echo "Symlinking dotfiles..."

link "${cwd}/zshrc" ~/.zshrc
link "${cwd}/ideavimrc" ~/.ideavimrc
link "${cwd}/gitconfig" ~/.gitconfig
link "${cwd}/tmux.conf" ~/.tmux.conf
link "${cwd}/zsh_aliases.zsh" ~/.zsh_aliases.zsh
link "${cwd}/zsh_functions.zsh" ~/.zsh_functions.zsh

# Ensure ~/.config directory exists
mkdir -p "$HOME/.config"

echo "Symlinking configs..."

# Symlink Alacritty config
mkdir -p "$HOME/.config/alacritty"
link "${cwd}/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

# Symlink Lazygit config
mkdir -p "$HOME/.config/lazygit"
link "${cwd}/config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# Symlink Ghostty config
mkdir -p "$HOME/Library/Application Support/com.mitchellh.ghostty"
link "${cwd}/config/ghostty/config" "$HOME/Library/Application Support/com.mitchellh.ghostty/config"

# Symlink gh-dash config
mkdir -p "$HOME/.config/gh-dash"
link "${cwd}/config/gh-dash/config.yml" "$HOME/.config/gh-dash/config.yml"

# Symlink starship config
link "${cwd}/config/starship.toml" "$HOME/.config/starship.toml"

# Symlink scripts directory
mkdir -p "$HOME/.config/arjun-dotfiles"
link "${cwd}/scripts" "$HOME/.config/arjun-dotfiles/scripts"

# Symlink secrets directory if it exists
if [ -d "$cwd/secrets" ]; then
    link "${cwd}/secrets" "$HOME/.secrets"
fi

# Symlink Neovim and Tmuxinator configurations
link "${parent_dir}/my-nvim-config" "$HOME/.config/nvim"
link "${cwd}/tmuxinator" "$HOME/.config/tmuxinator"

echo "Done!"
