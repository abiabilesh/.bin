#!/bin/bash
THIS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install vim
ln -s $THIS_SCRIPT_PATH/_coc.vim ~/.coc.vim
mkdir -p ~/.vim/undodir
vim -c "PlugInstall --sync" -c "PlugUpdate --sync" -c "qall"

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

