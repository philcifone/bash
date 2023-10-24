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
katahdin="/Volumes/Katahdin"

gamehenge="/Volumes/Gamehenge"

abraxas="/Volumes/Abraxas"

catalyst="phil@10.0.0.164:/mnt/catalyst/users/phil/"

# capture current date
current_date=$(date +%Y-%m-%d)

# make and set backup log path
mkdir /Volumes/Gamehenge/Computer/backup-logs
log_path="/Volumes/Gamehenge/Computer/backup-logs"
        
# set rsync backup and sync flags and options
#rsync_bkup_opt="-avb --backup-dir $2/$current_date --delete --dry-run"
rsync_sync_opt="-av --delete --dry-run"

# run rsync backup command and save output to log
echo "Syncing scratch disk locally from katahdin to gamehenge"
#$(which rsync) $rsync_sync_opt $katahdin/Uploads/2023/ $gamehenge/Photography/ALL\ UPLOADS/2023/ >> backup_$current_date.log
#$(which rsync) $rsync_sync_opt $katahdin/Lightroom/ $gamehenge/Photography/Lightroom/NEW_Lightroom_Backups/ >> backup_$current_date.log
#$(which rsync) $rsync_sync_opt $katahdin/PhotosLibrary $gamehenge/Photography/ >> backup_$current_date.log

echo "Syncing volume remotely from gamehenge to catalyst"
#$(which rsync) $rsync_sync_opt --exclude=Movies_Shows --exclude=TOM $gamehenge/ $catalyst >> backup_$current_date.log

echo "Backing up volume locally from gamehenge to abraxas"
./rsync-backup.sh $gamehenge/Documents $abraxas/Documents

log=backup_$current_date.log

# move log to log folder
cp $log $log_path/
rm $log

# Print end status message.
echo "Backup finished"
echo "Run: 'cat $log_path/backup_$current_date.log' to view log"
exit
