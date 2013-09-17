#!/bin/sh
tmp=$IFS
IFS=
function getkey()
{
    key=`echo $1 | sed -r 's/(<.*>).*/\1/'`
    echo  ${key}
}
function getleft()
{
    min=`echo $1 | sed -r 's/.*>([0-9]*).*/\1/'`
    echo  $min
}

function getright()
{
    max=`echo $1 | awk -F"[0-9] " '{print $2}'`
    echo $max
}
function wr_result()
{
    echo result is : $1 $2 $3
    echo $1 $2 $3>>result
}

# Empty ./result
touch result
cat /dev/null > result >/dev/null 2>&1

for file in ./data/*
do
    echo ${file##\.*/} >> result
    sed -n '1,4p' $file >>result
    while read readline 
    do
        echo readline is :$readline
        key=$(getkey $readline)
        echo key is $key
        # Search keywork
        remoteline=$(grep $key $file)
        echo remoteline is :$remoteline

        lo_l=$(getleft $readline)
        echo lo_l is :$lo_l
        re=$(getleft $remoteline)
        echo re is :$re
        if [ $re -lt $lo_l ] 
        then
            result=${re}-warnning-min
        fi

        lo_r=$(getright $readline)
        echo lo_r is :$lo_r
        echo re is :$re
        if [ $re -gt $lo_r ] 
        then
            result=$re-warnning-max
            echo result in main is :$result
        fi
        
        wr_result $key  ${result:-$re}
    done < mark.mk
done
