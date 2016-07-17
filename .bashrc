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

shopt -s cdspell

export PATH=/usr/local/bin:/usr/local/sbin:$PATH
export LSCOLORS="gxfxcxdxbxegedabagacad"
export EDITOR="nano";
export NODE_REPL_HISTORY=~/.node_history;
export NODE_REPL_HISTORY_SIZE='32768';
export PYTHONIOENCODING='UTF-8';

for file in ~/dotfiles/.{alias,functions,bash_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

fortune -s
