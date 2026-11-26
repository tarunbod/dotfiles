OS=""
case "$OSTYPE" in
  darwin*)  OS="macos" ;;
  linux*)   OS="linux" ;;
  bsd*)     OS="bsd" ;;
  *)        OS="unknown" ;;
esac
export OS

if [[ $OS == "macos" ]]; then
    if ! command -v brew > /dev/null 2>&1; then
        read "REPLY?homebrew not found. Do you want to install it? [y/n]: "
        [[ $REPLY = y* ]] && /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi

    if ! command -v nix > /dev/null 2>&1; then
        read "REPLY?nix not found. Do you want to install it? [y/n]: "
        [[ $REPLY = y* ]] && \
          curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh && \
          echo "Reload shell and install nix-darwin with ~/dotfiles/install-nix-darwin.sh"
    fi
else
    if ! command -v nix > /dev/null 2>&1; then
        read -p "nix not found. Do you want to install it? [y/n]: "
        [[ $REPLY = y* ]] && \
          curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh -s -- --daemon && \
          echo "Reload shell and install home-manager with ~/dotfiles/install-home-manager.sh"
    fi
fi
