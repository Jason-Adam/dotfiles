#!/bin/sh

set -e

# Install Python Version
PYTHON_VERSION=3.8.2

pyenv install -v "$PYTHON_VERSION" &&
    pyenv global "$PYTHON_VERSION"
