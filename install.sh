if [[ $OS == "macos" ]]; then

    function install_brew() {
        if [[ $1 = "-f" ]]; then
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
            brew tap caskroom/cask
            brew tap homebrew/dupes
        fi

        if [[ ! command -v brew > /dev/null 2>&1 ]]; then
            read -p "homebrew not found. Do you want to install it? [y/n]: "
            [[ $REPLY = y* ]] && install_brew -f
        fi
    }

    install_brew

    function ensure() {
      command -v "$1" > /dev/null 2>&1 || { read -p "$1 not found. Do you want to install it? [y/n]: "; { [[ $REPLY = y* ]] && $2; } }
    }

    ensure "tmux"    "brew install tmux"
    ensure "fortune" "brew install fortune"
    ensure "uv"      "brew install uv"
    ensure "node"    "brew install node"
    ensure "tree"    "brew install tree"
    ensure "ffmpeg"  "brew install ffmpeg"
    ensure "wget"    "brew install wget"
    ensure "cloc"    "brew install cloc"

    find ~/Library/Fonts | grep "FiraCode" > /dev/null 2>&1 || brew install --cask font-fira-code

    [[ -f "/Applications/Google Chrome.app" ]] || brew install --cask google-chrome
fi
