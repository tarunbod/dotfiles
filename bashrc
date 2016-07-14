function update() {

  cwd=$(pwd)

  cd ~

  brew update
  brew upgrade --all

  brew prune
  brew cleanup
  brew cask cleanup

  sudo pip install --upgrade pip
  sudo pip3 install --upgrade pip
  sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
  sudo pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U
  sudo pip install --upgrade setuptools
  sudo rpip3 install --upgrade setuptools

  npm update -g

  cd $cwd

}

function install_brew() {
  if [[ ! -f /usr/local/bin/brew ]]; then
    /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap caskroom/cask
    brew install python
  fi
}

function install_package() {
  command -v "$1" >/dev/null 2>&1 || { echo "$1 not found. Installing." >&2; $2; }
}

install_brew

install_package node    "brew install node"
install_package python2 "brew install python"
install_package python3 "brew install python3"
install_package fortune "brew install fortune"
install_package tree    "brew install tree"
install_package subl    "brew cask install sublime-text"
install_package md5sum  "brew install md5sha1sum"
install_package cmake   "brew install cmake"
install_package mongodb "brew install mongodb"
install_package express "npm install -g express-generator"

shopt -s cdspell

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export LSCOLORS="gxfxcxdxbxegedabagacad"

for file in `find ~/dotfiles -type f -name ".[^.]*" -maxdepth 1`; do
  if [[ ! $file =~ "gitignore" ]]; then
      source $file
  fi
done

fortune -s
