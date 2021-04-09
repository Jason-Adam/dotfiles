#!/bin/sh

set -e

# Symlink all dotfiles
ln -s -f "$HOME"/code/dotfiles/.vimrc "$HOME"/.vimrc
ln -s -f "$HOME"/code/dotfiles/.zshrc "$HOME"/.zshrc
ln -s -f "$HOME"/code/dotfiles/.tmux.conf "$HOME"/.tmux.conf
ln -s -f "$HOME"/code/dotfiles/coc-settings.json "$HOME"/.vim/coc-settings.json
ln -s -f "$HOME"/code/dotfiles/.gitconfig "$HOME"/.gitconfig
ln -s -f "$HOME"/code/dotfiles/.gitignore_global "$HOME"/.gitignore_global
ln -s -f "$HOME"/code/dotfiles/Makevars "$HOME"/.R/Makevars
ln -s -f "$HOME"/code/dotfiles/.vimrc "$HOME"/.ideavimrc
ln -s -f "$HOME"/code/dotfiles/kitty.conf "$HOME"/.config/kitty/kitty.conf
ln -s -f "$HOME"/code/dotfiles/.k9s/skin.yml "$HOME"/.k9s/skin.yml
ln -s -f "$HOME"/code/dotfiles/.ctags "$HOME"/.ctags
