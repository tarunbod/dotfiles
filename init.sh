#!/usr/bin/env bash

set -e

# Symlink shell init files into home directory
if [[ -f ~/.bashrc ]]; then
  mv ~/.bashrc ~/.bashrc.old
fi

if [[ -f ~/.zshrc ]]; then
  mv ~/.zshrc ~/.zshrc.old
fi

if [[ ! -f ~/.bashrc ]]; then
  ln -s ~/dotfiles/.bashrc ~/.bashrc
fi

if [[ ! -f ~/.zshrc ]]; then
  ln -s ~/dotfiles/.zshrc ~/.zshrc
fi

# create home bin dir
mkdir -p ~/bin

# generate ssh key
if [[ ! -f ~/.ssh/id_ed25519 ]]; then
    read -p "ssh key not found. Do you want to generate it? [y/n]: "
    [[ $REPLY = y* ]] && \
      ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519 -C "$(whoami)@$(hostname)" && \
      echo -e "\n\n=====\nAdd the public key to your github account from another machine:\n\techo \"$(cat ~/.ssh/id_ed25519.pub)\" | gh ssh-key add -t $(hostname) -\n\n=====\n\n"
fi

install_packages() {
  local OS=""
  case "$OSTYPE" in
    darwin*)  OS="macos" ;;
    linux*)   OS="linux" ;;
    bsd*)     OS="bsd" ;;
    *)        OS="unknown" ;;
  esac

  if [[ $OS == "macos" ]]; then
    if ! command -v brew > /dev/null 2>&1; then
      read -p "homebrew not found. Do you want to install it? [y/n]: "
      [[ $REPLY = y* ]] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    if ! command -v nix > /dev/null 2>&1; then
      read -p "nix not found. Do you want to install it? [y/n]: "
      [[ $REPLY = y* ]] && \
        curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh && \
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && \
        sudo nix --extra-experimental-features 'nix-command flakes' run 'nix-darwin/master#darwin-rebuild' -- --flake ~/dotfiles/.#${NIX_CONFIG_PROFILE:-TMBP} switch
    fi
  elif [[ -f /etc/NIXOS ]]; then
    sudo nixos-rebuild switch --flake '/home/tarunbod/dotfiles'
  else
    if ! command -v nix > /dev/null 2>&1; then
      read -p "nix not found. Do you want to install it? [y/n]: "
      [[ $REPLY = y* ]] && \
        curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon && \
        . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh && \
        NIX_CONFIG="extra-experimental-features = nix-command flakes" nix run home-manager/master -- switch --flake '/home/tarunbod/dotfiles/.#ubuntu'
    fi
  fi
}

# Ask for confirmation and install programs/packages
read -p "Do you want to install programs and packages? [y/n]: "
[[ $REPLY = y* ]] && install_packages
