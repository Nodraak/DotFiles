#!/usr/bin/env bash

#
# Aliases
#

# clipboard
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

# basic cmd
alias ls='ls --color'
alias ll='ls -lGh'
alias la='ls -lGha'
alias lla='la'
alias grep='grep --color'
alias pcregrep='pcregrep --color'
alias du='du -kh'
alias df='df -khT'

# more advanced cmd
alias c='clear'
alias py='python3'
alias ipy='ipython3'
alias v="vim"
alias diff='colordiff'
alias vd='vimdiff'

# dev
alias g='git'  # now this is what I call 'lazy'
complete -o default -o nospace -F _git g
alias gg='gitg'
alias gg.='gg .'
alias gcc='gcc -fdiagnostics-color=auto'
alias disas='objdump -D -F -M intel --demangle'
alias disasArm='arm-none-eabi-objdump -D -F -M intel -m i386 --demangle'

# dev - techno specific utils
#alias pylint='pylint3 --comment=y'
complete -o nospace -F _filedir_xspec pylint
#alias pylintd='pylint3 --load-plugins pylint_django'

# dual monitor - dont forget to reset conky
alias dmen='xrandr --output HDMI1 --mode 1440x900 --above LVDS1 && ~/.conky/starter.py'
alias dmdis='xrandr --output HDMI1 --off && ~/.conky/starter.py'

# misc
alias pdflatex='pdflatex -file-line-error -halt-on-error'
HISTIGNORE='jrnl *'  # no export needed
HISTCONTROL='ignorespace'
bind Space:magic-space  # expand !!, ^old^new, etc

alias sl='sl -e'
alias tmux='TERM=screen-256color tmux'  # keep vim's user defined theme
alias dmesg='dmesg -dTw'

alias ports='netstat -tulanp'
alias getlyrics='kid3-cli -c "get comment" "$(mocp --info | grep File | cut -b 7-)"'

alias iftop_wlan='sudo iftop -i wlp2s0b1'

alias youtube-dl-audio="youtube-dl --extract-audio --format 140"
