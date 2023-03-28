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
alias ctags="`brew --prefix`/bin/ctags"

###################################################
# Plugins
###################################################
plugins=(
    git 
    vi-mode 
    fzf
    tmux
    zsh-syntax-highlighting
    zsh-autosuggestions
    zsh-completions
)

source $ZSH/oh-my-zsh.sh

# Aliases
alias reload!='clear && source ~/.zshrc'
alias cat='bat'
alias ls='exa --group-directories-first'
alias la='exa --group-directories-first --all'
alias ll='exa --group-directories-first --long'
alias lst='exa --group-directories-first --tree'
alias llt='exa --group-directories-first --long --tree'
alias tar='gtar'

# gcloud autocomplete
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jasonadam/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="$HOME/bin:$PATH"

# Rust
export PATH="$PATH:$HOME/.cargo/bin"

# Poetry
export PATH="$HOME/.poetry/bin:$PATH"

# Node@16
export PATH="/usr/local/opt/node@16/bin:$PATH"

# ZLS
export PATH="$PATH:$HOME/zls/zig-out/bin"

# Gawk
export PATH="/usr/local/opt/gawk/libexec/gnubin:$PATH"

# Dotnet
export DOTNET_ROOT="$HOME/.dotnet"
export PATH="$PATH:$HOME/.dotnet:$HOME/.dotnet/tools"

# Load Environment variable file for python virtual envs
load-env() {
    set -o allexport && \
        source "$1" && \
        set +o allexport;
}
