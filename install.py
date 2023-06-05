#!/usr/bin/env python3

from __future__ import print_function
import os
import subprocess


SRC_DIR = '%s/dotfiles' % os.getcwd()  # need full path and no expansion of '.' is performed
DEST_DIR = os.environ['HOME']  # no expansion of "~" is performed
LINK = ['ln', '-s']

# (source, dest)
FILELIST = (
# base
    ('bash', '.bash'),
    ('config/mimeapps.list', '.config/mimeapps.list'),
    ('config/sublime-text-3/Packages', '.config/sublime-text-3/Packages'),
    ('config/terminator', '.config/terminator'),
    ('git/gitconfig', '.gitconfig'),
    ('ipython', '.ipython'),
    ('vim/vim', '.vim'),
    ('vim/vimrc', '.vimrc'),

# laptop
    #('config/dunst', '.config/dunst'),
    #('config/i3', '.config/i3'),
    #('config/i3lock', '.config/i3lock'),
    #('config/i3blocks', '.config/i3blocks'),
    #('config/redshift.conf', '.config/redshift.conf'),
    #('conky', '.conky'),

# others
    #('coveragerc', '.coveragerc'),
    #('gdbinit', '.gdbinit'),
    #('git/git_template', '.git_template'),
    #('pylintrc', '.pylintrc'),
    #('tmux.conf', '.tmux.conf'),
)


def main():
    print('%s -> %s\n' % (SRC_DIR, DEST_DIR))

    # todo: mkdir /home/user/.config
    for src, dest in FILELIST:
        source = '%s/%s' % (SRC_DIR, src)
        destination = '%s/%s' % (DEST_DIR, dest)

        if not os.path.lexists(destination):
            status = 'ln'
        else:
            if os.path.realpath(destination) == source:
                status = 'ok'
            else:
                status = 'KO'

        print('[%s] %-15s -> %s' % (status, src, dest))

        if status == 'ln':
            with open(os.devnull, 'w') as shutup:
                subprocess.check_call(LINK + [source, destination], stderr=shutup)

    print('\nTwo last things:')
    print('\t* Update dotfiles/bash/main.sh dotfiles path')
    print('\t* Run: echo "source ~/.bash/main.sh" >> ~/.bashrc')


if __name__ == '__main__':
    main()

