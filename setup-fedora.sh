#!/bin/bash

# install essential tools
sudo dnf install -y make gcc curl wget git tmux
sudo dnf install -y fonts-firacode tilix

# add myself to wheel group (for Fedora)
sudo gpasswd -a `whoami` wheel

# install zsh
sudo dnf install -y zsh util-linux-user

# install fzf
# <Ctrl-t>, <Ctrl-r>, <Alt-c>
sudo dnf install -y fd-find ripgrep the_silver_searcher bat

# install vim
# - install nodejs first -- for fedora 28 or older
sudo dnf install -y yarnpkg
if [ $? -ne 0 ]
then 
    sudo dnf install -y gcc-c++ make
    curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
    sudo dnf remove -y nodejs # clean install
    sudo dnf install -y nodejs
    sudo npm install -g yarn
fi

# - install coc tools
sudo dnf install -y clang clang-devel clang-libs clang-tools-extra
sudo dnf install -y clang-analyzer
sudo dnf install -y bear

# - install x11 clipboard
sudo dnf install -y xclip xsel

# - install vim-x11
sudo dnf install -y vim vim-X11

# install neovim
sudo dnf install -y snapd
sudo ln -f -s /var/lib/snapd/snap /snap
snap list nvim
if [ $? -ne 0 ]
then 
    sleep 90 # wait for snap device is seeded
    sudo snap install --beta nvim --classic
fi

# install ncurses library
sudo dnf install -y ncurses-devel ncurses


