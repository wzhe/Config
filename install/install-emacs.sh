#!/bin/bash

source install-pre.sh

$INSTALL install build-essential automake texinfo libjpeg-dev libncurses5-dev
$INSTALL install libtiff5-dev libgif-dev libpng-dev libxpm-dev libgtk-3-dev libgnutls28-dev
mkdir -p ~/install
cd ~/install
git clone --depth 1 -b master https://github.com/emacs-mirror/emacs.git
cd emacs/
./autogen.sh
./configure --with-mailutils
sudo make install
