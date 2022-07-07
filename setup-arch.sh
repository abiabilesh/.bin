#!/bin/bash

# install a web browser
sudo pacman -S --noconfirm yay
yay -S microsoft-edge-stable

# install documentation tools
# - paper writing
sudo pacman -S --noconfirm texlive-most texlive-bin otf-latin-modern texlive-langkorean
sudo pacman -S --noconfirm gnuplot python-pygments
sudo pacman -S --noconfirm libreoffice-fresh
# - website
sudo pacman -S --noconfirm pelican
# - lecture materials
sudo pacman -S --noconfirm pandoc python-sphinx
# - lecture tools (3574)
sudo pacman -S --noconfirm python-pexpect lcov gcovr valgrind

# install essential tools
sudo pacman -S --noconfirm base-devel python2 python3 git tmux tig htop cmake
sudo pacman -S --noconfirm tilix ttf-fira-code
sudo pacman -S --noconfirm python-cairosvg


# install Hangul fonts
sudo pacman -S --noconfirm adobe-source-han-sans-kr-fonts ttf-baekmuk noto-fonts-cjk

# install Hangul IME
# - https://ders45.blogspot.com/2017/03/manjaro-linux-17.html?m=1
# - https://archived.forum.manjaro.org/t/help-with-setting-up-ibus-for-korean/129055
# - https://forum.manjaro.org/t/guide-how-to-set-up-korean-keyboard-on-manjaro-kde/23799
echo ko_KR.UTF-8 UTF-8 | sudo tee -a /etc/locale.gen
sudo locale-gen

sudo pacman -S --noconfirm ibus ibus-hangul
echo 'export GTK_IM_MODULE=ibus'        >> ~/.xprofile
echo 'export XMODIFIERS=@im=ibus'       >> ~/.xprofile
echo 'export QT_IM_MODULE=ibus'         >> ~/.xprofile
echo 'export OOO_FORCE_DESKTOP="gnome"' >> ~/.xprofile
echo 'ibus-daemon -drx'                 >> ~/.xprofile

# install zsh
sudo pacman -S --noconfirm zsh

# install fzf
# <Ctrl-t>, <Ctrl-r>, <Alt-c>
sudo pacman -S --noconfirm fd ripgrep the_silver_searcher bat

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

# Manual configuration
# ====================
# 
# 1. auto enable bluetooth
#   /etc/bluetooth/main.conf 
#   AutoEnable=true 
#   https://forum.manjaro.org/t/bluetooth-is-disabled-by-default-after-upgrading-to-the-latest-stable/111249
#
# 2. remap CAPSLOCK to Ctrl using gnome tweak tool


