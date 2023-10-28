#!/bin/bash
#
#

# User input for directory selection
# 
echo "What directory do you want to sort?"

read sortPath

cd $sortPath

# Create subdirectories in lowercase if they don't exist
sudo mkdir -p documents images movies audio rss compressed

# Move documents to the "documents" directory
sudo mv *.pdf *.PDF *.docx *.xlsx *.pptx *.txt documents/

# Move images to the "images" directory
sudo mv *.jpg *.JPG *.jpeg *.JPEG *.png *.gif *.bmp *.webp images/

# Move movie files to the "movies" directory
sudo mv *.mp4 *.avi *.mkv *.mov movies/

# Move audio files to the "audio" directory
sudo mv *.mp3 *.wav *.flac audio/

# Move rss files to the "rss" directory
sudo mv *.rss rss/

# Move compressed files to the "compressed" directory
sudo mv *.tar.* *.tar *.zip

echo "Files organized by media type."

# Function to create a dated folder and move files into it
#move_to_dated_folder() {
#  for file in "$1"/*; do
#    [ -f "$file" ] && mkdir -p "$1/$(date -r "$file" '+%Y-%m-%d')" && mv "$file" "$1/$(date -r "$file" '+%Y-%m-%d')/"
#  done
#}

# Move files into dated folders based on their creation date
#move_to_dated_folder documents
#move_to_dated_folder images
#move_to_dated_folder movies
#move_to_dated_folder audio

#echo "Files organized by creation date."

