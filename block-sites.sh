#!/bin/bash

usage="Usage: $(basename $0) [-ar domain] [-h]

Options:
    -a		--add		add site to block list
    -r		--remove	remove site from block list
    -h		--help		show this help text"

argerr="$(basename $0): missing or unknown argument
Try $(basename $0) --help for usage information"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

case "$1" in
    -a|--add)
        if [ -n $2 ]; then
            echo "$argerr"
            exit 1
        fi
        if ! grep -q $2 /etc/hosts; then
            echo -e "127.0.0.1\t$2" | sudo tee -a /etc/hosts > /dev/null
            echo "Added $2 to /etc/hosts"
        else
            echo "$2 already in /etc/hosts"
        fi
        ;;
    -r|--remove)
        if [ -n $2 ]; then
            echo "$argerr"
            exit 1
        fi
        if grep -q $2 /etc/hosts; then
            TEMP=$(mktemp)
            grep -v $2 /etc/hosts > $TEMP
            cat $TEMP | sudo tee /etc/hosts > /dev/null
            echo "Removed $2 from /etc/hosts"
        else
            echo "$2 not in /etc/hosts"
        fi
        ;;
    -h|--help)
        echo "$usage"
        ;;
    *)
        echo "$argerr"
        ;;
esac
