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

rm -rf rsync_logs
mkdir -p rsync_logs

echo $(date --rfc-3339=seconds) >> rsync_logs/stdout

# home - local
rsync $ARGS /home/nodraak /media/nodraak/Backup/Home | tee -a rsync_logs/stdout

# media - local
rsync $ARGS /media/Media/Backup /media/nodraak/Backup/Media | tee -a rsync_logs/stdout
rsync $ARGS /media/Media/PhotosEtImages /media/nodraak/Backup/Media | tee -a rsync_logs/stdout

echo $(date --rfc-3339=seconds) >> rsync_logs/stdout

