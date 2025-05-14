source $HOME/dotfiles/.os

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/games:$PATH
export EDITOR="nvim";
export XDG_CONFIG_HOME="$HOME/.config";

for file in $HOME/dotfiles/.{alias,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

if [[ -f "$HOME/.extra" ]]; then
    source $HOME/.extra
fi

if command -v tmux >/dev/null 2>&1 && [[ ! -n $TMUX ]] && [[ ! -n $no_tmux ]]; then
  tmux new -d -s 0 2>/dev/null
  tmux attach -t 0
elif command -v nu >/dev/null 2>&1; then
  exec -l nu
fi
