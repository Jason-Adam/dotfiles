#!/bin/sh

set -e

mkdir -p ~/.git_template/hooks

for hook in ../hooks/*.sh; do
    file=$(echo "$hook" | grep -o '[^/]*$')
    file_symlink=$(echo "$file" | cut -d '.' -f1)
    ln -s -f ~/code/dotfiles/hooks/"$file" ~/.git_template/hooks/"$file_symlink"
done
