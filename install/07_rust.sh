#!/usr/bin/env bash

set -e;

# Install Rust
setup_rust() {
	curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh;
	rustup component add rls rust-analysis rust-src;
}

setup_rust;
