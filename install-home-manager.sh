#!/usr/bin/env bash

NIX_CONFIG="extra-experimental-features = nix-command flakes" nix run home-manager/master -- switch --flake '/home/tarunbod/dotfiles/.#ubuntu'
