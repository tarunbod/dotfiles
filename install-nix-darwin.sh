#!/usr/bin/env zsh

sudo nix --extra-experimental-features 'nix-command flakes' run 'nix-darwin/master#darwin-rebuild' --flake ~/dotfiles switch
