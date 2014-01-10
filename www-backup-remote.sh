#!/bin/sh

THEDATE=`date +%d%m%y%H%M`

mysqldump -uroot -pPASSWORD main > ~/backups/www/dbbackup$THEDATE.bak

tar -cf ~/backups/www/sitebackup$THEDATE.tar /var/www
gzip ~/backups/www/sitebackup$THEDATE.tar

find ~/backups/www/site* -mtime +7 -exec rm {} \;
find ~/backups/www/db* -mtime +7 -exec rm {} \;
