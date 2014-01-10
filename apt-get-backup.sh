#!/bin/sh

read -p "Would you like to backup (b) or restore (r)? " choice
case "$choice" in 
	b|B )
		echo;
		sudo dpkg --get-selections > backup.txt;
		echo "Created backup file backup.txt";
		exit;;
	r|R )
		echo;
		sudo apt-get install aptitude;
		sudo dpkg --clear-selections;
		sudo dpkg --set-selections < backup.txt;
		sudo aptitude install;
		exit;;
	* )
		echo "invalid";
		exit;
esac
