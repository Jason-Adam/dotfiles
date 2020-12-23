#!/usr/bin/env bash

set -e;

# Run All Install Scripts
for f in $(ls ~/code/dotfiles/install); do
    . ~/code/dotfiles/install/"$f";
done;
