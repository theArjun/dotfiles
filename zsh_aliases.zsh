# Python and Virtual Environment
alias pyt="pytest"
alias a="source .venv/bin/activate"
alias d="deactivate"
alias idiff="git diff --name-only | grep .py | xargs isort"
alias fdiff="git diff --name-only | grep .py | xargs flake8"
alias rdiff="git diff --name-only | grep .py | xargs ruff format"
alias upi="uv pip install"
alias up="uv pip"
alias rf="ruff format ."
alias rc="ruff check ."
alias rcf="ruff check --fix ."
alias rcfu="ruff check --fix --unsafe-fixes ."

# Added Python aliases
alias pyf="python -m black ."
alias pyi="python -m isort ."
alias pylf="python -m flake8"
alias pyr="python -m ruff check ."
alias pyrc="python -m ruff check --fix ."
alias pyd="python -m pydoc"
alias pyprof="python -m cProfile -o profile.pstats"
alias pyprofsort="python -c 'import pstats; p=pstats.Stats(\"profile.pstats\"); p.sort_stats(\"cumulative\").print_stats(50)'"
alias venv="python -m venv .venv"
alias pipout="pip list --outdated"
alias pipreq="pip freeze > requirements.txt"

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

# Direnv
alias de="direnv edit ."
alias da="direnv allow ."
alias dr="direnv reload"

# Flutter
alias frd="flutter run --flavor dev"
alias fba="flutter build apk --flavor dev --debug"
alias fcl="flutter clean"
alias fpcl="flutter pub cache clean"

# Typescript
alias formatts="npx @biomejs/biome format --write ./src"
# Added Typescript/JavaScript aliases
alias eslf="npx eslint --fix ."
alias prtf="npx prettier --write ."
alias nrd="npm run dev"
alias nrs="npm run start"
alias nrb="npm run build"
alias nrt="npm run test"
alias yrn="yarn"
alias yrd="yarn dev"
alias yrs="yarn start"
alias yrb="yarn build"
alias yrt="yarn test"
alias pni="pnpm install"
alias pnd="pnpm dev"
alias pns="pnpm start"
alias pnb="pnpm build"
alias pnt="pnpm test"

# Git Aliases
alias gfh="git-file-history"
alias lg="lazygit"
alias cleanbr='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'
alias cbr='git checkout -b'
alias glol='git log --graph --pretty="%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset"'

# Added git workflow aliases
alias gpr="gh pr create"
alias gprl="gh pr list"
alias gprv="gh pr view"
alias gprc="gh pr checkout"
alias gis="git status --short"
alias gll="git log --oneline -10"
alias gwta="git worktree add"
alias gwtl="git worktree list"
alias gwtr="git worktree remove"
alias gspr="git stash && git pull --rebase && git stash pop"

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
alias ytmp="yt-dlp --extract-audio --audio-format mp3"
alias ytpl='yt-dlp --ignore-errors --format bestaudio --extract-audio --embed-metadata --embed-thumbnail --add-metadata --audio-format mp3 --audio-quality 160K --output "%(title)s.%(ext)s"'

# File System
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
alias nvd="neovide ."
alias nv="nvim ."
alias vi="nvim"
alias vim="nvim"
alias myip="ifconfig en0 | grep inet | grep -v inet6 | cut -d ' ' -f2"
alias ls="eza --icons --group-directories-first"

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

# Development Tools
alias http="python -m http.server"
alias jsb="json_pp <"
alias ccat="pygmentize -g"
alias cip="curl -s ipinfo.io | jq"
alias wip="curl -s wttr.in"
alias cls="clear"
alias path="echo $PATH | tr ':' '\n'"
alias ports="sudo lsof -iTCP -sTCP:LISTEN -P"
alias myports="sudo lsof -iTCP -sTCP:LISTEN -P | grep -i $USER"
alias diskspace="df -h"
alias foldersize="du -sh"
alias biggest="du -sh * | sort -hr | head -10"
alias mem="free -h"
alias cpuinfo="lscpu"
alias timestamp="date +%s"
alias isodate="date -u +\"%Y-%m-%dT%H:%M:%SZ\""
alias histg="history | grep"

# Project navigation
alias cdp="cd ~/projects"
alias cdw="cd ~/workspace"
alias cdd="cd ~/Downloads"
alias cdt="cd /tmp"
