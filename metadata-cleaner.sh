#!/bin/sh

if [[ $# -eq 0 ]]
then
  echo "usage: ./metadata-cleaner.sh path"
  exit
fi

INPUT_PATH=$1

IFS=$'\n'
for FILE_NAME in `find "$INPUT_PATH"`
do
  echo "PROCESSING $FILE_NAME"
  exiftool -overwrite_original -all= "$FILE_NAME"
done


