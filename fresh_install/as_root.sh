#!/usr/bin/env bash

$user=xx

# keyboard
cp etc_default_keyboard /etc/default/keyboard
service keyboard-setup reload

# time zone
cp etc_timezone /etc/timezone

# apt
apt-get update
apt-get upgrade

# (very) basic packages
apt-get install -y --no-install-recommends \
    sudo vim git

# activate root for user
usermod -G sudo $user

