https://askubuntu.com/questions/126526/how-can-i-personalize-my-macbook-pro-touchpad
https://gist.github.com/roadrunner2/1289542a748d9a104e7baec6a92f9cd7




# Dotfiles

```bash
cd $HOME && git clone https://github.com/Nodraak/dotfiles && cd dotfiles
./install.py
```

# Base

## Apt

```bash
APTINSTALL=apt-get install -q -y

# compile/dev
$APTINSTALL build-essential make cmake autoconf automake shellcheck python3-dev python3-pip gdb
$APTINSTALL colordiff ascii
# sysadmin
$APTINSTALL htop iotop iftop powertop lm-sensors
$APTINSTALL ethtool socat dnsutils netutils-tools net-tools
$APTINSTALL telnet curl wget nmap strace
$APTINSTALL rsync stress
# X11
$APTINSTALL xorg lightdm i3 i3blocks i3lock scrot suckless-tools  # {i3lock,scrot}->lock, suckless-tools->dmenu
$APTINSTALL xbacklight libnotify-bin imagemagick gnome-control-center terminator # xbacklight, notify-send (battery), convert
$APTINSTALL conky lm-sensors redshift
#$APTINSTALL xautolock xsel feh dunst uswsusp

# bash
$APTINSTALL bash-completion command-not-found
# tools and lib
$APTINSTALL unzip gzip bzip2
$APTINSTALL ca-certificates ffmpeg imagemagick jpegoptim libxml2-utils
# apps
$APTINSTALL gitg thunderbird amarok transmission-gtk vlc kmymoney libreoffice gimp
```

## Pip

```bash
sudo pip3 install \
    requests beautifulsoup4 \
    numpy matplotlib \
    flask django \
    httpie pygments pylint youtube-dl ipython
```

## Config

```bash
#
# Wifi
#
# * Conf file crda
# * Enable apt contrib and non-free
# * Install firmware-b43-installer gnome-control-center  # b43-fwcutter
# * `XDG_CURRENT_DESKTOP=GNOME gnome-control-center`


#
# Local DNS
#
    # apt-get install dnsmasq
    # conf file dnsmask.conf
    # /etc/dhcp/dhclient.conf
    #   supersede domain-name-servers 127.0.0.1;
    #   supersede domain-name ".";
    # check it worked: nslookup nodraak.fr / nmcli

#
# Lock_on_suspend
#
# conf file /etc/systemd/system/suspend.service
# sudo systemctl enable suspend.service

#
# xbacklight
#
# $ cat /etc/X11/xorg.conf
#   Section "Device"
#        Identifier      "Card0"
#        Driver          "intel"
#        Option          "Backlight"     "/sys/class/backlight/intel_backlight"
#   EndSection

nodraak ALL=NOPASSWD:/home/nodraak/.config/i3/kbdbacklight

#
# Docker
#

# Image path: https://blog.adriel.co.nz/2018/01/25/change-docker-data-directory-in-debian-jessie/

```


## Apps

```bash
#
# Sublime
#
# * Install: Cf https://www.sublimetext.com/3
# * License
# * Plugins + config files

#
# Firefox
#
# * uninstall apt's firefox
# * download from website + install manually in /opt + symlink to /usr/bin
# * plugings:
#     * uBlock Origin https://addons.mozilla.org/en-US/firefox/addon/ublock-origin/
#     * Privacy Badger https://www.eff.org/privacybadger
#     * more extensions (cookie manager, disable ctrlq, ghostery, greasmonkey, gnotifier, live hhtp headers, modify http headers, sqlite manager, speed tweaks (speady fox), ssleuth, user agent switcher, web dev)
# * settings (cf firefoxconfig)

#
# Latex
#
    texlive
    texlive-xetex
    texlive-fonts-extra  # fontawesome - or just fonts-font-awesome
    texlive-lang-french
    texlive-latex-extra  # moderncv + patch https://tex.stackexchange.com/questions/260446/what-does-you-have-requested-package-foo-but-the-package-provides-foo-me
    texlive-science  # siunitx
    pandoc


    texlive-full
    xzdec pgf texlive-formats-extra aspell
    # finish texlive install
    # refs
    #   https://tex.stackexchange.com/questions/137428/tlmgr-cannot-setup-tlpdb
    #   https://help.ubuntu.com/community/LaTeX
    #   (https://en.wikibooks.org/wiki/LaTeX/Installing_Extra_Packages)
    sudo tlmgr init-usertree
    sudo tlmgr install framed
    sudo texhash
    sudo tlmgr option repository ftp://tug.org/historic/systems/texlive/2017/tlnet-final

#
# Steam - https://wiki.debian.org/Steam
#

Source non-free: deb http://deb.debian.org/debian/ buster main contrib non-free
dpkg --add-architecture i386
apt update
apt install steam

# KSP: https://github.com/KSP-CKAN/CKAN


```














```
# added nodraak 2017-09-12
# be nice to the hdd
tmpfs                                           /tmp            tmpfs           defaults,noatime,nosuid,nodev,mode=1777,size=1024M 0 0

# /media/Media
UUID=1286acbd-c6fc-4bd1-b57b-572e59ac32e2       /media/Media    ext4            defaults,noatime 0       2
```



docker

acpid : for suspend (https://wiki.archlinux.org/index.php/Acpid)

keyboard backlight
    https://askubuntu.com/questions/26248/how-to-get-keyboard-light-keys-working-on-macbook#26249
    https://wiki.ubuntu.com/MactelSupportTeam/PPA






#    w3m tmux screen
#    itstool intltool pkg-config
#    units \
#    arduino  cloc mercurial \
#    valgrind \
#    wireshark aircrack-ng \
#    wine \
#    evince zathura eog pcmanfm caja \
#    hexchat \
#    qemu \
#    tor geogebra  \
#    audacity filezilla \
#    libglib2.0-dev libgtk-3-dev python3-tk libopencv-dev \
#    kicad itree libnotify-bin \
#    cryptsetup


    # jrnl mbed-cli  pyline scipy opencv-python
https://github.com/jrnl-org/jrnl


    unattended-upgrades \
    fail2ban \
    logwatch logrotate \
    docker
echo "Configure these packages!"


# desktop




# unlock bluetooth :
sudo rfkill list
sudo rfkill unblock 42

# moserial
# https://wiki.gnome.org/action/show/Apps/Moserial / https://gitlab.gnome.org/GNOME/moserial.git
# deps: gnome-common yelp-tools gtk+-3.0 valac
# port access: sudo addgroup "$USERNAME" dialout
# old: tarball from http://ftp.gnome.org/pub/GNOME/sources/moserial/

# virtualbox
# apt source https://www.virtualbox.org/wiki/Linux_Downloads
# virtualbox-guest-additions-iso ?

# xctu (xbee)
# https://www.digi.com/products/xbee-rf-solutions/xctu-software/xctu

# font Hack
# http://sourcefoundry.org/hack/
#https://github.com/source-foundry/Hack


# dropbox + gdrive


# steam

exit

# --------

# TODO:

# backup
# monitoring

# migrate Documents/ Images/ Musique/ Telechargements/

# --------

ffmpef ffprobe ?
makerbot ?
arc theme ?
crosstools ?
keybase ?
opera / chromium ?

arm-none-eabi-xx (+ mbed-os + mbed-cli) + cross compiler (os_dev)
android-tools-adb
dia
gnome-*
graphviz
quassel
mono

gnuplot
gpredict
gperf

Download ISO
    debian
    tails
    systemrescuecd
    kali / bodhi cbpp dracOs Parrot Solus
    rpi


pip3 install weboob ansible
