
PHONE_MOUNT="/media/nodraak/zenfone/"
PHONE_ROOT="/media/nodraak/zenfone/Internal storage/"
BACKUP_PATH="/media/Media/Backup/zenfone/"
#CP_CMD="./adb-sync -R"
CP_CMD="cp"
CP_ARGS="-r"

all: mount backup push_music umount todo

todo:
	echo ">> !! Backup your contacts, calendar and other things!! <<"

mount: umount
	mount $(PHONE_MOUNT)

umount:
	umount $(PHONE_MOUNT) || true

backup:
	mkdir -p $(BACKUP_PATH)

	rm -r $(BACKUP_PATH)/Playlists

	$(CP_CMD) $(CP_ARGS) $(PHONE_ROOT)/DCIM			$(BACKUP_PATH)/
	$(CP_CMD) $(CP_ARGS) $(PHONE_ROOT)/Pictures		$(BACKUP_PATH)/
	$(CP_CMD) $(CP_ARGS) $(PHONE_ROOT)/Playlists	$(BACKUP_PATH)/
	$(CP_CMD) $(CP_ARGS) $(PHONE_ROOT)/Snapchat		$(BACKUP_PATH)/

push_music:
	# push music
	$(CP_CMD) $(CP_ARGS) ~/Musique/* $(PHONE_ROOT)/Music/

	# clean and push playlists
	#adb shell "rm -r /sdcard/Playlists/*"
	rm -r $(PHONE_ROOT)/Playlists
	$(CP_CMD) $(CP_ARGS) ~/.kde/share/apps/amarok/playlists $(PHONE_ROOT)/Playlists

	# ask android to rescan fs
	#adb shell "am broadcast -a android.intent.action.MEDIA_MOUNTED -d file:///sdcard"
