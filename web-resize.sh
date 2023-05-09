#!/bin/bash
#
#
# script to resize images for web
#
#
# image magick must be installed
#

# resize to 1200px on the long edge
magick mogrify -resize 1200x1200 *.jpg && 
	
# format all JPEG in directory to webp
magick mogrify -format webp -quality 90 *.jpg

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

# remove jpeg files
rm *.jpg

exit
