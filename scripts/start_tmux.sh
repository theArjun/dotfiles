
#!/bin/bash

# Check if inside tmux already
if [ -z "$TMUX" ]; then
    # Start tmux or attach to an existing session
    tmux attach-session -t default || tmux new-session -s default
else
    # Already inside tmux, continue normally
    exec bash
fi
