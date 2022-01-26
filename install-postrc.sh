#!/bin/bash
THIS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# create a postrc file
POSTRC=$THIS_SCRIPT_PATH/postrc
echo "source $THIS_SCRIPT_PATH/alias.sh" > $POSTRC
echo "export PATH=\$PATH:$THIS_SCRIPT_PATH/" >> $POSTRC
echo "export EDITOR=vim" >> $POSTRC
echo "export TERM=xterm-256color" >> $POSTRC
echo 'export FZF_DEFAULT_COMMAND="fd --type f"' >> $POSTRC
echo 'export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"' >> $POSTRC
echo "export VAGRANT_DEFAULT_PROVIDER=virtualbox" >> $POSTRC

# install postrc
# TODO: check if it is already installed
echo "[ -f $POSTRC ] && source $POSTRC" >> ~/.zshrc

