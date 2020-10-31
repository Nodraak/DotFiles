# README.md

Playlist synchronizer between computer and phone.

## Usage

* `./main.py help` or `./main.py sync <src> <dst>`.
* Playlists will be read from / written to `./databases/<backend>/`

## Playlist (im|ex)porters (backends):

* Amarok (TODO)
* Json (reference database, easy to git diff)
* M3u (for VLC on Android)
* Rhythmbox

## Finding lost songs

In `psync.PlaylistDb.get_data()`:

```py
import subprocess
from difflib import SequenceMatcher
from .utils import removeprefix

DATA = subprocess.check_output('find ~/Musique', shell=True).split('\n')

def find_song(file):
    r_best = 0
    i_best = 0
    for i, s in enumerate(DATA):
        r = SequenceMatcher(None, s, file).ratio()
        if r > r_best:
            r_best = r
            i_best = i
    return removeprefix(DATA[i_best], '/home/nodraak/Musique/')

p_data['songs'][i] = find_song(file)
print(file, '->', p_data['songs'][i])
```

