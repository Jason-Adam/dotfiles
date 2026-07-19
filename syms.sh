#!/bin/sh

set -e

# Symlink all dotfiles
mkdir -p "$HOME"/.config/nvim
ln -s -f "$HOME"/code/dotfiles/.zshrc "$HOME"/.zshrc
ln -s -f "$HOME"/code/dotfiles/init.vim "$HOME"/.config/nvim/init.vim
ln -s -f "$HOME"/code/dotfiles/starship.toml "$HOME"/.config/starship.toml
ln -s -f "$HOME"/code/dotfiles/.gitconfig "$HOME"/.gitconfig

# Global agent instructions (single source of truth: AGENTS.md)
mkdir -p "$HOME"/.config/goose "$HOME"/.pi/agent "$HOME"/.claude
ln -s -f "$HOME"/code/dotfiles/AGENTS.md "$HOME"/.config/goose/.goosehints
ln -s -f "$HOME"/code/dotfiles/AGENTS.md "$HOME"/.pi/agent/AGENTS.md
ln -s -f "$HOME"/code/dotfiles/AGENTS.md "$HOME"/.claude/CLAUDE.md

# Shared skills + subagents (Agent Skills standard: ~/.agents).
# Goose and Pi discover ~/.agents/skills and ~/.agents/agents natively.
# Claude is intentionally NOT linked into ~/.claude: goose also reads ~/.claude
# for backward compat, so linking there would double-load every skill/agent.
ln -s -f "$HOME"/code/dotfiles/agents "$HOME"/.agents

# Central thoughts store (research/plans/handoffs), namespaced by repo.
# rpi-research, rpi-plan, and handoff write here; note content is git-ignored.
ln -s -f "$HOME"/code/dotfiles/thoughts "$HOME"/thoughts

# Pi extensions (agent hooks run on file edits, etc.)
mkdir -p "$HOME"/.pi/agent/extensions
ln -s -f "$HOME"/code/dotfiles/pi-extensions/format-on-edit.ts "$HOME"/.pi/agent/extensions/format-on-edit.ts
