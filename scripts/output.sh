#! /bin/bash

#modify to only case another time?
while getopts 's' OPTION; do
    case "$OPTION" in
        s)
            offOutput ;;
        ?)
            echo "script usage: $(basename $0) [-s]"
            exit 1 ;;
    esac
done

#just shutdown before connecting, but later we need to use this when
#disconnecting some output, and maybe prompt options to know which is
#connected
offOutput() {
    local i=0
    while [ "$i" -lt "${#name[@]}" ]
    do
        echo "SHUTTING DOWN ${name[$i]}"
        xrandr --output ${name[$i]} --off #2> /dev/null
        ((++i))  
    done
sleep 1
}

connectOutput() {
    local i=0
    local a=0

    #while to run determined xrandr commands, where x is the number limit
    #of outputs connected to your pc right now. max 3, actually
    while [ "$i" -lt "${#name[@]}" ] #[ "$i" -lt "${#name[@]}" ]
    do
    	if [ "${name[$i]}" == "$main" ]; then
            xrandr --output ${name[$i]} --auto
	    elif [ ! "${name[$i]}" == "${name[$i-1]}" ]; then
	    	if [ "$a" -eq 0 ]; then
	    		xrandr --output ${name[$i]} --auto --right-of $main #--scale-from ${ar2[$i]})"
	    	else
	    		xrandr --output ${name[$i]} --auto --left-of $main #--scale-from ${ar2[$i]})"
	    	fi
         ((++a))
    	fi
        ((++i))
    done
}

connected="$(xrandr | grep -P '(?<= )connected')"
name=($(grep -oP '(^(.*?)(?= ))' <<< $connected))
resolution=($(grep -oP '[0-9]+x[0-9]+' <<< $connected))

main=${name[0]}


connectOutput
wal -R

#porra, isso era cabaço, hsayuhsayu
#"<<<" send the here-string to standard input, aka stdin, in this case, $line
#while read -r line; do
#	arName[$x]=$line
#	((++x))
#done <<< "$name"



