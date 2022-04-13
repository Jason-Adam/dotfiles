#!/bin/sh

set -e

mkdir -p "$HOME"/.git_template/hooks

for hook in hooks/*.sh; do
    file=$(echo "$hook" | grep -o '[^/]*$')
    file_symlink=$(echo "$file" | cut -d '.' -f1)
    ln -s -f "$HOME"/code/dotfiles/hooks/"$file" "$HOME"/.git_template/hooks/"$file_symlink"
done
