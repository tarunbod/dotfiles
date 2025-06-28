# Ask for sudo permission upfront
sudo -v

# Symlink bash_profile, inputrc, and bashrc files into home directory

if [[ -f ~/.bashrc ]]; then
  mv ~/.bashrc ~/.bashrc.old
fi

ln -s ~/dotfiles/.{bashrc,inputrc,gitconfig,tmux.conf} ~/

# neovim
ln -s ~/dotfiles/nvim ~/.config/nvim

# nushell
mkdir -p ~/.config/nushell
ln -s ~/dotfiles/config.nu ~/.config/nushell/config.nu

ln -s ~/dotfiles/starship.toml ~/.config/starship.toml

# create home bin dir
mkdir ~/bin

# Source script to identify OS
source ~/dotfiles/.os

# Install programs/packages
source ~/dotfiles/install.sh

# Reload the shell to have changes take effect
exec $SHELL -l
