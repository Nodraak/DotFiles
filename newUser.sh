#!/bin/bash

NEWUSER=nodraak

useradd $NEWUSER
passwd $NEWUSER
mkdir /home/$NEWUSER
chown $NEWUSER:users /home/$NEWUSER
