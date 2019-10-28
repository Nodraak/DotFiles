#!/usr/bin/env bash

#
# Color definitions - for fancy prompt PS1 or colored man
#

# Normal Colors
Black='\e[0;30m'
Red='\e[0;31m'
Green='\e[0;32m'
Yellow='\e[0;33m'
Blue='\e[0;34m'
Purple='\e[0;35m'
Cyan='\e[0;36m'
White='\e[0;37m'

# Bold
BBlack='\e[1;30m'
BRed='\e[1;31m'
BGreen='\e[1;32m'
BYellow='\e[1;33m'
BBlue='\e[1;34m'
BPurple='\e[1;35m'
BCyan='\e[1;36m'
BWhite='\e[1;37m'

# Background
On_Black='\e[40m'
On_Red='\e[41m'
On_Green='\e[42m'
On_Yellow='\e[43m'
On_Blue='\e[44m'
On_Purple='\e[45m'
On_Cyan='\e[46m'
On_White='\e[47m'

# Color Reset
NC="\e[m"

#
# Colored man
#

# mb start blink
# md start bold
# me turn off bold, blink and underline
# so start standout (reverse video)
# se stop standout
# us start underline
# ue stop underline

export LESS_TERMCAP_mb=$'\E[0m'
export LESS_TERMCAP_md=$'\E[0;32m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_so=$'\E[0;31m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_us=$'\E[0;34m'
export LESS_TERMCAP_ue=$'\E[0m'
