#!/bin/bash

sudo apt-get update

# install essential tools
sudo apt install -y make gcc curl wget git tmux
sudo apt install -y fonts-firacode tilix
sudo apt install -y tig htop cmake

# install zsh
sudo apt install -y zsh

# install fzf
# <Ctrl-t>, <Ctrl-r>, <Alt-c>
sudo apt install -y fd-find 
# ripgrep the_silver_searcher bat

# install gnome tweak tool to remap CAPSLOCK to Ctrl
sudo apt install -y gnome-tweak-tool

# install vim
# - install node.js first
curl -sL install-node.now.sh/lts > /tmp/.nodejs-install.sh
sudo bash /tmp/.nodejs-install.sh
sudo rm -f /tmp/.nodejs-install.sh
sudo npm install -g yarn

# - install coc tools
sudo apt install -y clang clangd clang-tools libclang-dev clang-tidy clang-format
sudo apt install -y bear

# - install x11 clipboard
sudo apt install -y xclip xsel

# - install vim-x11
sudo apt install -y vim vim-gui-common

# install neovim
sudo apt install -y neovim

# install ncurses library
sudo apt install -y ncurses-base ncurses-bin


