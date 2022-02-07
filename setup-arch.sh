#!/bin/bash

# udpate the package database
sudo pacman -Syy --noconfirm

# install a web browser
sudo pacman -S --noconfirm yay
yay -S microsoft-edge-stable

# install documentation tools
sudo pacman -S --noconfirm  texlive-most texlive-bin gnuplot
sudo pacman -S --noconfirm pandoc
sudo pacman -S --noconfirm  libreoffice-still

# install essential tools
sudo pacman -S --noconfirm base-devel git tmux tig htop cmake
sudo pacman -S --noconfirm tilix ttf-fira-code

# install zsh
sudo pacman -S --noconfirm zsh

# install fzf
# <Ctrl-t>, <Ctrl-r>, <Alt-c>
sudo pacman -S --noconfirm fd ripgrep ripgrep the_silver_searcher bat

# install gnome tweak tool to remap CAPSLOCK to Ctrl
sudo pacman -S --noconfirm gnome-tweaks

# install vim
# - install node.js first
curl -sL install-node.now.sh/lts > /tmp/.nodejs-install.sh
sudo bash /tmp/.nodejs-install.sh
sudo rm -f /tmp/.nodejs-install.sh
sudo npm install -g yarn

# - install coc tools
sudo pacman -S --noconfirm clang 
sudo pacman -S --noconfirm bear

# - install x11 clipboard
sudo pacnma -S  --noconfirm xclip xsel

# - install vim-x11
sudo pacnma -S --noconfirm gvim

# install neovim
sudo pacnma -S --noconfirm neovim

# install ncurses library
sudo pacnma -S --noconfirm ncurses


