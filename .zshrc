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
    git-prompt
    vi-mode 
    fzf
    tmux
)

source $ZSH/oh-my-zsh.sh

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
autoload -Uz vcs_info
precmd() { vcs_info }

zstyle ':vcs_info:git:*' check-for-changes true

# Make change indicators red
zstyle ':vcs_info:git:*' unstagedstr '%F{red} ●%f'
zstyle ':vcs_info:git:*' stagedstr '%F{red} +%f'

zstyle ':vcs_info:git:*' formats ' [%b%u%c]'
zstyle ':vcs_info:git:*' actionformats ' [%b|%a%u%c]'

setopt prompt_subst

RPROMPT=
PROMPT='%~${vcs_info_msg_0_} %# '

. "$HOME/.local/bin/env"
