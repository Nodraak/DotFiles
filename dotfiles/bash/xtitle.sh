#!/usr/bin/env bash

#
# Set title of terminal, used by PS1 and some alias
#

function set_xtitle()
{
    case "$TERM" in
        *term* | rxvt)
            echo -en "\033]0;$@\007"
            ;;
        *)
            ;;
    esac
}
