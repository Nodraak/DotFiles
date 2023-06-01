
## OS base

```bash
# keyboard
cp xx/etc_default_keyboard /etc/default/keyboard
cp conf/etc/X11/xorg /etc....
service keyboard-setup restart
reboot?

# time zone
cp xx/etc_timezone /etc/timezone

sudo apt-get purge uswsusp && sudo apt-get install uswsusp # (swap issue)

reboot
```

## Packages

```bash
APTINSTALL=apt-get install -q -y

# sysadmin
${APTINSTALL} powertop lm-sensors
# X11
${APTINSTALL} xorg lightdm i3 i3blocks i3lock scrot suckless-tools  # {i3lock,scrot}->lock, suckless-tools->dmenu
${APTINSTALL} xbacklight libnotify-bin imagemagick gnome-control-center terminator # xbacklight, notify-send (battery), convert
${APTINSTALL} conky lm-sensors redshift
#${APTINSTALL} xautolock xsel feh dunst uswsusp

# apps
${APTINSTALL} thunderbird amarok transmission-gtk kmymoney
```

```bash
#
# Steam - https://wiki.debian.org/Steam
#

Source non-free: deb http://deb.debian.org/debian/ buster main contrib non-free
dpkg --add-architecture i386
apt update
apt install steam

# KSP: https://github.com/KSP-CKAN/CKAN
```

```bash
apt install \
    w3m tmux screen \
    itstool intltool pkg-config \
    units \
    arduino mercurial \
    valgrind \
    wireshark aircrack-ng \
    wine \
    evince zathura eog pcmanfm caja \
    hexchat \
    qemu \
    tor geogebra  \
    audacity filezilla \
    libglib2.0-dev libgtk-3-dev python3-tk libopencv-dev \
    itree libnotify-bin \
    cryptsetup

pip3 install jrnl mbed-cli pyline opencv-python
https://github.com/jrnl-org/jrnl

apt install \
    unattended-upgrades \
    fail2ban \
    logwatch logrotate \
    docker
echo "Configure these packages!"
```

```bash
# unlock bluetooth :
sudo rfkill list
sudo rfkill unblock 42

# virtualbox
# apt source https://www.virtualbox.org/wiki/Linux_Downloads
# virtualbox-guest-additions-iso ?

# xctu (xbee)
# https://www.digi.com/products/xbee-rf-solutions/xctu-software/xctu

# font Hack
# http://sourcefoundry.org/hack/
#https://github.com/source-foundry/Hack

# dropbox + gdrive

# --------

arm-none-eabi-xx (+ mbed-os + mbed-cli) + cross compiler (os_dev)
gnome-*

gnuplot
gpredict
gperf

Download ISO
    debian
    tails
    systemrescuecd
    kali / bodhi cbpp dracOs Parrot Solus
    rpi


pip3 install weboob
```

## Conf

https://askubuntu.com/questions/126526/how-can-i-personalize-my-macbook-pro-touchpad
https://gist.github.com/roadrunner2/1289542a748d9a104e7baec6a92f9cd7

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


acpid : for suspend (https://wiki.archlinux.org/index.php/Acpid)

keyboard backlight
    https://askubuntu.com/questions/26248/how-to-get-keyboard-light-keys-working-on-macbook#26249
    https://wiki.ubuntu.com/MactelSupportTeam/PPA
```
