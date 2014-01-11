#!/bin/bash

result=$(curl -s https://freedns.afraid.org/dynamic/update.php?UPDATESTRING)

if [[ "$result" == Updated* ]]
then
    echo "$result" | mail -s "IP Address Changed" geraint@android.net
fi
