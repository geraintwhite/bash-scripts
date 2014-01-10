#!/bin/sh

sudo rm -rf /home/pi/backups/fullBackup/*
mkdir /home/pi/backups/fullBackup/files
sudo rsync -aAXv /* /home/pi/backups/fullBackup/files --exclude-from '/home/pi/scripts/exclude.txt'
sudo tar -zcvf /home/pi/backups/fullBackup/fullBackup.tar.gz /home/pi/backups/fullBackup/files
sudo rm -rf /home/pi/backups/fullBackup/files
