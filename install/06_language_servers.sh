#!/usr/bin/env bash

set -e;

# Install Language Servers for coc.nvim
lang_servers() {
    curl -sL install-node.now.sh/lts | bash;
	npm install -g dockerfile-language-server-nodejs;
	npm i -g bash-language-server;
}

lang_servers;
