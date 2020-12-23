#!/usr/bin/env bash

set -e;

# Install Homebrew package manager (mac only)
homebrew() {
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)";
}

homebrew;
