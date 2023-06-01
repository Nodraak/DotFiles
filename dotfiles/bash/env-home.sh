#!/usr/bin/env bash

# dual monitor - dont forget to reset conky
# arandr
alias dmen='xrandr --output HDMI1 --mode 1440x900 --above LVDS1 && ~/.conky/starter.py'
alias dmdis='xrandr --output HDMI1 --off && ~/.conky/starter.py'
