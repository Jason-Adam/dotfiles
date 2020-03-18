PHONY install:
	getbrew
	golang
	cloud
	database
	gui

PHONY getbrew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

PHONY term:
	brew cask install iterm2
	brew install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

PHONY cli:
	brew install bat
	brew install exa
	brew install fzf
	brew install rg
	brew install jq

PHONY cloud:
	brew install kubectl
	brew cask install google-cloud-sdk

PHONY golang:
	brew install go

PHONY database:
	brew install mongodb/brew/mongodb-community
	brew install postgresql

PHONY gui:
	brew cask install visual-studio-code
	brew cask install mongodb-compass

PHONY py:
	brew install python
	brew install pipenv
