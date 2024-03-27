# Python
alias pyt="pytest"
alias a="source .venv/bin/activate"
alias d="source deactivate"
alias idiff="git diff --name-only | grep .py | xargs isort"
alias fdiff="git diff --name-only | grep .py | xargs flake8"
alias rdiff="git diff --name-only | grep .py | xargs ruff format"
alias upi="uv pip install"

# Django
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

# Flutter
alias frd="flutter run --flavor dev"
alias fba="flutter build apk --flavor dev --debug"

# Git aliases
alias gfh="git-file-history"
alias lg="lazygit"

# Java
alias gjf="java -jar ~/tools/gjf.jar --replace"

# Docker aliases
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
alias dcvrmall="docker volume rm $(docker volume ls -q)"
alias dcvpruneall="docker volume prune -f"

# YT
alias ytmp="youtube-dl --extract-audio --audio-format mp3"
alias ytpl='yt-dlp --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s"'

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
alias weather="curl wttr.in"
alias pro="ps aux | fzf --preview 'pstree -p {}' --preview-window=right:70%:wrap"
alias c="cz commit"
alias cat="bat --paging=never"
alias myip="ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2"
# Execute command from history
alias h="cat ~/.zsh_history | fzf | awk '{print $2}' | xargs -I % sh -c '%'"
alias ldo="lazydocker"

# Tmux
alias t="tmux"
alias ta="tmux attach"
alias td="tmux detach"
alias tl="tmux list-sessions"
alias tk="tmux list-keys"
alias ts="$HOME/.config/scripts/tmux_sessionizer.sh"
alias tso="tmux source-file ~/.tmux.conf"
