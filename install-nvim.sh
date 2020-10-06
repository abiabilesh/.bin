#!/bin/bash
THIS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install neovim
sudo dnf install -y snapd
sudo ln -f -s /var/lib/snapd/snap /snap
snap list nvim
if [ $? -ne 0 ]
then 
    sleep 90 # wait for snap device is seeded
    sudo snap install --beta nvim --classic
fi

# install init.vim
mkdir -p ~/.config/nvim/
ln -f -s $THIS_SCRIPT_PATH/_vimrc ~/.config/nvim/init.vim

# install plugins
/snap/bin/nvim -c "PlugInstall --sync" -c "PlugUpdate --sync" -c "qall"
/snap/bin/nvim --headless -c "call firenvim#install(0, 'export PATH=\"$PATH\"')" -c quit
/snap/bin/nvim -c ":call coc#util#install()" -c qall

# set up coc
ln -s $THIS_SCRIPT_PATH/coc-settings.json ~/.config/nvim/coc-settings.json

# More instructions on firenvim
# https://jdhao.github.io/2020/01/01/firenvim_nvim_inside_browser/
