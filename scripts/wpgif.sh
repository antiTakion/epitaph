#! /bin/bash

FILE=
FILE_DEFAULT="/home/takion/files/pictures/wallpapers/pixel/default.gif"
#"${1:=$(grep -oP "(?<=').*(?=')" < /home/takion/.fehbg)}"

#if xwinwrap is running, kill and wait. maybe create a function for it?
wp_gif(){
    if [ ! -z $(pidof xwinwrap) ]; then
        kill $(pidof xwinwrap) && sleep 2
    fi
        xwinwrap -s -b -ni -fdt -nf -fs -ov \
        -- mpv "$1" --wid WID \
        --loop-file --no-audio \
        & disown
        #--no-osc --no-osd-bar \
        #--panscan=1.0 --no-input-default-bindings \
    wal -i "$1"
}

#same as the above, but now confirm if net is up.
#maybe a better way to do it? 
wp_stream(){
    if [ ! -z $(pidof xwinwrap) ]; then
        kill $(pidof xwinwrap) && sleep 2
    fi

    ping -c 1 google.com
    if [ $? == 0 ]; then
        xwinwrap -s -b -ni -fdt -nf -fs -ov \
        -- mpv "$1" --wid WID \
        --loop-file --no-audio \
       & disown 
    else
        wp_gif "$FILE_DEFAULT"
    fi
    wal -i "$FILE_DEFAULT"

}

#if no parameters given, use the default gif file as wpp.
#definintely there is a better way to do it.
if [ $# -eq 0 ]; then
    wp_gif "$FILE_DEFAULT"
fi

#this case need one default option, do it later.
#there's really a need to shift 2 times in the flags with parameters?
while [ $# -gt 0 ]; do
    key="$1"

    case $key in 
        -f|--file)
            FILE="$2"
            shift; shift
            wp_gif "$FILE" ;;

        -d|--default)
            wp_gif "$FILE_DEFAULT"
            shift ;;

        -s|--stream)
            FILE="$2"
            shift; shift
            wp_stream "$FILE" ;;
    esac
done
