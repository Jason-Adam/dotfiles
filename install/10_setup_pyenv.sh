#!/usr/bin/env bash

set -e;

# Install Python Version
PYTHON_VERSION=3.8.2

setup_pyenv() {
	pyenv install -v "$PYTHON_VERSION";
	pyenv global "$PYTHON_VERSION";
}

setup_pyenv;
