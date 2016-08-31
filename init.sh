# Ask for sudo permission upfront
sudo -v

# Symlink bash_profile, inputrc, and bashrc files into home directory
ln -s ~/dotfiles/.{bash_profile,bashrc,inputrc,gitconfig} ~/

# Source script to identify OS
source ~/dotfiles/.os

# Install programs/packages
source ~/dotfiles/install.sh

if [[ $OS == "macos" ]]; then
    # Setup defaults for macOS
    source ~/dotfiles/.macos
fi

# Reload the shell to have changes take effect
exec $SHELL -l
