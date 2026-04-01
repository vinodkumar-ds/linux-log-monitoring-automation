#!/bin/bash

echo 
echo

THRESHOLD=90
LOG_DIR="/mnt/app_logs"

usage=$(df -h $LOG_DIR | awk 'NR==2 {print $5}' | tr -d '%')

if [ "$usage" -ge "$THRESHOLD" ]
then
	echo "Critical : Disk usage is ${usage}% - cleaning old logs "

	cd $LOG_DIR || exit

	ls -1t app_log_*.log 2>/dev/null | tail -n +6 | xargs rm -f 

	echo " Clean up completed"
else
	echo "Disk usage normal :${usage}%"
fi

