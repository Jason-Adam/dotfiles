#!/bin/sh

# Let's keep our brew environment up-to-date and clean
set -e

brew update &&
    brew upgrade &&
    brew cleanup &&
    brew autoremove
