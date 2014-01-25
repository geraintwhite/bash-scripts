#!/bin/bash

usage="Usage: $(basename $0) [-ar domain] [-h]

Options:
    -a    --add       add site to block list
    -r    --remove    remove site from block list
    -l    --list      list all blocked sites
    -h    --help      show this help text"

argerr="$(basename $0): missing or unknown argument
Try $(basename $0) --help for usage information"

tag="#BlockedSites#"

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

case "$1" in

    -a|--add)
        if [ -z "$2" ]; then
            echo "$argerr"
            exit 1
        fi

        if ! grep -q $tag /etc/hosts; then
            echo $tag | sudo tee -a /etc/hosts > /dev/null
        fi

        if ! grep -q $2 /etc/hosts; then
            echo -e "127.0.0.1\t$2" | sudo tee -a /etc/hosts > /dev/null
            echo "Added $2 to /etc/hosts"
        else
            echo "$2 already in /etc/hosts"
        fi
        ;;

    -r|--remove)
        if [ -z "$2" ]; then
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

    -l|--list)
        for line in "$(sed "0,/$tag/d" /etc/hosts)"; do
            echo $(echo $line | sed -e 's/^127.0.0.1[ \t]*//')
        done
        ;;

    -h|--help)
        echo "$usage"
        ;;

    *)
        echo "$argerr"
        ;;

esac
