#!/bin/bash

# Personal journaling script so I can download my images and label them faster
# Previews all images in ~/Downloads and quickly converts and moves them

JOURNAL_FOLDER="$HOME/Desktop/Recreation/2023-journal"
JOURNAL_FILE="$JOURNAL_FOLDER/journal.md"
IMAGE_DIR="$JOURNAL_FOLDER/imgs"

shopt -s nocaseglob

mkdir -p "$IMAGE_DIR"

DEFAULT_DATE=$(date +"%Y_%m_%d")
read -e -p "Enter the date of entry: " -i "$DEFAULT_DATE" ENTRY_DATE
ENTRY_DATE=${ENTRY_DATE:-$DEFAULT_DATE}

MARKDOWN_DATE=$(echo "$ENTRY_DATE" | tr '_' '-')
echo -e "\n# $MARKDOWN_DATE\n" >> "$JOURNAL_FILE"

read -p "Do you want to add images (from ~/Downloads)? (y/n): " ADD_IMAGES

if [[ $ADD_IMAGES == "y" ]]; then
  for IMAGE in "$HOME/Downloads"/*.{jpg,jpeg,png,gif,heic}; do
    if [ -f "$IMAGE" ]; then
      feh --scale-down "$IMAGE"

      read -p "Do you want to add $IMAGE? (y/n): " ADD_THIS_IMAGE

      if [[ $ADD_THIS_IMAGE == "y" ]]; then

        # Convert the image to PNG
        CONVERTED_IMAGE="${IMAGE%.*}.png"
        magick "$IMAGE" "$CONVERTED_IMAGE"

        read -p "Enter a label for the image: " IMAGE_LABEL

        IMAGE_NAME="${ENTRY_DATE}_${IMAGE_LABEL}.png"
        mv "$CONVERTED_IMAGE" "$IMAGE_DIR/$IMAGE_NAME"

        echo "![${IMAGE_LABEL}](${IMAGE_DIR}/${IMAGE_NAME})" >> "$JOURNAL_FILE"
      fi
    fi
  done

  for VIDEO in "$HOME/Downloads"/*.{mov,mp4}; do
    if [ -f "$VIDEO" ]; then
      mpv "$VIDEO"

      read -p "Do you want to add $VIDEO? (y/n): " ADD_THIS_VIDEO

      if [[ $ADD_THIS_VIDEO == "y" ]]; then

        read -p "Enter a label for the image: " VIDEO_LABEL

        VIDEO_NAME="${ENTRY_DATE}_${VIDEO_LABEL}.mov"
        mv "$VIDEO" "$IMAGE_DIR/$VIDEO_NAME"

        echo "![${VIDEO}](${IMAGE_DIR}/${VIDEO_NAME})" >> "$JOURNAL_FILE"
      fi
    fi
  done
fi

nvim "$JOURNAL_FILE" +"norm G"
