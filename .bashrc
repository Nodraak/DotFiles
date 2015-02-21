
# prompt
SEP="\e[0;32m#\e[m"
AT="\e[0;32m@\e[m"
export PS1="$SEP \u$AT\h $SEP \t $SEP \j $SEP \w $SEP\n\$"
PROMPT_COMMAND='echo -ne "\033]0;$(basename "$(pwd)")\007"'

# git
export EDITOR=vim

# basic
alias ll='ls -l -G'
alias la='ls -la -G'
alias lla='la'
alias grep='grep --color'

# dev foundation + django + docker + es
alias cc='compass compile'
eval $(complete -p ls | sed 's/ls/cc/')
# cmd1 use the exact same completion options as cmd2
# eval $(complete -p cmd2 | sed 's/cmd2/cmd1/')
alias pmr='python manage.py runserver'
alias docker='sudo docker'
alias startes='sudo /usr/share/elasticsearch/bin/elasticsearch'

# ece - fpga basys2
alias xilinx='env WINEPREFIX="/home/nodraak/.wine" wine C:\\windows\\command\\start.exe /Unix /home/nodraak/.wine/dosdevices/c:/users/Public/Bureau/Xilinx\ \ ISE\ 9.2i.lnk &> /dev/null'
alias tobasys='sudo djtgcfg'

# misc
alias pdflatex='pdflatex -halt-on-error'
alias netmap='nmap -v -sn'
alias xclip="xclip -selection c"

function mplayerinfo
{
    LEN=$(mplayer -vo null -ao null -frames 0 -identify "$@" 2>/dev/null | \
        grep "^ID_LENGTH" | sed -e 's/ID_LENGTH=//g')
    HR=$(echo "$LEN/3600"|bc)
    MIN=$(echo "($LEN-$HR*3600)/60"|bc)
    SEC=$(echo "$LEN%60"|bc|cut -d '.' -f 1)
    echo $(printf "%02.0f:%02.0f:%02.0f" $HR $MIN $SEC)
}

# dropbox daemon
#~/.dropbox-dist/dropboxd

clear
linuxlogo

