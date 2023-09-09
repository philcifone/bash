#!/bin/bash

# Check if ImageMagick (magick command) is installed
if ! command -v magick &> /dev/null; then
    echo "Error: ImageMagick is not installed. Please install it and re-run the script."
    exit 1
fi

# Check if ExifTool is installed
if ! command -v exiftool &> /dev/null; then
    echo "Error: ExifTool is not installed. Please install it and re-run the script."
    exit 1
fi

# Check for jpeg files and handle renaming *.jpeg to *.jpg
shopt -s nullglob
for file in *.jpeg; do
    mv -- "$file" "${file%.jpeg}.jpg"
done

# Check for jpeg files
if compgen -G "*.jpg" > /dev/null; then
    # Resize to 1200px on the long edge and convert to webp
    if magick mogrify -resize 1200x1200 -format webp -quality 90 *.jpg 2>/dev/null; then
        echo "Conversion completed."
    else
        echo "Error: Conversion failed."
        exit 2
    fi
else
    echo "Error: This directory does not contain any JPEG files to convert."
    exit 2
fi

# Remove metadata (EXIF) from JPEG and WebP files
if exiftool -all= *.jpg 2>/dev/null && exiftool -all= *.webp 2>/dev/null; then
    echo "Metadata removal completed."
else
    echo "Error: Metadata removal failed."
fi

# Ask user if for photos or blog
read -p "Is this for photos or blog? " top_level

# Ask user to designate the final path (should be the present directory)
read -p "What directory is this? " img_folder

# Set variable for img_path, include user input to designate filename
img_path="/images/${top_level}/${img_folder}/"

# List all webp files and save to a file
ls *.webp >> img_list.txt 

# Format output for markdown and save to a file
awk -v prefix="${img_path}" '{print "![pic](" prefix $0 ")"}' img_list.txt > md_list.txt

# Ask user if they want to remove jpeg files when finished
read -p "Delete JPEG files? (y or n): " delete

if [ "$delete" = "y" ]; then
    rm *.jpg
    echo "JPEG files deleted."
else
    echo "No files were deleted."
fi

exit

