#!/bin/sh

set -e

# Symlink all dotfiles
ln -s -f "$HOME"/code/dotfiles/coc-settings.json "$HOME"/.config/nvim/coc-settings.json
ln -s -f "$HOME"/code/dotfiles/kitty.conf "$HOME"/.config/kitty/kitty.conf
ln -s -f "$HOME"/code/dotfiles/.ctags "$HOME"/.ctags
ln -s -f "$HOME"/code/dotfiles/.zshrc "$HOME"/.zshrc
ln -s -f "$HOME"/code/dotfiles/init.vim "$HOME"/.config/nvim/init.vim
ln -s -f "$HOME"/code/dotfiles/.tmux.conf "$HOME"/.tmux.conf
ln -s -f "$HOME"/code/dotfiles/.gitconfig "$HOME"/.gitconfig
ln -s -f "$HOME"/code/dotfiles/.gitignore_global "$HOME"/.gitignore_global
ln -s -f "$HOME"/code/dotfiles/zls.json "$HOME"/Library/Application\ Support/zls.json
ln -s -f "$HOME"/code/dotfiles/.ideavimrc "$HOME"/.ideavimrc
ln -s -f "$HOME"/code/dotfiles/claude_desktop_config.json "$HOME"/Library/Application\ Support/Claude/claude_desktop_config.json
ln -s -f "$HOME"/code/dotfiles/.goosehints "$HOME"/.config/goose/.goosehints
