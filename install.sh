#!/bin/bash
THIS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install essential tools
sudo dnf install -y make gcc curl wget git fira-code-fonts tmux

# add myself to wheel group (for Fedora)
sudo gpasswd -a `whoami` wheel

# install dns-search domain
sudo cp $THIS_SCRIPT_PATH/30-dns-override /etc/NetworkManager/dispatcher.d/30-dns-override

# install conf files
ln -f -s $THIS_SCRIPT_PATH/_tmux.conf ~/.tmux.conf
ln -f -s $THIS_SCRIPT_PATH/_emacs ~/.emacs
ln -f -s $THIS_SCRIPT_PATH/_vimrc ~/.vimrc
ln -f -s $THIS_SCRIPT_PATH/_gvimrc ~/.gvimrc

# install zsh
sudo dnf install -y zsh util-linux-user
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.oh-my-zsh/custom/themes/powerlevel10k
sed -i '/ZSH_THEME/ s/robbyrussell/powerlevel10k\/powerlevel10k/' ~/.zshrc
chsh -s $(which zsh)

# install fzf
# <Ctrl-t>, <Ctrl-r>, <Alt-c>
sudo dnf install -y fd-find ripgrep the_silver_searcher bat
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

# install vim and other tools
$THIS_SCRIPT_PATH/install-vim.sh
$THIS_SCRIPT_PATH/install-nvim.sh
$THIS_SCRIPT_PATH/install-cpubars.sh

# finally, install postrc
$THIS_SCRIPT_PATH/install-postrc.sh

