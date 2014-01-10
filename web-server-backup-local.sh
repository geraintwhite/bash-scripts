#!/bin/bash

rsync -avz pi@raspberrypi:/home/pi/backups/backupFiles/www/* /home/geraint/backups/site/
find /home/geraint/backups/site/* -mtime +7 -exec rm {} \;
