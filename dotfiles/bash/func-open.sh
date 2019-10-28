#!/usr/bin/env bash

function o()
{
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
            cmd="subl"
            ;;
        *.html )
            cmd="firefox"
            ;;
        * )
            if [ $# -eq 1 ]; then
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
        echo Error: unknown extension, using pcmanfm for opening "$@"
        cmd="pcmanfm"
    fi

    exec $cmd "$@" 2> /dev/null &
}
complete -o nospace -F _filedir_xspec o
