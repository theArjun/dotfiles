# Get the current pwd and store it to variable cwd
cwd=$(pwd)
parent_dir=$(dirname $(pwd))

# Symlink this repo files to the configuration dotfiles.
ln -sf ${cwd}/zshrc ~/.zshrc
ln -sf ${cwd}/ideavimrc ~/.ideavimrc
ln -sf ${cwd}/gitconfig ~/.gitconfig
ln -sf ${cwd}/tmux.conf ~/.tmux.conf
ln -sf ${cwd}/zsh_aliases.zsh ~/.zsh_aliases.zsh
ln -sf ${cwd}/zsh_functions.zsh ~/.zsh_functions.zsh
ln -sf ${cwd}/git_aliases.zsh ~/.git_aliases.zsh
ln -sf ${cwd}/powerline_theme.sh ~/.tmux/plugins/tmux-powerline/themes/custom.sh

# Check if .config directory exists in $HOME
# If not, create it and symlink the config files
# for alacritty
if [ ! -d "$HOME/.config" ]; then
  mkdir $HOME/.config
fi
# Also check if alacritty directory exists in .config
# If not, create it and symlink the config files
if [ ! -d "$HOME/.config/alacritty" ]; then
  mkdir $HOME/.config/alacritty
fi
ln -sf ${cwd}/config/alacritty/alacritty.toml $HOME/.config/alacritty/alacritty.toml

# Also check if lazygit directory exists in .config
# If not, create it and symlink the config files
if [ ! -d "$HOME/.config/lazygit" ]; then
  mkdir $HOME/.config/lazygit
fi
ln -sf ${cwd}/config/lazygit/config.yml $HOME/.config/lazygit/config.yml

# Move scripts directory content inside .config and symlink
# the scripts
if [ ! -d "$HOME/.config/scripts" ]; then
  mkdir $HOME/.config/scripts
fi
ln -sf ${cwd}/*.sh $HOME/.config/scripts

# Move nvim
ln -sf ${parent_dir}/my-nvim-config ~/.config/nvim
# Move tmuxinator
ln -sf ${cwd}/tmuxinator ~/.config/tmuxinator

# Add custom segements in tmux powerline
mkdir -p ~/.config/tmux-powerline/segments
ln -sf ${cwd}/scripts/nepali_date.sh ~/.config/tmux-powerline/segments/
ln -sf ${cwd}/scripts/nepse.sh ~/.config/tmux-powerline/segments/
