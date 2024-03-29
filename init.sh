# Ask for sudo permission upfront
sudo -v

# Symlink bash_profile, inputrc, and bashrc files into home directory
ln -s ~/dotfiles/.{bash_profile,bashrc,zshrc,inputrc,gitconfig,tmux.conf} ~/
ln -s ~/dotfiles/data/nvim ~/.config/nvim

git clone https://github.com/tarunbod/ohmyzsh.git

# Setup custom scripts
mkdir ~/bin
ln -s ~/dotfiles/scripts/{mpdlib.py,todo.py} ~/bin/

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
