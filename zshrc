# Auto-start tmux
if command -v tmux &>/dev/null && [ -z "$TMUX" ] && [[ $- == *i* ]] && [ -t 0 ]; then
    tmux attach-session -t default 2>/dev/null || tmux new-session -s default
fi

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


# Aliases
source ~/.zsh_aliases.zsh
# Functions
source ~/.zsh_functions.zsh

# Environment Variables
export EDITOR="nvim"

# Config
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Load zsh modules needed for completion
zmodload zsh/complist
zmodload zsh/parameter
zmodload zsh/zleparameter
autoload -Uz compinit is-at-least add-zle-hook-widget zmathfunc

# Autoload additional zsh completion functions needed by zsh-autocomplete
autoload -Uz _main_complete _complete _approximate
autoload -Uz chpwd_recent_dirs chpwd_recent_filehandler

# Set up fpath for completions (must be before compinit)
fpath=("$HOME/.zsh_plugins/zsh-autocomplete" $fpath)
fpath=(/opt/homebrew/share/zsh/site-functions $fpath)
fpath=(/opt/homebrew/share/zsh-completions $fpath)
fpath=("$HOME/.docker/completions" $fpath)

# Only rebuild zcompdump once per day
if [ "$(date +%j)" != "$(/usr/bin/stat -f %Sm -t %j ~/.zcompdump 2>/dev/null)" ]; then
  rm -f ~/.zcompdump*(N)
  compinit -i
else
  compinit -i -C
fi

# Source zsh-syntax-highlighting (must be before autosuggestions)
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Source zsh-autosuggestions BEFORE Atuin to allow proper key binding override
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
  # Configure autosuggestions to work nicely with Atuin
  export ZSH_AUTOSUGGEST_STRATEGY=(history completion atuin)
fi

# Source zsh-autocomplete after compinit ONLY if it exists
if [ -d "$HOME/.zsh_plugins/zsh-autocomplete" ]; then
  if [[ -z "$functions[compdef]" ]]; then
    autoload -Uz compdef
  fi
  
  # Ensure add-zle-hook-widget function is loaded
  if [[ -z "$functions[add-zle-hook-widget]" ]]; then
    autoload -Uz add-zle-hook-widget
  fi
  
  # Ensure zmathfunc is loaded
  if [[ -z "$functions[zmathfunc]" ]]; then
    autoload -Uz zmathfunc
  fi
  
  source "$HOME/.zsh_plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
fi

# History substring search keeps Up/Down focused on the current command prefix.
if [ -f /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh ]; then
  source /opt/homebrew/share/zsh-history-substring-search/zsh-history-substring-search.zsh
  bindkey '^[[A' history-substring-search-up
  bindkey '^[[B' history-substring-search-down
  bindkey '^[OA' history-substring-search-up
  bindkey '^[OB' history-substring-search-down
fi

# Remind when a shorter alias exists for a command typed manually.
if [ -f /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh ]; then
  export YSU_MESSAGE_POSITION="after"
  source /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh
fi

# Plugins
plugins=(
 git
 zsh-syntax-highlighting
 zsh-autosuggestions
 zsh-completions
 virtualenv
 direnv
)

# AWS CLI Completion with descriptions
if command -v aws_completer &>/dev/null; then
  complete -C "$(which aws_completer)" aws
elif [ -f /opt/homebrew/bin/aws_completer ]; then
  complete -C /opt/homebrew/bin/aws_completer aws
elif [ -f ~/.local/bin/aws_completer ]; then
  complete -C ~/.local/bin/aws_completer aws
fi

# Enable completion descriptions (list-grouped-by-tags style)
zstyle ':completion:*' format '%B%F{blue}--- %d ---%f%b'
zstyle ':completion:*:descriptions' format '%B%F{green}%d%f%b'
zstyle ':completion:*' group-name ''

# UV (Python package manager) Completion
if command -v uv &>/dev/null; then
  eval "$(uv generate-shell-completion zsh)"
fi

# Python (pip) Completion
if command -v register-python-argcomplete &>/dev/null; then
  eval "$(register-python-argcomplete pip)"
  eval "$(register-python-argcomplete pip3)"
fi

# Poetry Completion
if command -v poetry &>/dev/null; then
  fpath+=($HOME/.zfunc)
  mkdir -p $HOME/.zfunc
  poetry completions zsh > $HOME/.zfunc/_poetry 2>/dev/null
fi

# pipx Completion
if command -v pipx &>/dev/null; then
  eval "$(register-python-argcomplete pipx)"
fi

# Cargo/Rust Completion
if command -v cargo &>/dev/null; then
  fpath+=($HOME/.cargo/completion)
fi

# Docker Completion (if not already in fpath)
if command -v docker &>/dev/null; then
  fpath+=(/opt/homebrew/share/docker/completion)
fi

# Git Completion (enhanced)
if command -v git &>/dev/null; then
  fpath+=(/opt/homebrew/share/zsh/site-functions)
fi

# Completion styling with descriptions
zstyle ':completion:*' list-grouped
zstyle ':completion:*' list-colors '=(#b) #([0-9]#)*=36=31'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,%cpu,cmd'
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=* l:|=*'

# SSH Completion - Parse ~/.ssh/config for hostname suggestions
if [ -f ~/.ssh/config ]; then
  _ssh_hosts=($(grep -E "^Host\s" ~/.ssh/config | grep -v "\*" | awk '{print $2}'))
  if [[ -n $_ssh_hosts ]]; then
    compdef _ssh_hosts_completion ssh scp sftp
  fi
  _ssh_hosts_completion() {
    compadd "$@" "${_ssh_hosts[@]}"
  }
fi

# There can be .secrets dir and envvars.zsh file in the .secrets dir.
# If there is, source it.
if [ -d "$HOME/.secrets" ]; then
	if [ -f "$HOME/.secrets/envvars.zsh" ]; then
		source "$HOME/.secrets/envvars.zsh"
	fi
fi


# FZF
# Enable fzf key bindings and completion if installed.
if [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
fi
if [ -f /opt/homebrew/opt/fzf/shell/completion.zsh ]; then
  source /opt/homebrew/opt/fzf/shell/completion.zsh
fi

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


# Atuin
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"

# Starship
eval "$(starship init zsh)"
eval "$(direnv hook zsh)"
eval "$(zoxide init zsh)"
# Added by Antigravity
export PATH="/Users/arjun/.antigravity/antigravity/bin:$PATH"
