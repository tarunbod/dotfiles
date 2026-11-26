#!/usr/bin/env nu

let autoload_dir = ($nu.data-dir | path join 'vendor/autoload');
mkdir $autoload_dir;
starship init nu | save -f ($autoload_dir | path join 'starship.nu');
carapace _carapace nushell | save -f ($autoload_dir | path join 'carapace.nu');
jj util completion nushell | save -f ($autoload_dir | path join 'jj.nu');
