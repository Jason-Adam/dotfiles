#!/bin/sh

set -e

# Install Python Versions (currently only last 3)
PYTHON_VERSIONS="$(pyenv install --list | grep ' 3\.[89]\.' | tail -2 | awk '{$1=$1};1')"

for version in $PYTHON_VERSIONS; do
    pyenv install -v "$version"
done

# Set Global versio to latest
GLOBAL_VERSION="$(echo "$PYTHON_VERSIONS" | tail -1)"
pyenv global "$GLOBAL_VERSION"

# Install Poetry
curl -sSL https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py | python -
poetry --version
