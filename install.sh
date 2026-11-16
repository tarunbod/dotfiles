OS=""
case "$OSTYPE" in
  darwin*)  OS="macos" ;;
  linux*)   OS="linux" ;;
  bsd*)     OS="bsd" ;;
  *)        OS="unknown" ;;
esac
export OS

if [[ $OS == "macos" ]]; then
    function install_brew() {
        if [[ $1 = "-f" ]]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            brew tap caskroom/cask
            brew tap homebrew/dupes
        fi
    }

    if ! command -v brew > /dev/null 2>&1; then
        read -p "homebrew not found. Do you want to install it? [y/n]: "
        [[ $REPLY = y* ]] && install_brew -f
    fi

    if ! command -v nix > /dev/null 2>&1; then
        read -p "nix not found. Do you want to install it? [y/n]: "
        [[ $REPLY = y* ]] && \
          curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install | sh && \
          exec -l $SHELL ~/dotfiles/install-nix-darwin.sh
    fi
fi
