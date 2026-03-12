# Function as alias
function pips {
    pip install $1 && pip freeze | grep $1 >> requirements.txt
}

function pipdev {
	pip install $1 && pip freeze | grep $1 >> requirements-dev.txt
}

function format {
	black $1 && isort $1 && flake8 $1
}

function pyclear {
  find . -type d -name '__pycache__' -exec rm -rf {} +
}

function pr {
  GH_FORCE_TTY=100% gh pr list | fzf --ansi --preview 'GH_FORCE_TTY=100% gh pr view {1}' --header-lines 3 | awk '{print $1}' | xargs gh pr checkout
}

function ghi {
  local selected
  selected=$(GH_FORCE_TTY=100% gh issue list | fzf --ansi --preview 'GH_FORCE_TTY=100% gh issue view {1}' --header-lines 3) || return
  local number=$(echo "$selected" | awk '{print $1}')
  gh issue develop "$number" --checkout
}

function syncall {
  echo "Syncing config..."
  # Store current datetime in a variable and host name too
  # This will be used to create a backup of the current config
  #
  # The format is: YYYY-MM-DD-HH-MM-SS
  current_date_time="`date +%Y-%m-%d-%H-%M-%S`"
  host_name="`hostname`"
  git add .
  # Author should be actions bot so that it doesn't show up as my commit
  git commit -m "Syncing config on $current_date_time on $host_name"
  git push
}

function br {
  git branch --sort=-committerdate | fzf --header "Checkout Recent Branch" --preview "git diff --color=always {1}" --pointer="" | xargs git checkout
}

function gitignore {
  read -p "Enter the ignore type: " ignore_type
  curl -sLw "\n" https://toptal.com/developers/gitignore/api/$ignore_type > .gitignore
}

function checkv() {
    local package_name="$1"
    local latest_version=$(http GET "https://pypi.org/pypi/${package_name}/json" | jq -r '.info.version')
    echo "Latest Version: $latest_version"
    local current_version=$(pip show $package_name | grep Version | awk '{print $2}')
    echo "Current version: $current_version"
}

