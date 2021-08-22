#!/bin/bash
THIS_SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# install ncurses library
sudo dnf install -y ncurses-devel ncurses

# download cpubar source code
git clone https://github.com/aclements/cpubars.git cpubars-src

# compile and install cpubars
rm -f $THIS_SCRIPT_PATH/cpubars
(cd $THIS_SCRIPT_PATH/cpubars-src; make; cp cpubars ..)

# clean up
rm -rf $THIS_SCRIPT_PATH/cpubars-src 
