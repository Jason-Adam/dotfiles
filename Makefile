.PHONY: all
all:
	./_install.sh

.PHONY: dirs
dirs:
	./install/01_dirs.sh

.PHONY: terminal
terminal:
	./install/02_terminal.sh

.PHONY: homebrew
homebrew:
	./install/03_homebrew.sh

.PHONY: cli
cli:
	./install/04_cli.sh

.PHONY: dotfiles
dotfiles: dirs
	./install/05_dotfiles.sh

.PHONY: language_servers
language_servers:
	./install/06_language_servers.sh

.PHONY: setup_rust
setup_rust:
	./install/07_rust.sh

.PHONY: gcloud_sdk
gcloud_sdk:
	./install/08_gcloud_sdk.sh

.PHONY: sh_scripts
sh_scripts: dirs
	./install/09_sh_scripts.sh

.PHONY: setup_pyenv
setup_pyenv:
	./install/10_setup_pyenv.sh
