#!/bin/sh

set -e

# Symlink all dotfiles
ln -s -f "$HOME"/code/dotfiles/coc-settings.json "$HOME"/.vim/coc-settings.json
ln -s -f "$HOME"/code/dotfiles/kitty.conf "$HOME"/.config/kitty/kitty.conf
ln -s -f "$HOME"/code/dotfiles/home.nix "$HOME"/.config/nixpkgs/home.nix
ln -s -f "$HOME"/code/dotfiles/.ctags "$HOME"/.ctags
