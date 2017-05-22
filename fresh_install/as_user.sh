#!/usr/bin/env bash

git clone https://github.com/Nodraak/dotfiles
cd dotfiles && ./install.py

sudo apt-get install -y --no-install-recommends \
    bash-completion \
    python-pip python-dev build-essential make cmake \
    unzip evince zathura eog \
    htop iotop iftop \
    xorg lightdm i3 suckless-tools \
    i3blocks i3lock dunst uswsusp xbacklight xautolock xsel feh conky redshift \
    itstool libxml2-utils intltool pkg-config libglib2.0-dev libgtk-3-dev  # moserial

sudo pip install thefuck scandir

sudo apt-get install -y --no-install-recommends \
    firefox-esr pcmanfm gitg

# sublime-text https://www.sublimetext.com/2 download, extract, move to /opt, ln -s sublime_text /usr/bin/sublime
# moserial http://ftp.gnome.org/pub/GNOME/sources/moserial/ xz --decompress, tar -xf, ./configure, make, sudo make install

exit
# ----

thunderbird
music: amarok
irc: xchat
audocity
gimp
WIFI
gdb
curl, wget
latex, pandoc, texlive
libreoffice
transmission
vlc
steam
nmap
valgrind
matplotlib, numpy, request, scipy

