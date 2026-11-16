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

# generate ssh key
if [[ ! -f ~/.ssh/id_ed25519 ]]; then
    read -p "ssh key not found. Do you want to generate it? [y/n]: "
    [[ $REPLY = y* ]] && ssh-keygen -t ed25519 -N "" -f ~/.ssh/id_ed25519 -C "$(whoami)@$(hostname)"
fi

# Ask for confirmation and install programs/packages
read -p "Do you want to install programs and packages? [y/n]: "
[[ $REPLY = y* ]] && exec -l $SHELL ~/dotfiles/install.sh
