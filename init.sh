# Ask for sudo permission upfront
sudo -v

# Symlink bash_profile, inputrc, and bashrc files into home directory
ln -s ~/dotfiles/.{bash_profile,bashrc,zshrc,inputrc,gitconfig,tmux.conf} ~/

# neovim
ln -s ~/dotfiles/nvim ~/.config/nvim

# nushell
mkdir -p ~/.config/nushell
ln -s ~/dotfiles/config.nu ~/.config/nushell/config.nu

# create home bin dir
mkdir ~/bin

# Source script to identify OS
source ~/dotfiles/.os

# Install programs/packages
source ~/dotfiles/install.sh

if [[ $OS == "macos" ]]; then
    # Setup defaults for macOS
    cp ~/dotfiles/.tmux-osx.conf ~/
    source ~/dotfiles/.macos
fi

# Reload the shell to have changes take effect
exec $SHELL -l
