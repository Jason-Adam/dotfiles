###################################################
# Path
###################################################
# Gopath
export GOPATH=$HOME/go

# Path to your oh-my-zsh installation.
ZSH_DISABLE_COMPFIX=true
export ZSH="/Users/jasonadam/.oh-my-zsh"

###################################################
# Misc
###################################################
# vim mode
set -o vi

# Theme
ZSH_THEME="spaceship"
SPACESHIP_CHAR_SYMBOL=":: "
SPACESHIP_DIR_TRUNC=1
SPACESHIP_DIR_TRUNC_PREFIX=
SPACESHIP_DIR_TRUNC_REPO=false
SPACESHIP_GIT_PREFIX=
SPACESHIP_VENV_PREFIX="["
SPACESHIP_VENV_SUFFIX="] "
SPACESHIP_PROMPT_ORDER=(
  dir
  venv
  git
  char
)

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--preview "bat {}"'
alias vimfzf='vim $(fzf)'
alias ctags="`brew --prefix`/bin/ctags"

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

###################################################
# Plugins
###################################################
plugins=(
    git 
    vi-mode 
    zsh-autosuggestions 
    docker 
    docker-compose
    kubectl 
    web-search 
    python
)

# K8 autocomplete
source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)

# Aliases
alias reload!='clear && source ~/.zshrc'
alias cat='bat'
alias ls='exa --group-directories-first'
alias la='exa --group-directories-first --all'
alias ll='exa --group-directories-first --long'
alias lst='exa --group-directories-first --tree'
alias llt='exa --group-directories-first --long --tree'
alias rstudio='open -a RStudio'

# gcloud autocomplete
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jasonadam/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc'; fi

export PATH="/usr/local/opt/llvm/bin:$PATH"
export PATH=$PATH:"$GOPATH/bin"
export PATH="$HOME/.pyenv/bin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:$HOME/.cargo/bin"
eval "$(pyenv init -)"
export PATH="$HOME/.poetry/bin:$PATH"

# Load Environment variable file for python virtual envs
load-env() {
    set -o allexport && \
        source "$1" && \
        set +o allexport;
}
