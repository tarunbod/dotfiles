# Ask for sudo permission upfront
sudo -v

# Symlink shell init files into home directory
if [[ -f ~/.bashrc ]]; then
  mv ~/.bashrc ~/.bashrc.old
fi

if [[ -f ~/.zshrc ]]; then
  mv ~/.zshrc ~/.zshrc.old
fi

ln -s ~/dotfiles/.{bashrc,zshrc,gitconfig,tmux.conf} ~/

# neovim
mkdir -p ~/.config/nvim
ln -s ~/dotfiles/nvim/init.lua ~/.config/nvim/init.lua

# nushell
mkdir -p ~/.config/nushell
ln -s ~/dotfiles/config.nu ~/.config/nushell/config.nu

# starship
ln -s ~/dotfiles/starship.toml ~/.config/starship.toml

# create home bin dir
mkdir ~/bin

# Install programs/packages
source ~/dotfiles/install.sh

# Reload the shell to have changes take effect
exec $SHELL -l
