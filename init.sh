# Symlink shell init files into home directory
if [[ -f ~/.bashrc ]]; then
  mv ~/.bashrc ~/.bashrc.old
fi

if [[ -f ~/.zshrc ]]; then
  mv ~/.zshrc ~/.zshrc.old
fi

if [[ ! -f ~/.bashrc ]]; then
  ln -s ~/dotfiles/.bashrc ~/.bashrc
fi

if [[ ! -f ~/.zshrc ]]; then
  ln -s ~/dotfiles/.zshrc ~/.zshrc
fi

# create home bin dir
mkdir ~/bin

# Install programs/packages
source "~/.${SHELL##*/}rc"
source ~/dotfiles/install.sh
