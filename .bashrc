source ~/dotfiles/.os

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
  sudo pip3 install --upgrade setuptools

  npm update -g

  cd $cwd

}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s cdspell

export PATH=/usr/local/bin:/usr/local/sbin:$PATH

if [[ $OS == "macos" ]]; then
    export LSCOLORS="gxfxcxdxbxegedabagacad"
else
    export LSCOLORS="di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
fi

export EDITOR="nano";
export NODE_REPL_HISTORY=~/.node_history;
export NODE_REPL_HISTORY_SIZE='32768';
export PYTHONIOENCODING='UTF-8';

for file in ~/dotfiles/.{alias,functions,bash_prompt,install}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

clear; fortune -s
