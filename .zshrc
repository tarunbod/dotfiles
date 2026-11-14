if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

export PATH="/usr/local/bin:/usr/local/sbin:/usr/games:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"
if [[ -f "$HOME/.cargo/env" ]]; then
  source "$HOME/.cargo/env"
fi
if command -v rbenv >/dev/null 2>&1; then
  eval "$(rbenv init - zsh)"
fi

export EDITOR="nvim";
export XDG_CONFIG_HOME="$HOME/.config";

if [[ -f ~/.extra ]]; then
    source ~/.extra
fi

if [ -n "$REX_BIN_DIR" ]; then
  export PATH="$REX_BIN_DIR:$PATH"
fi

if [[ $- == *i* ]] && command -v nu >/dev/null 2>&1; then
  exec -l nu
fi
