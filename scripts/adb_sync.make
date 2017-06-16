
all: backup push_music todo

todo:
	echo ">> !! Backup your contacts !! <<"

backup:
	./adb-sync -R /sdcard/DCIM/Camera /media/Media/Backup/OnePlus/DCIM/
	./adb-sync -R /sdcard/DCIM/Facebook /media/Media/Backup/OnePlus/DCIM/
	./adb-sync -R /sdcard/Pictures /media/Media/Backup/OnePlus/
	rm -r /media/Media/Backup/OnePlus/Playlists/*
	./adb-sync -R /sdcard/Playlists /media/Media/Backup/OnePlus/
	./adb-sync -R /sdcard/Snapchat /media/Media/Backup/OnePlus/

push_music:
	./adb-sync ~/Musique/ /sdcard/Music
	adb shell "rm -r /sdcard/Playlists/*"
	./adb-sync ~/.kde/share/apps/amarok/playlists/ /sdcard/Playlists
	adb shell "am broadcast -a android.intent.action.MEDIA_MOUNTED -d file:///sdcard"

