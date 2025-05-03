$env.config.show_banner = false
$env.config.edit_mode = 'vi'

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

const extra_config_path = "~/extra.nu"
source (if ($extra_config_path | path exists) { $extra_config_path } else { null })

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

if $nu.is-interactive {
  fortune -s
}
