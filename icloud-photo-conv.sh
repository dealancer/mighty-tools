#!/bin/sh
# set -e

if [ $# -eq 0 ]
then
  echo "usage: ./icloud-photo-conv.sh input-path output-path"
  exit
fi

INPUT_PATH=$1
OUTPUT_PATH=$2

[ ! -d "$OUTPUT_PATH" ] && echo "Output path does not exist." && exit

IFS=$'\n'
for FILE_NAME in `ls "$INPUT_PATH" | sed -n '1!p'`
do
  CREATED_DATE=$(exiftool -s -s -s -createdate "$INPUT_PATH/$FILE_NAME")

  if [ -z "$CREATED_DATE" ]
  then
    NEW_SUB_DIR_NAME="_nodate"
    NEW_FILE_NAME="$(echo "$FILE_NAME" | md5 | cut -c1-8)"
  else
    NEW_SUB_DIR_NAME=$(date -j -f %Y:%m:%d\ %H:%M:%S "$CREATED_DATE" +%Y-%m)
    NEW_FILE_NAME="$(date -j -f %Y:%m:%d\ %H:%M:%S "$CREATED_DATE" +%Y%m%d-%H%m%S)-$(echo "$FILE_NAME" | md5 | cut -c1-8)"
  fi
  EXTENSION=$(echo "$FILE_NAME" | awk -F . '{print $NF}' | tr '[:lower:]' '[:upper:]')

  echo "Processing $FILE_NAME..."

  [ -d "$OUTPUT_PATH/$NEW_SUB_DIR_NAME" ] || mkdir "$OUTPUT_PATH/$NEW_SUB_DIR_NAME"

  if [ $EXTENSION = "HEIC" ]
  then
    magick convert "$INPUT_PATH/$FILE_NAME" "$OUTPUT_PATH/$NEW_SUB_DIR_NAME/$NEW_FILE_NAME.JPG"
  elif [ $EXTENSION = "MOV" ]
  then
    ffmpeg -y -hide_banner -loglevel panic -threads 4 -i "$INPUT_PATH/$FILE_NAME" -map_metadata 0 -c copy -c:a aac "$OUTPUT_PATH/$NEW_SUB_DIR_NAME/$NEW_FILE_NAME.MP4"
  else
    cp "$INPUT_PATH/$FILE_NAME" "$OUTPUT_PATH/$NEW_SUB_DIR_NAME/$NEW_FILE_NAME.$EXTENSION"
  fi
done
