#!/usr/bin/env bash

$user=xx

# keyboard
cp xx/etc_default_keyboard /etc/default/keyboard
cp conf/etc/X11/xorg /etc....
service keyboard-setup restart
reboot?

# time zone
cp xx/etc_timezone /etc/timezone

# apt
# update src: disable cdrom and add source
apt-get update -y
apt-get upgrade -y

# (very) basic packages
apt-get install -y --no-install-recommends \
    sudo vim git

# activate root for user
usermod -a -G sudo $user

sudo apt-get purge uswsusp && sudo apt-get install uswsusp # (swap issue)

reboot
