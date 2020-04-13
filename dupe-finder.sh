#!/bin/sh

if [ $# -eq 0 ]
then
  echo "usage: ./dupe-finder.sh path"
  exit
fi

DIR=$1

find "$DIR" \! -type d -exec cksum {} \; | sort | tee /tmp/files.tmp | cut -f 1,2 -d ' ' | uniq -d | grep -hif /dev/stdin /tmp/files.tmp
