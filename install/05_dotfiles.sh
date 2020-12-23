#!/usr/bin/env bash

set -e;

# Symlink all dotfiles
dotfiles() {
	ln -s -f ~/code/dotfiles/.vimrc ~/.vimrc;
	ln -s -f ~/code/dotfiles/.zshrc ~/.zshrc;
	ln -s -f ~/code/dotfiles/.tmux.conf ~/.tmux.conf;
	ln -s -f ~/code/dotfiles/coc-settings.json ~/.vim/coc-settings.json;
	ln -s -f ~/code/dotfiles/.gitconfig ~/.gitconfig;
	ln -s -f ~/code/dotfiles/Makevars ~/.R/Makevars;
	ln -s -f ~/code/dotfiles/.vimrc ~/.ideavimrc;
	ln -s -f ~/code/dotfiles/kitty.conf ~/.config/kitty/kitty.conf;
	ln -s -f ~/code/dotfiles/.k9s/skin.yml ~/.k9s/skin.yml;
}

dotfiles;
