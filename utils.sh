#!/bin/bash

FILES=".bash_aliases .vimrc .gitconfig .git_template/"

check_git () {
    if [ -n "$(git status -s -uno)" ];
    then
        echo "Some changes are not commited, exiting ...";
        exit 1
    fi
}

backup () {
    for f in $FILES
    do
        echo "copying ~/$f to ."
        cp -r ~/$f .
    done
}

deploy () {
    for f in $FILES
    do
        echo "copying $f to ~/"
        cp -r $f ~/
    done
}

case $1 in
    backup | b )
        check_git
        echo "Backup :"
        backup
        ;;
    deploy | d )
        check_git
        echo "Backuping to check if overiding uncommited changes ..."
        backup
        check_git
        echo "Seems fine."
        echo "Deploy :"
        deploy
        ;;
    *)
        echo "I need an action : backup (or b) or deploy (or d)"
        exit 1
        ;;
esac

