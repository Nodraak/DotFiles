#!/usr/bin/env python
# -*- coding: utf-8 -*-

from os import system, chdir

configs = (
    '0_bg',
    '1_header',
    '2_system',
    '3_disk',
    '4_network',
)

chdir('/home/nodraak/.conky/')

# make config files
for config in configs:
    system('cat config/base_settings.conkyrc config/%s.part.conkyrc > build/%s.conkyrc' % (config, config))

# kill former daemons
system('killall -q conky')

# start daemons
for config in configs:
    system('conky -d -q -c build/%s.conkyrc' % config)

