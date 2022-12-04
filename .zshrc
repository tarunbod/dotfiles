# ohmyzsh setup
export ZSH=$HOME/ohmyzsh
ZSH_THEME="tarunbod"
plugins=()
source $ZSH/oh-my-zsh.sh

# user config
if [[ $OS == "macos" ]]; then
    export LSCOLORS="gxfxcxdxbxegedabagacad"
else
    export LSCOLORS="di=36;40:ln=35;40:so=32;40:pi=33;40:ex=31;40:bd=34;46:cd=34;43:su=0;41:sg=0;46:tw=0;42:ow=0;43:"
fi

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/games:$PATH
export EDITOR="nvim";
export NODE_REPL_HISTORY=$HOME/.node_history;
export NODE_REPL_HISTORY_SIZE='32768';
export PYTHONIOENCODING='UTF-8';

for file in $HOME/dotfiles/.{alias,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

if [[ -f $HOME/.extra ]]; then
    source $HOME/.extra
fi

# start tmux
if command -v tmux >/dev/null 2>&1 && [[ ! -n $TMUX ]] && [[ ! -n $no_tmux ]]; then
    tmux new -d -s 0 2>/dev/null
    tmux attach -t 0
fi

# motd stuff
fortune -s;
echo;
echo "TODO:" 
todo.py list
