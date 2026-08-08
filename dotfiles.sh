#!/usr/bin/env bash

mkdir -p ~/.local/bin/

# Install in case this is a fresh computer
echo "=================="
echo "Installing apps..."
echo "=================="
sudo apt update
sudo apt install zsh fzf ripgrep git tmux

sudo add-apt-repository ppa:neovim-ppa/stable
sudo apt update
sudo apt install neovim

echo "==============="
echo "cloning repo..."
echo "==============="
git clone --bare git@github.com:tatsu22/dotfiles.git $HOME/.dotfiles

# define config alias locally since the dotfiles
# aren't installed on the system yet
function config {
   git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

# create a directory to backup existing dotfiles to

mkdir -p .dotfiles-backup
config checkout

if [ $? = 0 ]; then
  echo "Checked out dotfiles from git@github.com:tatsu22/dotfiles.git";
  else
    echo "Moving existing dotfiles to ~/.dotfiles-backup";
    config checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi

# checkout dotfiles from repo
config checkout
config config status.showUntrackedFiles no

# Setup tmux
echo "=================="
echo "Setting up tmux..."
echo "=================="

git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Setup zk
echo "=================="
echo "Setting up tmux..."
echo "=================="

curl -Lo https://github.com/zk-org/zk/releases/download/v0.15.6/zk-v0.15.6-linux-amd64.tar.gz
tar -xvf zk-v0.15.6-linux-amd64.tar.gz
mv zk ~/.local/bin
rm zk-v0.15.6-linux-amd64.tar.gz

