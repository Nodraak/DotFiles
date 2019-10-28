#!/usr/bin/env bash

#
# Fancy prompt PS1
#

_ps1_update () {
    # must be first
    local pipe_status="${PIPESTATUS[@]}"
    local pipe_status_sum="$(echo $pipe_status | sed 's/ /+/g' | bc)"

    local tmp
    local user_hostname
    local user_hostname="${USER}@${HOSTNAME}"

    # window title
    #set_xtitle "${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}"

    PS1=""

    # date
    PS1+="${Cyan}\t${NC} "

    # login + hostname
    # TODO: add rpi + update for Debian 9
    if [[ "$user_hostname" = "achardon@ltadch" ]]; then
        PS1+="${Green}$user_hostname${NC} "
    elif [[ "$user_hostname" = "Debian@ltadch" ]]; then
        PS1+="${Green}$user_hostname${NC} "
    elif [[ "$user_hostname" = "adch@s5icsaswdev" ]]; then
        PS1+="${Cyan}$user_hostname${NC} "
    else
        PS1+="${Red}$user_hostname${NC} "
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
    if [[ "$pipe_status_sum" != "0" ]]; then
        PS1+="${Red}$pipe_status${NC} "
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
