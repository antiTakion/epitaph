#!/bin/bash

path=/tmp/lock

#confirm if /tmp/lock exists, and if not, create it
[ ! -d "$path" ] && mkdir /tmp/lock 
[ ! -d "$path"/icon/ ] && mkdir "$path"/icon/

#init all the files
scrot $path/tmpbg.jpg
bg="$path/tmpbg.jpg"
[ ! -e $path/icon/* ] && cp "$HOME"/files/pictures/icons/* "$path"/icon/
icon="$(find "$path"/icon/ | awk 'NR>1' | shuf -n 1)"

[ ! -d $path/crop/ ] && mkdir $path/crop/ || rm $path/crop/*
convert "$bg" -crop 25% $path/crop/crop.png
#output goes to var, as a array
var=($(find $path/crop/ -iname *crop* -type f | shuf))

#you can read from file using @ before the path of the file, \
#e.g., montage @/tmp/filelist
montage ${var[*]} -geometry +0-0 "$bg"

#will pixelate the image
#convert "$bg" -fill black -colorize 30% "$bg"
# -scale 10% -scale 1000% \

convert "$bg" \
        -filter Gaussian \
        -blur 0x3 \
        "$bg" 

convert "$bg" "$icon" -gravity center -composite -matte "$bg"
i3lock -n -t -i "$bg" \
    --bar-indicator --bar-position h --bar-direction 1 --bar-width=30 --bar-periodic-step 100 \
    --bar-base-width 50 --bar-color 00000000 --timesize=20 --wrongsize=30 \
    --noinputtext=""
