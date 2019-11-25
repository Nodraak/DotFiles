#!/usr/bin/env bash

# export or not export -> http://unix.stackexchange.com/questions/107851/using-export-in-bashrc

DIR="$HOME/dotfiles/dotfiles/bash/"

# basics
source "$DIR/colors.sh"
source "$DIR/xtitle.sh"
source "$DIR/ps1.sh"  # depends on colors and xtitle
source "$DIR/env.sh"
source "$DIR/aliases.sh"
source "$DIR/git-completion.sh"

# docker X11 forwarding
#xhost +local:nodraak > /dev/null

# funcs
source "$DIR/func-open.sh"
source "$DIR/func-latex.sh"
source "$DIR/func-pdf.sh"
source "$DIR/func-miscs.sh"

# env specific
#source "$DIR/gmv.sh"
