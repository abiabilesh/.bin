#!/bin/bash

# sudo pacman -S yay
# yay -S microsoft-edge-stable

# sudo pacman -Syyu texlive-most texlive-bin gnuplot
# sudo pacman -Syyu libreoffice-still

# install essential tools
sudo pacman -S base-devel git tmux tig htop cmake
sudo pacman -S tilix ttf-fira-code

# install zsh
sudo pacman -S zsh

# install fzf
# <Ctrl-t>, <Ctrl-r>, <Alt-c>
sudo pacman -S fd ripgrep ripgrep the_silver_searcher bat

# install gnome tweak tool to remap CAPSLOCK to Ctrl
sudo pacman -S gnome-tweaks

# install vim
# - install node.js first
curl -sL install-node.now.sh/lts > /tmp/.nodejs-install.sh
sudo bash /tmp/.nodejs-install.sh
sudo rm -f /tmp/.nodejs-install.sh
sudo npm install -g yarn

# - install coc tools
sudo pacman -S clang 
sudo pacman -S bear

# - install x11 clipboard
sudo pacnma -S  xclip xsel

# - install vim-x11
sudo pacnma -S gvim

# install neovim
sudo pacnma -S neovim

# install ncurses library
sudo pacnma -S ncurses


