#!/bin/bash
#
# Thanks Jay from Learn Linux TV for the BASH scripting tutorial!
#
# This has been modified to fit my needs.
#
#

# check to make sure user entered two arguments
if [ $# -ne 2 ]
then
    echo "usage: backup-script.sh <source> <dest>"
    echo "please try again." 
    exit 1
fi

# check if rsync is installed
if ! command -v rsync > /dev/null 2>&1
then
    echo "this script requires rsync."
    echo "consult your package manager"
    exit 2
fi

# capture current date
current_date=$(date +%Y-%m-%d)
        
        # set rsync flags and options
	rsync_options="-avb --backup-dir $2/$current_date --delete"

# run rsync backup command and save output to log
$(which rsync) $rsync_options $1 $2/current >> backup_$current_date.log
