#!/bin/bash

USER=$(whoami)

cd /home/$USER/.emacs.d

git clone https://github.com/alezost/alect-themes.git && \
git clone https://github.com/spotify/dockerfile-mode.git && \
git clone https://github.com/jaypei/emacs-neotree.git && \
git clone git://orgmode.org/org-mode.git
