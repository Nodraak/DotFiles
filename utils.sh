#!/bin/bash

FILES=".bashrc .vimrc .gitconfig .git_template/"

case $1 in
    backup | b )
        echo "Backup :"
        for f in $FILES
        do
            echo "copying ~/$f to ."
            cp -r ~/$f .
        done
        ;;
    deploy | d )
        echo "Deploy :"
        for f in $FILES
        do
            echo "copying $f to ~/$f"
            cp -r $f ~/
        done
        ;;
    *)
    echo "I need an action : backup (or b) or deploy (or d)"
    exit 1
esac

