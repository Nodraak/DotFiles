#!/bin/bash

set -e  # exit if command fails
set -u  # exit if var is undeclared

DEST="/media/nodraak/Backup"

LOG_FILE="backup_home.log"

RSYNC_ARGS="-Phav --delete --exclude-from=./backup_home.exclude.txt"
# P: --partial --progress (good for big transferts)
# h: human readable numbers
# a: archive (implies recursive + other flags)
# v: verbose
# u: update (ie skip if the dest is newer than the src)
# z: compress
# --delete delete on dest if deleted on src

if [ ! -d /media/nodraak/Backup ]
then
    echo "Error: /media/nodraak/Backup is not mounted"
    exit 1
fi

rm -f ${LOG_FILE}

date --rfc-3339=seconds >> ${LOG_FILE}
df -h /media/nodraak/Backup/ | tee -a ${LOG_FILE}

# home - local
rsync ${RSYNC_ARGS} /home/nodraak ${DEST}/Home | tee -a ${LOG_FILE}

# media - local
rsync ${RSYNC_ARGS} /media/Media/Backup ${DEST}/Media | tee -a ${LOG_FILE}
rsync ${RSYNC_ARGS} /media/Media/PhotosEtImages ${DEST}/Media | tee -a ${LOG_FILE}

df -h /media/nodraak/Backup/ | tee -a ${LOG_FILE}
date --rfc-3339=seconds >> ${LOG_FILE}

date --rfc-3339=seconds >> backup_home.complete.log

