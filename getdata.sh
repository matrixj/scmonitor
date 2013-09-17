#!/bin/sh

echo -n '<hostname>'
hostname

echo -n '<date>'
date '+%Y-%m-%d %H:%M:%S'

echo -n '<uptime>'
uptime | sed -r 's/.*up\s*([^,]*).*/\1/'

echo -n '<interface>'
#ip a 
echo

echo -n '<process number>'
ps -e | wc -l

echo -n '<root use>'
df -h |awk -F'[ %]+' '$NF == "/" { print $(NF-1)}'

