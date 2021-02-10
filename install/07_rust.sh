#!/bin/sh

set -e

# Install Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
rustup component add rls rust-analysis rust-src
