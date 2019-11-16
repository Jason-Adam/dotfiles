PHONY install:
	getbrew
	tools
	cloud

PHONY getbrew:
	/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

PHONY tools:
	brew install neovim
	brew cask install iterm2
	brew cask install visual-studio-code
	brew install zsh
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
	brew install bat
	brew install exa
	brew install fzf
	brew install rg
	brew install jq

PHONY cloud:
	brew install

