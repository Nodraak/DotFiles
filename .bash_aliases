#!/usr/bin/env bash

# export or not export -> http://unix.stackexchange.com/questions/107851/using-export-in-bashrc

#set -u # exit when your script tries to use undeclared variables

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

#
# Fancy prompt PS1
#

_ps1_update () {
    local last_cmd_ret="$?"  # must be first

    local tmp
    PS1=""

    # window title
    PS1+=$(printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}")

    # date
    PS1+="${Cyan}\t${NC} "

    # login + hostname
    tmp="${USER}@${HOSTNAME}"
    if [[ "$tmp" = "nodraak@macbian8" ]]; then
        PS1+="${Green}$tmp${NC} "
    else
        PS1+="${Yellow}$tmp${NC} "
    fi

    # last cmd ret
    if [[ "$last_cmd_ret" != "0" ]]; then
        PS1+="${Red}$last_cmd_ret${NC} "
    fi

    # git
    tmp="$(__git_ps1 "[%s]")"
    if [[ -n "$tmp" ]]; then
        PS1+="${Yellow}$tmp${NC} "
    fi

    # cwd
    PS1+="${Blue}\w${NC} "

    # finally, new line + user/root prompt
    PS1+="\n\$ "

    # no "export PS1" needed
}

PROMPT_COMMAND="_ps1_update"

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto verbose git"

#
# Aliases
#

# basic
alias ll='ls -lGh'
alias la='ls -lGha'
alias lla='la'
alias grep='grep --color'

alias py='python'
alias py3='python3'
alias ipy='ipython'
alias pip3='python3 -m pip'

# dev
alias gcc='gcc -fdiagnostics-color=auto'
alias g='git'  # now this is what I call 'lazy'
complete -o default -o nospace -F _git g
alias gg='gitg'
alias sba='source ../bin/activate'
alias cc='compass compile'
complete -o nospace -F _filedir_xspec cc
alias pmr='python manage.py runserver'
alias pylint='pylint --comment=y'
complete -o nospace -F _filedir_xspec pylint
alias pylintd='pylint --load-plugins pylint_django'

cvg () {
    coverage erase
    echo "Starting tests ..."
    coverage run ./manage.py test
    echo "Generating html report ..."
    coverage html
}

# misc
alias pdflatex='pdflatex -file-line-error -halt-on-error'
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'
HISTIGNORE='jrnl *'  # no export needed
eval "$(thefuck-alias)"  # pip thefuck
bind Space:magic-space  # expand !!, ^old^new, etc

#
# Misc stuff
#

alias texspell="aspell -d en -t -c MiniProject.tex --extra-dicts=custom.rws"
# sudo aspell --lang=en create master /usr/lib/aspell/custom.rws < ./dic.txt

export EDITOR="vim"  # for git, crontab, ...

o () {
    local file ext cmd

    if [ $# -eq 0 ];
    then
        echo 'No arg, I need something to open.'
        exit 1
    fi

    file="$1"
    ext="${file##*.}"

    case $ext in
        png|jpg|jpeg )
            cmd="eog"
            ;;
        mp3|flac|mp4|mkv|avi )
            cmd="vlc"
            ;;
        pdf )
            #cmd="evince"
            cmd="zathura"
            ;;
        txt|md|tex|c|h|py|css|scss|js|json|sh )
            cmd="sublime"
            ;;
        html )
            cmd="firefox"
            ;;
        * )
            if [ $# -eq 1 ];
            then
                case $ext in
                    zip )
                        cmd="unzip"
                        ;;
                    gz )
                        cmd="tar -xzf"
                        ;;
                    * )
                        echo "unknown extension ($ext), or tricky cmd (gz, ...), using caja for opening $@"
                        cmd="caja"
                        ;;
                esac
            else
                echo "unknown extension ($ext), or tricky cmd (gz, ...), using caja for opening $@"
                cmd="caja"
            fi
            ;;
    esac

    exec "$cmd" "$@" &
}
complete -o nospace -F _filedir_xspec o

ssh () {
    echo -n -e "\e]0;ssh - $@\a"
    /usr/bin/ssh "$@"
}

export GOPATH=~/gopath
export PATH=$GOPATH:$GOPATH/bin:${PATH}
export DRIVE_GOMAXPROCS=8

#
# Unused
#

#alias netmap='nmap -v -sn'

# ece - fpga basys2
#alias xilinx='env WINEPREFIX="/home/nodraak/.wine" wine C:\\windows\\command\\start.exe /Unix /home/nodraak/.wine/dosdevices/c:/users/Public/Bureau/Xilinx\ \ ISE\ 9.2i.lnk &> /dev/null'
#alias tobasys='sudo djtgcfg prog -d Basys2 -i 0 -f'

#
# Tmp stuff (to be deleted at the end of the year)
#

alias gpsServer="rdesktop -u user -p user -a 16 192.168.1.104 -g 90%"
alias tamere='klog achard15'

#
# Finally, stuff that print something
#

#linuxlogo

# Makes our day a bit more fun !
if [ -x /usr/games/fortune ]; then
    /usr/games/fortune -s
fi

# Makes a more readable output.
alias du='du -kh'
alias df='df -kTh'

function xtitle()
{
    case "$TERM" in
    *term* | rxvt)
        echo -en  "\e]0;$*\a" ;;
    *)  ;;
    esac
}


# Aliases that use xtitle
alias top='xtitle Processes on $HOST && top'
alias make='xtitle Making $(basename $PWD) ; make'

__no_exe__ () {

# .. and functions
function man()
{
    for i ; do
        xtitle The $(basename $1|tr -d .[:digit:]) manual
        command man -a "$i"
    done
}

function extract()      # Handy Extract Program
{
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2)   tar xvjf $1     ;;
            *.tar.gz)    tar xvzf $1     ;;
            *.bz2)       bunzip2 $1      ;;
            *.rar)       unrar x $1      ;;
            *.gz)        gunzip $1       ;;
            *.tar)       tar xvf $1      ;;
            *.tbz2)      tar xvjf $1     ;;
            *.tgz)       tar xvzf $1     ;;
            *.zip)       unzip $1        ;;
            *.Z)         uncompress $1   ;;
            *.7z)        7z x $1         ;;
            *)           echo "'$1' cannot be extracted via >extract<" ;;
        esac
    else
        echo "'$1' is not a valid file!"
    fi
}

# Multimedia
complete -f -o default -X \
'!*.+(gif|GIF|jp*g|JP*G|bmp|BMP|xpm|XPM|png|PNG)' xv gimp ee gqview
complete -f -o default -X '!*.+(mp3|MP3)' mpg123 mpg321
complete -f -o default -X '!*.+(ogg|OGG)' ogg123
complete -f -o default -X \
'!*.@(mp[23]|MP[23]|ogg|OGG|wav|WAV|pls|\
m3u|xm|mod|s[3t]m|it|mtm|ult|flac)' xmms
complete -f -o default -X '!*.@(mp?(e)g|MP?(E)G|wma|avi|AVI|\
asf|vob|VOB|bin|dat|vcd|ps|pes|fli|viv|rm|ram|yuv|mov|MOV|qt|\
QT|wmv|mp3|MP3|ogg|OGG|ogm|OGM|mp4|MP4|wav|WAV|asx|ASX)' xine

}

