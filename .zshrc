source $HOME/dotfiles/.os

export PATH=$HOME/bin:/usr/local/bin:/usr/local/sbin:/usr/games:$PATH
export EDITOR="nvim";
export XDG_CONFIG_HOME="$HOME/.config";

for file in $HOME/dotfiles/.{alias,functions}; do
    [ -r "$file" ] && [ -f "$file" ] && source "$file";
done

if [[ -f ~/.extra ]]; then
    source ~/.extra
fi

if [ -n "$REX_BIN_DIR" ]; then
  export PATH="$REX_BIN_DIR:$PATH"
fi

if [[ $- == *i* ]] && command -v nu >/dev/null 2>&1; then
  exec -l nu
fi
