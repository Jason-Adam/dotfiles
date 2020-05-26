.PHONY: main homebrew cli_tools dotfiles apps

main: homebrew terminal cli dotfiles apps

homebrew:
	cd
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

terminal:
	cd
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

cli:
	brew install tmux
	brew install pyenv
	brew install zsh-syntanx-highlighting
	brew install kubectl
	brew install exa
	brew install node
	brew install ctags
	brew install bat

apps:
	brew cask install slack
	brew cask install keeper-password-manager
	brew cask install alfred
	brew cask install spectacle
	brew cask install docker

dotfiles:
	mkdir code && cd code
	git clone https://github.com/Jason-Adam/dotfiles.git
	ln -s -f ~/code/dotfiles/.vimrc ~/.vimrc
	ln -s -f ~/code/dotfiles/.zshrc ~/.zshrc
	ln -s -f ~/code/dotfiles/.tmux.conf ~/.tmux.conf
	ln -s -f ~/code/dotfiles/.vim/coc-settings.json
	ln -s -f ~/code/dotfiles/.gitconfig ~/.gitconfig
