#!/bin/bash
echo "=================Script for checking CPU usage ========"
echo
echo


usage=$(mpstat 1 1 | awk '/Average/ {print $NF}' )
CPU=$(echo "100 - $usage" | bc)
echo "CPU idle : $usage %"
echo "CPU used : $CPU %"

