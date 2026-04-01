#!/bin/bash

LOG_FS="/mnt/app_logs"

echo
echo "===== $(date) ====="

usage=$(df -h $LOG_FS | awk 'NR==2 {print $5}' | tr -d '%')

if [ $usage -ge 90 ]
then
    echo "CRITICAL: $LOG_FS usage ${usage}%"

    df -h $LOG_FS

    echo "Triggering log cleanup..."

    /home/vinod/april1/cleanup_log.sh >> /home/vinod/april1/cleanup.log 2>&1

elif [ $usage -ge 80 ]
then
    echo "HIGH: $LOG_FS usage ${usage}%"

    df -h $LOG_FS

elif [ $usage -ge 70 ]
then
    echo "WARNING: $LOG_FS usage ${usage}%"

    df -h $LOG_FS
fi
