#!/bin/bash

# Get the current working directory and its parent directory
cwd=$(pwd)
parent_dir=$(dirname "$cwd")

ln -sf ${cwd}/zshrc ~/.zshrc
ln -sf ${cwd}/ideavimrc ~/.ideavimrc
ln -sf ${cwd}/gitconfig ~/.gitconfig
ln -sf ${cwd}/tmux.conf ~/.tmux.conf
ln -sf ${cwd}/zsh_aliases.zsh ~/.zsh_aliases.zsh
ln -sf ${cwd}/zsh_functions.zsh ~/.zsh_functions.zsh

# Ensure ~/.config directory exists
mkdir -p "$HOME/.config"

# Symlink Alacritty config
mkdir -p "$HOME/.config/alacritty"
ln -sf "${cwd}/config/alacritty/alacritty.toml" "$HOME/.config/alacritty/alacritty.toml"

# Symlink Lazygit config
mkdir -p "$HOME/.config/lazygit"
ln -sf "${cwd}/config/lazygit/config.yml" "$HOME/.config/lazygit/config.yml"

# Symlink starship config
ln -sf "${cwd}/config/starship.toml" "$HOME/.config/starship.toml"

# Symlink scripts directory
mkdir -p "$HOME/.config/scripts"
ln -sf "${cwd}/*.sh" "$HOME/.config/scripts"

# Symlink secrets directory if it exists
if [ -d "$cwd/secrets" ]; then
    ln -sf "${cwd}/secrets" "$HOME/.secrets"
fi

# Symlink Neovim and Tmuxinator configurations
ln -sf "${parent_dir}/my-nvim-config" "$HOME/.config/nvim"
ln -sf "${cwd}/tmuxinator" "$HOME/.config/tmuxinator"
