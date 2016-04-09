#!/usr/bin/env bash

# export or not export -> http://unix.stackexchange.com/questions/107851/using-export-in-bashrc

#set -u # exit when your script tries to use undeclared variables

#
# Set title of terminal, used by PS1 and some alias
#

set_xtitle () {
    case "$TERM" in
        *term* | rxvt)
            echo -en "\033]0;$@\007"
            ;;
        *)
            ;;
    esac
}

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
    set_xtitle "${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}"

    # virtual env
    if [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ];
    then
        virtual_env=$(basename "$VIRTUAL_ENV")
        if [ "$virtual_env" != "" ];
        then
            PS1+="($virtual_env) "
        fi
    fi

    # date
    PS1+="${Cyan}\t${NC} "

    # login + hostname
    tmp="${USER}@${HOSTNAME}"
    if [[ "$tmp" = "nodraak@macbian8" ]]; then
        PS1+="${Green}$tmp${NC} "
    else
        PS1+="${Red}$tmp${NC} "
    fi

    # git
    if [[ "$(type -t __git_ps1)" = "" ]]; then
        PS1+="${Red}gitPS1NotFound${NC} "
    else
        tmp="$(__git_ps1 "[%s]")"
        if [[ -n "$tmp" ]]; then
            PS1+="${Yellow}$tmp${NC} "
        fi
    fi

    # last cmd ret
    if [[ "$last_cmd_ret" != "0" ]]; then
        PS1+="${Red}$last_cmd_ret${NC} "
    fi

    # cwd
    PS1+="${Blue}\w${NC} "

    # finally, new line + user/root prompt
    PS1+="\n\\$ "

    # no "export PS1" needed
}

PROMPT_COMMAND="_ps1_update"

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUPSTREAM="auto verbose git"

#
# Aliases
#

# basic
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

alias ls='ls --color'
alias ll='ls -lGh'
alias la='ls -lGha'
alias lla='la'
alias grep='grep --color'
alias du='du -kh'
alias df='df -khT'

alias ipy='ipython'
alias py3='python3'

# dev
alias gcc='gcc -fdiagnostics-color=auto'

alias g='git'  # now this is what I call 'lazy'
complete -o default -o nospace -F _git g
source /usr/share/bash-completion/completions/git

alias gg='set_xtitle "gitg" ; gitg'
alias sba='source ../bin/activate'
alias cc='compass compile'
complete -o nospace -F _filedir_xspec cc
alias pmr='set_xtitle "python manage.py runserver" ; python manage.py runserver'
alias pylint='pylint --comment=y'
complete -o nospace -F _filedir_xspec pylint
alias pylintd='pylint --load-plugins pylint_django'

cvg () {
    set_xtitle "coverage"
    coverage erase
    echo "Starting tests ..."
    coverage run ./manage.py test
    echo "Generating html report ..."
    coverage html
}

# misc
_pdflatex () {
    set_xtitle "pdfLaTeX - $@"
    /usr/bin/env pdflatex -file-line-error -halt-on-error "$@"
}
alias pdflatex='_pdflatex'
HISTIGNORE='jrnl *'  # no export needed
bind Space:magic-space  # expand !!, ^old^new, etc

# https://github.com/nvbn/thefuck
eval "$(thefuck-alias)"
alias please='fuck'


