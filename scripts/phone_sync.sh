#!/usr/bin/env bash

PHONE_ROOT="/run/user/1000/gvfs/mtp:host=HUAWEI_LLD-L31_FPMNW18A26012053/Interner Speicher"
BACKUP_PATH="/media/Media/Backup/2020-01-Honor/"
CP_CMD="cp -r -v"

function backup() {
    mkdir -p "$BACKUP_PATH"

    rm -rf "$BACKUP_PATH/Playlists"

    $CP_CMD "$PHONE_ROOT/DCIM"      "$BACKUP_PATH"
    $CP_CMD "$PHONE_ROOT/Pictures"  "$BACKUP_PATH"
    #$CP_CMD "$PHONE_ROOT/Playlists" "$BACKUP_PATH"
    #$CP_CMD "$PHONE_ROOT/Snapchat"  "$BACKUP_PATH"
    $CP_CMD "$PHONE_ROOT/Download/opengpstracker"  "$BACKUP_PATH"
}

function push_music() {
    # push music
    $CP_CMD ~/Musique/* "$PHONE_ROOT/Music/"

    # clean and push playlists
    rm -r "$PHONE_ROOT/Playlists"
    #$CP_CMD ~/.kde/share/apps/amarok/playlists "$PHONE_ROOT/Playlists"
    $CP_CMD ~/dotfiles/scripts/music/databases/m3u "$PHONE_ROOT/Playlists"

    # ask android to rescan fs
    adb shell "am broadcast -a android.intent.action.MEDIA_MOUNTED -d file:///sdcard"
}

function todo() {
    echo ">> !! Backup your contacts, calendar and other things!! <<"
}

df -h
backup
df -h
#push_music
#todo
