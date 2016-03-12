#!/usr/bin/env python
# -*- coding: utf-8 -*-

import subprocess
import sys

# your home dir where all your dot files are. Usually corresponding to ~/
HOME_DIR = '/home/nodraak/'

# list of objects to backup and/or deploy. Directories must end with a "/".
OBJECTS = [
    '.bash_aliases',
    '.conky/',
    '.coveragerc',
    '.gdbinit',
    '.git_template/',
    '.gitconfig',
    '.ipython/profile_default/ipython_config.py',
    '.vimrc',
    '.vim/minivim_color_statusbar.vim',
    '.vim/minivim_keybindings.vim',
    '.vim/bundle/vim-gitgutter/autoload/',
    '.vim/bundle/vim-gitgutter/plugin/gitgutter.vim',
    '.vim/autoload/',
    '.xsession',
]


def print_usage():
    print('I need an action : backup (or b) or deploy (or d)')


def check_git():
    if subprocess.check_output(['git', 'status', '-suno']):
        print('Some changes are not commited, exiting ...')
        exit(1)


def get_cmd_chunks(f, home_dir_source, home_dir_target):
    is_file = not f.endswith('/')

    directory = '%s%s' % (home_dir_target, '/'.join(f.split('/')[:-1]))
    if directory != home_dir_target:
        print 'mkdir -p %s' % directory
        subprocess.call(['mkdir', '-p', directory])

    source = '%s%s%s' % (home_dir_source, f, '*' if not is_file else '')
    target = '%s%s' % (home_dir_target, f)

    cmd = ['cp']
    if not is_file:
        cmd.append('-r')
    cmd.append(source)
    cmd.append(target)

    return ' '.join(cmd)


def do_it(what):
    print('== %s ==' % what)
    for f in OBJECTS:
        if what == 'Backup':
            cmd = get_cmd_chunks(f, HOME_DIR, './')
        else:
            cmd = get_cmd_chunks(f, './', HOME_DIR)
        print('\t%s' % cmd)
        subprocess.call(cmd, shell=True)


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
            print('\n'.join((
                'Bash: make sur "if [ -f ~/.bash_aliases ]; then . ~/.bash_aliases; fi" is present in .bashrc',
                'Conky: run "cd %s/.conky/ && ./starter.py"' % HOME_DIR,
            )))
        else:
            print_usage()


if __name__ == '__main__':
    main()
