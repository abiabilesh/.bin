#!/bin/bash

# sudo pacman -S yay
# yay -S microsoft-edge-stable

# sudo pacman -Syyu texlive-most texlive-bin

# install essential tools
sudo pacman -S base-devel git tmux tig htop cmake
sudo pacman -S tilix ttf-fira-code

# install zsh
sudo pacman -S zsh

# install fzf
# <Ctrl-t>, <Ctrl-r>, <Alt-c>
sudo apt install -y fd-find 
# ripgrep the_silver_searcher bat

# install gnome tweak tool to remap CAPSLOCK to Ctrl
sudo pacman -S gnome-tweaks

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


