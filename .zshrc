###################################################
# Homebrew (first, so `brew` is on PATH below)
###################################################
eval "$(/opt/homebrew/bin/brew shellenv)"

###################################################
# Path
###################################################
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"                  # go-installed tools (golangci-lint, gopls, ...)

export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"            # Rust
export PATH="/opt/homebrew/opt/libpq/bin:$PATH" # libpq

###################################################
# Shell options
###################################################
# vi mode
bindkey -v

###################################################
# History
###################################################
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=50000
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt inc_append_history

###################################################
# Completion
###################################################
if type brew &>/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -Uz compinit && compinit

###################################################
# FZF
###################################################
export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
export FZF_DEFAULT_OPTS='--height 30% --border'
export FZF_CTRL_T_COMMAND='fd --type f'
export FZF_CTRL_T_OPTS="--preview 'head {}'"
export FZF_CTRL_R_OPTS='--sort --exact'
export FZF_ALT_C_COMMAND='fd --type d'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"
source <(fzf --zsh)

###################################################
# Aliases
###################################################
alias vim='nvim'
alias vimfzf='nvim $(fzf)'
alias reload!='clear && source ~/.zshrc'

###################################################
# Functions
###################################################
clawd() {
  claude --teammate-mode in-process --dangerously-skip-permissions "$@"
}

# Load an env file for python virtual envs
load-env() {
  set -o allexport && \
    source "$1" && \
    set +o allexport;
}

# Build a namespaced branch name: <user>.<yyyymmdd>.<slug>
bname() {
  if [ -z "$1" ]; then
    echo "Usage: bname <text>"
    return 1
  fi

  local text
  text=$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')

  echo "$(whoami).$(date +%Y%m%d).${text}"
}

# Create and switch to a new branch named via bname
gnb() {
  if [ -z "$1" ]; then
    echo "Usage: gnb <branch-name-text>"
    return 1
  fi

  git checkout -b "$(bname "$1")"
}

unalias md 2>/dev/null
md() {
  if [ -z "$1" ]; then
    echo "Usage: md <file.md>"
    return 1
  fi
  open -a "MacDown 3000" "$1"
}

prweb() {
  # Ensure we're inside a git repository
  if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Not inside a git repository."
    return 1
  fi

  # Ensure gh CLI is installed
  if ! command -v gh >/dev/null 2>&1; then
    echo "GitHub CLI (gh) is not installed."
    return 1
  fi

  # Get current branch
  local branch
  branch=$(git rev-parse --abbrev-ref HEAD)

  if [[ "$branch" == "HEAD" ]]; then
    echo "You are in a detached HEAD state."
    return 1
  fi

  # Push branch if it doesn't exist on remote
  if ! git ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1; then
    echo "Pushing branch '$branch' to origin..."
    git push -u origin "$branch" || return 1
  fi

  # Create draft PR and open in browser
  gh pr create --fill --web
}

###################################################
# Prompt
###################################################
eval "$(starship init zsh)"
