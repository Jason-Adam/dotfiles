#!/bin/sh

set -e

# Run All Install Scripts
for file in install/*.sh; do
    ./install/"$file"
done
