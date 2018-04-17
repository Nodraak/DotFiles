#!/usr/bin/env python
# -*- coding: utf-8 -*-

from os import system, chdir, environ

home_dir = '%s/.conky/' % environ['HOME']
configs = (
    '0_bg',
    '1_system',
    '2_processes',
    '3_disks',
    '4_network',
)

print('chdir("%s")' % home_dir)
chdir(home_dir)

# clean previous state
system('rm -rf build')
system('killall -q conky')

# make config files and start daemons
system('mkdir build')
for config in configs:
    system('cat config/base_settings.conkyrc config/%s.part.conkyrc > build/%s.conkyrc' % (config, config))

    cmd = 'conky -d -q -c build/%s.conkyrc' % config
    print(cmd)
    system(cmd)

