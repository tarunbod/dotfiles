#!/usr/bin/env nu

let autoload_dir = ($nu.data-dir | path join 'vendor/autoload');
mkdir $autoload_dir;
^starship init nu | save -f ($autoload_dir | path join 'starship.nu');
^carapace _carapace nushell | save -f ($autoload_dir | path join 'carapace.nu');
if (which jj | is-not-empty) {
  ^jj util completion nushell | save -f ($autoload_dir | path join 'jj.nu');
}

let vim_plugged_path = ($env.HOME | path join "/.local/share/nvim/site/autoload/plug.vim");
if not ($vim_plugged_path | path exists) {
  ^curl -fLo $vim_plugged_path --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}
