#!/bin/sh

set -e

# Tools to Install through brew package manager
tools="
    tmux
    pyenv
    kubectl
    exa
    node
    npm
    ctags
    bat
    openjdk
    rg
    gradle
    awk
    go
    jq
    llvm
    pandoc
    shellcheck
    k9s
    gh
    tmux-mem-cpu-load
    mongodb-community
    mongodb-compass
    dbeaver-community
    kitty
    slack
    keeper-password-manager
    alfred
    spectacle
    docker
    r
    rstudio
    google-chrome
    intellij-idea-ce
    google-backup-and-sync
    gpg-suite-no-mail
    spotify
    visual-studio-code
    shfmt
"

for tool in $tools; do
    brew install "$tool"
done
