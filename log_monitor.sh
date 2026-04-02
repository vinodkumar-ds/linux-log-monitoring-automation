#!/bin/bash


LOGFILE="/var/log/syslog"


echo "=========================================="
echo "Log Monitoring Report"
echo "=========================================="

if [ ! -f "$LOGFILE" ] 
then
	echo " Log file not found  $LOGFILE "
	exit 1
fi

recent_logs=$(journalctl --since "1 hour ago")



error_count=$(echo "$recent_logs" | grep -i "error" | wc -l)
warn_count=$(echo "$recent_logs" | grep -i "warn" | wc -l)
fail_count=$(echo "$recent_logs" | grep -i "fail" | wc -l)

echo " Errors   : $error_count"
echo " Warnings : $warn_count"
echo " Failures : $fail_count"

echo "------------------------------------------"

total_issue=$((error_count + warn_count + fail_count ))

echo " Total issue : $total_issue"
echo
if [ $total_issue -lt 20 ]
then
	echo " Status : NORMAL "
elif [ $total_issue -lt 50 ] 
then
	echo " Status : WARNING "
else 
	echo " STATUS : CRITICAL "
fi

echo "================================================="

