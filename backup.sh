#!/bin/bash
THIS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

SOURCE_DIR=$HOME
TARGET_DIR="/run/media/changwoo/changwoo@vt.edu"

if [ ! -d $TARGET_DIR ]; then
    echo -e "\e[91mBackup drive is not mounted to $TARGET_DIR!\e[0m"
    exit 1
fi

echo -e "\e[32mBackup $SOURCE_DIR to $TARGET_DIR...\e[0m"
rsync -av --exclude={.cache,.config,.local,.zoom,.vim,.emacs.d,.oh-my-zsh,.vagrant.d,.texlive2021,Downloads,*~,*.o,vmlinuz*,System.map*,initramfs*} \
      $SOURCE_DIR $TARGET_DIR
