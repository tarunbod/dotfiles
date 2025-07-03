[[ $- == *i* ]] || return

source $HOME/dotfiles/.os

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/games:$PATH
export EDITOR="nvim";
export XDG_CONFIG_HOME="$HOME/.config";

for file in ~/dotfiles/.{alias,functions,bash_prompt}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

if [[ -f ~/.extra ]]; then
    source ~/.extra
fi
