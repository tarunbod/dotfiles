# nu config
$env.config.show_banner = false
$env.config.edit_mode = 'vi'

# aliases
alias l = ls
alias ll = ls -al
alias o = ^open
alias tma = tmux attach
alias k = kubectl

alias master = git checkout master
alias main = git checkout main
alias gs = git status
alias gd = git diff
alias ga = git add -A
alias gc = git commit -m
alias gp = git push

def --env mkcd [ $dir_name: string ] {
  mkdir $dir_name
  cd $dir_name
}

if ('~/.secrets.json' | path exists) {
  load-env (open ~/.secrets.json)
}

# extras
const extra_config_path = "~/extra.nu"
source (if ($extra_config_path | path exists) { $extra_config_path } else { null })

$env.CARAPACE_BRIDGES = 'zsh,bash'

$env.BAT_THEME = "base16"

# fortune on shell start
if $nu.is-interactive {
  fortune -s
}
