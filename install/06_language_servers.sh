#!/bin/sh

set -e

# Install Language Servers for coc.nvim
curl -sL install-node.now.sh/lts | bash
npm install -g dockerfile-language-server-nodejs
