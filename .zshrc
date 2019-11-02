# -------------------------------------------
# PATH
# -------------------------------------------
export GOPATH=$HOME/go
export ZSH=$HOME/.oh-my-zsh
if [ -f '/Users/jasonadam/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc'; fi

# -------------------------------------------
# USER CONFIGURATION
# -------------------------------------------
ZSH_THEME="agnoster"
COMPLETION_WAITING_DOTS="true"

# -------------------------------------------
# PLUGINS
# -------------------------------------------
plugins=(git vi-mode zsh-autosuggestions docker kubectl web-search)
source $ZSH/oh-my-zsh.sh

# kubectl autocompletion
source <(kubectl completion zsh)

# Syntax Highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# fzf - fuzzy finder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
