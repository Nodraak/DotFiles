#!/usr/bin/env python3
"""
TODO: check https://github.com/adrienverge/rhythmbox_playlist_to_m3u/blob/master/rhythmbox_playlist_to_m3u.py
"""

from lxml import etree
import urllib.parse
from .psync import Backend, PlaylistDb
from .utils import removeprefix


class Rhythmbox(Backend):
    SONG_PATH_ROOT = 'file:///home/nodraak/Musique/'

    def load(self):
        pdb = PlaylistDb()

        tree = etree.parse(self.path)
        root = tree.getroot()

        for xml_playlist in root.getchildren():
            pdb_playlist_songs = []

            playlist_name = xml_playlist.attrib['name']

            if playlist_name in ['New Playlist', 'Recent', 'Play Queue']:
                continue

            for song in xml_playlist.getchildren():
                song_path = self.song_decode_path(song.text)

                assert song_path.startswith(self.SONG_PATH_ROOT)
                song_path = removeprefix(song_path, self.SONG_PATH_ROOT)

                pdb_playlist_songs.append(song_path)

            pdb.add_playlist(
                playlist_name,
                {
                    'songs': pdb_playlist_songs,
                },
            )

        return pdb

    def save(self, data):
        xml_rdb = etree.Element('rhythmdb-playlists')

        xml_p_new = etree.SubElement(xml_rdb, 'playlist', dict([
            ('name', 'New Playlist'),
            ('show-browser', 'true'),
            ('browser-position', '155'),
            ('search-type', 'search-match'),
            ('type', 'automatic'),
            ('sort-key', 'Artist'),
            ('sort-direction', '0'),
        ]))
        c1 = etree.SubElement(xml_p_new, 'conjunction')
        e = etree.SubElement(c1, 'equals', {'prop': 'type'})
        e.text = 'song'
        s = etree.SubElement(c1, 'subquery')
        c2 = etree.SubElement(s, 'conjunction')
        etree.SubElement(c2, 'like', {'prop': 'title-folded'})

        xml_p_recent = etree.SubElement(xml_rdb, 'playlist', dict([
            ('name', 'Recent'),
            ('show-browser', 'true'),
            ('browser-position', '167'),
            ('search-type', 'search-match'),
            ('type', 'automatic'),
            ('sort-key', 'Artist'),
            ('sort-direction', '0'),
        ]))
        c1 = etree.SubElement(xml_p_recent, 'conjunction')
        e = etree.SubElement(c1, 'equals', {'prop': 'type'})
        e.text = 'song'
        s = etree.SubElement(c1, 'subquery')
        c2 = etree.SubElement(s, 'conjunction')
        c3 = etree.SubElement(c2, 'current-time-within', {'prop': 'first-seen'})
        c3.text = '13910400'  # 23 weeks as seconds

        for i, (playlist_name, playlist_data) in enumerate(data.get_data()):

            xml_playlist = etree.SubElement(xml_rdb, 'playlist', dict([
                ('name', playlist_name),
                ('show-browser', 'false'),
                ('browser-position', '%d' % (179+i)),
                ('search-type', 'search-match'),
                ('type', 'static'),
            ]))

            for song in playlist_data['songs']:
                s = etree.SubElement(xml_playlist, 'location')
                s.text = self.SONG_PATH_ROOT + self.song_encode_path(song)

        etree.SubElement(xml_rdb, 'playlist', dict([
            ('name', 'Play Queue'),
            ('show-browser', 'false'),
            ('browser-position', '180'),
            ('search-type', 'search-match'),
            ('type', 'queue'),
        ]))

        # dump to str and write to file

        xml_s = etree.tostring(xml_rdb, xml_declaration=True, pretty_print=True).decode('ascii')

        with open(self.path, 'w') as f:
            f.write(xml_s)

    def song_decode_path(self, name):
        name = urllib.parse.unquote(name)
        return name

    def song_encode_path(self, name):
        """
        Encode uft8 and some special char such as space, but without following
        any standard. *sigh* God.
        """
        name = urllib.parse.quote(name)
        name = name.replace('%21', '!')  # '!' is not escaped
        name = name.replace('%24', '$')  # '$' is not escaped
        name = name.replace('%26', '&')  # '&' is escaped by xml (as '&amp;')
        name = name.replace('%27', "'")  # "'" is not escaped
        name = name.replace('%28', '(')  # '(' is not escaped
        name = name.replace('%29', ')')  # ')' is not escaped
        name = name.replace('%2C', ',')  # ',' is not escaped
        return name