#
# Misc stuff
#
alias htop='set_xtitle "htop - ${HOSTNAME}" ; htop'
texspell () {
    if [ $# -eq 0 ]
    then
        echo "Usage: texspell <lang> [file or dir]"
        return 0
    fi

    lang="$1"
    if [ $# -eq 2 ]
    then
        dir="$2"
    else
        dir="."
    fi
    if [ -f "/usr/lib/aspell/custom_${lang}.rws" ]
    then
        dict="--extra-dicts=custom_${lang}.rws"
    else
        dict=""
    fi

    for f in $(find $dir | grep "\.tex$"); do
        echo "aspell $lang $f $dict"
        aspell -d "$lang" -t "$dict" -c "$f"
    done
}
#texdic () {
#    sudo aspell --lang=en create master /usr/lib/aspell/custom_en.rws < ./dic.txt
#}

export EDITOR="vim"  # for git, crontab, ...

o () {
    local cmd

    if [[ $# -eq 0 ]]; then
        echo 'Error: argument expected.'
        return 1
    fi

    file -E "$1"
    if [[ $?  -ne 0 ]]; then
        echo 'Error: File not found.'
        return 2
    fi

    cmd=""

    case $1 in
        *.png|*.jpg|*.jpeg )
            cmd="eog"
            ;;
        *.mp3|*.flac|*.mp4|*.mkv|*.avi )
            cmd="vlc"
            ;;
        *.pdf )
            #cmd="evince"
            cmd="zathura"
            ;;
        *.txt|*.md|*.tex|*.c|*.h|*.py|*.css|*.scss|*.js|*.json|*.sh )
            cmd="sublime"
            ;;
        *.html )
            cmd="firefox"
            ;;
        * )
            if [ $# -eq 1 ];
            then
                case $1 in
                    *.tar.bz2)  cmd="tar xvjf"      ;;
                    *.tar.gz)   cmd="tar xvzf"      ;;
                    *.bz2)      cmd="bunzip2"       ;;
                    *.rar)      cmd="unrar x"       ;;
                    *.gz)       cmd="gunzip"        ;;
                    *.tar)      cmd="tar xvf"       ;;
                    *.tbz2)     cmd="tar xvjf"      ;;
                    *.tgz)      cmd="tar xvzf"      ;;
                    *.zip)      cmd="unzip"         ;;
                    *.Z)        cmd="uncompress"    ;;
                    *.7z)       cmd="7z x"          ;;
                esac
            fi
            ;;
    esac

    if [[ "$cmd" = "" ]]; then
        echo Error: unknown extension, using caja for opening "$@"
        cmd="caja"
    fi

    exec $cmd "$@" &
}
complete -o nospace -F _filedir_xspec o

# how can I make this more generic ?
py () {
    set_xtitle "python - $@"
    /usr/bin/env python "$@"
}
ssh () {
    set_xtitle "ssh - $@"
    /usr/bin/env ssh "$@"
}
man () {
    set_xtitle "man - $@"
    /usr/bin/env man "$@"
}
sublime () {
    set_xtitle "sublime - $@"
    /usr/bin/env sublime "$@"
}
gitsh () {
    set_xtitle "gitsh"
    /usr/bin/env gitsh "$@"
}

export GOPATH=~/gopath
export PATH=$GOPATH:$GOPATH/bin:${PATH}
export DRIVE_GOMAXPROCS=8

#
# Tmp / unused stuff (to be deleted at the end of the year)
#

#alias netmap='nmap -v -sn'

# ece - fpga basys2
#alias xilinx='env WINEPREFIX="/home/nodraak/.wine" wine C:\\windows\\command\\start.exe /Unix /home/nodraak/.wine/dosdevices/c:/users/Public/Bureau/Xilinx\ \ ISE\ 9.2i.lnk &> /dev/null'
#alias tobasys='sudo djtgcfg prog -d Basys2 -i 0 -f'

# aau
alias gpsServer="rdesktop -u user -p user -a 16 192.168.1.104 -g 70%"
alias tamere='klog achard15'

#
# Finally, stuff that prints something
#

#linuxlogo

# Makes our day a bit more fun !
if [ -x /usr/games/fortune ]; then
    /usr/games/fortune -s | cowsay
fi

#
# ----------------------------------
#

grepdf () {
    if [ $# -ne 2 ] && [ $# -ne 3 ]; then
        echo "Usage: grepdf <pattern> <path> [<grep opt>]"
        return 0
    fi

    pattern=$1
    path=$2
    grepopt=""
    if [ $# -eq 3 ]; then
        grepopt=$3
    fi

    find_cmd="pdftotext -q '{}' - | grep $grepopt --with-filename --label='{}' --color \"$pattern\""
    find "$path" -name "*.pdf" -exec sh -c "$find_cmd" \;
}

whereispylib () {
    py -c "import $1; print $1.__path__"
}

airdroid_proxy () {
    mitmproxy -s test_mtimproxy.py -R https://192.168.87.101:8890/ -b 127.0.0.1 -p 8080
}

getlyrics () {
    kid3-cli -c "get comment" "$(mocp --info | grep File | cut -b 7-)"
}

alias tmux='TERM=screen-256color tmux'  # keep vim's user defined theme
