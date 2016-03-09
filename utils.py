#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess
import sys

# your home dir where all your dot files are. Usually corresponding to ~/
HOME_DIR = '/home/nodraak'

# list of objects to backup and/or deploy. Each item can be a two elements list
# [source, target], or a one element [source] list if source == target.
OBJECTS = [
    ['.bash_aliases'],
    ['.conky/'],
    ['.coveragerc'],
    ['.gdbinit'],
    ['.git_template/'],
    ['.gitconfig'],
    ['.ipython/profile_default/ipython_config.py', 'ipython_config.py'],
    ['.vimrc'],
    ['.vim/minivim_color_statusbar.vim'],
    ['.vim/minivim_keybindings.vim'],
    ['.vim/bundle/vim-gitgutter/autoload/'],
    ['.vim/bundle/vim-gitgutter/plugin/gitgutter.vim'],
    ['.vim/autoload/'],
    ['.xsession'],
]


def print_usage():
    print('I need an action : backup (or b) or deploy (or d)')


def check_git():
    if subprocess.check_output(['git', 'status', '-s', '-uno']):
        print('Some changes are not commited, exiting ...')
        exit(1)


def get_cmd_chunks(f, backup=True):
    if len(f) == 1:
        source, target = f[0], f[0]
    elif len(f) == 2:
        source, target = f
    else:
        print('Error, "%s" is wrongly formatted.' % f)
        exit(1)

    is_file = not source.endswith('/')

    # set source and target

    if backup:
        source = '%s/%s' % (HOME_DIR, source)
        if is_file:  # file
            target = './%s' % target
        else:  # dir
            target = './'
    else:
        source, target = target, source
        target = '%s/' % HOME_DIR

    # build cmd

    cmd = ['cp']
    if not is_file:
        cmd.append('-r')
    cmd.append(source)
    cmd.append(target)

    return cmd


def do_it(what):
    print('== %s ==' % what)
    for f in OBJECTS:
        cmd = get_cmd_chunks(f, what == 'Backup')
        print('\t%s' % cmd)
        subprocess.call(cmd)
    if what == 'Deploy':
        print('conky may have been messed up, run "bash -c \'cd %s/.conky/ && ./starter.py" to restart\'' % HOME_DIR)


def main():
    if len(sys.argv) != 2:
        print_usage()
    else:
        if sys.argv[1] in ('b', 'backup'):
            check_git()
            do_it('Backup')
        elif sys.argv[1] in ('d', 'deploy'):
            check_git()
            print('Backuping first to check if overiding uncommited changes ...')
            do_it('Backup')
            check_git()
            print('Everything seems fine, I can deploy.')
            do_it('Deploy')
        else:
            print_usage()


if __name__ == '__main__':
    main()
