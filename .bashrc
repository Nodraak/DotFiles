
# Color definitions
black='\e[0;30m'
red='\e[0;31m'
green='\e[0;32m'
yellow='\e[0;33m'
blue='\e[0;34m'
purple='\e[0;35m'
cyan='\e[0;36m'
white='\e[0;37m'
nc="\e[m"

# prompt + title
export PS1="${cyan}\t ${green}\u${white}@${red}\h ${blue}\w${nc}\n\$"
#export PROMPT_COMMAND='echo -ne "\033]0;$(pwd)@$(hostname)\007"'
. /etc/profile.d/vte.sh # on new tab, opens in the directory I was in previously /!\ override PROMPT_COMMAND

# git
export EDITOR=vim

# basic
alias ll='ls -l -G'
alias la='ls -la -G'
alias lla='la'
alias grep='grep --color'

# dev foundation + django
alias sba='source ../bin/activate'
alias cc='compass compile'
alias pmr='python manage.py runserver'

# ece - fpga basys2
alias xilinx='env WINEPREFIX="/home/nodraak/.wine" wine C:\\windows\\command\\start.exe /Unix /home/nodraak/.wine/dosdevices/c:/users/Public/Bureau/Xilinx\ \ ISE\ 9.2i.lnk &> /dev/null'
alias tobasys='sudo djtgcfg prog -d Basys2 -i 0 -f'

# aptget
alias sag='sudo apt-get'

# misc
alias pdflatex='pdflatex -halt-on-error'
alias netmap='nmap -v -sn'
alias xclip="xclip -selection c"
alias scvls='sudo cat /var/log/syslog | tail -n 100'


# colored man

#mb      blink     start blink
#md      bold      start bold
#me      sgr0      turn off bold, blink and underline
#so      smso      start standout (reverse video)
#se      rmso      stop standout
#us      smul      start underline
#ue      rmul      stop underline

export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
export LESS_TERMCAP_md=$'\E[32m'  # begin bold
#export LESS_TERMCAP_md=$'\E[01;32;5;74m'  # begin bold
export LESS_TERMCAP_me=$'\E[0m'           # end mode
export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
export LESS_TERMCAP_so=$'\E[31m'  # begin bold
#export LESS_TERMCAP_so=$'\E[01;31;5;74m'  # begin bold
export LESS_TERMCAP_ue=$'\E[0m'           # end underline
export LESS_TERMCAP_us=$'\E[34m' # begin underline
#export LESS_TERMCAP_us=$'\E[04;34;5;146m' # begin underline

clear
linuxlogo

