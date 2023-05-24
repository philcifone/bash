#!/bin/bash

####################################
#
# IN PROGRESS
#
# TO DO
# Assign rsync-backup.sh to binary path on Mac Mini
# Run segments of script to test
#
#
# Backup script for local storage using rsync
#
####################################

# Volumes
katahdin="/Volumes/Katahdin/"

gamehenge="/Volumes/Gamehenge/"

abraxas="/Volumes/Abraxas/"

catalyst="phil@10.0.0.164:/mnt/catalyst/users/phil/"

# capture current date
current_date=$(date +%Y-%m-%d)

# set backup log path
log_path="~/terminal/backup-logs/"
        
# set rsync backup and sync flags and options
rsync_bkup_opt="-avb --backup-dir $2/$current_date --delete"
rsync_sync_opt="-av --delete"

# run rsync backup command and save output to log
echo "syncing scratch disk katahdin to gamehenge"
$(which rsync) $rsync_sync_opt $(katahdin)Uploads/2023/ $(gamehenge)Photography/ALL\ UPLOADS/2023/
>> $(log_path)backup_$current_date.log
$(which rsync) $rsync_sync_opt $(katahdin)Lightroom/ $(gamehenge)Photography/Lightroom/NEW_Lightroom_Backups/
>> $(log_path)backup_$current_date.log
$(which rsync) $rsync_sync_opt $(katahdin)PhotosLibrary $(gamehenge)Photography/
>> $(log_path)backup_$current_date.log

echo "syncing volume gamehenge to catalyst"
$(which rsync) $rsync_sync_opt --exclude=Movies_Shows $(gamehenge) $(catalyst)
>> $(log_path)backup_$current_date.log

echo "Backing up gamehenge to abraxas"
rsync-backup.sh $rsync_bkup_opt --exclude=TOM $(gamehenge) $(abraxas) 
>> $(log_path)backup_$current_date.log

# Print end status message.
echo "Backup finished"
echo "Run: 'cat $(log_path)backup_$current_date.log' to view log"
exit
