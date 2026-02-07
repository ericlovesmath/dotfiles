#!/bin/bash

# Nix home-manager manager

FLAKE_PATH="$HOME/dotfiles"
FLAKE_TARGET="$FLAKE_PATH#fedora"

# Check if home-manager is installed globally
if ! [ -x "$(command -v home-manager)" ]; then
    HM_CMD="nix run home-manager -- --flake $FLAKE_TARGET"
else
    HM_CMD="home-manager --flake $FLAKE_TARGET"
fi

export HM_CMD FLAKE_PATH
