#!/usr/bin/env bash

# export or not export -> http://unix.stackexchange.com/questions/107851/using-export-in-bashrc

DIR="$HOME/Documents/nodraak/DotFiles/dotfiles/bash/"

# basics
source "$DIR/colors.sh"
source "$DIR/env.sh"
source "$DIR/git-completion.sh"
source "$DIR/xtitle.sh"
source "$DIR/aliases.sh"  # depends on git-completion.sh
source "$DIR/ps1.sh"  # depends on colors.sh and xtitle.sh

# docker X11 forwarding
#xhost +local:nodraak > /dev/null

# funcs
source "$DIR/func-latex.sh"
source "$DIR/func-miscs.sh"
source "$DIR/func-open.sh"
source "$DIR/func-pdf.sh"

# env specific
#source "$DIR/env-home.sh"
#source "$DIR/env-gmv.sh"
source "$DIR/env-reflex.sh"
