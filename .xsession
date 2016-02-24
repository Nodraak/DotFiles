#!/bin/bash

if [ -f ~/.conky/starter.py ]
then
    ~/.conky/starter.py &
fi

if [ -f ~/.dropbox-dist/dropboxd ]
then
    ~/.dropbox-dist/dropboxd &
fi

exit 0

