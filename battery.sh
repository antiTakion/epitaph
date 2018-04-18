#!/bin/bash
PATH=/usr/bin/:/home/takion/.bin./scripts/

if
	acpi | grep Discharging | grep -oP "(([^0-9][4-9]\%)|([1][0-9]\%))|20\%" | grep -oP "([0-9]\%|[0-9][0-9]\%)"
then
	export DISPLAY=:0 && notify-send Battery 'Low battery, bro.'
elif
	acpi | grep -oP 100\%
then
	export DISPLAY=:0 && notify-send Battery 'I am full, bro.'
elif
	acpi | grep Discharging | grep -oP "[^0-9][0-3]\%" | grep -oP "[0-3]\%"
then
	systemctl suspend
fi
