#!/bin/bash

source_dir="/mnt/pve/gamehenge"
target_dir="/catalyst/cloud"
directories=("Books" "Computer" "Design" "Documents" "images" "Music" "Photography" "School" "TOM" "Video")
current_date=$(date +%Y-%m-%d)
log_path="$target_dir/logs/"
backup_dir="$target_dir/backup/"

# Make log path if doesnt exist
if [ ! -d "$log_path" ]; then
    mkdir -p "$log_path"
fi

# Function to perform rsync for a given directory
rsync_directory() {
    source="$1/$2/"
    target="$3/$2/"
    sudo rsync -avbP --size-only --ignore-existing --backup-dir="$backup_dir" --delete "$source" "$target"
}

# Loop through the directories array and perform rsync for each directory
for dir in "${directories[@]}"; do
    rsync_directory "$source_dir" "$dir" "$target_dir" >> "$log_path/backup_$current_date.log" 2>&1
done

echo "Backup of gamehenge to catalyst complete."
