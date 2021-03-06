# Ask for sudo permission upfront
sudo -v

# Symlink bash_profile, inputrc, and bashrc files into home directory
ln -s ~/dotfiles/.{bash_profile,bashrc,inputrc,gitconfig,tmux.conf} ~/
ln -s ~/dotfiles/data/.emacs.d ~/

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
