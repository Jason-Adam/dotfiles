###################################################
# Path
###################################################

export GOPATH=$HOME/go
export GOROOT="$(brew --prefix go)/libexec"
export PATH="$PATH:${GOPATH}/bin:${GOROOT}/bin"

# Path to your oh-my-zsh installation.
ZSH_DISABLE_COMPFIX=true
export ZSH=$HOME/.oh-my-zsh

###################################################
# Misc
###################################################
# vim mode
set -o vi

# Theme
ZSH_THEME="minimal"

COMPLETION_WAITING_DOTS="true"

# FZF
export FZF_DEFAULT_COMMAND='fd --type file --hidden --no-ignore'
export FZF_DEFAULT_OPTS='--height 30% --border'
export FZF_CTRL_T_COMMAND='fd --type f'
export FZF_CTRL_T_OPTS="--preview 'head {}'"
export FZF_CTRL_R_OPTS='--sort --exact'
export FZF_ALT_C_COMMAND='fd --type d'
export FZF_ALT_C_OPTS="--preview 'tree -C {} | head -200'"

alias vim='nvim'
alias vimfzf='nvim $(fzf)'

###################################################
# Plugins
###################################################
plugins=(
    git 
    vi-mode 
    fzf
    tmux
)

source $ZSH/oh-my-zsh.sh

eval "$(/opt/homebrew/bin/brew shellenv)"

# Aliases
alias reload!='clear && source ~/.zshrc'

export PATH="$HOME/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Load Environment variable file for python virtual envs
load-env() {
    set -o allexport && \
        source "$1" && \
        set +o allexport;
}

# Git prompt
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="] "
ZSH_THEME_GIT_PROMPT_SEPARATOR=""
ZSH_THEME_GIT_PROMPT_BRANCH="%b"
ZSH_THEME_GIT_PROMPT_DIRTY=" %F{red}●%f"
ZSH_THEME_GIT_PROMPT_CLEAN=""
PROMPT='%~ $(git_prompt_info)%# '

gnb() {
  if [ -z "$1" ]; then
    echo "Usage: gnb <branch-name-text>"
    return 1
  fi

  local date
  date=$(date +%Y%m%d)

  local text
  text=$(echo "$1" | tr '[:upper:]' '[:lower:]' | tr ' ' '-' | tr -cd '[:alnum:]-')

  local branch="ja.${date}.${text}"

  git checkout -b "$branch"
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
