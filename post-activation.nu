#!/usr/bin/env nu

let autoload_dir = ($nu.data-dir | path join 'vendor/autoload');
mkdir $autoload_dir;
^starship init nu | save -f ($autoload_dir | path join 'starship.nu');
^carapace _carapace nushell | save -f ($autoload_dir | path join 'carapace.nu');
if (which jj | is-not-empty) {
  ^jj util completion nushell | save -f ($autoload_dir | path join 'jj.nu');
}

let vim_plugged_path = ($env.HOME | path join ".local/share/nvim/site/autoload/plug.vim");
if not ($vim_plugged_path | path exists) {
  mkdir ($vim_plugged_path | path dirname)
  try {
    http get "https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim" | save $vim_plugged_path
  } catch { |err|
    print $"Failed to download vim-plugged: ($err)"
  }
}

if (^cat ~/.ssh/*.pub | lines | each { split row ' ' | drop 1 | str join ' ' } | intersect (http get https://github.com/tarunbod.keys | lines) | is-not-empty) {
  git -C ~/dotfiles remote set-url origin git@github.com:tarunbod/dotfiles.git
}
