#!/bin/bash
# Launched by Ghostty as its `command` (see config/ghostty/config).
# Attaches to the default tmux session, creating it if needed. Every other
# terminal gets a plain shell session -- tmux is only started from here.

# Ghostty is a GUI app, so it inherits the bare /etc/paths PATH; make sure
# Homebrew's bin is visible before looking for tmux.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

login_shell() {
    exec "${SHELL:-/bin/zsh}" -l
}

# Already inside tmux (or tmux isn't installed): just be a normal shell.
if [ -n "$TMUX" ] || ! command -v tmux >/dev/null 2>&1; then
    login_shell
fi

tmux new-session -A -s default

# Fall back to a normal shell when the session is detached rather than exited.
login_shell
