#!/bin/bash

NEWUSER=nodraak
ADMINGROUP=sudo # or admin or root

useradd $NEWUSER  # create user
passwd $NEWUSER  # password
mkdir /home/$NEWUSER  # home dir 1/2
chown $NEWUSER:users /home/$NEWUSER  # home dir 2/2
chsh -s /bin/bash $NEWUSER  # default shell on login
usermod -a -G $ADMINGROUP $NEWUSER  # sudoer
# todo : copy initial files : .bashrc .vimrc