function subdir() {
    # Check if a URL is provided
    if [ $# -eq 0 ]; then
        echo "Use like: subdir <URL>"
				return 1
    fi
    # Extract repository URL, path to subfolder, and branch name from the provided URL
    local REPO_URL=$(echo $1 | sed -E 's|https://github.com/([^/]+/[^/]+)/tree/([^/]+)/(.+)|https://github.com/\1.git|')
    local SUBFOLDER_PATH=$(echo $1 | sed -E 's|https://github.com/([^/]+/[^/]+)/tree/([^/]+)/(.+)|\3|')
    local BRANCH_NAME=$(echo $1 | sed -E 's|https://github.com/([^/]+/[^/]+)/tree/([^/]+)/(.+)|\2|')
    # Generate a folder name based on the repository name and subfolder
    local FOLDER_NAME=$(basename $(dirname $REPO_URL))_$(basename $SUBFOLDER_PATH)
    # Initialize a new git repository
    git init $FOLDER_NAME
    # Navigate into the repository
    cd $FOLDER_NAME
    # Add the remote repository
    git remote add -f origin $REPO_URL
    # Enable sparse checkout
    git config core.sparseCheckout true
    # Add the subfolder to the sparse-checkout configuration
    echo $SUBFOLDER_PATH >> .git/info/sparse-checkout
    # Pull the specified folder from the repository
    git pull origin $BRANCH_NAME
    echo "Downloaded $SUBFOLDER_PATH from $REPO_URL on branch $BRANCH_NAME into $FOLDER_NAME/"
}

convert_to_h265() {
    if [ $# -lt 2 ]; then
        echo "Usage: convert_to_h265 input.mp4 output.mp4 [crf_value]"
        return 1
    fi

    input_file="$1"
    output_file="$2"
    crf_value="${3:-28}"  # Default to CRF 28 if not provided

    ffmpeg -i "$input_file" -vcodec libx265 -crf "$crf_value" -threads 0 "$output_file"
}

function lpr() {
    gh pr list --state merged --json mergedAt,author,title,number |
        jq -r '["PR Number", "Author", "Title", "Merged At"],
               ["---------", "------", "-----", "---------"],
               (.[] | [.number, .author.login, .title, .mergedAt]) | @tsv' |
        column -t -s $'\t'
}

function gi() { curl -sLw "\n" https://www.toptal.com/developers/gitignore/api/$@ ;}

function sdir() { local dir dir=$(fd --type d --max-depth 5 --hidden --exclude .git | fzf --height 40% --layout reverse --border) && cd "$dir" ;}

# Git Worktree functions
function wt() {
  local selected
  selected=$(git worktree list | fzf --height 40% --layout reverse --border \
    --header "Switch Worktree" \
    --preview 'git log --oneline -10 --color=always $(echo {} | awk "{print \$NF}" | tr -d "[]")' \
  ) && cd "$(echo "$selected" | awk '{print $1}')"
}

function wta() {
  local branch
  branch=$(git branch -a --sort=-committerdate | sed 's/^[* ]*//' | sed 's|remotes/origin/||' | sort -u | \
    fzf --height 40% --layout reverse --border \
    --header "Add Worktree from Branch" \
    --preview 'git log --oneline -10 --color=always {}' \
  ) || return
  local dir="../$(basename $(git rev-parse --show-toplevel))-$branch"
  git worktree add "$dir" "$branch" && cd "$dir"
}

function wtn() {
  if [ $# -eq 0 ]; then
    echo "Usage: wtn <new-branch-name>"
    return 1
  fi
  local branch="$1"
  local dir="../$(basename $(git rev-parse --show-toplevel))-$branch"
  git worktree add -b "$branch" "$dir" && cd "$dir"
}

function wtr() {
  local selected
  selected=$(git worktree list | tail -n +2 | \
    fzf --height 40% --layout reverse --border \
    --header "Remove Worktree" --multi \
    --preview 'git log --oneline -10 --color=always $(echo {} | awk "{print \$NF}" | tr -d "[]")' \
  ) || return
  echo "$selected" | while read -r line; do
    local path="$(echo "$line" | awk '{print $1}')"
    git worktree remove "$path" && echo "Removed: $path"
  done
}

# ============================================================================
# INTERACTIVE VISUAL FUNCTIONS - Terminal Interactivity Enhancements
# ============================================================================

# Show colorized system status with emoji indicators
function status() {
  echo ""
  echo "╔═══════════════════════════════════════════╗"
  echo "║        🖥️  SYSTEM STATUS DASHBOARD        ║"
  echo "╚═══════════════════════════════════════════╝"
  echo ""

  # CPU usage
  local cpu_usage=$(top -l1 | grep "CPU usage" | awk '{print $3}' | cut -d'%' -f1)
  if (( ${cpu_usage%.*} > 70 )); then
    echo "🔴 CPU Usage: ${cpu_usage}%"
  elif (( ${cpu_usage%.*} > 40 )); then
    echo "🟡 CPU Usage: ${cpu_usage}%"
  else
    echo "🟢 CPU Usage: ${cpu_usage}%"
  fi

  # Memory usage
  local mem_usage=$(vm_stat | grep "Pages free" | awk '{print $3}' | cut -d'.' -f1)
  echo "💾 Memory: $(free -h 2>/dev/null || vm_stat | head -2)"

  # Disk usage
  echo "💿 Disk Usage: $(df -h / | tail -1 | awk '{print $5 " used of " $2}')"

  # Git status if in repo
  if git rev-parse --git-dir > /dev/null 2>&1; then
    local uncommitted=$(git status --porcelain | wc -l)
    if [ $uncommitted -eq 0 ]; then
      echo "✅ Git: Clean"
    else
      echo "⚠️  Git: $uncommitted uncommitted changes"
    fi
  fi

  echo ""
}
