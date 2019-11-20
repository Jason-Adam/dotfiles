###################################################
# Path
###################################################
# Gopath
export GOPATH=$HOME/go
export PATH=~/Library/Python/3.7/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="/Users/jasonadam/.oh-my-zsh"

###################################################
# Misc
###################################################
# Theme
ZSH_THEME="agnoster"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Aliases
alias reload!='clear && source ~/.zshrc'
alias cat='bat'
alias vim='nvim'

alias ls='exa --group-directories-first'
alias la='exa --group-directories-first --all'
alias ll='exa --group-directories-first --long'
alias lst='exa --group-directories-first --tree'
alias llt='exa --group-directories-first --long --tree'

export FZF_DEFAULT_COMMAND='rg --files --hidden --glob "!.git/*"'
export FZF_DEFAULT_OPTS='--preview "bat {}"'
export FZF_DEFAULT_OPTS='--preview "[[ $(file --mime {}) =~ binary ]] &&
                 echo {} is a binary file ||
                 (bat --style=numbers --color=always {} ||
                  highlight -O ansi -l {} ||
                  coderay {} ||
                  rougify {} ||
                  cat {}) 2> /dev/null | head -500"'

alias vimfzf='vim $(fzf)'

# Syntax highlighting
source /usr/local/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
###################################################
# Plugins
###################################################
plugins=(git vi-mode zsh-autosuggestions docker kubectl web-search)

# K8 autocomplete
source $ZSH/oh-my-zsh.sh
source <(kubectl completion zsh)

# gcloud autocomplete
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/jasonadam/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/path.zsh.inc'; fi
# The next line enables shell command completion for gcloud.
if [ -f '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/jasonadam/google-cloud-sdk/completion.zsh.inc'; fi
