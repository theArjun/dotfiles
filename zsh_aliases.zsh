# Python and Virtual Environment
alias pyt="pytest"
alias a="source .venv/bin/activate"
alias d="deactivate"
alias idiff="git diff --name-only | grep .py | xargs isort"
alias fdiff="git diff --name-only | grep .py | xargs flake8"
alias rdiff="git diff --name-only | grep .py | xargs ruff format"
alias upi="uv pip install"
alias up="uv pip"
alias rr="rye run"

# Django Management Commands
alias dj="python manage.py"
alias djdd="python manage.py dumpdata"
alias djc="python manage.py check"
alias djm="python manage.py migrate"
alias djmm="python manage.py makemigrations"
alias djsh="python manage.py shell"
alias djshp="python manage.py shell_plus"
alias djt="python manage.py test"
alias djrs="python manage.py runserver"
alias djrsp="python manage.py runserver_plus"
alias djl="djlint --reformat --format-css"
alias djd="django_doctor fix --address=0.0.0.0 --port=9001"
alias pm="python manage.py"

# Streamlit
alias st="streamlit run"

# Flutter
alias frd="flutter run --flavor dev"
alias fba="flutter build apk --flavor dev --debug"
alias fcl="flutter clean"
alias fpcl="flutter pub cache clean"

# Postgres
alias pgstart="brew services start postgresql"
alias pgstop="brew services stop postgresql"
alias pgrestart="brew services restart postgresql"
alias pgcli="psql -U postgres"
alias pgdump="pg_dump -U postgres"
alias pgrestore="pg_restore -U postgres"

# Git Aliases
alias gfh="git-file-history"
alias lg="lazygit"
alias cleanbr='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias cbr='git checkout -b'

# Java
alias gjf="java -jar ~/tools/gjf.jar --replace"

# Docker Aliases
alias dc="docker-compose"
alias dcb="docker-compose build"
alias dcd="docker-compose down"
alias dce="docker-compose exec"
alias dcl="docker-compose logs"
alias dcp="docker-compose ps"
alias dcr="docker-compose run"
alias dcs="docker-compose stop"
alias dcu="docker-compose up"
alias dcv="docker-compose volume"
alias dcvls="docker volume ls"
alias dcvrm="docker volume rm"
alias dcvprune="docker volume prune"
alias dcvpruneall="docker volume prune -f"
alias dcrestart="docker-compose restart"  # Added alias
alias dcupb="docker-compose up --build"  # Added alias

# YT
alias ytmp="youtube-dl --extract-audio --audio-format mp3"
alias ytpl='yt-dlp --ignore-errors --format bestaudio --extract-audio --embed-metadata --embed-thumbnail --add-metadata --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s"'

# File System
alias ls="eza --icons --sort type"
alias ll="ls -la"
alias .1="cd .."
alias .2="cd ../.."
alias .3="cd ../../.."
alias .4="cd ../../../.."
alias .5="cd ../../../../.."
alias :q="exit"

# Custom
alias ed="nvim ~/.zshrc"
alias eda="nvim ~/.zsh_aliases.zsh"
alias so="source ~/.zshrc"
alias ng="ngrok http --domain=previously-choice-puma.ngrok-free.app"
alias nv="fd --type f --hidden --exclude .git | fzf-tmux -p | xargs nvim"
alias nvc="nvim ."
alias nvd="fd --type d --hidden --exclude .git | fzf-tmux -p | xargs neovide"
alias weather="curl wttr.in"
alias pro="ps aux | fzf --preview 'pstree -p {}' --preview-window=right:70%:wrap"
alias c="cz commit"
alias cat="bat --paging=never"
alias myip="ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2"
alias h="cat ~/.zsh_history | fzf | awk '{print \$2}' | tee >(xargs -I % echo '%') | xargs -I % sh -c '%'"
alias ldo="lazydocker"

# Tmux
alias t="tmux"
alias ta="tmux attach"
alias td="tmux detach"
alias tl="tmux list-sessions"
alias tk="tmux list-keys"
alias ts="$HOME/.config/scripts/tmux_sessionizer.sh"
alias tso="tmux source-file ~/.tmux.conf"
alias tks="tmux kill-server"
alias tn="tmux new -s"  # Added alias
alias tr="tmux rename-session"  # Added alias

# System Monitoring and Management
alias topcpu="ps aux --sort=-%cpu | head"  # Added alias
alias topmem="ps aux --sort=-%mem | head"  # Added alias
