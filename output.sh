#! /bin/bash

#for line in "$(xrandr | grep " connected" | grep -oP [0-9]+x[0-9]+)"
#do
#	echo "$line"
#	sleep 3
#done
	
#var="$(xrandr | grep " connected" | grep -oP [0-9]+x[0-9]+)"

#run both xrandrs, one to receive the name of the output, and the other to receive the best resolution possible, I think
out="$(xrandr | grep -oP [A-z]+-*[0-9]\ [c] | grep -oP [A-z]+-*[0-9])"
out2="$(xrandr | grep " connected" | grep -oP [0-9]+x[0-9]+)"

#echo "$var"
#echo "$out"

#while read -r line
#do
#	var1="$line"
#	echo
#done <<< "$var"

#2 arrays
ar=(1 2 3)
ar2=(1 2 3)
v=0

#echo ${ar[$x]}

#something that I need to research more, but this run a while loop in the output of "$out", hence the "<<<"

while read -r line
do
	ar[$x]=$line
	x=$[$x+1]
	
done <<< "$out"

#the second loop, to receive the best resolutions to a variable

while read -r line
do
	ar2[$y]=$line
	echo "${ar2[$y]}"
	y=$[$y+1]

done <<< "$out2"


#echo ${ar[$x]}
#echo $x

i=0
a=0
main=${ar[0]}
echo $main 

#while to run determined xrandr commands, where x is the number limit of outputs connected to your pc right now

while [ "$i" -lt "$x" ] #[ "$i" -lt "${#ar[@]}" ]
do
	if 
		[[ "${ar[$i]}" == "$main" ]]; 
	then
	#	echo ${ar[$i]}
		com="$(xrandr --output ${ar[$i]} --auto)" 
		#echo foi1
	elif
		[[ ! "${ar[$i]}" == "${ar[$i-1]}" ]]; # && "$a" -eq 0 ]];
	then
	#	echo foi2
		if [[ "$a" -eq 0 ]];
		then
			com="$(xrandr --output ${ar[$i]} --auto --right-of $main --scale-from ${ar2[$i]})"
	#		echo eh1
		else
			com="$(xrandr --output ${ar[$i]} --auto --left-of $main --scale-from ${ar2[$i]})"
	#		echo eh2
			echo "${ar[$i]}"
		fi
	#	echo ${ar[$i]}
		a=$[$a+1]
#	elif
#		[[ ! "${ar[$i]}" == "${ar[0]}" && "$a" -eq 1 ]];
#	then
#		echo ${ar[$i]}
#		com="$(xrandr --output ${ar[$i]} --auto --left-of LVDS1)"
	fi
		i=$[$i+1]
done

#wal -R
