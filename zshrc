export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/sbin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/System/Cryptexes/App/usr/bin:$PATH"
export PATH="/usr/bin:$PATH"
export PATH="/bin:$PATH"
export PATH="/usr/sbin:$PATH"
export PATH="/sbin:$PATH"
export PATH="/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/local/bin:$PATH"
export PATH="/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/bin:$PATH"
export PATH="/var/run/com.apple.security.cryptexd/codex.system/bootstrap/usr/appleinternal/bin:$PATH"
export PATH="$HOME/executables:$PATH"
export PATH="$HOME/Library/Android/sdk/emulator:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="$HOME/tools/flutter/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.atuin/bin:$PATH"
export PATH="/opt/homebrew/opt/postgresql@16/bin:$PATH"
export PATH="/opt/homebrew/opt/libxslt/bin:$PATH"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export GOPATH="$HOME/go"
export PATH="$GOPATH/bin:$PATH"

# For compilers to find openjdk you may need to set:
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@16/lib"
export CPPFLAGS="-I/opt/homebrew/opt/postgresql@16/include"


# command for zsh-completions
source ~/.zsh_plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh
# Aliases
source ~/.zsh_aliases.zsh
# Git aliases
source ~/.git_aliases.zsh
# Functions
source ~/.zsh_functions.zsh

# Environment Variables
export EDITOR="nvim"

# Config
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Plugins
plugins=(
 git
 zsh-syntax-highlighting
 zsh-autosuggestions
 zsh-completions
 virtualenv
 direnv
)

# There can be .secrets dir and envvars.zsh file in the .secrets dir.
# If there is, source it.
if [ -d "$HOME/.secrets" ]; then
	if [ -f "$HOME/.secrets/envvars.zsh" ]; then
		source "$HOME/.secrets/envvars.zsh"
	fi
fi


# FZF
# Enable preview window with bat (syntax highlighting)
export FZF_PREVIEW_COMMAND='[[ $(file --mime {}) =~ binary ]] && echo {} || bat --style=numbers,changes --color=always {} 2> /dev/null | sed "s/\[[0-9;]*m//g"'
# FZF options
export FZF_DEFAULT_OPTS='
--layout=reverse
--inline-info
--height=80%
--border
--ansi
--prompt="> "'
# Use ripgrep as the default source for files
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git" 2>/dev/null'
# Use ripgrep for fuzzy searching within files
export FZF_ALT_C_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git" 2>/dev/null'

# Rust
export RUST_BACKTRACE=1

# Pipenv
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath="$HOME/.docker/completions $fpath"
autoload -Uz compinit
compinit
# End of Docker CLI completions

# Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Starship
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"


