#!/bin/sh

set -e

git clone https://github.com/Jason-Adam/sh-scripts.git "$HOME"/code &&
    cd "$HOME"/code/sh-scripts &&
    ./_install.sh
