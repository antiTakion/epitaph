#! /bin/bash
#PATH=/usr/bin/:/home/takion/.bin/scripts/

#'cause this export dbus_session, you need root permission,
#thus, create as root and give suid permission to this script
#function that receives a message and send to the user
notify() {
    export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus
    #for user in $users; do
    export DISPLAY=:0 && /usr/bin/notify-send Battery "$1"
}

#users=$(who | awk '{print $1}')
acpi="$(acpi)"
battery="$(grep -oP '[0-9]+(?=%)' <<< $acpi)"
status="$(grep -ioE 'Charging|Discharging|Full' <<< $acpi)"
#echo "Irmão, the battery is $status and have $battery% of energy remaining!"

#if the battery status is discharging and less than 20, a message will
#be sent via notify and if less than 5, will suspend the machine.
#another message will be sent if the status is full
if [ "$status" == "Discharging" ]; then
    if [ "$battery" -lt 20 ]; then
        notify 'Low battery, bro!'
        if [ "$battery" -lt 5 ]; then
            systemctl suspend 
        fi
    fi      
elif [ "$status" == "Full" ]; then
    notify 'I am full, pal!'
fi
