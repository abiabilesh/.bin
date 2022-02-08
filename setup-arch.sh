#!/bin/bash

# install a web browser
sudo pacman -S --noconfirm yay
yay -S microsoft-edge-stable

# install documentation tools
# - paper writing
sudo pacman -S --noconfirm texlive-most texlive-bin gnuplot python-pygments
sudo pacman -S --noconfirm libreoffice-still
# - lecture materials
sudo pacman -S --noconfirm pandoc python-sphinx
# - website
sudo pacman -S --noconfirm pelican

# install essential tools
sudo pacman -S --noconfirm base-devel git tmux tig htop cmake
sudo pacman -S --noconfirm tilix ttf-fira-code
sudo pacman -S --noconfirm adobe-source-han-sans-kr-fonts ttf-baekmuk 
sudo pacman -S --noconfirm fcitx5-hangul fcitx5-configtool

# install zsh
sudo pacman -S --noconfirm zsh

# install fzf
# <Ctrl-t>, <Ctrl-r>, <Alt-c>
sudo pacman -S --noconfirm fd ripgrep ripgrep the_silver_searcher bat

# install gnome tweak tool to remap CAPSLOCK to Ctrl
sudo pacman -S --noconfirm gnome-tweaks

# install vim
# - install node.js first
sudo pacman -S --noconfirm nodejs
sudo npm install -g yarn

# - install coc tools
sudo pacman -S --noconfirm clang 
sudo pacman -S --noconfirm bear

# - install x11 clipboard
sudo pacman -S  --noconfirm xclip xsel

# - install vim-x11
sudo pacman -S --noconfirm gvim

# install neovim
sudo pacman -S --noconfirm neovim

# install ncurses library
sudo pacman -S --noconfirm ncurses


