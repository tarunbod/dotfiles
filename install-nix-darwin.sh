#!/usr/bin/env zsh

# TODO: add current hostname to flake, add ssh master key to be able to decrypt secrets, add ssh key to github
sudo nix -extra-experimental-features 'nix-command flakes' run 'nix-darwin/master#darwin-rebuild' --flake ~/dotfiles switch
