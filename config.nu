# config.nu
#
# Installed by:
# version = "0.103.0"
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
#
# You can open this file in your default editor using:
# config nu
#
# See `help config nu` for more options
#
# You can remove these comments if you want or leave
# them for future reference.

$env.config.show_banner = false
$env.config.edit_mode = 'vi'

$env.PROMPT_INDICATOR_VI_NORMAL = "❯ "

alias la = ls -al
alias o = ^open
alias tma = tmux attach
alias k = kubectl
alias master = git checkout master
alias main = git checkout main

const extra_config_path = "~/extra.nu"
source (if ($extra_config_path | path exists) { $extra_config_path } else { null })

mkdir ($nu.data-dir | path join "vendor/autoload")
starship init nu | save -f ($nu.data-dir | path join "vendor/autoload/starship.nu")

if $nu.is-interactive {
  fortune -s
}
