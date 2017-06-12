#!/usr/bin/env bash

APTFLAGS="-y --no-install-recommends"

#
# dot files
#

git clone https://github.com/Nodraak/dotfiles
cd dotfiles && ./install.py

#
# packages
#

# server + desktop

sudo apt-get install ${APTFLAGS} \
    bash-completion command-not-found shellcheck sl \
    build-essential make cmake autoconf automake python-pip python-dev ipython \
    unzip gzip bzip2 \
    curl wget w3m screen tmux \
    htop iotop iftop powertop stress lm-sensors \
    nmap strace \
    imagemagick jpegoptim \
    ca-certificates rsync telnet \
    pygmentize itstool libxml2-utils intltool pkg-config

sudo pip install numpy requests httpie beautifulsoup flask django pygments

sudo apt-get install ${APTFLAGS} \
    unattended-upgrades \
    fail2ban \
    logwatch logrotate \
    docker
echo "Configure these packages!"


# desktop

# TODO: wifi (b43) + bluetooth
sudo apt-get install ${APTFLAGS} \
    ethtool \
    units pyline \
    arduino gitg cloc moserial \
    gdb valgrind \
    wireshark aircrack-ng \
    wine \
    texlive pandoc aspell \
    xorg lightdm i3 suckless-tools \
    i3blocks i3lock dunst uswsusp xbacklight xautolock \
    xsel feh conky redshift \
    evince zathura eog pcmanfm caja \
    thunderbird amarok xchat firefox-esr \
    transmission-gtk vlc qemu virtualbox virtualbox-guest-additions-iso \
    tor torbrowser-launcher virtualbox-guest-additions-iso geogebra kmymoney \
    steam \
    libreoffice gimp audacity filezilla eagle \
    libglib2.0-dev libgtk-3-dev

sudo pip install matplotlib jrnl mbed-cli youtube-dl

# sublime-text https://www.sublimetext.com/3 download, extract, move to /opt, ln -s sublime_text /usr/bin/sublime, config files + license
# dropbox + gdrive
# migrate Documents/ Images/ Musique/ Telechargements/

exit
# ----

i3
suckless-tools # dmenu
i3blocks
i3locks
dunst / feh # bg ?
uswsusp # suspend, ...
xbacklight
xautolock
scrot # screenshots

wicd / wpasupplicant

gnu gcc arm
android-tools-adb
dia
gnome-*
gnuplot
gpredict
gperf
graphviz
quassel
xctu (xbee) ?
chromium / opera ?
mono

Download ISO
    debian
    tails
    systemrescuecd
    kali / bodhi cbpp dracOs Parrot Solus
    rpi

