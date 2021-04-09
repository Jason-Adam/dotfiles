#!/bin/sh

set -e

mkdir -p "$HOME"/code &&
    git clone https://github.com/Jason-Adam/dotfiles.git "$HOME"/code

# Run All Install Scripts
for file in "$HOME"/code/dotfiles/install/*.sh; do
    ."$HOME"/code/dotfiles/install/"$file"
done
