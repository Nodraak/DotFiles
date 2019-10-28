#!/usr/bin/env bash

function _texspell_file()
{
    if [ $# -ne 4 ]
    then
        echo "Usage: _texspell <lang> <file> <extradict> <localdict>"
        return 1
    fi

    lang=$1
    file=$2
    extradict=$3
    localdict=$4

    for word in $(aspell --lang="$lang" --mode=tex "$extradict" "$localdict" list < "$file" | sort | uniq)
    do
        echo "$word"
        #echo "== $word =="
        #grep --with-filename --line-number " $word " "$file"
    done
}

function texspell()
{
    # args

    if [ $# -ne 2 ]
    then
        echo "Usage: texspell <lang> <file or dir>"
        return 0
    fi

    lang="$1"
    file_or_dir="$2"

    # options

    extradict=""
    localdict=""
    if [ -f "/usr/lib/aspell/custom_${lang}.rws" ]
    then
        echo "Using extra dic \"custom_${lang}.rws\""
        extradict="--extra-dicts=custom_${lang}.rws"
    fi
    if [ -f "./aspell_dict.txt" ]
    then
        echo "Using personal dict \"./aspell_dict.txt\""
        localdict="--personal=./aspell_dict.txt"
    fi

    # now spell checking

    if [ -d "$file_or_dir" ]
    then
        echo "Spell checking all .tex files in folder $file_or_dir"
        for f in $(find "$file_or_dir" | grep "\.tex$")
        do
            _texspell_file "$lang" "$f" "$extradict" "$localdict"
        done
    fi

    if [ -f "$file_or_dir" ]
    then
        echo "Spell checking file $file_or_dir"
        _texspell_file "$lang" "$file_or_dir" "$extradict" "$localdict"
    fi
}

#texdic () {
#    sudo aspell --lang=en create master /usr/lib/aspell/custom_en.rws < ./dic.txt
#}
