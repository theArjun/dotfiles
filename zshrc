export GOPATH="$HOME/go"
typeset -U path PATH
path=(
  $HOME/executables
  $HOME/.local/bin
  $HOME/.cargo/bin
  $HOME/.atuin/bin
  $GOPATH/bin
  $HOME/tools/flutter/bin
  $HOME/Library/Android/sdk/emulator
  /opt/homebrew/opt/openjdk/bin
  /opt/homebrew/opt/postgresql@18/bin
  /opt/homebrew/opt/libxslt/bin
  /opt/homebrew/bin
  /opt/homebrew/sbin
  $path
)

# Compiler flags for openjdk + postgresql so native extensions build.
export CPPFLAGS="-I/opt/homebrew/opt/openjdk/include -I/opt/homebrew/opt/postgresql@18/include"
export LDFLAGS="-L/opt/homebrew/opt/postgresql@18/lib"


# Aliases
source ~/.zsh_aliases.zsh
# Functions
source ~/.zsh_functions.zsh

# Environment Variables
export EDITOR="nvim"

# Config
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE

# Completion
# zsh-autocomplete owns the completion system. It runs compinit for us on the
# first prompt and claims Tab at that same moment, but only if Tab is still on
# expand-or-complete by then. Three rules follow:
#   1. Never call compinit here.
#   2. Never let anything else bind Tab. fzf's completion.zsh and fzf-tab both
#      do, and either one silently leaves us with bare expand-or-complete.
#   3. fpath must be final before the first prompt.
fpath=(
  /opt/homebrew/share/zsh/site-functions
  /opt/homebrew/share/zsh-completions
  /opt/homebrew/share/docker/completion
  $HOME/.docker/completions
  $HOME/.cargo/completion
  $HOME/.zfunc
  $fpath
)

# Colour matches the way ls does, so directories, symlinks and executables are
# told apart in the menu.
if command -v gdircolors &>/dev/null; then
  eval "$(gdircolors -b)"
fi

# Poetry takes about half a second to emit its completion, so build it once.
if command -v poetry &>/dev/null; then
  mkdir -p $HOME/.zfunc
  [ -s $HOME/.zfunc/_poetry ] || poetry completions zsh > $HOME/.zfunc/_poetry 2>/dev/null
fi

# Must come before any compdef call.
if [ -d "$HOME/.zsh_plugins/zsh-autocomplete" ]; then
  source "$HOME/.zsh_plugins/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
fi

# Layered on top of what zsh-autocomplete already sets. Leave menu, group-name
# and the catch-all format style to the plugin: it tunes those as a set.
#
# matcher-list is the one exception. The plugin's default only maps typed
# lowercase onto uppercase, so `ZSH_FU` never finds `zsh_functions.zsh`; this
# maps both directions, and - against _ as well. Keep the plugin's trailing
# `r:|[.]=**` and its ordering, m before r, or matches come out wrong. The
# fuzzy fallback pass reads a different context and is unaffected.
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]-_}={[:upper:][:lower:]_-} r:|[.]=**'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*:descriptions' format '%F{blue}%B%d%b%f'
zstyle ':completion:*:*:*:*:processes' command 'ps -u $USER -o pid,%cpu,cmd'

# AWS CLI
if command -v aws_completer &>/dev/null; then
  complete -C "$(command -v aws_completer)" aws
fi

# UV (Python package manager)
if command -v uv &>/dev/null; then
  eval "$(uv generate-shell-completion zsh)"
fi

# Python (pip, pipx)
if command -v register-python-argcomplete &>/dev/null; then
  eval "$(register-python-argcomplete pip)"
  eval "$(register-python-argcomplete pip3)"
  command -v pipx &>/dev/null && eval "$(register-python-argcomplete pipx)"
fi

# Line editor plugins, in the one order that works: autocomplete (above), then
# syntax highlighting, then autosuggestions.
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  # No `completion` strategy here: it reruns the completion system on every
  # keystroke, which zsh-autocomplete is already doing.
  export ZSH_AUTOSUGGEST_STRATEGY=(history atuin)
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Remind when a shorter alias exists for a command typed manually.
if [ -f /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh ]; then
  export YSU_MESSAGE_POSITION="after"
  source /opt/homebrew/share/zsh-you-should-use/you-should-use.plugin.zsh
fi

# There can be .secrets dir and envvars.zsh file in the .secrets dir.
# If there is, source it.
if [ -d "$HOME/.secrets" ]; then
	if [ -f "$HOME/.secrets/envvars.zsh" ]; then
		source "$HOME/.secrets/envvars.zsh"
	fi
fi


# FZF
# Key bindings only (^T, ^R, Alt-C). completion.zsh is deliberately left out:
# it binds Tab to fzf-completion, which stops zsh-autocomplete from ever
# claiming Tab and drops us back to plain expand-or-complete.
if [ -f /opt/homebrew/opt/fzf/shell/key-bindings.zsh ]; then
  source /opt/homebrew/opt/fzf/shell/key-bindings.zsh
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
# Alt-C changes directory, so it needs directories, not files.
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git 2>/dev/null'

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

# GPG commit signing
export GPG_TTY=$(tty)
