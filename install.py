#!/usr/bin/env python

from __future__ import print_function
import os
import subprocess


SRC_DIR = '%s/dotfiles' % os.getcwd()  # need full path and no expansion of '.' is performed
DEST_DIR = os.environ['HOME']  # no expansion of "~" is performed
LINK = ['ln', '-s']

# (source, dest)
FILELIST = (
    ('bash_aliases', '.bash_aliases'),
    ('config/dunst', '.config/dunst'),
    ('config/i3', '.config/i3'),
    ('config/i3lock', '.config/i3lock'),
    ('config/i3blocks', '.config/i3blocks'),
    ('config/redshift.conf', '.config/redshift.conf'),
    ('conky', '.conky'),
    ('coveragerc', '.coveragerc'),
    ('gdbinit', '.gdbinit'),
    ('git/gitconfig', '.gitconfig'),
    ('git/git_template', '.git_template'),
    ('ipython', '.ipython'),
    ('pylintrc', '.pylintrc'),
    ('tmux.conf', '.tmux.conf'),
    ('vim/vim', '.vim'),
    ('vim/vimrc', '.vimrc'),
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

    print('\nPlease run:\n\techo "source ~/.bash_aliases" >> ~/.bashrc')


if __name__ == '__main__':
    main()

