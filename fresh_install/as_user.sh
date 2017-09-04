#!/usr/bin/env bash

APTFLAGS="-y --no-install-recommends"

#
# dot files
#

cd $HOME
git clone https://github.com/Nodraak/dotfiles
cd dotfiles && ./install.py

#
# packages
#

# server + desktop

sudo apt-get install ${APTFLAGS} \
    bash-completion command-not-found shellcheck sl \
    build-essential make cmake autoconf automake python-pip python-dev \
    unzip gzip bzip2 \
    curl wget w3m screen tmux \
    htop iotop iftop powertop stress lm-sensors \
    nmap strace \
    imagemagick jpegoptim \
    ca-certificates rsync telnet \
    itstool libxml2-utils intltool pkg-config

sudo pip3 install numpy requests httpie beautifulsoup flask django pygments

sudo apt-get install ${APTFLAGS} \
    unattended-upgrades \
    fail2ban \
    logwatch logrotate \
    docker
echo "Configure these packages!"


# desktop

sudo apt-get install ${APTFLAGS} \
    ethtool socat dnsutils netutils-tools net-tools \
    units \
    arduino gitg cloc mercurial \
    gdb valgrind \
    wireshark aircrack-ng \
    wine \
    texlive-full texlive-lang-french texlive-latex-extra xzdec pgf texlive-formats-extra pandoc aspell \
    xorg lightdm i3 suckless-tools \
    i3blocks i3lock dunst uswsusp xbacklight xautolock \
    xsel feh conky redshift \
    evince zathura eog pcmanfm caja \
    thunderbird amarok hexchat \
    transmission-gtk vlc qemu \
    tor geogebra kmymoney \
    libreoffice gimp audacity filezilla \
    libglib2.0-dev libgtk-3-dev python3-tk libopencv-dev \
    kicad itree libnotify-bin \
    colordiff ascii

sudo pip3 install matplotlib jrnl mbed-cli youtube-dl pyline ipython scipy opencv-python

# finish texlive install
# refs
#   https://tex.stackexchange.com/questions/137428/tlmgr-cannot-setup-tlpdb
#   https://help.ubuntu.com/community/LaTeX
#   (https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages)
sudo tlmgr init-usertree
sudo tlmgr install framed
sudo texhash

# unlock bluetooth :
sudo rfkill list
sudo rfkill unblock 42

# moserial
# tarball from http://ftp.gnome.org/pub/GNOME/sources/moserial/

# virtualbox
# apt source https://www.virtualbox.org/wiki/Linux_Downloads
# virtualbox-guest-additions-iso ?

# xctu (xbee)
# https://www.digi.com/products/xbee-rf-solutions/xctu-software/xctu

# sublime
# download (add repo + apt-get)
# license
# plugins + config files

# Firefox
# uninstall apt's firefox
# download from website + install manually in /opt + symlink to /usr/bin
# plugings:
#   uBlock Origin https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
#   Privacy Badger https://www.eff.org/privacybadger
#   more extensions (cookie manager, disable ctrlq, ghostery, greasmonkey, gnotifier, live hhtp headers, modify http headers, sqlite manager, speed tweaks (speady fox), ssleuth, user agent switcher, web dev)
# settings (cf firefoxconfig)

# Local dns
# apt-get install dnsmasq
# conf file dnsmask.conf
# /etc/dhcp/dhclient.conf
#   supersede domain-name-servers 127.0.0.1;
#   supersede domain-name ".";
# check it worked: ndlookup nodraak.fr / nmcli

# font Hack
# http://sourcefoundry.org/hack/

# check conky + i3bar

# torbrowser

# lock_on_suspend
# conf file /etc/systemd/system/suspend.service - OR somewhere else
sudo systemctl enable suspend.service
sudo systemctl disable suspend.service

# wifi
# sudo apt-get install firmware-b43-installer
# fucking use gnome's nm-applet / gnome-settings and drop wicd
# need?: crda conf file (wifi ?)
# test it works

# dropbox + gdrive

# xbacklight
#$ cat /etc/X11/xorg.conf
#Section "Device"
#        Identifier      "Card0"
#        Driver          "intel"
#        Option          "Backlight"     "/sys/class/backlight/intel_backlight"
#EndSection

# steam

