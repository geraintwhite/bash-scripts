#!/bin/bash

state=$(cat /sys/class/power_supply/BAT0/status)
percentage=$(cat /sys/class/power_supply/BAT0/capacity)

if [ $percentage -gt 80 ]; then
  colour="g"
elif [ $percentage -gt 20 ]; then
  colour="y"
else
  colour="r"
fi

if [ $state = "Charging" ]; then
  colour="b"
fi

echo -e "\005{$colour}$percentage%"
