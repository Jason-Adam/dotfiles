PYTHON_VERSION := 3.8.2

.PHONY: homebrew
homebrew:
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

.PHONY: terminal
terminal:
	xcode-select --install
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt"
	ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
	git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

.PHONY: cli
cli:
	brew install tmux
	brew install pyenv
	brew install kubectl
	brew install exa
	brew install node
	brew install npm
	brew install ctags
	brew install bat
	brew install openjdk
	brew install rg
	brew install gradle
	brew install awk
	brew install go
	brew install jq
	brew install llvm
	brew install pandoc
	brew install shellcheck
	brew install k9s
	brew install gh
	brew install tmux-mem-cpu-load
	brew install mongodb-community
	brew install mongodb-compass
	brew install dbeaver-community
	brew install kitty
	brew install slack
	brew install keeper-password-manager
	brew install alfred
	brew install spectacle
	brew install docker
	brew install r
	brew install rstudio
	brew install google-chrome
	brew install intellij-idea-ce
	brew install google-backup-and-sync
	brew install gpg-suite-no-mail
	brew install spotify
	brew install visual-studio-code

.PHONY: cli_upgrade
cli_upgrade:
	brew upgrade

.PHONY: dotfiles
dotfiles:
	mkdir ~/code
	git clone https://github.com/Jason-Adam/dotfiles.git ~/code
	ln -s -f ~/code/dotfiles/.vimrc ~/.vimrc
	ln -s -f ~/code/dotfiles/.zshrc ~/.zshrc
	ln -s -f ~/code/dotfiles/.tmux.conf ~/.tmux.conf
	ln -s -f ~/code/dotfiles/coc-settings.json ~/.vim/coc-settings.json
	ln -s -f ~/code/dotfiles/.gitconfig ~/.gitconfig
	ln -s -f ~/code/dotfiles/Makevars ~/.R/Makevars
	ln -s -f ~/code/dotfiles/.vimrc ~/.ideavimrc
	ln -s -f ~/code/dotfiles/kitty.conf ~/.config/kitty/kitty.conf
	ln -s -f ~/code/dotfiles/.k9s/skin.yml ~/.k9s/skin.yml

.PHONY: language_servers
language_servers:
	npm install -g dockerfile-language-server-nodejs
	npm i -g bash-language-server

.PHONY: setup_rust
setup_rust:
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
	rustup component add rls rust-analysis rust-src

.PHONY: gcloud_sdk
gcloud_sdk:
	curl https://sdk.cloud.google.com | bash

.PHONY: setup_pyenv
setup_pyenv:
	pyenv install -v $(PYTHON_VERSION)
	pyenv global $(PYTHON_VERSION)

.PHONY: sh_scripts
sh_scripts:
	git clone https://github.com/Jason-Adam/sh-scripts.git ~/code
	mkdir ~/bin
	ln -s -f ~/code/sh-scripts/py-deps.sh ~/bin/py-deps
	ln -s -f ~/code/sh-scripts/py-gitignore.sh ~/bin/py-gitignore
	ln -s -f ~/code/sh-scripts/load-env.sh ~/bin/load-env
