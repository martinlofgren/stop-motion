#!/usr/bin/env bash

if [ "$#" == "0" ]; then
    echo "Usage: `basename $0` PROJECT" >&2
    exit 1
fi

proj=$1
bin_dir=`dirname $(readlink -f $0)`

# Include config file
source $bin_dir/config

# Get file from device
#$img_get_cmd
touch shot.jpg
if [ $? -ne 0 ]; then
    echo "Could not fetch image from device"
    exit 1
fi

# Setup directory if non-existing
if [ ! -d $proj ]; then
    echo "Creating directory $proj..."
    mkdir $proj
fi

# Get the next filename
next=0
for entry in "$proj"/*
do
    if [ -f "$entry" ]; then
	filename=$(basename $entry)
	numbering=$(sed "s/\(^shot0*\)\([0-9]*\)\(.jpg$\)/\2/" <<< $filename)


	if [ "$numbering" -gt "$next" ]; then
	    next=$numbering
	fi
    fi
done

# Rename file and move to project directory
printf -v newfile "shot%09d.jpg" $((next + 1))
mv shot.jpg $proj/$newfile

echo "[$proj] Created file $newfile"

