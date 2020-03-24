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

# Make myndshft repo private
GOPRIVATE="bitbucket.org/myndshft/*"

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

###################################################
# Plugins
###################################################
plugins=(git vi-mode zsh-autosuggestions docker kubectl web-search)

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

# gcloud autocomplete
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jasonadam/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc'; fi

export PATH=$PATH:"$GOPATH/bin"
export PATH="/Users/jasonadam/.pyenv/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Gitignore creation function
function gi() { curl -sLw n https://www.gitignore.io/api/$@ ;}

# Load Env Function
load-env() {
    set -o allexport;
    source $1;
    set +o allexport;
}

# Load python linters in virtual env
load-linters() {
    py_dev=("pylint" "flake8" "bandit" "mypy" "black" "isort")
    if [ "$PIPENV_ACTIVE" ]; then
        for i in "${py_dev[@]}"; do
            pipenv install "$i" --dev --skip-lock
        done;
    elif [ "$POETRY_ACTIVE" ]; then
        for i in "${py_dev[@]}"; do
            poetry add "$i" --dev 
        done;
    else
        echo "please activate a virtualenv and rerun"
    fi;
}

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/jasonadam/.sdkman"
[[ -s "/Users/jasonadam/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/jasonadam/.sdkman/bin/sdkman-init.sh"
