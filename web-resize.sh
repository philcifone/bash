#!/bin/bash
#
# philcifone.com -- web-resize script
#
# This script designed to resize a directory of images for my site. 
# Images are resized to 1200px on the long edge.
# And converted to .webp format.
#
# These specs give a solid performance rating through
# google dev tools web interface. 
#
# Overview:
# The script checks if image magick is installed
# renames any "*.jpeg" to *.jpg" 
# requests user input to generate filepath 
# outputs path to markdown link format
# user can then copy & paste into markdown post

# image magick must be installed
if ! hash magick 2>/dev/null 
then
        echo "Please install image magick and re-run the script"
fi

# Handle case where no files match glob patterns
shopt -s nullglob

# Rename *.jpeg to *.jpg
for file in *.jpeg; do
    mv -- "$file" "${file%.jpeg}.jpg"
done

# Check for jpg files
if compgen -G "*.jpg" > /dev/null; then
    # Resize to 1200px on the long edge and convert to webp
    magick mogrify -resize 1200x1200 -format webp -quality 90 *.jpg
    echo "Conversion completed."
else
    echo "This directory does not contain any JPEG files to convert."
    exit 1
fi

# ask user if for photos or blog
read -p "Is this for photos or blog? " top_level

# ask user to designate path (should exist already)
read -p "what directory is this? " img_folder

# set variable for img_path, include user input to designate filename
img_path="/images/${top_level}/${img_folder}/"

# list all webp files and save to file
ls *.webp >> img_list.txt 

# format output for markdown and save to file
awk -v prefix="${img_path}" '{print "![pic](" prefix $0 ")"}' img_list.txt > md_list.txt

# ask user if they want to remove jpeg files when finished
read -p "Delete JPEG files? (y or n): " delete

if [ "$delete" = "y" ]; then
    rm *.jpg
    echo "JPEG files deleted."
else
    echo "No files were deleted."
fi

exit
