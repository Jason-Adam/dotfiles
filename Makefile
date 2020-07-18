PYTHON_VERSION := 3.8.2

.PHONY: homebrew terminal cli cli_upgrade apps dotfiles language_servers setup_rust gcloud_sdk setup_pyenv

homebrew:
	cd
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

terminal:
	cd
	xcode-select --install
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

cli:
	brew install tmux
	brew install pyenv
	brew install kubectl
	brew install kubectx
	brew install helm
	brew install exa
	brew install node
	brew install npm
	brew install ctags
	brew install bat
	brew install openjdk
	brew install rg
	brew install cmake
	brew install opencv
	brew install terraform
	brew install terraform-docs
	brew install ansible
	brew install gradle
	brew install gradle-completion
	brew install awk
	brew install go
	brew install jq
	brew install llvm
	brew install pandoc
	brew install shellcheck

cli_upgrade:
	brew upgrade tmux
	brew upgrade pyenv
	brew upgrade kubectl
	brew upgrade kubectx
	brew upgrade helm
	brew upgrade exa
	brew upgrade node
	brew upgrade npm
	brew upgrade ctags
	brew upgrade bat
	brew upgrade openjdk
	brew upgrade rg
	brew upgrade cmake
	brew upgrade opencv
	brew upgrade terraform
	brew upgrade terraform-docs
	brew upgrade ansible
	brew upgrade gradle
	brew upgrade gradle-completion
	brew upgrade awk
	brew upgrade go
	brew upgrade jq
	brew upgrade llvm
	brew upgrade pandoc
	brew upgrade shellcheck

apps:
	brew cask install iterm2
	brew cask install slack
	brew cask install keeper-password-manager
	brew cask install alfred
	brew cask install spectacle
	brew cask install docker
	brew cask install r
	brew cask install rstudio
	brew cask install google-chrome
	brew cask install intellij-idea
	brew cask install clion
	brew cask install google-backup-and-sync
	brew cask install gpg-suite-no-mail
	brew cask install spotify
	brew cask install visual-studio-code
	brew cask install zoom

dotfiles:
	mkdir code && cd code
	git clone https://github.com/Jason-Adam/dotfiles.git
	ln -s -f ~/code/dotfiles/.vimrc ~/.vimrc
	ln -s -f ~/code/dotfiles/.zshrc ~/.zshrc
	ln -s -f ~/code/dotfiles/.tmux.conf ~/.tmux.conf
	ln -s -f ~/code/dotfiles/coc-settings.json ~/.vim/coc-settings.json
	ln -s -f ~/code/dotfiles/.gitconfig ~/.gitconfig
	ln -s -f ~/code/dotfiles/Makevars ~/.R/Makevars
	ln -s -f ~/code/dotfiles/.vimrc ~/.ideavimrc

language_servers:
	npm install -g dockerfile-language-server-nodejs
	npm i -g bash-language-server

setup_rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

gcloud_sdk:
	curl https://sdk.cloud.google.com | bash

setup_pyenv:
	pyenv install -v $(PYTHON_VERSION)
	pyenv global $(PYTHON_VERSION)
