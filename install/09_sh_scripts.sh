#!/usr/bin/env bash

set -e;

# Setup Shell Scripts
sh_scripts() {
	git clone https://github.com/Jason-Adam/sh-scripts.git ~/code;
	. ~/code/sh-scripts/_install.sh;
}

sh_scripts;
