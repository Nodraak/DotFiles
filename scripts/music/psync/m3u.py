#!/usr/bin/env python3

import pathlib
import urllib.parse
from .psync import Backend, PlaylistDb
from .utils import removeprefix, removesuffix


class M3u(Backend):
    SONG_PATH_ROOT = '../Music/'

    def load(self):
        pdb = PlaylistDb()

        for filepath in pathlib.Path(self.path).iterdir():
            if not filepath.is_file():
                continue

            with open(self.path+filepath.name, 'r') as f:
                assert f.readline().strip() == '#EXTM3U', 'File "%s" should start with "#EXTM3U"' % filepath.name

                pdb_playlist_tags = []
                pdb_playlist_songs = []
                for i, line in enumerate(f):
                    line = line.strip()
                    if (i % 2) == 0:
                        assert line.startswith('#EXTINF:'), 'File "%s" line %d should start with "#EXTINF:"' % (filepath.name, i+2)
                        _, tag = line.split(':')
                        pdb_playlist_tags.append(tag)
                    else:
                        song_path = urllib.parse.unquote(line)

                        assert song_path.startswith(self.SONG_PATH_ROOT), 'File "%s" line %d should start with "%s"' % (filepath.name, i+2, self.SONG_PATH_ROOT)
                        song_path = removeprefix(song_path, self.SONG_PATH_ROOT)

                        pdb_playlist_songs.append(song_path)

                pdb.add_playlist(
                    removesuffix(filepath.name, '.m3u'),
                    {
                        'songs': pdb_playlist_songs,
                        'tags': pdb_playlist_tags,
                    },
                )

        return pdb

    def save(self, data):
        for playlist_name, playlist_data in data.get_data():
            if 'tags' not in playlist_data:
                playlist_data['tags'] = ['' for _ in range(len(playlist_data['songs']))]

            filepath = '%s/%s.m3u' % (self.path, playlist_name)
            with open(filepath, 'w') as f:
                f.write('#EXTM3U\n')

                for tag, song in zip(playlist_data['tags'], playlist_data['songs']):
                    f.write('#EXTINF:%s\n' % tag)
                    f.write('%s\n' % urllib.parse.quote(self.SONG_PATH_ROOT+song))
