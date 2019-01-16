source ~/dotfiles/.os

alias install="source ~/dotfiles/install.sh"

function update() {

  cwd=$(pwd)

  cd ~/dotfiles
  
  echo "Pulling new data from https://github.com/tarunbod/dotfiles"
  git pull

  install

  if [[ $OS == "macos" ]]; then

      brew update
      brew upgrade --all

      brew prune
      brew cleanup
      brew cask cleanup

  elif [[ $OS == "linux" ]]; then

      apt-get update
      apt-get upgrade

  fi

  sudo pip install --upgrade pip
  sudo pip3 install --upgrade pip
  sudo pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U
  sudo pip3 freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip3 install -U
  sudo pip install --upgrade setuptools
  sudo pip3 install --upgrade setuptools

  sudo npm update -g

  cd $cwd

}

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

shopt -s histappend
shopt -s cdspell

if [[ $OS == "macos" ]]; then
    export LSCOLORS="gxfxcxdxbxegedabagacad"
else
    export LSCOLORS="di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
fi

export PATH=~/bin:/usr/local/bin:/usr/local/sbin:/usr/games:$PATH
export EDITOR="vi";
export NODE_REPL_HISTORY=~/.node_history;
export NODE_REPL_HISTORY_SIZE='32768';
export PYTHONIOENCODING='UTF-8';

for file in ~/dotfiles/.{alias,functions,bash_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

if [[ -f ~/.extra ]]; then
    source ~/.extra
fi

if command -v tmux >/dev/null 2>&1 && [[ ! -n $TMUX ]] && [[ ! -n no_tmux ]]; then
    tmux new -d -s 0 2>/dev/null
    tmux attach -t 0
fi

fortune -s;
echo;
echo "TODO:" 
todo.py list
