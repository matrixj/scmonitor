#!/bin/sh

COMMAND=`cat getdata.sh`
# Run getdata.sh to fetch info in remote hosts
pscp.pssh -h hosts getdata.sh /tmp/tmp.sh >>/dev/null
pssh -h hosts -o ./data "sh /tmp/tmp.sh" 
pssh -h hosts "rm /tmp/tmp.sh" >>/dev/null

#analize data in directory 'data'
sh ana.sh
