#!/bin/bash
# Herdr port of tmux_sessionizer.sh: fuzzy-find a project under ~/workspace and
# focus its herdr workspace, creating the workspace when it doesn't exist yet.
# Bound to prefix+t in config/herdr/config.toml -- the key tmux uses for the
# tmux sessionizer.

# Popups inherit herdr's environment, which may not have Homebrew on PATH.
export PATH="/opt/homebrew/bin:/usr/local/bin:$PATH"

herdr_bin="${HERDR_BIN_PATH:-herdr}"

selected=$(find "$HOME/workspace" -mindepth 2 -maxdepth 2 -type d | fzf)

if [[ -z $selected ]]; then
  exit 0
fi

selected_name=$(basename "$selected" | tr . _)

existing=$("$herdr_bin" workspace list 2>/dev/null |
  jq -r --arg name "$selected_name" \
    '.result.workspaces[]? | select(.label == $name) | .workspace_id' |
  head -n 1)

if [[ -n $existing ]]; then
  "$herdr_bin" workspace focus "$existing"
else
  "$herdr_bin" workspace create --cwd "$selected" --label "$selected_name" --focus
fi
