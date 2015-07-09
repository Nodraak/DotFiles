
###########
# Custom
###########

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

# basic
alias ll='ls -l -G'
alias la='ls -la -G'
alias lla='la'
alias grep='grep --color'

# dev foundation + django
export EDITOR=vim  # for git
alias sba='source ../bin/activate'
alias cc='compass compile'
alias pmr='python manage.py runserver'
alias pylint='pylint --comment=y'
alias pylintd='pylint --load-plugins pylint_django'
alias cvg='coverage erase && coverage run ./manage.py test && coverage html'
alias docker='sudo docker'
alias pip3='python3 -m pip'
alias gg='gitg'

# ece - fpga basys2
alias xilinx='env WINEPREFIX="/home/nodraak/.wine" wine C:\\windows\\command\\start.exe /Unix /home/nodraak/.wine/dosdevices/c:/users/Public/Bureau/Xilinx\ \ ISE\ 9.2i.lnk &> /dev/null'
alias tobasys='sudo djtgcfg prog -d Basys2 -i 0 -f'

# misc
alias sag='sudo apt-get'
alias pdflatex='pdflatex -halt-on-error'
alias netmap='nmap -v -sn'
function git_merged {
    git rev-list -1 --format=%p $1 | grep -v commit | xargs -I {} sh -c 'git rev-list -1 --format="%h %ct" {}' | grep -v commit
}
alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

function o {
    if [ $# -eq 0 ];
    then
        echo 'no arg :('
        exit 1
    fi

    file=$1
    ext=${file##*.}

    case $ext in
        png|jpg|jpeg )
            cmd="eog"
            ;;
        mp3|flac|mp4|mkv|avi )
            cmd="vlc"
            ;;
        pdf )
            cmd="evince"
            ;;
        txt|md|tex|c|h|py|html|css|scss|js|json|sh )
            cmd="sublime"
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
                        echo "unknown extension ($ext), or tricky cmd (gz, ...), using nautilus"
                        cmd="nautilus"
                        ;;
                esac
            else
                echo "unknown extension ($ext), or tricky cmd (gz, ...), using nautilus"
                cmd="nautilus"
            fi
            ;;
    esac

    $cmd $@ > /dev/null 2>&1 &
}

# ssh tunnel
# ssh -fNg -L 5555:localhost:5432 {your_username}@{yourdomain.com}
# This open an SSH connection in the background mapping your local port 5555 to your server’s port 5432 (Postgres’ default port). Type “man ssh” to see what each of these flags is specifically doing.
# Now, create a new connection in pgAdmin using localhost as your host and port 5555.

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

# dafuq perl ?
PATH="/home/nodraak/perl5/bin${PATH+:}${PATH}"; export PATH;
PERL5LIB="/home/nodraak/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/nodraak/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/nodraak/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/nodraak/perl5"; export PERL_MM_OPT;
