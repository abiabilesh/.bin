#!/bin/bash
THIS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install nodejs first -- for fedora 28 or older
sudo dnf install -y yarnpkg
if [ $? -ne 0 ]
then 
    sudo dnf install -y gcc-c++ make
    curl -sL https://rpm.nodesource.com/setup_12.x | sudo -E bash -
    sudo dnf remove -y nodejs # clean install
    sudo dnf install -y nodejs
    sudo npm install -g yarn
fi

# install coc tools
sudo dnf install -y clang clang-devel clang-libs clang-tools-extra
sudo dnf install -y clang-analyzer npm 
sudo dnf install -y bear

# install x11 clipboard
sudo dnf install -y xclip xsel

# install vim
ln -s $THIS_SCRIPT_PATH/_coc.vim ~/.coc.vim
sudo dnf install -y vim vim-X11
mkdir -p ~/.vim/undodir
vim +PlugInstall +PlugUpdate +qall

# set up coc
ln -s $THIS_SCRIPT_PATH/coc-settings.json ~/.vim/coc-settings.json
clang-tidy --checks='-*,bugprone-*' --dump-config > ~/.clang-tidy
vim -c ":call coc#util#install()" -c qall

# install thesaurus
rm -f $THIS_SCRIPT_PATH/mthesaur.txt
wget http://www.gutenberg.org/files/3202/files/mthesaur.txt
mkdir -p ~/.vim/thesaurus
ln -s $THIS_SCRIPT_PATH/mthesaur.txt ~/.vim/thesaurus/mthesaur.txt

# install github-markdown css
rm -f $THIS_SCRIPT_PATH/github-markdown.css  
wget https://raw.githubusercontent.com/sindresorhus/github-markdown-css/gh-pages/github-markdown.css
ln -f -s $THIS_SCRIPT_PATH/github-markdown.css ~/.markdown.css

