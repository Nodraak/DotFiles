#!/bin/bash

set -e

ARGS="-Phav --delete --exclude-from=./backup_home.exclude.txt"

# P: --partial --progress (good for big transferts)
# h: human readable numbers
# a: archive (implies recursive + other flags)
# v: verbose
# u: update (ie skip if the dest is newer than the src)
# z: compress
# --delete delete on dest if deleted on src

# home - local
#rsync $ARGS /home/nodraak /media/nodraak/Backdraak/macbian
rsync $ARGS /home/nodraak /media/nodraak/Backup/Home

# media - local
#rsync $ARGS /media/Media /media/nodraak/Backup/


#rsync $ARGS /home/nodraak nodraak@nodraak.fr:/media/Backup/Home/
#rsync -Phavuz /home/eskimon/dossier eskimon@cible:/dossier/cible
