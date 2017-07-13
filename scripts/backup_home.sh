#!/bin/bash

set -e  # exit if command fails
set -u  # exit if var is undeclared

LOG_FILE="backup_home.log"

RSYNC_ARGS="-Phav --delete --exclude-from=./backup_home.exclude.txt"
# P: --partial --progress (good for big transferts)
# h: human readable numbers
# a: archive (implies recursive + other flags)
# v: verbose
# u: update (ie skip if the dest is newer than the src)
# z: compress
# --delete delete on dest if deleted on src

rm -f ${LOG_FILE}

date --rfc-3339=seconds >> ${LOG_FILE}
df -h /media/nodraak/Backup/ | tee -a ${LOG_FILE}

# home - local
rsync ${RSYNC_ARGS} /home/nodraak /media/nodraak/Backup/Home | tee -a ${LOG_FILE}

# media - local
rsync ${RSYNC_ARGS} /media/Media/Backup /media/nodraak/Backup/Media | tee -a ${LOG_FILE}
rsync ${RSYNC_ARGS} /media/Media/PhotosEtImages /media/nodraak/Backup/Media | tee -a ${LOG_FILE}

df -h /media/nodraak/Backup/ | tee -a ${LOG_FILE}
date --rfc-3339=seconds >> ${LOG_FILE}

