#!/usr/bin/env python3

import pathlib
import sys


class PlaylistDb:
    """
    A PlaylistDb looks like this:

    ```json
    {
        # playlist 1
        'some title': {
            'songs': [
                'filepath/of/song/1',
                'filepath/of/song/2',
                'filepath/of/song/3',
            ],
            # optional backend-specific fields
        },

        # playlist 2
        # ...
    },
    ```

    All song paths are relative to the music folder (~/Music/). Each backend
    specifies a SONG_PATH_ROOT as needed.
    """
    def __init__(self, data=None):
        self.data = data or {}

    def get_data(self):
        d = sorted(self.data.items(), key=lambda tup: tup[0].lower())

        for p_name, p_data in d:
            for song in p_data['songs']:
                file = pathlib.Path('/home/nodraak/Musique/' + song)

                #assert len(song.split('/')) == 3, 'File "%s" should look like "<artist>/<album>/<song>"' % song
                assert file.exists(), 'File "%s" does not exists' % song
                assert p_data['songs'].count(song) == 1, 'Song "%s" is present more than once in the playlist "%s"' % (song, p_name)

        return d

    def add_playlist(self, playlist_name, playlist_data):
        if playlist_name in self.data:
            raise ValueError('Playlist already in PlaylistDb')

        if 'songs' not in playlist_data:
            raise ValueError('playlist_data does not contain a "songs" key')

        self.data[playlist_name] = playlist_data


class Backend:
    """
    A Backend is a playlist (Im|Ex)porter.
    """

    SONG_PATH_ROOT = ''

    def __init__(self, path, *args, **kwargs):
        self.path = path

    def load(self):
        """
        Import.
        Load the data (which can be in one or several files, depending on the
        backend) and return it as a psync.PlaylistDb object.
        """
        raise NotImplementedError()

    def save(self, data):
        """
        Export.
        Save the psync.PlaylistDb object passed as parameter. Depending on the
        backend, the PlaylistDb can be saved to one or several files.
        """
        raise NotImplementedError()


def sync(src, dst):
    data = src.load()
    print('| Playlist Name                  | Count |')
    print('|--------------------------------|-------|')
    for playlist_name, playlist_data in data.get_data():
        print('| %-30s | %5d |' % (playlist_name, len(playlist_data['songs'])))
    dst.save(data)


def usage(msg=None):
    exe = sys.argv[0]

    if msg:
        print('Error: %s' % msg)

    print('Usage:')
    print('\t%s help' % exe)
    print('\t%s sync <from> <to>' % exe)

    if msg:
        exit(1)


def main(conf):
    if len(sys.argv) == 1:
        usage('expected command')
    else:
        if sys.argv[1] == 'help':
            usage()
        elif sys.argv[1] == 'sync':
            if len(sys.argv) != 4:
                usage('command "sync" expects two arguments')
            else:
                src, dst = conf.get(sys.argv[2]), conf.get(sys.argv[3])
                if not (src and dst):
                    usage('backend "%s" or "%s" not found' % (sys.argv[2], sys.argv[3]))
                else:
                    sync(src, dst)
        else:
            usage('unknown command "%s"' % sys.argv[1])
