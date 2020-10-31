#!/usr/bin/env python3

import json
from .psync import Backend, PlaylistDb


class Json(Backend):
    def load(self):
        with open(self.path, 'r') as f:
            return PlaylistDb(json.load(fp=f))

    def save(self, data):
        with open(self.path, 'w') as f:
            json.dump(dict(data.get_data()), fp=f, sort_keys=True, indent=2)
            f.write('\n')
