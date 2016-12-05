if [[ $OS == "macos" ]]; then

    function install_brew() {
        if [[ $1 = "-f" ]]; then
            /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
            brew tap caskroom/cask
            brew tap homebrew/dupes
        fi

        if [[ ! -f /usr/local/bin/brew ]]; then
            read -p "homebrew not found. Do you want to install it? [y/n]: "
            [[ $REPLY = y* ]] && install_brew -f
        fi
    }

    function install_cask() {
        if [[ ! -d "/usr/local/Caskroom/$1" ]]; then
            read -p "$1 not found. Do you want to install it? [y/n]: "
            [[ $REPLY = y* ]] && brew cask install "$1"
        fi
    }

    function install_package() {
        [[ -f "/usr/local/bin/$1" ]] || { read -p "$1 not found. Do you want to install it? [y/n]: "; { [[ $REPLY = y* ]] && $2; } }
    }

    install_brew

    install_package "node"    "brew install node"
    install_package "python2" "brew install python"
    install_package "python3" "brew install python3"
    install_package "fortune" "brew install fortune"
    install_package "tree"    "brew install tree"
    install_package "md5sum"  "brew install md5sha1sum"
    install_package "cmake"   "brew install cmake"
    install_package "mongod"  "brew install mongodb"
    install_package "cloc"    "brew install cloc"
    install_package "nano"    "brew install nano"
    install_package "ffmpeg"  "brew install ffmpeg"
    install_package "wget"    "brew install wget"
    install_package "tmux"    "brew install tmux"
    install_package "mvn"     "brew install maven"
    install_package "mpd"     "brew install mpd"
    install_package "mpc"     "brew install mpc"

    find ~/Library/Fonts | grep "FiraCode" > /dev/null 2>&1 || brew tap caskroom/fonts && brew cask install font-fira-code

    install_cask java
    install_cask google-chrome
    install_cask audacity
    install_cask atom
    install_cask slack

    brew tap caskroom/versions
    install_cask iterm2-nightly

elif [[ $OS == "linux" ]]; then

    function install_package() {
        command -v $1 >/dev/null 2>&1 || { read -p "$1 not found. Do you want to install it? [y/n]: "; { [[ $REPLY = y* ]] && $2; } }
    }

    if [[ `command -v nodejs` = "" ]] || [[ `nodejs --version 2>/dev/null` = "v0"* ]]; then
        read -p "nodejs not found. Do you want to install it? [y/n]: "
        [[ $REPLY = y* ]] && curl -sL https://deb.nodesource.com/setup_6.x | sudo -E bash - && sudo apt-get install -y nodejs
    fi

    install_package "python2" "sudo apt-get install python"
    install_package "pip"     "sudo apt-get install python-pip"
    install_package "python3" "sudo apt-get install python3"
    install_package "pip3"    "sudo apt-get install python3-pip"
    install_package "fortune" "sudo apt-get install fortune-mod"
    install_package "tree"    "sudo apt-get install tree"
    install_package "cmake"   "sudo apt-get install cmake"
    install_package "mongod"  "sudo apt-get install mongodb-server"
    install_package "cloc"    "sudo apt-get install cloc"
    install_package "tmux"    "sudo apt-get install tmux"
    install_package "nmap"    "sudo apt-get install nmap"
    install_package "mpd"     "sudo apt-get install mpd"

fi

install_package "express"    "sudo npm install -g express-generator"
install_package "youtube-dl" "sudo pip install youtube-dl"


function install_atom_package() {
    if [[ ! -d "$HOME/.atom/packages/$1" ]]; then
        read -p "$1 not found. Do you want to install it? [y/n]: "
        [[ $REPLY = y* ]] && apm install "$1"
    fi
}

install_atom_package "dark-code-syntax"
install_atom_package "seti-ui"
install_atom_package "atom-beautify"
install_atom_package "minimap"
install_atom_package "emmet"
