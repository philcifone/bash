#!/bin/bash

echo "What directory do you want to sort?"
read sortPath

if [ ! -d "$sortPath" ]; then
  echo "Directory '$sortPath' does not exist."
  exit 1
fi

cd "$sortPath"

# Create subdirectories in lowercase if they don't exist
for dir in documents images movies audio rss compressed; do
  if [ ! -d "$dir" ]; then
    mkdir -p "$dir"
  fi
done

# Function to move files to the appropriate directory
move_files() {
  local source_dir="$1"
  local target_dir="$2"
  shift 2
  for ext in "$@"; do
    mv -t "$target_dir" *.$ext 2>/dev/null
    mv -t "$target_dir" *.$(tr '[:upper:]' '[:lower:]' <<< "$ext") 2>/dev/null
  done
}

# Move documents to the "documents" directory
move_files "$sortPath" "documents" pdf PDF docx xlsx pptx txt

# Move images to the "images" directory
move_files "$sortPath" "images" jpg JPG jpeg JPEG png gif bmp webp

# Move movie files to the "movies" directory
move_files "$sortPath" "movies" mp4 avi mkv mov

# Move audio files to the "audio" directory
move_files "$sortPath" "audio" mp3 wav flac

# Move rss files to the "rss" directory
move_files "$sortPath" "rss" rss

# Move compressed files to the "compressed" directory
move_files "$sortPath" "compressed" tar gz zip ZIP

echo "Files organized by media type."
