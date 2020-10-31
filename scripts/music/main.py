#!/usr/bin/env python3

import psync


CONF = {
    'json': psync.Json('./databases/json/playlists.json'),

    # ~/.local/share/rhythmbox/playlists.xml
    'rhythmbox': psync.Rhythmbox('./databases/rhythmbox/playlists.xml'),

    # '~/.kde/share/apps/amarok/playlists/'
    # 'amarok': 'psync.Amarok('./databases/amarok/'),

    # phone
    'm3u': psync.M3u('./databases/m3u/'),
}


if __name__ == '__main__':
    psync.main(CONF)
