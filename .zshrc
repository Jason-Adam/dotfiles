# -------------------------------------------
# PATH
# -------------------------------------------
export GOPATH = $HOME/go
export ZSH="/Users/jasonadam/.oh-my-zsh"
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
source <(kubectl completion zsh)
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
